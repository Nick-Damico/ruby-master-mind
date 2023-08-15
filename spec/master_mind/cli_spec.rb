# frozen_string_literal: true

require "master_mind"

module MasterMind
  RSpec.describe CLI do
    let(:game) { Game.new(CLI.new, State.new) }
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

    describe "#display_options" do
      it "displays options to the player" do
        expected_options = Game::PLAYER_TOKENS.map { |key, token| "#{key}: #{token}" }.join(" ")

        expect { subject.display_options }.to output(/#{expected_options}/).to_stdout
      end
    end

    describe "#prompt_for_decode" do
      it "prompts the player with a message to enter in a decode" do
        expect do
          subject.prompt_for_decode
        end.to output("#{CLI::PROMPT_MSG}\n").to_stdout
      end
    end

    describe "#player_decode" do
      it "gets the players decode guess" do
        allow(subject).to receive(:gets).and_return("1234")
        expect(subject.player_decode).to eq([1, 2, 3, 4])
      end

      context "invalid decode entry" do
        it "does not raise an error if decode is nil value" do
          allow(subject).to receive(:gets).and_return(nil)
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
