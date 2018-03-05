# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Proposals
    describe NotifyProposalsMentionedJob do
      include_context "when creating a comment"
      subject { described_class }

      let(:comment) { create(:comment, commentable: commentable) }
      let(:proposal_feature) { create(:proposal_feature, organization: organization) }
      let(:proposal_metadata) { Decidim::ContentParsers::ProposalParser::Metadata.new([]) }

      describe "with mentioned proposals" do
        let(:linked_proposal) { create(:proposal, feature: proposal_feature) }

        before do
          proposal_metadata[:linked_proposals] << linked_proposal
        end
        it "notifies the author about it" do
          expect(Decidim::EventsManager)
            .to receive(:publish)
            .with(
              event: "decidim.events.comments.proposal_mentioned",
              event_class: Decidim::Proposals::ProposalMentionedEvent,
              resource: commentable,
              recipient_ids: [linked_proposal.decidim_author_id],
              extra: {
                comment_id: comment.id,
                mentioned_proposal_id: linked_proposal.id
              }
            )
          subject.perform_now(comment, proposal_metadata)
        end
      end
    end
  end
end
