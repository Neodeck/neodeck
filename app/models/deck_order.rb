class DeckOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  after_initialize :default_values

  def default_values
    self.shipped ||= false
  end

  def tracking_url
    "https://wwwapps.ups.com/WebTracking/track?track=yes&trackNums=#{self.tracking_number}&loc=en_us"
  end

  def self.calculate_shipping(address)
    package = ActiveShipping::Package.new(16, [5, 5, 5], units: :imperial)

    origin = ActiveShipping::Location.new({
      country: $ship_from_country,
      state: $ship_from_state,
      city: $ship_from_city,
      zip: $ship_from_zip
    })

    dest = ActiveShipping::Location.new({
      country: address[:country],
      state: address[:state],
      city: address[:city],
      zip: address[:zip]
    })

    # format it properly :)
    rate = $ups.find_rates(origin, dest, package).rates.sort_by(&:price)[0]
    [rate.service_name, rate.price / 100.00]
  end
end
