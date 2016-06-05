class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :socket_auth_token
  validates_uniqueness_of :email
  validates_presence_of :name
  has_many :decks
  before_create :generate_token

  def generate_token
    self.socket_auth_token = SecureRandom.hex
    self.admin ||= false
  end

  def api_safe
    {
      id: self.id,
      name: self.name,
      email: self.email,
      admin: self.admin
    }
  end
end
