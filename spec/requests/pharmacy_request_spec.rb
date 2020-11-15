require 'rails_helper'

# integration tests
RSpec.describe "Pharmacies", type: :request do
  it 'should get a pharmacy as defined in the seeds' do
    get '/pharmacy', params: {latitude: '39.2', longitude: '-95.8'}

    expect(response.code).to eq('200');
    expect(response.body).to_not be_nil
    json_body = JSON.parse(response.body)
    expect(json_body['pharmacy']).to_not be_nil
    expect(json_body['pharmacy']['name']).to eq('HUNTERS RIDGE PHARMACY')
    expect(json_body['pharmacy']['address']).to eq('3405 NW HUNTERS RIDGE TER STE 200')
    expect(json_body['pharmacy']['city']).to eq('TOPEKA')
    expect(json_body['pharmacy']['state']).to eq('KS')
    expect(json_body['pharmacy']['zip']).to eq(66618)
    expect(json_body['pharmacy']['latitude']).to eq(39.129845)
    expect(json_body['pharmacy']['longitude']).to eq(-95.712654)
    expect(json_body['pharmacy']['distance']).to eq(6.745)

  end
end
