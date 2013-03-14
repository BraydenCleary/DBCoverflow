class Question < ActiveRecord::Base
  has_many :votes, :as => :votable
  has_many :responses, :as => :respondable
  has_many :answers
  belongs_to :user

  validates :title, :content, :presence => true

  attr_accessible :title, :content, :user_id, :vote_count

  def move_vote_counter(vote_type)
    vote_type == 'upvote' ? self.vote_count += 1 : self.vote_count -= 1
    self.save
  end

  def sum_vote
    self.votes.sum('value')
  end

end
