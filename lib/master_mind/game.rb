# frozen_string_literal: true

module MasterMind
  class Game
    GAME_ROUNDS = 10 # TODO: Make configurable from game menu.
    GUESSES_PER_ROUND = 4
    STATE = %i[start playing game_over].freeze

    attr_accessor :current_turn
    attr_reader :interface, :code_board, :key_board

    def initialize(interface)
      @interface = interface
      @current_turn = 0
      @code_board = generate_code_board
      @key_board = generate_key_board
    end

    def start
      interface.greeting
    end

    def board
      @code_board
    end

    def input_guess(guess)
      raise ArgumentError, "guess must be a collection" unless guess.is_a?(Array)
      raise ArgumentError, "guess cannot be empty" if guess.empty?

      board[current_turn] = guess
    end

    private

    def generate_code_board
      Array.new(GAME_ROUNDS, Array.new(GUESSES_PER_ROUND, "-"))
    end

    def generate_key_board
      Array.new(GAME_ROUNDS, Array.new(GUESSES_PER_ROUND, "-"))
    end
  end
end
