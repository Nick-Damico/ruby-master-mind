# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe State do
    let(:game) { Game.new(CLI.new, State.new) }

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
      it "moves from STARTING to PLAYING" do
        expect(subject.starting?)
        subject.update(game)

        expect(subject.playing?).to eq true
      end

      it "moves from PLAYING to GAME_OVER if player runs out of turns" do
        subject.update(game)
        expect(subject.playing?).to eq true

        game.instance_variable_set(:@current_turn, Game::GAME_ROUNDS)
        subject.update(game)
        expect(subject.game_over?).to eq true
      end

      it "does not move from PLAYING to GAME_OVER if player has turns remaining" do
        subject.update(game)
        expect(subject.playing?).to eq true

        game.instance_variable_set(:@current_turn, (1..Game::GAME_ROUNDS - 1).to_a.sample)
        subject.update(game)
        expect(subject.playing?).to eq true
      end

      it "moves from PLAYING to GAME_OVER if player has turns remaining but has decoded the pattern(Won)" do
        subject.update(game)
        expect(subject.playing?).to eq true

        game.instance_variable_set(:@current_turn, (1..Game::GAME_ROUNDS - 1).to_a.sample)
        expect(game).to receive(:decoded?).and_return(true)
        subject.update(game)

        expect(subject.game_over?).to eq true
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
