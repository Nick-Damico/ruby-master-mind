# frozen_string_literal: true

require "master_mind"

module MasterMind
  RSpec.describe CLI do
    let(:game) { Game.new(CLI.new) }
    subject { game.interface }

    describe "#greeting" do
      it "displays an initial message to the player" do
        expect { subject.greeting }.to output("Welcome to MasterMind!\n").to_stdout
      end
    end
  end
end
