# frozen_string_literal: true

# A Gem's root file is in charge of laoding code for the gem.

require "pry-byebug"
require_relative "master_mind/game"
require_relative "master_mind/cli"
require_relative "master_mind/state"
require_relative "master_mind/version"

module MasterMind
  class Error < StandardError; end
  # Your code goes here...

  Game.new(
    CLI.new,
    State.new
  ).start
end
