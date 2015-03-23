require 'securerandom'

module Arima
  module Searcher
  end
end

module Arima::Searcher::Test
  class << self
    def search(params)
      result = (1..10).map do |i|
        {
          _id: SecureRandom.hex(10),
          time: (Time.now + i).to_s,
          uid: 12345678,
          type: "users/messages#create",
          other: {friend_id: 10 + i},
        }
      end
      result
    end
  end
end
