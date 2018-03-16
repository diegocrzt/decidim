# frozen_string_literal: true

module Decidim
  module Surveys
    # Custom helpers, scoped to the surveys engine.
    #
    module ApplicationHelper
      def present_answers_for(question_form)
        SurveyAnswerPresenter.for_collection(question_form.answers)
      end
    end
  end
end
