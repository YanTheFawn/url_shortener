class IntegerToBase62
  attr_reader :integer

  def self.call(integer)
    new(integer).call
  end

  def initialize(integer)
    @integer = integer
  end

  def call
    #integer = Link.find_by_url!(url).id
    #we convert the integer to base 62 because there are 62
    #characters considered valid for a URL: [a-z,A-Z,0-9]
    map = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    #find starting power of 62 to use
    current_power = minimum_power_needed_to_describe_value_in_base62(integer)

    #at this point we've found a power group that our number fits
    #into, so we can start dividing.

    #represents the new values at every base62 digit's place
    #e.g. 62 would be represented as [1, 0]
    #e.g. 61 would be reprerented as [Z]
    converted_digit_values = []

    current_value = integer

    while(current_power >= 0) do
      power_value = 62**(current_power)

      converted_digit_value = current_value/power_value
      converted_digit_values.push(map[converted_digit_value])
      #should be the remainder of the preceding division
      current_value = current_value % power_value
      current_power -= 1
    end

    converted_digit_values.join
  end

  private

  def minimum_power_needed_to_describe_value_in_base62(value)
    current_power = 0
    while(value >= 62**(current_power+1)) do
      current_power +=1
    end

    current_power
  end
end
