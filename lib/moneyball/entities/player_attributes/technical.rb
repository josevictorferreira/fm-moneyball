# typed: strict
# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

module Moneyball
  module Entities
    module PlayerAttributes
      Technical = Data.define(:corners, :crossing, :dribbling, :finishing, :first_touch, :free_kick_taking, :heading,
                              :long_shots, :long_throws, :marking, :passing, :penalty_taking, :tackling, :technique) do
        extend T::Sig
        extend Utils::Fetchable

        sig { returns(Integer) }
        def corners
          @corners
        end

        sig { returns(Integer) }
        def crossing
          @crossing
        end

        sig { returns(Integer) }
        def dribbling
          @dribbling
        end

        sig { returns(Integer) }
        def finishing
          @finishing
        end
        sig { returns(Integer) }
        def first_touch
          @first_touch
        end
        sig { returns(Integer) }
        def free_kick_taking
          @free_kick_taking
        end
        sig { returns(Integer) }
        def heading
          @heading
        end
        sig { returns(Integer) }
        def long_shots
          @long_shots
        end
        sig { returns(Integer) }
        def long_throws
          @long_throws
        end
        sig { returns(Integer) }
        def marking
          @marking
        end
        sig { returns(Integer) }
        def passing
          @passing
        end
        sig { returns(Integer) }
        def penalty_taking
          @penalty_taking
        end
        sig { returns(Integer) }
        def tackling
          @tackling
        end
        sig { returns(Integer) }
        def technique
          @technique
        end

        sig do
          params(corners: Integer, crossing: Integer, dribbling: Integer, finishing: Integer,
                 first_touch: Integer, free_kick_taking: Integer, heading: Integer, long_shots: Integer,
                 long_throws: Integer, marking: Integer, passing: Integer, penalty_taking: Integer,
                 tackling: Integer, technique: Integer).void
        end
        def initialize(corners:, crossing:, dribbling:, finishing:, first_touch:, free_kick_taking:,
                       heading:, long_shots:, long_throws:, marking:, passing:, penalty_taking:,
                       tackling:, technique:)
          @corners = T.let(corners, Integer)
          @crossing = T.let(crossing, Integer)
          @dribbling = T.let(dribbling, Integer)
          @finishing = T.let(finishing, Integer)
          @first_touch = T.let(first_touch, Integer)
          @free_kick_taking = T.let(free_kick_taking, Integer)
          @heading = T.let(heading, Integer)
          @long_shots = T.let(long_shots, Integer)
          @long_throws = T.let(long_throws, Integer)
          @marking = T.let(marking, Integer)
          @passing = T.let(passing, Integer)
          @penalty_taking = T.let(penalty_taking, Integer)
          @tackling = T.let(tackling, Integer)
          @technique = T.let(technique, Integer)
        end

        sig { params(player_data: T::Hash[String, String]).returns(Entities::PlayerAttributes::Technical) }
        def self.build(player_data)
          Entities::PlayerAttributes::Technical.new(
            corners: fetch_attribute(player_data, 'Cor'), crossing: fetch_attribute(player_data, 'Cro'),
            dribbling: fetch_attribute(player_data, 'Dri'), finishing: fetch_attribute(player_data, 'Fin'),
            first_touch: fetch_attribute(player_data, 'Fir'), free_kick_taking: fetch_attribute(player_data, 'Fre'),
            heading: fetch_attribute(player_data, 'Hea'), long_shots: fetch_attribute(player_data, 'Lon'),
            long_throws: fetch_attribute(player_data, 'L Th'), marking: fetch_attribute(player_data, 'Mar'),
            passing: fetch_attribute(player_data, 'Pas'), tackling: fetch_attribute(player_data, 'Tck'),
            technique: fetch_attribute(player_data, 'Tec'), penalty_taking: fetch_attribute(player_data, 'Pen')
          )
        end
      end
    end
  end
end

# rubocop:enable Metrics/ParameterLists
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
