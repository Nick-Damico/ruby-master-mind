# frozen_string_literal: true

module MasterMind
  class State
    PHASES = %i[starting playing game_over].freeze

    attr_accessor :phase

    def initialize
      @phase = :starting
    end

    def update(game)
      case phase
      when :starting
        self.phase = :playing
      when :playing
        return unless game.out_of_turns? || game.decoded?

        self.phase = :game_over
      end
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
  end
end
