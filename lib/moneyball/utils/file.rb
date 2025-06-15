# typed: strict
# frozen_string_literal: true

module Moneyball
  module Utils
    # Utility methods for file read and parse operations
    module File
      class << self
        extend T::Sig

        sig { params(line_content: String).returns(T::Boolean) }
        def line_empty?(line_content)
          return true if ["\n", "\r\n"].include?(line_content) || line_content[0..3] == '| --'

          false
        end
      end
    end
  end
end
