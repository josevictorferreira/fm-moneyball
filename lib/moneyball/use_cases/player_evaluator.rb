# typed: strict
# frozen_string_literal: true

require 'terminal-table'

module Moneyball
  module UseCases
    # PlayerEvaluator is responsible for evaluating player data from a file.
    class PlayerEvaluator
      extend T::Sig

      sig { params(file_path: String).void }
      def initialize(file_path)
        @file_path = T.let(file_path, String)
      end

      sig { void }
      def call
        player_data = AdapterFactory.parser_for(:rtf).call(@file_path)
        player_data.sort_by!(&:rating).reverse!
        relevant_data = player_data.take(10).map do |player|
          [player.name, player.rating, player.general.age, player.general.height]
        end
        table = Terminal::Table.new(headings: %w[Name Rating Age Height], rows: relevant_data)

        puts table
      end

      sig { params(file_path: String).void }
      def self.call(file_path:)
        new(file_path).call
      end
    end
  end
end
