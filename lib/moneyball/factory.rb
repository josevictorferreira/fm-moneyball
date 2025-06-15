# typed: strict
# frozen_string_literal: true

require_relative 'core/parser'
require_relative 'adapters/text/parser'

module Moneyball
  # Factory class to create adapters based on the URL
  class AdapterFactory
    extend T::Sig

    DATA_FILE_ADAPTERS = T.let({
      rtf: Adapters::Text::Parser,
      text: Adapters::Text::Parser
    }.freeze, T::Hash[Symbol, T.class_of(Core::Parser)])

    sig { params(type: Symbol).returns(T.class_of(Core::Parser)) }
    def self.parser_for(type)
      DATA_FILE_ADAPTERS.fetch(type, Adapters::Text::Parser)
    end
  end
end
