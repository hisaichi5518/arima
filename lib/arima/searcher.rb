module Arima
  module Searcher
    class SettingError < StandardError; end

    extend Arima::Schema
    schema_name :search_schema
    default_schema [
      {"name"=>"uid", "type"=>"text", "placeholder"=>1234567, "jp"=>"ユーザーid"},
      {"name"=>"type", "type"=>"text", "placeholder"=>"user.search", "jp"=>"行動タイプ"},
      {"name"=>"start_at", "type"=>"datetime-local", "jp"=>"開始日時(必須)"},
      {"name"=>"end_at", "type"=>"datetime-local", "jp"=>"終了日時(必須)"},
      {"name"=>"page", "type"=>"text", "placeholder"=>1, "jp"=>"ページ番号", "default_value"=>1},
    ]

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
