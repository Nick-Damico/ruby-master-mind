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

    attr_accessor :current_turn, :scoreboard, :decode
    attr_reader :interface, :decode_board, :state

    def initialize(interface, state)
      @current_turn = GAME_ROUNDS - 1
      @decode_board = generate_decode_board
      @scoreboard = generate_scoreboard
      @interface = interface
      @state = state
      @decode = []
      pattern
    end

    def start
      # interface.greeting
      # state.update(self)
      # while state.playing?
      #   interface.display_board(decode_board, scoreboard)

      #   until validate_decode
      #     interface.prompt_for_decode
      #     self.decode = interface.player_decode
      #   end

      #   score_decode
      #   insert_decode
      #   self.current_turn -= 1
      #   state.update(self)
      # end

      # decoded?(decode) ? interface.display_winning_msg : interface.display_game_over_msg
    end

    def board
      @decode_board
    end

    def validate_decode
      return false unless decode.length == PATTERN_LENGTH
      return false unless decode_contains_valid_options?

      true
    end

    def insert_decode
      board[current_turn] = convert_to_symbols(decode)
    end

    def score_decode
      scoreboard_pos = 0
      decode.each_with_index do |val, idx|
        next unless pattern_includes_value?(val)

        scoreboard[current_turn][scoreboard_pos] = score_decode_match(val, idx)
        scoreboard_pos += 1
      end
    end

    def out_of_turns?
      current_turn.negative?
    end

    def pattern
      @pattern ||= Array.new(GUESSES_PER_ROUND) { PLAYER_TOKENS.keys.map(&:to_i).sample }
    end

    def decoded?
      pattern_in_symbols = convert_to_symbols(pattern)
      board.any? { |decode| decode == pattern_in_symbols }
    end

    def scoreboard_currrent_row
      scoreboard[current_turn]
    end

    private

    def turn_count!
      self.current_turn -= 1
    end

    def convert_to_symbols(num_arr)
      num_arr.map { |num| PLAYER_TOKENS[num] }
    end

    def decode_contains_valid_options?
      decode.all? { |num| num >= 1 && num <= PATTERN_LENGTH }
    end

    def generate_decode_board
      Array.new(GAME_ROUNDS) { Array.new(GUESSES_PER_ROUND, "🔘") }
    end

    def generate_scoreboard
      Array.new(GAME_ROUNDS) { Array.new(GUESSES_PER_ROUND, "🔘") }
    end

    def pattern_includes_value?(val)
      pattern.include?(val)
    end

    def score_decode_match(decode_val, column)
      pattern[column] == decode_val ? SCORE_TOKENS[:exact_match] : SCORE_TOKENS[:match]
    end
  end
end
