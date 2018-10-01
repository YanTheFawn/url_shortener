require 'rails_helper'

describe "Link retrieval" do
  it 'redirects the user from the shortened url to the full url' do
    link = Link.create(url: 'https://www.nike.com')
    shortened_url = link.shortened_url

    get "/#{shortened_url}"

    expect(response).to redirect_to('https://www.nike.com')
  end
end
