# typed: strict
# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
# rubocop:disable Metrics/MethodLength

module Moneyball
  module Entities
    module PlayerAttributes
      GoalKeeping = Data.define(:aerial_reach, :command_of_area, :communication, :eccentricity, :handling, :kicking,
                                :one_on_ones, :passing, :punching, :reflexes, :rushing_out, :throwing) do
        extend T::Sig
        extend Utils::Fetchable

        sig { returns(Integer) }
        def aerial_reach
          @aerial_reach
        end

        sig { returns(Integer) }
        def command_of_area
          @command_of_area
        end

        sig { returns(Integer) }
        def communication
          @communication
        end

        sig { returns(Integer) }
        def eccentricity
          @eccentricity
        end
        sig { returns(Integer) }
        def handling
          @handling
        end
        sig { returns(Integer) }
        def kicking
          @kicking
        end
        sig { returns(Integer) }
        def one_on_ones
          @one_on_ones
        end
        sig { returns(Integer) }
        def passing
          @passing
        end
        sig { returns(Integer) }
        def punching
          @punching
        end
        sig { returns(Integer) }
        def reflexes
          @reflexes
        end
        sig { returns(Integer) }
        def rushing_out
          @rushing_out
        end
        sig { returns(Integer) }
        def throwing
          @throwing
        end

        sig do
          params(aerial_reach: Integer, command_of_area: Integer, communication: Integer, eccentricity: Integer,
                 handling: Integer, kicking: Integer, one_on_ones: Integer, passing: Integer,
                 punching: Integer, reflexes: Integer, rushing_out: Integer, throwing: Integer).void
        end
        def initialize(aerial_reach:, command_of_area:, communication:, eccentricity:, handling:, kicking:,
                       one_on_ones:, passing:, punching:, reflexes:, rushing_out:, throwing:)
          @aerial_reach = T.let(aerial_reach, Integer)
          @command_of_area = T.let(command_of_area, Integer)
          @communication = T.let(communication, Integer)
          @eccentricity = T.let(eccentricity, Integer)
          @handling = T.let(handling, Integer)
          @kicking = T.let(kicking, Integer)
          @one_on_ones = T.let(one_on_ones, Integer)
          @passing = T.let(passing, Integer)
          @punching = T.let(punching, Integer)
          @reflexes = T.let(reflexes, Integer)
          @rushing_out = T.let(rushing_out, Integer)
          @throwing = T.let(throwing, Integer)
        end

        sig { params(player_data: T::Hash[String, String]).returns(Entities::PlayerAttributes::GoalKeeping) }
        def self.build(player_data)
          Entities::PlayerAttributes::GoalKeeping.new(
            aerial_reach: fetch_attribute(player_data, 'Aer'), command_of_area: fetch_attribute(player_data, 'Cmd'),
            communication: fetch_attribute(player_data, 'Com'), eccentricity: fetch_attribute(player_data, 'Ecc'),
            one_on_ones: fetch_attribute(player_data, '1v1'), reflexes: fetch_attribute(player_data, 'Ref'),
            handling: fetch_attribute(player_data, 'Han'), kicking: fetch_attribute(player_data, 'Kic'),
            throwing: fetch_attribute(player_data, 'Thr'), passing: fetch_attribute(player_data, 'Pas'),
            punching: fetch_attribute(player_data, 'Pun'), rushing_out: fetch_attribute(player_data, 'TRO')
          )
        end
      end
    end
  end
end

# rubocop:enable Metrics/ParameterLists
# rubocop:enable Metrics/MethodLength
