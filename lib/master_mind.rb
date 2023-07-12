# frozen_string_literal: true

# A Gem's root file is in charge of laoding code for the gem.

require "pry-byebug"
require_relative "master_mind/version"

module MasterMind
  class Error < StandardError; end
  # Your code goes here...
  require_relative "master_mind/game"

  Game.new.start
end
