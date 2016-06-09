class TwoFactorMethod < ActiveRecord::Base
  belongs_to :user
  after_initialize :generate_secret

  def generate_secret
    self.secret ||= ROTP::Base32.random_base32
    self.verified ||= false
  end

  def verify(code)
    ROTP::TOTP.new(self.secret).now.to_s == code
  end

  def qr_code
    data = "otpauth://totp/CAH Creator?secret=#{self.secret}"
    data = Rack::Utils.escape(data)
    "https://chart.googleapis.com/chart?chs=200x200&chld=M|0&cht=qr&chl=#{data}"
  end
end
