class Micropost < ApplicationRecord
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :be_likeds, through: :favorites, source: :user
  
  validates :content, presence:true, length:{maximum:255}
end
