# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'User'

  has_many :questions,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: 'Question'
end
