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

    attr_accessor :current_turn, :scoreboard
    attr_reader :interface, :decode_board, :state

    def initialize(interface)
      @current_turn = GAME_ROUNDS - 1
      @decode_board = generate_decode_board
      @scoreboard = generate_scoreboard
      @interface = interface
      @state = State.new
      @pattern = nil
    end

    def start
      # interface.greeting
      # while state.playing?
      #   interface.display_board(decode_board, scoreboard)
      #   interface.prompt_for_decode
      #   decode = interface.player_decode
      #   until validate_decode(decode)
      #     decode = interface.player_decode
      #   end
      #   insert_decode(decode)
      #   score_decode
      # end

      # decoded?(decode) ? interface.display_winning_msg : interface.display_game_over_msg
    end

    def board
      @decode_board
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
      scoreboard_pos = 0
      board[current_turn].each_with_index do |val, idx|
        next unless pattern_includes_value?(val)

        scoreboard[current_turn][scoreboard_pos] = score_decode_match(val, idx)
        scoreboard_pos += 1
      end
    end

    def out_of_turns?
      current_turn >= Game::GAME_ROUNDS
    end

    def pattern
      @pattern ||= PLAYER_TOKENS.keys.sample(PATTERN_LENGTH)
    end

    def decoded?
      board[current_turn] == pattern
    end

    def scoreboard_currrent_row
      scoreboard[current_turn]
    end

    private

    def generate_decode_board
      Array.new(GAME_ROUNDS) { Array.new(GUESSES_PER_ROUND, "-") }
    end

    def generate_scoreboard
      Array.new(GAME_ROUNDS) { Array.new(GUESSES_PER_ROUND, "-") }
    end

    def pattern_includes_value?(val)
      pattern.include?(val)
    end

    def score_decode_match(decode_val, column)
      pattern[column] == decode_val ? SCORE_TOKENS[:exact_match] : SCORE_TOKENS[:match]
    end
  end
end
