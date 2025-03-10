# frozen_string_literal: true

## TODO:
#   Can the board manage the turn count?
#   - This is state that is constantly needing to be
#     passed by the game's state.
#   - Turn count is the number of filled in rows + 1
module MasterMind
  class Board
    EMPTY_TOKEN = "🔘"

    attr_accessor :decode, :score

    def initialize(rounds, guesses_per_round)
      @rounds = rounds
      @guesses = guesses_per_round
      @decode = generate_decode
      @score = generate_score
    end

    def to_a
      [decode, score]
    end

    def add_decode(row, code)
      decode[row] = code
    end

    def add_score(decode_score, turn_count)
      score[turn_count][first_empty_slot(turn_count)] = decode_score
    end

    def match?(solution)
      decode.any? { |code| code == solution }
    end

    def score_current_row(turn_count)
      score[turn_count]
    end

    private

    def generate_decode
      Array.new(@rounds) { Array.new(@guesses, EMPTY_TOKEN) }
    end

    def generate_score
      Array.new(@rounds) { Array.new(@guesses, EMPTY_TOKEN) }
    end

    def first_empty_slot(turn_count)
      score[turn_count].find_index { |column| column == EMPTY_TOKEN }
    end
  end
end
