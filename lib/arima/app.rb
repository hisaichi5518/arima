require 'sinatra/json'
require "sinatra/config_file"
require 'pathname'

module Arima
  class App < Sinatra::Application
    set :root, Pathname.new(__FILE__).parent.parent.parent
    set :views, "./views"
    set :public_folder, "./public"

    register Sinatra::ConfigFile
    config_file 'config/config.yml'

    get '/' do
      erb :index
    end

    get '/search' do
      logs = Arima::Searcher.search(params)
      json logs: logs
    end
  end
end
