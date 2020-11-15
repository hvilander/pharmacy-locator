require 'rails_helper'

RSpec.describe Pharmacy, type: :model do
  describe '#get_nearest_pharmacy' do
    context 'there is a nearest pharmacy found' do
      it 'returns the nearest pharmacy when lat lon are exactly at a pharmacy' do
        expected_name = "TALLGRASS PHARMACY"
        expected_distance = 0.0

        nearest_pharmacy = Pharmacy.get_nearest_pharmacy(39.05716000, -95.76692000)

        expect(nearest_pharmacy).to_not be_nil
        expect(nearest_pharmacy.name).to eq(expected_name);
        expect(nearest_pharmacy.distance).to eq(expected_distance);
      end

      it 'returns the nearest pharmacy when lat and lon are not at pharmacy' do
        expected_name = "ASSURED PHARMACY"
        expected_distance = 19.629

        nearest_pharmacy = Pharmacy.get_nearest_pharmacy(39.0, -95.0)

        expect(nearest_pharmacy).to_not be_nil
        expect(nearest_pharmacy.name).to eq(expected_name);
        expect(nearest_pharmacy.distance.round(4)).to eq(expected_distance);
      end

    end

    context 'no pharmacy can be found' do
      before(:each) do
        allow(Pharmacy).to receive(:all).and_return(Pharmacy.none)
      end

      it 'returns nil if a pharmacy could not be found' do
        nearest_pharmacy = Pharmacy.get_nearest_pharmacy(39.05716000, -95.76692000)
        expect(nearest_pharmacy).to eq(nil)
      end
    end
  end


end
