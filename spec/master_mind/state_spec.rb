# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe State do
    it "defines 3 valid states: starting, playing, and game_over" do
      expected_states = %i[starting playing game_over]

      expected_states.each do |state|
        expect(described_class::PHASES).to include(state)
      end
      expect(described_class::PHASES.length).to eq 3
    end

    describe "#initialize" do
      it "starts in STARTING state" do
        expect(subject.phase).to eq :starting
      end
    end

    describe "#update" do
      it "updates the state" do
        expected_state = :game_over
        subject.update(expected_state)

        expect(subject.phase).to eq expected_state
      end
    end

    describe "#playing?" do
      it "returns true if the game is in the playing state" do
        subject.update(game)
        expect(subject.playing?).to eq true
      end
    end

    describe "#starting?" do
      it "returns true if the game is in the STARTING state" do
        expect(subject.starting?).to eq true
      end
    end

    describe "#game_over?" do
      it "returns true if the game is in the game_over state" do
        subject.phase = :game_over
        expect(subject.game_over?).to eq true
      end
    end
  end
end
