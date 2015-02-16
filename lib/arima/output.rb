module Arima
  module Output
    extend Arima::Schema

    schema_name :output_schema
    default_schema [
      {"name"=>"time", "jp"=>"行動時間"},
      {"name"=>"uid", "jp"=>"ユーザーid"},
      {"name"=>"type", "jp"=>"行動タイプ"},
      {"name"=>"other", "jp"=>"その他", "hidden"=>true},
    ]
  end
end
