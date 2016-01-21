# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validate :respondent_cannot_answer_twice
  validate :author_cannot_answer_own_poll

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: 'AnswerChoice'

  belongs_to :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_cannot_answer_twice
    errors[:base] << 'Respondent cannot answer twice.' if respondent_already_answered?
  end

  def author_cannot_answer_own_poll
    errors[:base] << 'Author cannot respond to own poll' if author_responded_to_own_poll?
  end

  def author_responded_to_own_poll?
    self.question.poll.author_id == self.user_id
  end

  def respondent_already_answered?
    self.sibling_responses.exists?(user_id: self.user_id)
  end
end
