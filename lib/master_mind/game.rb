# frozen_string_literal: true

module MasterMind
  class Game
    GAME_ROUNDS = 10 # TODO: Make configurable from game menu.
    GUESSES_PER_ROUND = 4
    STATE = %i[start playing game_over].freeze

    def start
      greeting
    end

    def greeting
      puts "Welcome to MasterMind!"
    end

    def board
      generate_board
    end

    private

    def generate_board
      Array.new(GAME_ROUNDS, Array.new(GUESSES_PER_ROUND, ""))
    end
  end
end
