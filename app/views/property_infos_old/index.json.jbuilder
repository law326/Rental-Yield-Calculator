json.array!(@property_infos) do |property_info|
  json.extract! property_info, :id, :email, :phone_number, :postcode, :rental_period_type_id, :rent_income, :property_cost
  json.url property_info_url(property_info, format: :json)
end
