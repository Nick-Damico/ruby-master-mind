# frozen_string_literal: true

module MasterMind
  class State
    PHASES = %i[start playing game_over].freeze

    attr_reader :phase

    def initialize
      @phase = :playing
    end
  end
end
