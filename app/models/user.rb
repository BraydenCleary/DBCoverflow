class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation

  has_secure_password

  has_many :questions
  has_many :answers
  has_many :votes
  has_many :responses

  validates :email, :username, :presence => true
  validates :email, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, :length => { :minimum => 6 }

  def has_voted?(votable)
    Vote.where(user_id: self.id, votable: votable)
  end

  def upvote!(votable)
    self.votes.create(:votable => votable, :value => 1)
  end

  def downvote!(votable)
    self.votes.create(:votable => votable, :value => -1)
  end

end
