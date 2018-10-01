require 'rails_helper'

describe Link do
  it { is_expected.to validate_presence_of(:url) }

  it { is_expected.to have_db_column(:url) }
  it { is_expected.to have_db_column(:shortened_url) }
  it { is_expected.to have_db_column(:access_count)}

  it 'requires all urls begin with https://' do

    link = Link.new(url: 'http://nike.com')
    expect(link).to_not be_valid
  end
end
