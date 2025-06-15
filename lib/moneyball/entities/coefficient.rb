# typed: strict
# frozen_string_literal: true

require 'yaml'

module Moneyball
  module Entities
    # Represents a FM player in the Moneyball system.
    Coefficient = Data.define(:id, :name, :attributes) do
      extend T::Sig

      sig { returns(String) }
      def id
        @id
      end

      sig { returns(String) }
      def name
        @name
      end

      sig { returns(T::Hash[String, T::Array[Float]]) }
      def attributes
        @attributes
      end

      sig { params(id: String, name: String, attributes: T::Hash[String, T::Array[Float]]).void }
      def initialize(id:, name:, attributes:)
        @id = T.let(id, String)
        @name = T.let(name, String)
        @attributes = T.let(attributes, T::Hash[String, T::Array[Float]])
      end

      sig { returns(T::Array[Coefficient]) }
      def self.from_config
        @from_config ||= T.let(YAML.load_file(File.join(ROOT_DIR, 'config', 'coefficients.yaml')).then do |file_content|
          file_content.map do |key, value|
            new(id: key, name: value.fetch('name', ''), attributes: value.fetch('attributes', {}))
          end
        end, T.nilable(T::Array[Coefficient]))
      end
    end
  end
end
