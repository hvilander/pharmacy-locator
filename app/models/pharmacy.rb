require 'geokit'

class Pharmacy < ApplicationRecord
    attr_accessor :distance

    # Public: Class method to find the pharmacy nearest to the given location in latitude / longitude
    #
    # latitude: a String representation of the latitude
    # longitude: a String representation of the longitude 
    #
    # Returns a Pharmacy object with a distance field. The distance is caluclated in miles between the user's
    # location and the Pharmacy. Returns nil if no pharmacy can be located. 
    def self.get_nearest_pharmacy(latitude, longitude)
        
        user_latlon = Geokit::LatLng.new(latitude, longitude);
        all_pharmacies = Pharmacy.all

        distances = all_pharmacies.map do
            |pharmacy| user_latlon.distance_to(Geokit::LatLng.new(pharmacy.latitude, pharmacy.longitude)) 
        end


        distance_index_pair = distances.each_with_index.min
        return nil unless distance_index_pair

        index_of_min_value = distances.each_with_index.min[1]
        nearest_pharmacy = all_pharmacies[index_of_min_value]
        nearest_pharmacy.distance = distance_index_pair[0]

        return nearest_pharmacy 
    end
end
