# typed: strict
# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

module Moneyball
  module Entities
    module PlayerAttributes
      Mental = Data.define(:aggression, :anticipation, :bravery, :composure, :concentration, :decisions, :determination,
                           :flair, :leadership, :off_the_ball, :positioning, :teamwork, :vision, :work_rate) do
        extend T::Sig
        extend Utils::Fetchable

        sig { returns(Integer) }
        def aggression
          @aggression
        end

        sig { returns(Integer) }
        def anticipation
          @anticipation
        end

        sig { returns(Integer) }
        def bravery
          @bravery
        end

        sig { returns(Integer) }
        def composure
          @composure
        end
        sig { returns(Integer) }
        def concentration
          @concentration
        end
        sig { returns(Integer) }
        def decisions
          @decisions
        end
        sig { returns(Integer) }
        def determination
          @determination
        end
        sig { returns(Integer) }
        def flair
          @flair
        end
        sig { returns(Integer) }
        def leadership
          @leadership
        end
        sig { returns(Integer) }
        def off_the_ball
          @off_the_ball
        end
        sig { returns(Integer) }
        def positioning
          @positioning
        end
        sig { returns(Integer) }
        def teamwork
          @teamwork
        end
        sig { returns(Integer) }
        def vision
          @vision
        end
        sig { returns(Integer) }
        def work_rate
          @work_rate
        end

        sig do
          params(aggression: Integer, anticipation: Integer, bravery: Integer, composure: Integer,
                 concentration: Integer, decisions: Integer, determination: Integer, flair: Integer,
                 leadership: Integer, off_the_ball: Integer, positioning: Integer, teamwork: Integer,
                 vision: Integer, work_rate: Integer).void
        end
        def initialize(aggression:, anticipation:, bravery:, composure:, concentration:, decisions:,
                       determination:, flair:, leadership:, off_the_ball:, positioning:, teamwork:,
                       vision:, work_rate:)
          @aggression = T.let(aggression, Integer)
          @anticipation = T.let(anticipation, Integer)
          @bravery = T.let(bravery, Integer)
          @composure = T.let(composure, Integer)
          @concentration = T.let(concentration, Integer)
          @decisions = T.let(decisions, Integer)
          @determination = T.let(determination, Integer)
          @flair = T.let(flair, Integer)
          @leadership = T.let(leadership, Integer)
          @off_the_ball = T.let(off_the_ball, Integer)
          @positioning = T.let(positioning, Integer)
          @teamwork = T.let(teamwork, Integer)
          @vision = T.let(vision, Integer)
          @work_rate = T.let(work_rate, Integer)
        end

        sig { params(player_data: T::Hash[String, String]).returns(Entities::PlayerAttributes::Mental) }
        def self.build(player_data)
          Entities::PlayerAttributes::Mental.new(
            aggression: fetch_attribute(player_data, 'Agg'), anticipation: fetch_attribute(player_data, 'Ant'),
            bravery: fetch_attribute(player_data, 'Bra'), composure: fetch_attribute(player_data, 'Cmp'),
            concentration: fetch_attribute(player_data, 'Cnt'), decisions: fetch_attribute(player_data, 'Dec'),
            determination: fetch_attribute(player_data, 'Det'), flair: fetch_attribute(player_data, 'Fla'),
            leadership: fetch_attribute(player_data, 'Ldr'), off_the_ball: fetch_attribute(player_data, 'OtB'),
            positioning: fetch_attribute(player_data, 'Pos'), teamwork: fetch_attribute(player_data, 'Tea'),
            work_rate: fetch_attribute(player_data, 'Wor'), vision: fetch_attribute(player_data, 'Vis')
          )
        end
      end
    end
  end
end

# rubocop:enable Metrics/ParameterLists
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
