module Arima
  module Searcher
    class SettingError < StandardError; end

    def self.search(args)
      klass_str = Arima::App.settings.searcher["class"] or raise SettingError, "Can't find settings.searcher.class"
      require_class(klass_str).search(args)
    end

    private
    def self.require_class(name)
      # TODO: CamelCaseに対応させる
      # TODO: def require_class(name, prefix) like Plack::Util.load_class
      require "arima/searcher/#{name.downcase}"
      Object.const_get("Arima::Searcher::#{name}")
    end
  end
end
