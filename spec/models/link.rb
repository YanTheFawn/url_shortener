require 'rails_helper'

describe Link do
  it { is_expected.to validate_presence_of(:url) }
end
