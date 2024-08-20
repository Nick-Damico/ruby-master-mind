# frozen_string_literal: true

module MasterMind
  class Game
    GAME_ROUNDS = 10
    PATTERN_LENGTH = 4
    GUESSES_PER_ROUND = 4
    # TODO: Update this to match offical rules,
    #       Rules state there are six different colors.
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

    attr_accessor :current_turn, :board, :decode, :state
    attr_reader :cli

    # TODO: Delgation Cleanup
    #   There is alot of delgation method calls in this class.
    #   Remove the boring boilerplate code with something like Ruby's Forwardable Class
    #   https://ruby-doc.org/stdlib-3.0.0/libdoc/forwardable/rdoc/Forwardable.html

    def initialize(cli, state)
      @current_turn = GAME_ROUNDS - 1
      @board = Board.new(GAME_ROUNDS, GUESSES_PER_ROUND)
      @decode_board = @board.decode
      @scoreboard = @board.score
      @cli = cli
      @state = state
      @decode = []
    end

    def start
      display_start_screen
      prompt_game_menu while state.starting?

      game_round while state.playing?

      display_board
      display_final_msg
    end

    def boards
      board.to_a
    end

    def decode_length
      PATTERN_LENGTH
    end

    def game_round
      display_board
      # Clear the previous guess to ensure that only the current guess is validated.
      decode.clear
      player_decode until valid_decode?

      score_decode
      add_decode
      turn_count!
      update_state
    end

    def game_tokens
      PLAYER_TOKENS
    end

    def valid_decode?
      return false unless decode&.length == PATTERN_LENGTH
      return false unless decode_contains_valid_options?

      true
    end

    def add_decode
      board.add_decode(current_turn, convert_to_symbols(decode))
    end

    def score_decode
      decode.each_with_index do |val, idx|
        next unless matches_pattern?(val)

        board.add_score(score_decode_match(val, idx), current_turn)
      end
    end

    def out_of_turns?
      current_turn.negative?
    end

    def pattern
      @pattern ||= Array.new(GUESSES_PER_ROUND) { PLAYER_TOKENS.keys.map(&:to_i).sample }
    end

    def won?
      decoded? && !out_of_turns?
    end

    def scoreboard_currrent_row
      board.score_current_row(current_turn)
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

    def decoded?
      board.match?(convert_to_symbols(pattern))
    end

    def display_board
      cli.display_board(self)
    end

    def display_start_screen
      cli.greeting
    end

    def display_gameover_msg
      cli.display_gameover_msg
    end

    def display_winning_msg
      cli.display_winning_msg
    end

    def display_final_msg
      won? ? display_winning_msg : display_gameover_msg
    end

    def player_decode
      self.decode = cli.player_decode(self)
    end

    def matches_pattern?(val)
      pattern.include?(val)
    end

    def prompt_game_menu
      selection = cli.prompt_game_menu while selection != :playing

      update_state
    end

    def prompt_for_decode
      cli.prompt_for_decode
    end

    def update_state
      state.update_state(self)
    end

    def score_decode_match(decode_val, column)
      pattern[column] == decode_val ? SCORE_TOKENS[:exact_match] : SCORE_TOKENS[:match]
    end
  end
end
