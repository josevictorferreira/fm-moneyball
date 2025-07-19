# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'moneyball/utils/file'
require_relative 'moneyball/utils/fetchable'
require_relative 'moneyball/entities/player_attributes/general'
require_relative 'moneyball/entities/player_attributes/physical'
require_relative 'moneyball/entities/player_attributes/mental'
require_relative 'moneyball/entities/player_attributes/technical'
require_relative 'moneyball/entities/player_attributes/goal_keeping'
require_relative 'moneyball/entities/coefficient'
require_relative 'moneyball/entities/rating'
require_relative 'moneyball/entities/player'
require_relative 'moneyball/entities/tactic_position'
require_relative 'moneyball/entities/tactic'
require_relative 'moneyball/core/parser'
require_relative 'moneyball/adapters/text/parser'
require_relative 'moneyball/factory'
require_relative 'moneyball/core/table'
require_relative 'moneyball/use_cases/player_evaluator'
require_relative 'moneyball/use_cases/tactic_evaluator'

# The main module for Moneyball, a library for parsing and analyzing football manager player data.
module Moneyball
  ROOT_DIR = T.let(File.expand_path('..', __dir__), String)
end
