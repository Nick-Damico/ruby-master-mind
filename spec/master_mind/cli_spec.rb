# frozen_string_literal: true

require "master_mind"

module MasterMind
  RSpec.describe CLI do
    let(:game) { Game.new(CLI.new, State.new) }
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
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
          | 🔘 | 🔘 | 🔘 | 🔘 | | 🔘 | 🔘 | 🔘 | 🔘 |
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
      it "gets the players decode guess and coverts to an integer" do
        allow(subject).to receive(:gets).and_return("1234")
        expect(subject.player_decode).to eq([1, 2, 3, 4])
      end
    end
  end
end
