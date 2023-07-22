# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe State do
    it "defines 3 valid states: start, playing, and game_over" do
      expected_states = %i[start playing game_over]

      expected_states.each do |state|
        expect(described_class::PHASES).to include(state)
      end
      expect(described_class::PHASES.length).to eq 3
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
        subject.update(:playing)
        expect(subject.playing?).to eq true
      end
    end

    describe "#start?" do
      it "returns true if the game is in the start state" do
        subject.update(:start)
        expect(subject.start?).to eq true
      end
    end

    describe "#game_over?" do
      it "returns true if the game is in the game_over state" do
        subject.update(:game_over)
        expect(subject.game_over?).to eq true
      end
    end
  end
end
