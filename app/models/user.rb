class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email_format: true
  has_many :decks
  has_many :two_factor_methods
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

  def two_factor_count
    self.two_factor_methods.count
  end

  def validate_two_factor_code(code)
    if self.two_factor_methods.count > 0
      validation_success = false

      self.two_factor_methods.each do |method|
        if method.verify(code)
          # we did it!
          validation_success = true
          break
        end
      end

      validation_success
    else
      true # if there aren't any two-factor methods, we can't really verify it.
    end
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
