# typed: strict
# frozen_string_literal: true

module Moneyball
  module Entities
    # Represents a FM Tactic in the Moneyball system.
    TacticPosition = Data.define(:name, :coefficient, :players) do
      extend T::Sig

      sig { returns(String) }
      def name
        @name
      end

      sig { returns(Coefficient) }
      def coefficient
        @coefficient
      end

      sig { returns(T::Array[Player]) }
      def players
        @players
      end

      sig do
        params(name: String, coefficient: Coefficient, players: T::Array[Player]).void
      end
      def initialize(name:, coefficient:, players: [])
        @name = T.let(name, String)
        @coefficient = T.let(coefficient, Coefficient)
        @players = T.let(players_ordered_by_rating(players), T::Array[Player])
      end

      sig { returns(T::Hash[Symbol, T.any(String, Float, Integer)]) }
      def to_h
        {
          name: name,
          coefficient: coefficient.id,
          best_player: @players[0]&.name,
          best_player_rating: @players[0]&.ratings&.find { |rating| rating.coefficient.id == coefficient.id }&.value,
          second_best_player: @players[1]&.name,
          second_best_player_rating: @players[1]&.ratings&.find do |rating|
            rating.coefficient.id == coefficient.id
          end&.value,
          third_best_player: @players[2]&.name,
          third_best_player_rating: @players[2]&.ratings&.find do |rating|
            rating.coefficient.id == coefficient.id
          end&.value
        }
      end

      sig { params(coefficient: Coefficient, players: T::Array[Player]).returns(TacticPosition) }
      def self.build(coefficient, players)
        TacticPosition.new(
          name: coefficient.name,
          coefficient: coefficient,
          players: players
        )
      end

      private

      sig { params(players: T::Array[Player]).returns(T::Array[Player]) }
      def players_ordered_by_rating(players)
        players.sort_by do |player|
          player.ratings.find { |rating| rating.coefficient.id == coefficient.id }&.value || 0
        end.reverse
      end
    end
  end
end
