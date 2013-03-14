class Response < ActiveRecord::Base
  belongs_to :respondable, :polymorphic => true
  has_many :votes, :as => :votable
  belongs_to :user

  attr_accessible :user_id, :content

  validates :content, :presence => true

  def sum_vote
    self.votes.sum('value')
  end
end
