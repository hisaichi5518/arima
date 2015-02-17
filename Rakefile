require "rspec/core/rake_task"

$:.unshift File.join(File.dirname(__FILE__), "lib")
require "arima"
require "arima/searcher/pg"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :arima do
  desc '有馬のデフォルトのテーブル作成を行います'
  task :create_table do |task_name|
    connection = Arima::Searcher::Pg.connection

    # テーブルがないかのチェック
    connection.exec("SELECT 1 FROM information_schema.tables WHERE table_name = 'action_logs'") do |result|
      unless result.ntuples.zero?
        puts 'Relation "action_logs" already exists'
        exit
      end
    end

    create_table_sql = File.new(File.join(File.dirname(__FILE__), "sql", "create_table.sql"), "r").read
    connection.exec(create_table_sql)
    puts "done"
  end

  desc '有馬のデフォルトのテーブル削除を行います'
  task :drop_table do |task_name|
    connection = Arima::Searcher::Pg.connection

    # テーブルがあるかのチェック
    connection.exec("SELECT 1 FROM information_schema.tables WHERE table_name = 'action_logs'") do |result|
      if result.ntuples.zero?
        puts 'Table "action_logs" does not exist'
        exit
      end
    end

    drop_table_sql = File.new(File.join(File.dirname(__FILE__), "sql", "drop_table.sql"), "r").read
    connection.exec(drop_table_sql)
    puts "done"
  end
end
