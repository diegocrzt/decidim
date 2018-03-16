# frozen_string_literal: true

module Decidim
  module Surveys
    class SurveyAnswerPresenter < SimpleDelegator
      include Decidim::TranslationsHelper

      def self.for_collection(answers)
        answers.map { |answer| new(answer) }
      end

      def label
        base = "#{question.position}. #{translated_attribute(question.body)}"
        base += " #{mandatory_label}" if question.mandatory?
        base
      end

      private

      def mandatory_label
        "*"
      end
    end
  end
end
