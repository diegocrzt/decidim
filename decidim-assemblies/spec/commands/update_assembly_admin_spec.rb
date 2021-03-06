# frozen_string_literal: true

require "spec_helper"

module Decidim::Assemblies
  describe Admin::UpdateAssemblyAdmin do
    subject { described_class.new(form, user_role) }

    let!(:new_role) { "collaborator" }
    let!(:user_role) do
      user = create :assembly_admin
      Decidim::AssemblyUserRole.where(user: user).last
    end
    let(:form) do
      double(
        invalid?: invalid,
        current_user: current_user,
        role: new_role
      )
    end
    let(:current_user) { create(:user, :admin, :confirmed) }
    let(:invalid) { false }

    context "when the form is not valid" do
      let(:invalid) { true }

      it "is not valid" do
        expect { subject.call }.to broadcast(:invalid)
      end
    end

    context "when there is no user role given" do
      let(:user_role) { nil }

      it "broadcasts invalid" do
        expect { subject.call }.to broadcast(:invalid)
      end
    end

    context "when everything is ok" do
      it "updates the user role" do
        expect do
          subject.call
        end.to change { user_role.reload && user_role.role }.from("admin").to(new_role)
      end

      it "broadcasts invalid" do
        expect { subject.call }.to broadcast(:ok)
      end

      it "traces the action", versioning: true do
        expect(Decidim.traceability)
          .to receive(:update!)
          .with(user_role, current_user, { role: new_role }, resource: hash_including(:title))
          .and_call_original

        expect { subject.call }.to change(Decidim::ActionLog, :count)
        action_log = Decidim::ActionLog.last
        expect(action_log.version).to be_present
      end
    end
  end
end
