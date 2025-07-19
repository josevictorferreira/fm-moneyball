# typed: strict
# frozen_string_literal: true

module Moneyball
  module UseCases
    # PlayerEvaluator is responsible for evaluating player data from a file.
    class TacticEvaluator
      extend T::Sig

      DEFAULT_HEADERS = %i[
        name
        best_player
        best_player_rating
        second_best_player
        second_best_player_rating
        third_best_player
        third_best_player_rating
      ].freeze

      # Options class to encapsulate the configuration for player evaluation.
      class Options
        extend T::Sig

        sig { returns(String) }
        attr_accessor :file_path

        sig { returns(String) }
        attr_accessor :tactic_name

        sig { returns(T::Array[Symbol]) }
        attr_accessor :headers

        sig do
          params(file_path: String, tactic_name: String, headers: T::Array[Symbol]).void
        end
        def initialize(file_path: '', tactic_name: '', headers: DEFAULT_HEADERS)
          @file_path = T.let(file_path, String)
          @tactic_name = T.let(tactic_name, String)
          @headers = T.let(headers, T::Array[Symbol])
        end
      end

      sig { params(options: Options).void }
      def initialize(options)
        @options = T.let(options, Options)
        @file_path = T.let(options.file_path, String)
      end

      sig { void }
      def call
        build_table.print
      end

      sig { params(options: Options).void }
      def self.call(options)
        new(options).call
      end

      private

      sig { returns(Core::Table) }
      def build_table
        Core::Table.new(table_data)
                   .with_headers(@options.headers)
      end

      sig { returns(T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]]) }
      def table_data
        tactic.positions.map(&:to_h)
      end

      sig { returns(Entities::Tactic) }
      def tactic
        @tactic ||= T.let(Entities::Tactic.from_config(@options.tactic_name, players), T.nilable(Entities::Tactic))
      end

      sig { returns(T::Array[Entities::Player]) }
      def players
        @players ||= T.let(Adapters::Text::Parser.call(@file_path), T.nilable(T::Array[Entities::Player]))
      end

      sig { returns(T::Array[Symbol]) }
      def table_headers
        @table_headers ||= T.let(DEFAULT_HEADERS, T.nilable(T::Array[Symbol]))
      end
    end
  end
end
