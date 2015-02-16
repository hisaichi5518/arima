module Arima
  module Schema

    def schema_name(name=nil)
      @schema_name = name if name
      @schema_name
    end

    def default_schema(schema=nil)
      @default_schema = schema if schema
      @default_schema
    end

    def raw_schema
      if Arima::App.settings.respond_to?(schema_name)
        return Arima::App.settings.send(schema_name)
      end

      default_schema
    end

    def schema
      raw_schema.map do |column_info|
        Arima::Column.new(column_info)
      end
    end
  end
end
