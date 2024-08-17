# frozen_string_literal: true

require "master_mind"

module MasterMind
  RSpec.describe CLI do
    let(:game) { Game.new(CLI.new, StartingState.instance) }
    subject { game.cli }

    context "Messages" do
      describe "#greeting" do
        it "displays game title to the player" do
          expected_output = Artii::Base.new.asciify(described_class::TITLE)

          expect { subject.greeting }.to output(match(/^#{Regexp.escape(expected_output)}\s*$/)).to_stdout
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

        allow(subject).to receive(:prompt_for_decode).with(game).and_return(stubbed_guess)

        expect(subject.player_decode(game)).to eq(stubbed_guess)
      end
    end
  end
end
