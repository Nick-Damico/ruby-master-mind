# frozen_string_literal: true

require "spec_helper"
require "shared/singleton_spec"

module MasterMind
  RSpec.describe GameOverState, type: :model do
    let(:subject) { described_class.instance }

    it_behaves_like "a singleton"

    describe "#gameover?" do
      it "returns true" do
        expect(subject.gameover?).to eq true
      end
    end

    describe "#update" do
      it "transitions to StartingState" do
        game = Game.new(CLI.new, subject)

        subject.update_state

        expect(game.state).to_not eq subject
        expect(game.state.starting?).to eq true
      end
    end
  end
end
