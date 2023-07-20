# frozen_string_literal: true

require "spec_helper"

module MasterMind
  RSpec.describe State do
    it "defines 3 valid states: start, playing, and game_over" do
      expected_states = %i[start playing game_over]

      expected_states.each do |state|
        expect(described_class::PHASES).to include(state)
      end
      expect(described_class::PHASES.length).to eq 3
    end
  end
end
