require 'rails_helper'

describe API::V1::LinksController do
  describe '#create' do
    it 'takes a valid url and returns a shortened alias' do
      post :create, params: { link: { url: 'www.testing.com' }}

      expected_response = "https://mysite.com/1"

      expect(json_response).to eq(shortened_url: expected_response)
    end
  end

  #describe '#most_popular' do
    #it 'returns the top 100 most frequently accessed urls' do
    #end
  #end

  #describe '#show' do
    #it 'redirects the user to the full link associated with the provided alias' do

    #end
  #end
  def json_response
    JSON.parse(response.body).symbolize_keys
  end
end
