# typed: strict
# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists

module Moneyball
  module Entities
    module PlayerAttributes
      Physical = Data.define(:acceleration, :agility, :balance, :jumping_reach, :natural_fitness, :pace, :stamina,
                             :strength) do
        extend T::Sig
        extend Utils::Fetchable

        sig { returns(Integer) }
        def acceleration
          @acceleration
        end

        sig { returns(Integer) }
        def agility
          @agility
        end

        sig { returns(Integer) }
        def balance
          @balance
        end

        sig { returns(Integer) }
        def jumping_reach
          @jumping_reach
        end
        sig { returns(Integer) }
        def natural_fitness
          @natural_fitness
        end
        sig { returns(Integer) }
        def pace
          @pace
        end
        sig { returns(Integer) }
        def stamina
          @stamina
        end
        sig { returns(Integer) }
        def strength
          @strength
        end

        sig do
          params(acceleration: Integer, agility: Integer, balance: Integer, jumping_reach: Integer,
                 natural_fitness: Integer, pace: Integer, stamina: Integer, strength: Integer).void
        end
        def initialize(acceleration:, agility:, balance:, jumping_reach:, natural_fitness:, pace:,
                       stamina:, strength:)
          @acceleration = T.let(acceleration, Integer)
          @agility = T.let(agility, Integer)
          @balance = T.let(balance, Integer)
          @jumping_reach = T.let(jumping_reach, Integer)
          @natural_fitness = T.let(natural_fitness, Integer)
          @pace = T.let(pace, Integer)
          @stamina = T.let(stamina, Integer)
          @strength = T.let(strength, Integer)
        end

        sig { params(player_data: T::Hash[String, String]).returns(Entities::PlayerAttributes::Physical) }
        def self.build(player_data)
          Entities::PlayerAttributes::Physical.new(
            acceleration: fetch_attribute(player_data, 'Acc'),
            agility: fetch_attribute(player_data, 'Agi'),
            balance: fetch_attribute(player_data, 'Bal'),
            jumping_reach: fetch_attribute(player_data, 'Jum'),
            natural_fitness: fetch_attribute(player_data, 'Nat'),
            pace: fetch_attribute(player_data, 'Pac'),
            stamina: fetch_attribute(player_data, 'Sta'),
            strength: fetch_attribute(player_data, 'Str')
          )
        end
      end
    end
  end
end

# rubocop:enable Metrics/ParameterLists
