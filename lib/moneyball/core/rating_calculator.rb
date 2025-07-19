# typed: strict
# frozen_string_literal: true

module Moneyball
  module Core
    # Abstract base class for parsers
    class RatingCalculator
      extend T::Sig

      sig { params(player: Entities::Player, coefficient: Entities::Coefficient).void }
      def initialize(player, coefficient)
        @player = T.let(player, Entities::Player)
        @coefficient = T.let(coefficient, Entities::Coefficient)
      end

      sig { returns(Entities::Rating) }
      def call
        Entities::Rating.new(coefficient: @coefficient, value: normalized_rating.round(2).to_f)
      end

      sig { params(player: Entities::Player, coefficient: Entities::Coefficient).returns(Entities::Rating) }
      def self.call(player:, coefficient:)
        new(player, coefficient).call
      end

      private

      sig { returns(Float) }
      def weighed_rating
        total_weight = @coefficient.attributes.values.compact.sum
        @coefficient.attributes.keys.map do |attr|
          attr_value = attr.split('.').reduce(@player) do |obj, method_name|
            obj.public_send(method_name)
          end
          attr_value * @coefficient.attributes[attr]
        rescue StandardError => e
          puts "Error calculating weighed rating for #{attr}: #{e.message}"
        end.sum / total_weight
      end

      sig { returns(Float) }
      def normalized_rating
        ((weighed_rating - 0.0) / (20.0 - 0.0)) * 100.0
      end
    end
  end
end
