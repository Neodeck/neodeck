class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email_format: true
  has_many :decks
  after_initialize :default_values

  def default_values
    self.socket_auth_token ||= SecureRandom.hex
    self.admin ||= false
    self.premium ||= false
  end

  def deck_limit
    self.premium ? 100 : 3
  end

  def premium_price
   self.premium_override_price || 999
  end

  def api_safe
    {
      id: self.id,
      name: self.name,
      email: self.email,
      admin: self.admin,
      premium: self.premium
    }
  end
end
