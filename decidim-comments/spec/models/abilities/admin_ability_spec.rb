# frozen_string_literal: true

require "spec_helper"

module Decidim::Comments
  describe Abilities::AdminAbility do
    subject { described_class.new(user, context) }

    let(:user) { build(:user, :admin) }
    let(:context) { {} }

    context "when the user is not an admin" do
      let(:user) { build(:user) }

      it "doesn't have any permission" do
        expect(subject.permissions[:can]).to be_empty
        expect(subject.permissions[:cannot]).to be_empty
      end
    end

    it { is_expected.to be_able_to(:manage, Comment) }
  end
end
