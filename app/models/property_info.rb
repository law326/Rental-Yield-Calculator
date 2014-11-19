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
end
