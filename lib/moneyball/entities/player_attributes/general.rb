# typed: strict
# frozen_string_literal: true

module Moneyball
  module Entities
    module PlayerAttributes
      General = Data.define(:age, :height, :position, :club) do
        extend T::Sig

        sig { returns(Integer) }
        def age
          @age
        end

        sig { returns(Integer) }
        def height
          @height
        end

        sig { returns(String) }
        def position
          @position
        end

        sig { returns(String) }
        def club
          @club
        end

        sig { params(age: Integer, height: Integer, position: String, club: String).void }
        def initialize(age:, height:, position:, club: 'Unknown')
          @age = T.let(age, Integer)
          @height = T.let(height, Integer)
          @position = T.let(position, String)
          @club = T.let(club, String)
        end

        sig { returns(T::Hash[String, T.any(Integer, String)]) }
        def to_h
          { age: age, height: height, position: position, club: club }
        end

        sig { params(player_data: T::Hash[String, String]).returns(Entities::PlayerAttributes::General) }
        def self.build(player_data)
          Entities::PlayerAttributes::General.new(
            age: player_data.fetch('Age', '0').to_i,
            position: player_data.fetch('Position', 'GK').to_s,
            height: player_data.fetch('Height', '150 cm').gsub(' cm', '').to_s.to_i,
            club: player_data.fetch('Club', 'Unknown').to_s
          )
        end
      end
    end
  end
end
