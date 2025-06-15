# typed: strict
# frozen_string_literal: true

module Moneyball
  module UseCases
    # PlayerEvaluator is responsible for evaluating player data from a file.
    class PlayerEvaluator
      extend T::Sig

      # Options class to encapsulate the configuration for player evaluation.
      class Options
        extend T::Sig

        sig { returns(String) }
        attr_accessor :file_path

        sig { returns(T::Array[Symbol]) }
        attr_accessor :headers

        sig { returns(Symbol) }
        attr_accessor :sort

        sig { returns(Symbol) }
        attr_accessor :order

        sig { returns(Integer) }
        attr_accessor :limit

        sig do
          params(file_path: String, headers: T::Array[Symbol], sort: Symbol, order: Symbol, limit: Integer).void
        end
        def initialize(file_path: '', headers: %i[name age height gk_meta], sort: :desc, order: :age, limit: 10)
          @file_path = T.let(file_path, String)
          @headers = T.let(headers, T::Array[Symbol])
          @sort = T.let(sort, Symbol)
          @order = T.let(order, Symbol)
          @limit = T.let(limit, Integer)
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
                   .with_order(@options.order, @options.sort)
                   .with_limit(@options.limit)
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
