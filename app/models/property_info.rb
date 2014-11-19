class PropertyInfo < ActiveRecord::Base
	def rental_yield_calculation
		case self.rental_period_type_id
		when 1
			(self.rent_income.to_f * 12.0 / self.property_cost.to_f).to_d * 100
		when 2
			(self.rent_income.to_f / self.property_cost.to_f).to_d * 100
		end
	end
end
