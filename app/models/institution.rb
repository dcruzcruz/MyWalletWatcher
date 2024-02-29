class Institution < ApplicationRecord
  has_many :accounts

  attr_accessor :formatted_address

  def fetch_and_set_address
    response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&key=AIzaSyDfkpN_ptGyFIcV05dzlTiIy5oEC1ayadk")

    if response.code == 200
      parsed_response = JSON.parse(response.body)
      result = parsed_response["results"]&.first

      if result && result.key?("formatted_address")
        self.formatted_address = result["formatted_address"]
      else
        # Handle the case where the key is not present
        self.formatted_address = "Address not available"
      end
    else
      # Handle error
      self.formatted_address = "Error fetching address"
    end
  end
end
