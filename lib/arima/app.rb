require 'sinatra/json'
require "sinatra/config_file"
require "sinatra/reloader"
require 'pathname'

module Arima
  class App < Sinatra::Application
    set :root, Pathname.new(__FILE__).parent.parent.parent
    set :views, "./views"
    set :public_folder, "./public"

    register Sinatra::ConfigFile
    config_file 'config/config.yml'

    configure :development do
      register Sinatra::Reloader
      also_reload 'lib/*.rb'
      also_reload 'lib/*/*.rb'
      also_reload 'lib/*/*/*.rb'
      also_reload 'config/config.yml'
    end

    get '/' do
      erb :index
    end

    get '/search' do
      logs = Arima::Searcher.search(log_params)
      json logs: logs
    end

    def log_params
      columns = Arima::Searcher.schema.select do |column|
        param = params[column.name]
        !(param.nil? or param.empty?)
      end

      columns.map {|c| [c.name, params[c.name]] }.to_h
    end
  end
end
