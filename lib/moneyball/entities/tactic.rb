# typed: strict
# frozen_string_literal: true

require_relative '../core/rating_calculator'

module Moneyball
  module Entities
    # Represents a FM Tactic in the Moneyball system.
    Tactic = Data.define(:name, :positions) do
      extend T::Sig

      sig { returns(String) }
      def name
        @name
      end

      sig { returns(T::Array[TacticPosition]) }
      def positions
        @positions
      end

      sig do
        params(name: String, positions: T::Array[TacticPosition]).void
      end
      def initialize(name:, positions:)
        @name = T.let(name, String)
        @positions = T.let(positions, T::Array[TacticPosition])
      end

      sig { returns(T::Hash[Symbol, T.any(String, Float, Integer)]) }
      def to_h
        {
          name: name,
          positions: positions.map(&:to_h)
        }
      end

      sig { params(name: String, positions: T::Array[String], players: T::Array[Player]).returns(Tactic) }
      def self.build(name, positions, players)
        Tactic.new(
          name: name,
          positions: positions.filter_map do |position|
            coefficient = Coefficient.from_config.find { |c| c.id == position }
            next if coefficient.nil?

            TacticPosition.build(coefficient, players)
          end
        )
      end

      sig { params(name: String, players: T::Array[Player]).returns(Tactic) }
      def self.from_config(name, players)
        @from_config ||= T.let(
          YAML.load_file(
            File.join(ROOT_DIR, 'config', 'tactics.yaml')
          ).find { |tactic| tactic.first == name }
            &.then { |(tactic, positions)| Tactic.build(tactic, positions, players) }, T.nilable(Tactic)
        )
      end
    end
  end
end
