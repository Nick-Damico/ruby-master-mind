# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe MasterMind::Game do
    let(:cli) { CLI.new }
    subject { described_class.new(cli, StartingState.instance) }

    describe "#initialize" do
      it "setups the #current_turn on the last row of the board" do
        expect(subject.current_turn).to eq(described_class::GAME_ROUNDS - 1)
      end
    end

    describe "#decode_length" do
      it "returns the length of the secret decode" do
        expected_length = described_class::PATTERN_LENGTH
        expect(subject.decode_length).to eq expected_length
      end
    end

    describe "#out_of_turns?" do
      it "returns true if player is out of turns" do
        subject.current_turn = -1
        expect(subject.out_of_turns?).to eq true
      end
    end

    describe "#valid_decode?" do
      it "validates the players decode guess" do
        subject.decode = [1, 2, 3, 4]
        expect(subject.valid_decode?).to eq true
      end

      it "validates that the decode guess matches the pattern length" do
        subject.decode = [*(1..4)].sample(described_class::PATTERN_LENGTH)
        expect(subject.valid_decode?).to eq true
      end

      it "validates that the decode guess is not empty" do
        subject.decode = ""
        expect(subject.valid_decode?).to eq false
      end

      it "validates that the decode guess contains valid selections" do
        invalid_option = described_class::PATTERN_LENGTH + 1
        subject.decode = [*(1..4)].sample(described_class::PATTERN_LENGTH - 1)
        subject.decode << invalid_option

        expect(subject.valid_decode?).to eq false
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

    describe "#won?" do
      it "returns true if player decoded the secret pattern" do
        expected_pattern = subject.pattern
        subject.decode = expected_pattern
        subject.add_decode

        expect(subject.won?).to eq true
      end
    end

    describe "#score_decode" do
      let(:pattern) { [2, 2, 2, 4] }
      let!(:exact_match_token) { described_class::SCORE_TOKENS[:exact_match] }
      let!(:match_token) { described_class::SCORE_TOKENS[:match] }

      before do
        subject.instance_variable_set(:@pattern, pattern)
      end

      it "scores a match in the right position with a single 'black' token" do
        subject.decode = [1, 1, 1, 4]
        subject.score_decode
        subject.add_decode

        expect(subject.scoreboard_currrent_row.tally[exact_match_token]).to eq 1
      end

      it "scores a match in the wrong position with a single 'white' token" do
        subject.decode = [1, 4, 1, 1]
        subject.score_decode
        subject.add_decode

        expect(subject.scoreboard_currrent_row.tally[match_token]).to eq 1
      end

      xit "scores current row of the scoreboard for each correctly decoded value" do
        subject.decode = [1, 2, 2, 2]
        subject.score_decode
        subject.add_decode

        expect(subject.scoreboard_currrent_row.tally[match_token]).to eq 3
        expect(subject.scoreboard_currrent_row.tally[exact_match_token]).to eq 1
      end
    end
  end
end
