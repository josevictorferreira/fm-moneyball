# typed: strict
# frozen_string_literal: true

require 'terminal-table'

module Moneyball
  module Core
    TableOrder = Data.define(:sort_by, :direction) do
      extend T::Sig

      sig { returns(Symbol) }
      def sort_by
        @sort_by
      end

      sig { returns(Symbol) }
      def direction
        @direction
      end

      sig { params(sort_by: Symbol, direction: Symbol).void }
      def initialize(sort_by:, direction: :asc)
        @sort_by = T.let(sort_by, Symbol)
        @direction = T.let(direction, Symbol)
      end

      sig { returns(TableOrder) }
      def self.default
        new(sort_by: :name, direction: :asc)
      end
    end

    # Configuration for a table, including headers, order, limit, and filter.
    class TableConfig
      extend T::Sig

      sig { returns(T::Array[Symbol]) }
      attr_accessor :headers

      sig { returns(TableOrder) }
      attr_accessor :order

      sig { returns(Integer) }
      attr_accessor :limit

      sig { returns(T.nilable(String)) }
      attr_accessor :filter

      sig do
        params(headers: T::Array[Symbol], order: TableOrder, limit: Integer, filter: T.nilable(String)).void
      end
      def initialize(headers:, order:, limit: 10, filter: nil)
        @headers = T.let(headers, T::Array[Symbol])
        @order = T.let(order, TableOrder)
        @limit = T.let(limit, Integer)
        @filter = T.let(filter, T.nilable(String))
      end

      sig { returns(TableConfig) }
      def self.default
        new(headers: %i[name age height], order: TableOrder.default, limit: 10, filter: nil)
      end
    end

    # Represents a table of data with sorting and limiting capabilities.
    class Table
      extend T::Sig

      sig { returns(T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]]) }
      attr_accessor :data

      sig { returns(TableConfig) }
      attr_accessor :config

      sig { params(data: T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]], config: TableConfig).void }
      def initialize(data, config = TableConfig.default)
        @data = T.let(data, T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]])
        @config = T.let(config, TableConfig)
        @table_rows = T.let(@data.dup, T::Array[T::Hash[Symbol, T.any(String, Integer, Float)]])
      end

      sig { params(headers: T::Array[Symbol]).returns(T.self_type) }
      def with_headers(headers)
        @config.headers = T.let(headers, T::Array[Symbol])
        self
      end

      sig { params(sort_by: Symbol, direction: Symbol).returns(T.self_type) }
      def with_order(sort_by, direction = :desc)
        @config.order = T.let(TableOrder.new(sort_by: sort_by, direction: direction), TableOrder)
        self
      end

      sig { params(limit: Integer).returns(T.self_type) }
      def with_limit(limit)
        @config.limit = T.let(limit, Integer)
        self
      end

      sig { params(filter: String).returns(T.self_type) }
      def with_filter(filter)
        @config.filter = T.let(filter, T.nilable(String))
        self
      end

      sig { void }
      def print
        @table_rows = @data.dup
        sort_data!
        limit_data!
        filter_data!
        table = Terminal::Table.new(headings: formatted_table_headers, rows: formatted_table_rows)
        puts align_columns(table)
      end

      private

      sig { params(table: Terminal::Table).returns(Terminal::Table) }
      def align_columns(table)
        table.columns.each_with_index do |column, index|
          if column.first.is_a?(Integer) || column.first.is_a?(Float)
            table.align_column(index, :right)
          else
            table.align_column(index, :left)
          end
        end
        table
      end

      sig { returns(T::Array[String]) }
      def formatted_table_headers
        @config.headers.map do |header|
          header.to_s.gsub('_', ' ').gsub('-', ' ').split(' ').map(&:capitalize).join(' ')
        end
      end

      sig { returns(T::Array[T::Array[T.any(String, Integer, Float)]]) }
      def formatted_table_rows
        @table_rows.map do |row|
          data_row = T.let({}, T::Hash[Symbol, T.any(String, Integer, Float)])
          @config.headers.each do |header|
            data_row[header] = row.fetch(header, '')
          end
          data_row.values
        end
      end

      sig { void }
      def sort_data!
        return if @config.order.nil? || @config.order.sort_by.nil?

        @table_rows.sort_by! { |row| row[@config.order.sort_by] }

        @table_rows = @table_rows.reverse if @config.order.direction == :desc
      end

      sig { void }
      def limit_data!
        return if @config.limit.nil? || @config.limit <= 0

        @table_rows = @table_rows.first(@config.limit)
      end

      sig { void }
      def filter_data!
        return if @config.filter.nil? || @config.filter.to_s.empty?

        filter_regex = Regexp.new(@config.filter.to_s, Regexp::IGNORECASE)
        @table_rows = @table_rows.select do |row|
          row.any? { |_, value| value.to_s.match?(filter_regex) }
        end
      end
    end
  end
end
