# frozen_string_literal: true

require "spec_helper"

RSpec.shared_examples "a singleton" do
  describe ".instance" do
    it "returns same object instance" do
      prev_obj = described_class.instance

      expect(prev_obj).to eq described_class.instance
    end
  end
end
