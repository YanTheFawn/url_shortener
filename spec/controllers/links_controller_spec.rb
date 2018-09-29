require 'rails_helper'

describe API::V1::LinksController do
  describe '#show' do
    it 'updates the access count of the url requested' do
      link = Link.create(url: 'www.testing.com')
      shortened_url = link.shortened_url
      expect(link.access_count).to eq(0)

      get :show, params: {shortened_url: shortened_url }

      link.reload
      expect(link.access_count).to eq(1)
      expect(response).to redirect_to('www.testing.com')
    end
  end

  describe '#create' do
    it 'takes a valid url and returns a shortened alias' do
      post :create, params: { link: { url: 'www.testing.com' }}

      expected_response = "https://mysite.com/1"

      expect(json_response).to eq(shortened_url: expected_response)
    end
  end

  describe '#most_popular' do
    it 'returns the top 100 most frequently accessed urls' do
      popular_link = Link.create(url: "http://www.eatfood.com", access_count: 10)
      least_popular_link = Link.create(url: "http://www.study.com", access_count: 1)
      most_popular_link = Link.create(url: "http://www.party.com", access_count: 50)

      get :most_popular

      expect(json_response).to eq([
        "http://www.party.com",
        "http://www.eatfood.com",
        "http://www.study.com",
      ])
    end
  end

  #describe '#show' do
    #it 'redirects the user to the full link associated with the provided alias' do

    #end
  #end
  def json_response
    parsed_response = JSON.parse(response.body)
    parsed_response.symbolize_keys! if parsed_response.is_a?(Hash)

    parsed_response
  end
end
