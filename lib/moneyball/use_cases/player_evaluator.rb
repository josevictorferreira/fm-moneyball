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
        table = Terminal::Table.new(headings: headings, rows: table_data)

        puts table
      end

      sig { params(file_path: String).void }
      def self.call(file_path:)
        new(file_path).call
      end

      private

      sig { returns(T::Array[T::Array[T.any(String, Integer, Float)]]) }
      def table_data
        players_data.sort_by! { |p| p.ratings.first&.value }.reverse.take(10).map do |player|
          [player.name, player.general.age, player.general.height] + player.ratings.map(&:value)
        end
      end

      sig { returns(T::Array[Entities::Player]) }
      def players_data
        @players_data ||= T.let(Adapters::Text::Parser.call(@file_path), T.nilable(T::Array[Entities::Player]))
      end

      sig { returns(T::Array[String]) }
      def headings
        @headings ||= T.let(%w[Name Age Height] +
          Entities::Coefficient.from_config.map(&:name), T.nilable(T::Array[String]))
      end
    end
  end
end
