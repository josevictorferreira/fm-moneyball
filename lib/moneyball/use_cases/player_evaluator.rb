# typed: strict
# frozen_string_literal: true

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
        build_table.print
      end

      sig { params(file_path: String).void }
      def self.call(file_path:)
        new(file_path).call
      end

      private

      sig { returns(Core::Table) }
      def build_table
        Core::Table.new(table_data)
                   .with_headers(table_headers)
                   .with_order(:age, :asc)
                   .with_limit(15)
      end

      sig { returns(T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]]) }
      def table_data
        players_data.map(&:to_h)
      end

      sig { returns(T::Array[Entities::Player]) }
      def players_data
        @players_data ||= T.let(Adapters::Text::Parser.call(@file_path), T.nilable(T::Array[Entities::Player]))
      end

      sig { returns(T::Array[Symbol]) }
      def table_headers
        @table_headers ||= T.let(%i[name age height] +
          Entities::Coefficient.from_config.map(&:name).map(&:to_sym), T.nilable(T::Array[Symbol]))
      end
    end
  end
end
