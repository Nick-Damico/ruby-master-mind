# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe Game do
    let(:interface) { CLI.new }
    subject { described_class.new(interface) }

    describe "#initialize" do
      it "setups the #current_turn on the last row of the board" do
        expect(subject.current_turn).to eq(described_class::GAME_ROUNDS - 1)
      end
    end

    describe "#board" do
      it "returns a 2D matrix board" do
        board = subject.board
        expect(board).to be_a Array
        expect(board.first).to be_a Array
      end

      it "contains rows equal to the max number of rounds per game" do
        expected_row_count = described_class::GAME_ROUNDS
        expect(subject.board.length).to eq expected_row_count
      end

      it "contains columns equal to the guesses per round" do
        expected_column_count = described_class::GUESSES_PER_ROUND
        min_column_size = subject.board.max.size
        max_column_size = subject.board.min.size

        expect(min_column_size).to eq expected_column_count
        expect(max_column_size).to eq expected_column_count
      end
    end

    describe "#out_of_turns?" do
      it "returns true if player is out of turns" do
        subject.current_turn = Game::GAME_ROUNDS
        expect(subject.out_of_turns?).to eq true
      end
    end

    describe "#validate_decode" do
      it "validates the players decode guess" do
        decode = 1234
        expect(subject.validate_decode(decode)).to eq true
      end

      it "validates that the decode guess matches the pattern length" do
        decode = [*(1..4)].sample(described_class::PATTERN_LENGTH).join.to_i
        expect(subject.validate_decode(decode)).to eq true
      end

      it "validates that the decode guess is not empty" do
        decode = ""
        expect(subject.validate_decode(decode)).to eq false
      end

      it "validates that the decode guess contains valid selections" do
        invalid_option = described_class::PATTERN_LENGTH + 1
        decode = [*(1..4)].sample(described_class::PATTERN_LENGTH - 1)
        decode << invalid_option
        decode.join.to_i

        expect(subject.validate_decode(decode)).to eq false
      end
    end

    describe "#insert_decode" do
      it "adds guess to board for the current turn" do
        players_guess = [*1..4]
        subject.current_turn = 1
        subject.insert_decode(players_guess)

        expect(subject.board[subject.current_turn]).to eq players_guess
      end
    end

    describe "#pattern" do
      it "returns a secret pattern that the player must match to win" do
        expect(subject.pattern).to be_a(Array)
      end

      it "returns a pattern that matches the pattern length defined by the game" do
        expect(subject.pattern.length).to eq described_class::PATTERN_LENGTH
      end

      it "returns a pattern of only valid options defined by the game" do
        subject.pattern.each do |value|
          expect(described_class::PLAYER_TOKENS).to include(value)
        end
      end

      it "returns a consistent pattern across mulitple invocations" do
        expected_pattern = subject.pattern
        expect(subject.pattern).to eq expected_pattern
      end
    end

    describe "#decoded?" do
      it "returns true if player decoded the secret pattern" do
        expected_pattern = subject.pattern
        subject.insert_decode(expected_pattern)

        expect(subject.decoded?).to eq true
      end
    end

    describe "#score_decode" do
      it "scores current row of the scoreboard for each correctly decoded value" do
        pattern = %w[3 3 2 1]
        guess   = "1222"
        subject.instance_variable_set(:@pattern, pattern)
        subject.score_decode(guess)
        subject.insert_decode(guess)

        exact_match_token = described_class::SCORE_TOKENS[:exact_match]
        match_token = described_class::SCORE_TOKENS[:match]

        expect(subject.scoreboard_currrent_row.tally[match_token]).to eq 3
        expect(subject.scoreboard_currrent_row.tally[exact_match_token]).to eq 1
      end
    end
  end
end
