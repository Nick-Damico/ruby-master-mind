# frozen_string_literal: true

require "master_mind"

module MasterMind
  RSpec.describe CLI do
    let(:game) { Game.new(CLI.new, StartingState.instance) }
    subject { game.cli }

    context "Messages" do
      describe "#greeting" do
        xit "displays game title to the player" do
          expect { subject.greeting }.to output(/MasterMind/i).to_stdout
        end
      end

      describe "#display_winning_msg" do
        it "notifies the player that they have won" do
          expect { subject.display_winning_msg }.to output("#{CLI::WINNING_MSG}\n").to_stdout
        end
      end

      describe "#display_gameover_msg" do
        it "notifies the player that they have won" do
          expect { subject.display_gameover_msg }.to output("#{CLI::GAMEOVER_MSG}\n").to_stdout
        end
      end
    end

    describe "#display_board" do
      it "displays the boards to the player" do
        # TODO: The board needs to be configurable by player.
        #       This will need to be dynamically rendered on round count.
        expected_output = <<~OUTPUT
          ====================___====================
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
          ====================^^^====================
        OUTPUT
        expect { subject.display_board(game) }.to output(expected_output).to_stdout
      end
    end

    describe "#player_decode" do
      it "gets the players decode guess" do
        stubbed_guess = [1, 2, 3, 4]
        allow(subject).to receive(:player_decode).and_return(stubbed_guess)
        expect(subject.player_decode).to eq(stubbed_guess)
      end

      xcontext "invalid decode entry" do
        it "does not raise an error if decode is nil value" do
          allow(subject).to receive(:player_decode).and_return(nil)
          expect { subject.player_decode }.to_not raise_error
        end

        it "does not raise an error if decode is a blank value" do
          allow(subject).to receive(:gets).and_return("")
          expect { subject.player_decode }.to_not raise_error
        end
      end
    end
  end
end
