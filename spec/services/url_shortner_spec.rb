require 'rails_helper'

describe 'UrlShortener' do
 it "shortens a url to its db-id's base62 encoding" do
   # blah => id 1 =>
   url = "www.a.com"

   UrlShortener.call(url)

   expect(url).to eq('test')
 end

 it "never exceeds 6 characters when shorting the url" do
 end
end

