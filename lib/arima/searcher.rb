module Arima
  module Searcher
    def self.search(args)
      klass_str = Arima::App.settings.searcher["class"]

      # TODO: CamelCaseに対応させる
      # TODO: def load_class(name, prefix) like Plack::Util.load_class
      require "arima/searcher/#{klass_str.downcase}"
      klass = Object.const_get("Arima::Searcher::#{klass_str}")

      klass.search(args)
    end
  end
end
