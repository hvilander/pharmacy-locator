class PharmacyController < ApplicationController
  def show 
    @nearest_pharmacy = Pharmacy.get_nearest_pharmacy(params[:latitude], params[:longitude]) 
    render formats: :json
  end
end
