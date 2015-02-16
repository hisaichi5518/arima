module Arima
  module Output

    DEFAULT_SCHEMA = [
      {"name"=>"time", "jp"=>"行動時間"},
      {"name"=>"uid", "jp"=>"ユーザーid"},
      {"name"=>"type", "jp"=>"行動タイプ"},
      {"name"=>"other", "jp"=>"その他", "hidden"=>true},
    ]

    def self.raw_schema
      if Arima::App.settings.respond_to?(:output_schema)
        p Arima::App.settings.output_schema
        return Arima::App.settings.output_schema
      end

      DEFAULT_SCHEMA
    end
    def self.schema
      raw_schema.map do |column_info|
        Arima::Column.new(column_info)
      end
    end
  end
end
