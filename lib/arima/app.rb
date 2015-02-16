require 'sinatra/json'

module Arima
  class App < Sinatra::Application
    get '/' do
      json logs: []
    end

    get '/search' do
      json logs: []
    end
  end
end
