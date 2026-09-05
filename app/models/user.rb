class User < ApplicationRecord
  has_one_attached :profile_image
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_many :favorites, dependent: :destroy
  has_many :book_coments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  def get_profile_image(width, height)
        unless profile_image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        profile_image
    end

    def follow(user)
        active_relationships.create(followed_id: user.id)
    end

    def unfollow(user)
        active_relationships.find_by(followed_id: user.id)&.destroy
    end

    def following?(user)
        followings.include?(user)
    end
end
