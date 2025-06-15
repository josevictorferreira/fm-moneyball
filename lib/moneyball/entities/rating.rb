# typed: strict
# frozen_string_literal: true

require 'yaml'

module Moneyball
  module Entities
    # Represents a FM player in the Moneyball system.
    Rating = Data.define(:coefficient, :value) do
      extend T::Sig

      sig { returns(Coefficient) }
      def coefficient
        @coefficient
      end

      sig { returns(Float) }
      def value
        @value
      end

      sig { params(coefficient: Coefficient, value: Float).void }
      def initialize(coefficient:, value:)
        @coefficient = T.let(coefficient, Coefficient)
        @value = T.let(value, Float)
      end
    end
  end
end
