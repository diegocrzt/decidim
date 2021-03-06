# frozen_string_literal: true

module Decidim
  module Surveys
    # This class serializes the answers given by a User for survey so can be
    # exported to CSV, JSON or other formats.
    class SurveyUserAnswersSerializer < Decidim::Exporters::Serializer
      include Decidim::TranslationsHelper

      # Public: Initializes the serializer with a collection of SurveyAnswers.
      def initialize(survey_answers)
        @survey_answers = survey_answers
      end

      # Public: Exports a hash with the serialized data for the user answers.
      def serialize
        @survey_answers.each_with_index.inject({}) do |serialized, (answer, idx)|
          serialized.update("#{idx + 1}. #{translated_attribute(answer.question.body)}" => answer.body)
        end
      end
    end
  end
end
