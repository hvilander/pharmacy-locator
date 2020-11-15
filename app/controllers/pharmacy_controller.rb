class PharmacyController < ApplicationController
  def show 
    # validate that both are present an within their bounds
    params.require([:latitude, :longitude])
    latitude_useable = Float(params[:latitude]).between?(-90, 90)
    longitude_useable = Float(params[:longitude]).between?(-180, 180)
    return head 400 unless latitude_useable && longitude_useable

    @nearest_pharmacy = Pharmacy.get_nearest_pharmacy(params[:latitude], params[:longitude]) 
    return head 500 unless @nearest_pharmacy

    render formats: :json

   rescue ActionController::ParameterMissing, ArgumentError 
     return head 400
   end
end
