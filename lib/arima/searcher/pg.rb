require "pg"

module Arima
  module Searcher
  end
end

module Arima::Searcher::Pg
  class << self
    def search(args)
      []
    end

    private
    def connection
      config = Arima::App.settings.searcher["config"]
      PG.connect(*config)
    end
  end
end
