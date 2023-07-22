# frozen_string_literal: true

module MasterMind
  class Game
    GAME_ROUNDS = 10
    PATTERN_LENGTH = 4
    GUESSES_PER_ROUND = 4
    PLAYER_TOKENS = {
      1 => "🔴",
      2 => "🟢",
      3 => "🔵",
      4 => "🟡"
    }.freeze
    SCORE_TOKENS = {
      match: "⚪",
      exact_match: "⚫"
    }.freeze

    attr_accessor :current_turn, :key_board
    attr_reader :interface, :code_board, :state

    def initialize(interface)
      @current_turn = GAME_ROUNDS - 1
      @code_board = generate_code_board
      @key_board = generate_key_board
      @interface = interface
      @state = State.new
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
      board[current_turn].each_with_index do |val, idx|
        next unless pattern_includes_value?(val)

        key_board[current_turn][key_board_pos] = score_decode_match(val, idx)
        key_board_pos += 1
      end
    end

    def pattern
      @pattern ||= PLAYER_TOKENS.keys.sample(PATTERN_LENGTH)
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

    def pattern_include_value?(val)
      pattern.include?(val)
    end

    def score_decode_match(decode_val, column)
      pattern[column] == decode_val ? SCORE_TOKENS[:exact_match] : SCORE_TOKENS[:match]
    end
  end
end
