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
    results = AnswerChoice.find_by_sql(<<-SQL)
      SELECT
        answer_choices.*, COUNT(responses.id) AS num_responses
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        answer_choices.question_id = #{id}
      GROUP BY
        answer_choices.id
    SQL
    results.each do |answer_choice|
      results_hash[answer_choice.answer_choice] = answer_choice.num_responses
    end
    results_hash
  end

end
