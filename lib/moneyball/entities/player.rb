# typed: strict
# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
module Moneyball
  module Entities
    # Represents a FM player in the Moneyball system.
    Player = Data.define(:name, :general, :mental, :physical, :goal_keeping, :technical, :rating) do
      extend T::Sig

      sig { returns(String) }
      def name
        @name
      end

      sig { returns(PlayerAttributes::General) }
      def general
        @general
      end

      sig { returns(PlayerAttributes::Mental) }
      def mental
        @mental
      end

      sig { returns(PlayerAttributes::Physical) }
      def physical
        @physical
      end

      sig { returns(PlayerAttributes::GoalKeeping) }
      def goal_keeping
        @goal_keeping
      end

      sig { returns(PlayerAttributes::Technical) }
      def technical
        @technical
      end

      sig { returns(Float) }
      def rating
        @rating
      end

      sig do
        params(name: String, general: PlayerAttributes::General, mental: PlayerAttributes::Mental,
               physical: PlayerAttributes::Physical, goal_keeping: PlayerAttributes::GoalKeeping,
               technical: PlayerAttributes::Technical).void
      end
      def initialize(name:, general:, mental:, physical:, goal_keeping:, technical:)
        @name = T.let(name, String)
        @general = T.let(general, PlayerAttributes::General)
        @mental = T.let(mental, PlayerAttributes::Mental)
        @physical = T.let(physical, PlayerAttributes::Physical)
        @goal_keeping = T.let(goal_keeping, PlayerAttributes::GoalKeeping)
        @technical = T.let(technical, PlayerAttributes::Technical)
        @rating = T.let(calc_base_rating, Float)
      end

      sig { returns(Float) }
      def calc_base_rating
        coefficients = {
          'physical.agility' => 0.014640,
          'goal_keeping.reflexes' => 0.012837,
          'goal_keeping.aerial_reach' => 0.011812,
          'goal_keeping.throwing' => 0.007465,
          'mental.composure' => 0.007436,
          'goal_keeping.handling' => 0.006255,
          'mental.decisions' => 0.005089,
          'goal_keeping.rushing_out' => -0.003310
        }

        total_weight = coefficients.values.sum
        weighed_rating = coefficients.keys.map do |attr|
          attr_value = attr.split('.').reduce(self) do |obj, method_name|
            obj.public_send(method_name)
          end
          attr_value * coefficients[attr]
        end.sum / total_weight
        (((weighed_rating - 0.0) / (20.0 - 0.0)) * 100.0).round(2)
      end

      sig { params(player_data: T::Hash[String, String]).returns(Player) }
      def self.build(player_data)
        Entities::Player.new(
          name: player_data.fetch('Name', ''),
          general: PlayerAttributes::General.build(player_data),
          mental: PlayerAttributes::Mental.build(player_data),
          physical: PlayerAttributes::Physical.build(player_data),
          goal_keeping: PlayerAttributes::GoalKeeping.build(player_data),
          technical: PlayerAttributes::Technical.build(player_data)
        )
      end
    end
  end
end
# rubocop:enable Metrics/ParameterLists
