# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  has_many :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: 'AnswerChoice'

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: 'Poll'

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def title
    self.poll.title
  end

  def results
    results_hash = {}
    self.answer_choices.includes(:responses).each do |answer|
      results_hash[answer.answer_choice] = answer.responses.length
    end
    results_hash
  end
end
