# typed: strict
# frozen_string_literal: true

require 'yaml'

module Moneyball
  module Entities
    # Represents a coefficient used in the Moneyball system.
    class Coefficient
      extend T::Sig

      sig { returns(String) }
      attr_reader :id

      sig { returns(String) }
      attr_reader :name

      sig { returns(T::Hash[String, T::Array[Float]]) }
      attr_reader :attributes

      sig { params(id: String, name: String, attributes: T::Hash[String, T::Array[Float]]).void }
      def initialize(id:, name:, attributes:)
        @id = T.let(id, String)
        @name = T.let(name, String)
        @attributes = T.let(attributes, T::Hash[String, T::Array[Float]])
      end

      sig { params(filters: T::Array[String]).returns(T::Array[Coefficient]) }
      def self.from_config(filters = [])
        @from_config ||= T.let(YAML.load_file(File.join(ROOT_DIR, 'config', 'coefficients.yaml')).then do |file_content|
          file_content.filter_map do |key, value|
            next if filters.any? && filters.any? { |filter| !key.to_s.include?(filter) }

            new(id: key, name: value.fetch('name', ''), attributes: value.fetch('attributes', {}))
          end
        end, T.nilable(T::Array[Coefficient]))
      end
    end
  end
end
