module Arima
  class Column
    attr_accessor :column_info
    def initialize(column_info)
      @column_info = column_info
    end

    def name
      column_info["name"]
    end

    def label_name
      column_info["jp"] || name
    end

    def type
      column_info["type"]
    end

    def placeholder
      column_info["placeholder"]
    end

    def hidden?
      column_info["hidden"]
    end

    def default_value
      column_info["default_value"]
    end
  end
end
