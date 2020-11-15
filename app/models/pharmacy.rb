require 'geokit'

class Pharmacy < ApplicationRecord
    def self.get_nearest_pharmacy(latitude, longitude)
        # KU MED
        user_latlon = Geokit::LatLng.new(latitude, longitude);
        all_pharmacies = Pharmacy.all

        distances = all_pharmacies.map do
            |pharmacy| user_latlon.distance_to(Geokit::LatLng.new(pharmacy.latitude, pharmacy.longitude)) 
        end

        distance_index_pair = distances.each_with_index.min
        index_of_min_value = distances.each_with_index.min[1]

        nearest_pharmacy = all_pharmacies[index_of_min_value]
        nearest_pharmacy.distance = distance_index_pair[0]

        return nearest_pharmacy 
    end
end
