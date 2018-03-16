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
        base += " (#{max_choices_label})" if question.max_choices
        base
      end

      private

      def mandatory_label
        "*"
      end

      def max_choices_label
        I18n.t("surveys.question.max_choices", scope: "decidim.surveys", n: question.max_choices)
      end
    end
  end
end
