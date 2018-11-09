class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50 }
  validates :email, presence: true, length: {maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: {case_sensitive: false }
                  
  has_secure_password
#user-micropostsの関係性
  has_many :microposts
#user-relationships,follow(user)-reverse_of_relationshipsの関係性
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship",  foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :micropost

#follow/unfollowのためのメソッド

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  
  
  def like(micropost)
    self.favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unlike(micropost)
    relationship = self.favorites.find_by(micropost_id: micropost.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def liked_it?(micropost)
    self.likes.include?(micropost)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
end

