module Arima
  module Searcher
    class SettingError < StandardError; end

    def self.raw_schema
      Arima::App.settings.search_schema
    end
    def self.schema
      raw_schema.map do |column_info|
        Arima::Column.new(column_info)
      end
    end

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
