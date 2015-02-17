require "pg"
require "sql-maker"

module Arima
  module Searcher
  end
end

module Arima::Searcher::Pg
  extend SQL::Maker::Helper

  class << self
    def maker
      @maker ||= SQL::Maker.new(
        :driver => 'postgresql',
        :auto_bind => true,
      )
    end

    def search(params)
      where = build_where(params)
      opts = build_opts(params)
      sql = maker.select(table, columns, where, opts)

      result = connection.exec(sql)
      result.to_a
    end

    def connection
      config = Arima::App.settings.searcher["connection"]
      PG.connect(config)
    end

    private
    def build_where(params)
      # 指定されたcolumnだけ渡す
      cs = columns.select do |column|
        param = params[column]
        !(param.nil? or param.empty?)
      end

      cs.map {|c| [c, params[c]] }.to_h
    end

    def build_opts(params)
      # TODO: ページ最大数の指定
      # TODO: 100を設定にもっていく
      page  = (params["page"] || 1).to_i
      limit = 100 * page
      {order_by: "time", limit: limit, offset: limit - 100}
    end

    def table
      Arima::App.settings.searcher["table"]
    end
    def columns
      Arima::App.settings.searcher["columns"]
    end
  end
end
