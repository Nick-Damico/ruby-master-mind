# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe Game do
    let(:interface) { CLI.new }
    subject { described_class.new(interface) }

    describe "Game State" do
      it "defines 3 valid states: start, playing, and game_over" do
        expected_states = %i[start playing game_over]

        expected_states.each do |state|
          expect(described_class::STATE).to include(state)
        end
        expect(described_class::STATE.length).to eq 3
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

    describe "#input_guess" do
      it "adds guess to board for the current turn" do
        players_guess = [*1..4]
        subject.current_turn = 1
        subject.input_guess(players_guess)

        expect(subject.board[subject.current_turn]).to eq players_guess
      end
    end
  end
end
