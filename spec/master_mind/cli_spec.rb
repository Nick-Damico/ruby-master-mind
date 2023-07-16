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
        expect { subject.display_board(game.code_board, game.key_board) }.to output(expected_output).to_stdout
      end
    end
  end
end
