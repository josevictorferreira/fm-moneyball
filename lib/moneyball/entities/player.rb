# typed: strict
# frozen_string_literal: true

require_relative '../core/rating_calculator'

# rubocop:disable Metrics/ParameterLists
module Moneyball
  module Entities
    # Represents a FM player in the Moneyball system.
    Player = Data.define(:name, :general, :mental, :physical, :goal_keeping, :technical, :ratings, :best_rating, :second_best_rating) do
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

      sig { returns(T::Array[Rating]) }
      def ratings
        @ratings
      end

      sig { returns(T.nilable(Rating)) }
      def best_rating
        @best_rating
      end

      sig { returns(T.nilable(Rating)) }
      def second_best_rating
        @second_best_rating
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
        @ratings = T.let(player_ratings, T::Array[Rating])
        @best_rating = T.let(player_ratings[0], T.nilable(Rating))
        @second_best_rating = T.let(player_ratings[1], T.nilable(Rating))
      end

      sig { returns(T::Hash[Symbol, T.any(String, Float, Integer)]) }
      def to_h
        {
          name: name,
          best_rating: best_rating&.coefficient&.id,
          best_rating_value: best_rating&.value,
          second_best_rating: second_best_rating&.coefficient&.id,
          second_best_rating_value: second_best_rating&.value
        }.merge(general.to_h)
          .merge(ratings.map { |rating| [rating.coefficient.id.to_sym, rating.value] }.to_h)
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

      private

      sig { returns(T::Array[Rating]) }
      def player_ratings
        @player_ratings ||= T.let(Coefficient.from_config.map do |coefficient|
          Core::RatingCalculator.call(player: self, coefficient: coefficient)
        end.sort_by(&:value).reverse, T.nilable(T::Array[Rating]))
      end
    end
  end
end
# rubocop:enable Metrics/ParameterLists
