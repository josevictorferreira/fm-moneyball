# typed: strict
# frozen_string_literal: true

module Moneyball
  module Core
    # Abstract base class for parsers
    class Parser
      extend T::Sig
      extend T::Helpers
      abstract!

      sig { returns(String) }
      attr_reader :file_path

      sig { params(file_path: String).void }
      def initialize(file_path)
        @file_path = T.let(file_path, String)
      end

      sig { abstract.returns(T::Array[Entities::Player]) }
      def call; end

      sig { params(file_path: String).returns(T::Array[Entities::Player]) }
      def self.call(file_path)
        new(file_path).call
      end
    end
  end
end
