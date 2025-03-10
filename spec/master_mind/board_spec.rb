# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe MasterMind::Board do
    let(:game) { Game.new(CLI.new, StartingState.instance) }
    subject { game.board }

    describe "#add_decode" do
      it "adds guess to board for the current turn" do
        current_turn = 1
        expected_decode_in_symbols = (1..4).to_a.map { |num| Game::PLAYER_TOKENS[num] }

        subject.add_decode(current_turn, expected_decode_in_symbols)

        expect(subject.decode[current_turn]).to eq expected_decode_in_symbols
      end
    end

    describe "#add_score" do
      it "add players decode score to the first empty slot in the row" do
        exact_match_score = Game::SCORE_TOKENS[:match]
        turn_count = game.current_turn

        subject.add_score(exact_match_score, turn_count)

        expect(subject.score[turn_count][0]).to eq exact_match_score
      end
    end

    describe "#to_a" do
      it "returns an array containing both the decode and score boards" do
        expect(subject.to_a).to eq [subject.decode, subject.score]
      end
    end

    %i[decode score].each do |board_sym|
      describe "##{board_sym}" do
        it "returns a 2D matrix board" do
          board = subject.send(board_sym)

          expect(board).to be_a Array
          expect(board.first).to be_a Array
        end

        it "contains rows equal to the max number of rounds per game" do
          board = subject.send(board_sym)

          expected_row_count = Game::GAME_ROUNDS

          expect(board.length).to eq expected_row_count
        end

        it "contains columns equal to the guesses per round" do
          board = subject.send(board_sym)

          max_column_size = board.min.size
          expected_column_count = Game::GUESSES_PER_ROUND

          expect(max_column_size).to eq expected_column_count
        end
      end
    end

    describe "#score_current_row" do
      it "returns the score board row that matches the game turn count" do
        expected_row = subject.score[game.current_turn]

        expect(subject.score_current_row(game.current_turn)).to eq expected_row
      end
    end
  end
end
