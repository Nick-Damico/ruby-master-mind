# frozen_string_literal: true

module MasterMind
  class State
    PHASES = %i[starting playing game_over].freeze

    attr_accessor :phase

    def initialize
      @phase = :playing
    end

    def starting?
      phase == :starting
    end

    def playing?
      phase == :playing
    end

    def game_over?
      phase == :game_over
    end

    def update(state)
      raise ArgumentError, "Invalid state" unless PHASES.include?(state)

      self.phase = state
    end

  end
end
