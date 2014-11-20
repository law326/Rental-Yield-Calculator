require 'nokogiri'

class PropertyInfo < ActiveRecord::Base

  validates :email, presence: true
  validates :phone_number, presence: true
  validates :postcode, presence: true
  validates :rental_period_type_id, presence: true
  validates :rent_income, presence: true
  validates_numericality_of :rent_income
  validates :property_cost, presence: true
  validates_numericality_of :property_cost

  def rental_yield_calculation
    self.errors.add(:property_cost, 'cannot be zero') if self.property_cost == 0
    return false unless self.errors.empty?

    case self.rental_period_type_id
    when 1
      (self.rent_income.to_f * 12.0 / self.property_cost.to_f).to_d * 100
    when 2
      (self.rent_income.to_f / self.property_cost.to_f).to_d * 100
    end
  end

  def nearby_property_price
  	begin
	  	xml = WebApiUtil.get('api/v1/average_sold_prices.xml', {:postcode => self.postcode, :output_type => 'outcode', :area_type => 'streets', :api_key => 'u5p5yfvmxg3vvw3tubh6s7gn'})
	  	xml = Nokogiri::XML(xml)
	  	return nil if xml.xpath("//average_sold_price_1year").first.nil?
	  	xml.xpath("//average_sold_price_1year").first.content
  	rescue
  		return nil
  	end
  end

  def rent_suggestion
  	case self.rental_period_type_id
    when 1
      my_yield = self.rental_yield_calculation
      suggested_rent = self.nearby_property_price.to_d * (my_yield / 100).to_d / 12.0
    when 2
      my_yield = self.rental_yield_calculation
      suggested_rent = self.nearby_property_price.to_d * (my_yield / 100).to_d * 12.0
    end
  end
end
