require 'rails_helper'

describe API::V1::LinksController do
  describe '#show' do
    it 'updates the access count of the url requested' do
      link = Link.create(url: 'https://www.testing.com')
      shortened_url = link.shortened_url
      expect(link.access_count).to eq(0)

      get :show, params: {shortened_url: shortened_url }

      link.reload
      expect(link.access_count).to eq(1)
      expect(response).to redirect_to('https://www.testing.com')
    end

  end

  describe '#create' do
    it 'takes a valid url and returns a shortened alias' do
      post :create, params: { link: { url: 'https://www.testing.com' }}

      expected_response = Link.find_by_url('https://www.testing.com').display_shortened_url

      expect(json_response).to eq(shortened_url: expected_response)
    end

    it 'enqueues a background job to scrape the site title' do
      allow(SiteScraperJob).to receive(:perform_later)

      post :create, params: { link: { url: 'https://www.testing.com' }}

      link = Link.find_by_url('https://www.testing.com')

      expect(SiteScraperJob).to have_received(:perform_later).with({link_id: link.id})
    end
  end

  describe '#most_popular' do
    it 'returns the top 100 most frequently accessed urls' do
      popular_link = Link.create(url: "https://www.eatfood.com", access_count: 10)
      least_popular_link = Link.create(url: "https://www.study.com", access_count: 1)
      most_popular_link = Link.create(url: "https://www.party.com", access_count: 50)

      get :most_popular

      expect(json_response).to eq([
        {"url" => "https://www.party.com", "access_count" => 50},
        {"url" => "https://www.eatfood.com", "access_count" => 10},
        {"url" => "https://www.study.com", "access_count" => 1},
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
