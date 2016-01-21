# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :authored_polls,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'Poll'

  has_many :responses,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Response'

  def completed_polls
    Poll.find_by_sql(<<-SQL)
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON questions.poll_id = polls.id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN (
        SELECT
          responses.*
        FROM
          responses
        WHERE
          responses.user_id = #{id}
      ) AS user_responses
        ON user_responses.answer_choice_id = answer_choices.id
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.id) = COUNT(user_responses.id)
    SQL
  end
end
