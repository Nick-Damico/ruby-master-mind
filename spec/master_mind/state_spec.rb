# frozen_string_literal: true

require "spec_helper"
require "shared/singleton_spec"

module MasterMind
  RSpec.describe State, type: :model do
    it_behaves_like "a singleton"

    it "requires subclasses to implement #update_state" do
      class TestState < State; end
      new_state = TestState.instance

      expect { new_state.update_state }.to raise_error(NotImplementedError)
    end
  end
end
