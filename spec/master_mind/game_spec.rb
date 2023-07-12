# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe Game do
    describe "STATE" do
      it "defines 3 valid states: start, playing, and game_over" do
        expected_states = %i[start playing game_over]

        expected_states.each do |state|
          expect(described_class::STATE).to include(state)
        end
        expect(described_class::STATE.length).to eq 3
      end
    end

    it "returns message" do
      expect { subject.start }.to output("Welcome to MasterMind!\n").to_stdout
    end
  end
end
