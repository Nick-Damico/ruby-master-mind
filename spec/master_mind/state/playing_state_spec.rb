# frozen_string_literal: true

require "spec_helper"
require "shared/singleton_spec"

module MasterMind
  RSpec.describe PlayingState, type: :model do
    let(:subject) { described_class.instance }

    it_behaves_like "a singleton"

    it "returns false if checked for another state" do
      expect(subject.starting?).to eq false
    end

    it "returns true if checked for another state" do
      expect(subject).to respond_to(:starting?)
    end

    describe "#playing?" do
      it "returns true" do
        expect(subject.playing?).to eq true
      end
    end

    describe "#update" do
      context "Player is Out of Turns" do
        it "transitions to GameOverState" do
          game = Game.new(CLI.new, subject)
          allow(game).to receive(:out_of_turns?).and_return true

          subject.update_state(game)

          expect(game.state).to be_a(GameOverState)
          expect(game.state).to_not eq(subject)
        end
      end

      context "Player Won" do
        it "transitions to GameOverState" do
          game = Game.new(CLI.new, subject)
          allow(game).to receive(:won?).and_return true

          subject.update_state(game)

          expect(game.state).to be_a(GameOverState)
          expect(game.state).to_not eq(subject)
        end
      end

      context "Player has turns left and hasn't Won" do
        it "does not transition to next State" do
          game = Game.new(CLI.new, subject)
          allow(game).to receive(:won?).and_return false
          allow(game).to receive(:out_of_turns?).and_return false

          subject.update_state(game)

          expect(game.state).to be_a(described_class)
          expect(game.state).to eq subject
        end
      end
    end

    #   it "defines 3 valid states: starting, playing, and game_over" do
    #     expected_states = %i[starting playing game_over]

    #     expected_states.each do |state|
    #       expect(described_class::PHASES).to include(state)
    #     end
    #     expect(described_class::PHASES.length).to eq 3
    #   end

    #   describe "#initialize" do
    #     it "starts in STARTING state" do
    #       expect(subject.phase).to eq :starting
    #     end
    #   end

    #   describe "#update" do
    #     it "moves from STARTING to PLAYING" do
    #       expect(subject.starting?)
    #       subject.update(game)

    #       expect(subject.playing?).to eq true
    #     end

    #     it "moves from PLAYING to GAME_OVER if player runs out of turns" do
    #       subject.update(game)
    #       expect(subject.playing?).to eq true

    #       game.instance_variable_set(:@current_turn, -1)
    #       subject.update(game)
    #       expect(subject.game_over?).to eq true
    #     end

    #     it "does not move from PLAYING to GAME_OVER if player has turns remaining" do
    #       subject.update(game)
    #       expect(subject.playing?).to eq true

    #       game.instance_variable_set(:@current_turn, (1..Game::GAME_ROUNDS - 1).to_a.sample)
    #       subject.update(game)
    #       expect(subject.playing?).to eq true
    #     end

    #     it "moves from PLAYING to GAME_OVER if player has turns remaining but has decoded the pattern(Won)" do
    #       subject.update(game)
    #       expect(subject.playing?).to eq true

    #       game.instance_variable_set(:@current_turn, (1..Game::GAME_ROUNDS - 1).to_a.sample)
    #       expect(game).to receive(:decoded?).and_return(true)
    #       subject.update(game)

    #       expect(subject.game_over?).to eq true
    #     end
    #   end

    #   describe "#playing?" do
    #     it "returns true if the game is in the playing state" do
    #       subject.update(game)
    #       expect(subject.playing?).to eq true
    #     end
    #   end

    #   describe "#starting?" do
    #     it "returns true if the game is in the STARTING state" do
    #       expect(subject.starting?).to eq true
    #     end
    #   end

    #   describe "#game_over?" do
    #     it "returns true if the game is in the game_over state" do
    #       subject.phase = :game_over
    #       expect(subject.game_over?).to eq true
    #     end
    #   end
    # end
  end
end
