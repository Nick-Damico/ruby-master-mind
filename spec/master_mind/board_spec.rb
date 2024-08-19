# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe MasterMind::Board do
    let(:game) { Game.new(CLI.new, StartingState.instance) }
    subject { game.board }

    describe "#add_decode" do
      it "adds guess to board for the current turn" do
        current_turn = 1
        expected_decode_in_symbols = (1..4).to_a.map { |num| Game::PLAYER_TOKENS[num] }

        subject.add_decode(current_turn, expected_decode_in_symbols)

        expect(subject.decode[current_turn]).to eq expected_decode_in_symbols
      end
    end
  end

end
