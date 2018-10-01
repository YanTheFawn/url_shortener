require 'rails_helper'

describe 'UrlShortener' do
 it "shortens a url to its db-id's base62 value" do
   # blah => id 1 =>
   url = "www.myurl.com"
   Link.create(url: url)
   allow_any_instance_of(Link).to receive(:id).and_return(238339)

   shortened_href = UrlShortener.call(url)

   expect(shortened_href).to eq('100b')
 end

 it "never exceeds 6 characters when shorting the url" do
   url = "www.myurl.com"
   Link.create(url: url)
   allow_any_instance_of(Link).to receive(:id).and_return(987654321987)

   shortened_href = UrlShortener.call(url)

   expect(shortened_href.length < 7)
 end
end
