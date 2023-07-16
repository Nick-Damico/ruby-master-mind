# frozen_string_literal: true

module MasterMind
  class Game
    GAME_ROUNDS = 10
    PATTERN_LENGTH = 4
    GUESSES_PER_ROUND = 4
    VALID_OPTIONS = ["🔴", "🟢", "🔵", "🟡"].freeze
    VALID_KEYS = ["⚪", "⚫"].freeze
    STATE = %i[start playing game_over].freeze

    attr_accessor :current_turn, :key_board
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

    def decode_guess(guess)
      raise ArgumentError, "guess must be a collection" unless guess.is_a?(Array)
      raise ArgumentError, "guess cannot be empty" if guess.empty?

      board[current_turn] = guess
    end

    def score_decode_guess
      current_row = current_turn
      board[current_turn].each_with_index do |val, col|
        key_board[current_row][col] =
          if val == pattern[col]
            VALID_KEYS[1]
          elsif pattern.include?(val)
            VALID_KEYS[0]
          else
            "-"
          end
      end
    end

    def pattern
      @pattern ||= VALID_OPTIONS.sample(PATTERN_LENGTH)
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
