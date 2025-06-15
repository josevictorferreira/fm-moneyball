# typed: strict
# frozen_string_literal: true

module Moneyball
  module Adapters
    module Text
      # Parser for FM rtf exported files
      class Parser < Core::Parser
        extend T::Sig

        sig { override.returns(T::Array[Entities::Player]) }
        def call
          File.foreach(@file_path).lazy.filter_map do |line_content|
            next if Utils::File.line_empty?(line_content)

            line_content = line_content.strip[1..-2]

            if @headers.nil?
              @headers = T.let(parse_headers(line_content), T.nilable(T::Array[String]))
              nil
            else
              Entities::Player.build(parse_player_data(line_content, @headers))
            end
          end.to_a
        end

        private

        sig { params(line_content: String, headers: T::Array[String]).returns(T::Hash[String, String]) }
        def parse_player_data(line_content, headers)
          player_data = T.let({}, T::Hash[String, String])
          line_content.chomp.split('|').each_with_index do |value, index|
            key = headers[index]&.strip
            next if key.nil? || key.empty?

            player_data[key] = value.strip unless key.empty?
          end
          player_data
        end

        sig { params(line_content: String).returns(T::Array[String]) }
        def parse_headers(line_content)
          line_content.strip.split('|').filter_map do |header|
            text = header.strip
            text unless text.empty?
          end
        end
      end
    end
  end
end
