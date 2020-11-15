json.pharmacy do
  json.name @nearest_pharmacy.name
  json.address @nearest_pharmacy.street_address
  json.city @nearest_pharmacy.city
  json.state @nearest_pharmacy.state
  json.zip @nearest_pharmacy.zip
  json.latitude @nearest_pharmacy.latitude
  json.longitude @nearest_pharmacy.longitude
  json.distance '15 mi'
end
