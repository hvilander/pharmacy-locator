class PharmacyController < ApplicationController

def show 
  @nearest_pharmacy = Pharmacy.first
  
  render formats: :json
end


  
end
