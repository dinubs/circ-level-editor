class User < ActiveRecord::Base
  authenticates_with_sorcery!

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username, :password, presence: :true
  has_many :games

protected

  def generate_token
    self.token = SecureRandom.urlsafe_base64
    generate_token if Game.exists?(token: self.token)
  end
end
