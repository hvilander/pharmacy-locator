require 'rails_helper'

module PharmacyLocationEngine
  describe PharmacyController, type: :request do
    describe '#show' do
      context 'server error' do
          before(:each) do
            allow(Pharmacy).to receive(:get_nearest_pharmacy).and_return(nil)
          end
        it 'should return 500' do
          get '/pharmacy', params: {latitude: '0.0', longitude: '5.5'}
          expect(response.code).to eq('500');
          expect(response.body).to eq('');
        end
      end
      context 'Both params are present' do
        before(:each) do
          mock_pharmacy = Pharmacy.new({
            name: 'mock_pharm',
            street_address: 'mock_street_address',
            city: 'mock_city',
            state: 'ST',
            zip: 123456,
            distance: 15.0,
            })
          allow(Pharmacy).to receive(:get_nearest_pharmacy).and_return(mock_pharmacy)
        end

        it 'should call Pharmacy.get_nearest_pharmacy retrieving the mock data' do
          get '/pharmacy', params: {latitude: '0.0', longitude: '5.5'}
          expect(response.code).to eq('200');
          expect(response.body).to_not be_nil
          json_body = JSON.parse(response.body)

          expect(json_body['pharmacy']).to_not be_nil
          expect(json_body['pharmacy']['name']).to eq('mock_pharm')
        end

        it 'should return bad request when latitude is out of range' do
          get '/pharmacy', params: {latitude: '-10000.0', longitude: '5.5'}

          expect(response.code).to eq('400')
          expect(response.body).to eq('') 
        end

        it 'should return bad request when longitude is out of range' do
          get '/pharmacy', params: {latitude: '-10.0', longitude: '10000000.1'}

          expect(response.code).to eq('400')
          expect(response.body).to eq('') 
        end

        it 'should return bad request when latitude is not a float' do
          get '/pharmacy', params: {latitude: 'this is not a good float', longitude: '10000000.1'}

          expect(response.code).to eq('400')
          expect(response.body).to eq('') 
        end

        it 'should return bad request when latitude is not a float' do
          get '/pharmacy', params: {latitude: '10.000', longitude: 'this is also not a float'}

          expect(response.code).to eq('400')
          expect(response.body).to eq('') 
        end
      end

      context 'There are missing params' do
        it 'should return bad request when latitude is missing' do
          get '/pharmacy', params: {longitude: '-10.000'}

          expect(response.code).to eq('400')
          expect(response.body).to eq('') 
        end

        it 'should return bad request when longitude is missing' do
          get '/pharmacy', params: {latitude: '-10.000'}

          expect(response.code).to eq('400')
          expect(response.body).to eq('') 
        end

        it 'should return bad request both params are missing' do
          get '/pharmacy', params: {}

          expect(response.code).to eq('400')
          expect(response.body).to eq('') 
        end
      end
    end
  end
end