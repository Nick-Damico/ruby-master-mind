# frozen_string_literal: true

require "master_mind"

module MasterMind
  RSpec.describe CLI do
    let(:game) { Game.new(CLI.new) }
    subject { game.interface }

    describe "#greeting" do
      it "displays game title to the player" do
        expect { subject.greeting }.to output(/MasterMind/i).to_stdout
      end
    end

    describe "#display_board" do
      it "outputs the board" do
        # TODO: The board needs to be configurable by player.
        #       This will need to be dynamically rendered on round count.
        expected_output = <<~OUTPUT
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
          | - | - | - | - | | - | - | - | - |
        OUTPUT
        expect { subject.display_board(game.decode_board, game.scoreboard) }.to output(expected_output).to_stdout
      end
    end

    describe "#prompt_for_decode" do
      it "prompts the player with a message to enter in a decode" do
        expect { subject.prompt_for_decode }.to output("Enter your #{Game::PATTERN_LENGTH} digit decode guess: \n").to_stdout
      end
    end

    describe "#player_decode" do
      it "gets the players decode guess" do
        expected_selection = 1
        expect(subject).to receive(:player_decode).and_return(expected_selection)
        expect(subject.player_decode).to eq(expected_selection)
      end
    end
  end
end
