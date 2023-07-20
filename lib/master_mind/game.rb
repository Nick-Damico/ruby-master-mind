# frozen_string_literal: true

module MasterMind
  class Game
    GAME_ROUNDS = 10
    PATTERN_LENGTH = 4
    GUESSES_PER_ROUND = 4
    PLAYER_TOKENS = ["🔴", "🟢", "🔵", "🟡"].freeze
    SCORE_TOKENS = {
      match: "⚪",
      exact_match: "⚫"
    }.freeze
    STATE = %i[start playing game_over].freeze

    attr_accessor :current_turn, :key_board
    attr_reader :interface, :code_board

    def initialize(interface)
      @current_turn = GAME_ROUNDS - 1
      @code_board = generate_code_board
      @key_board = generate_key_board
      @interface = interface
      @pattern = nil
    end

    def start
      interface.greeting
    end

    def board
      @code_board
    end

    def validate_decode(decode)
      return false unless decode.to_s.length == PATTERN_LENGTH
      return false unless decode_contains_valid_options?(decode)

      true
    end

    def insert_decode(decode)
      board[current_turn] = decode
    end

    def decode_contains_valid_options?(decode)
      decode.digits.reverse.all? { |num| num >= 1 && num <= PATTERN_LENGTH }
    end

    def score_decode_guess
      key_board_pos = 0
      current_row = current_turn
      board[current_row].each_with_index do |val, col|
        next unless pattern_includes_value?(val)

        key_board[current_row][key_board_pos] = score_pattern_match(val, col)
      end
    end

    def pattern
      @pattern ||= PLAYER_TOKENS.sample(PATTERN_LENGTH)
    end

    def decoded?
      board[current_turn] == pattern
    end

    private

    def generate_code_board
      Array.new(GAME_ROUNDS, Array.new(GUESSES_PER_ROUND, "-"))
    end

    def generate_key_board
      Array.new(GAME_ROUNDS, Array.new(GUESSES_PER_ROUND, "-"))
    end

    def pattern_includes_value?(val)
      pattern.include?(val)
    end

    def score_pattern_match(val, column)
      val == pattern[column] ? SCORE_TOKENS[:exact_match] : SCORE_TOKENS[:match]
    end
  end
end
