# typed: strict
# frozen_string_literal: true

module Moneyball
  module Utils
    # Utility methods for file read and parse operations
    module Fetchable
      extend T::Sig

      sig { params(player_data: T::Hash[String, String], attribute: String).returns(Integer) }
      def fetch_attribute(player_data, attribute)
        attribute_str = player_data.fetch(attribute, '1').to_s
        if attribute_str.include?('-')
          result = (attribute_str.split('-').map(&:to_i).sum / 2.0).to_i
          result.zero? ? 1 : result
        else
          attribute_str.to_i
        end
      end
    end
  end
end
