# frozen_string_literal: true

require "spec_helper"
require "shared/singleton_spec"

module MasterMind
  RSpec.describe StartingState, type: :model do
    let(:subject) { described_class.instance }

    it_behaves_like "a singleton"

    describe "#starting?" do
      it "returns true for instance of StartingState" do
        expect(subject.starting?).to eq true
      end
    end

    describe "#update_state" do
      it "moves game to PlayingState" do
        game = Game.new(CLI.new, subject)

        subject.update_state(game)

        expect(game.state).to_not eq subject
        expect(game.state).to be_a PlayingState
      end
    end
  end
end
