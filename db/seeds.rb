# Generates Seed data via csv file in /lib/seeds/pharmacies.csv

require 'csv'
unparsed_pharmacies = File.read(Rails.root.join('lib', 'seeds', 'pharmacies.csv'))
parsed_pharmacies = CSV.parse(unparsed_pharmacies, headers: true, encoding: 'UTF-8')

parsed_pharmacies.each do |pharmacy|
  Pharmacy.create(
    name: pharmacy['name'].strip,
    street_address: pharmacy['address'].strip,
    city: pharmacy['city'].strip,
    state: pharmacy['state'].strip,
    zip: pharmacy['zip'].strip,
    latitude: pharmacy['latitude'].strip,
    longitude: pharmacy['longitude'].strip,
  )
end
