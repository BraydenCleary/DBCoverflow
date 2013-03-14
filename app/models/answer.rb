class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, :as => :votable
  has_many :responses, :as => :respondable
  validates :content, :presence => true
  attr_accessible :content, :question_id, :user_id

  def sum_vote
    self.votes.sum('value')
  end
end
