require 'spec_helper'

describe Arima::Searcher do
  describe ".search" do
    context "with config" do
      before do
        allow(Arima::App).to receive(:searcher) { {"class" => "Test"} }
      end

      it 'returns array' do
        expect(Arima::Searcher.search({})).to eq ["this is a test"]
      end
    end

    context "without config" do
      before do
        allow(Arima::App).to receive(:searcher) { {} }
      end

      it 'raise SettingError' do
        expect { Arima::Searcher.search({}) }.to raise_error Arima::Searcher::SettingError
      end
    end
  end

  describe ".raw_schema" do
    context "with config" do
      let :search_schema do
        [{
          "name"          => "column.name",
          "jp"            => "column.jp",
          "type"          => "column.type",
          "placeholder"   => "column.placeholder",
          "hidden"        => true,
          "default_value" => "column.default_value",
        }]
      end

      before do
        schema = search_schema
        allow(Arima::App).to receive(:search_schema) { schema }
      end

      it 'returns array' do
        expect(Arima::Searcher.raw_schema).to eq search_schema
      end
    end

    context "without config" do
      it 'returns DEFAULT_SCHEMA' do
        expect(Arima::Searcher.raw_schema).to eq Arima::Searcher::DEFAULT_SCHEMA
      end
    end
  end

  describe ".schema" do
    context "with config" do
      let :search_schema do
        [{
          "name"          => "column.name",
          "jp"            => "column.jp",
          "type"          => "column.type",
          "placeholder"   => "column.placeholder",
          "hidden"        => true,
          "default_value" => "column.default_value",
        }]
      end

      before do
        schema = search_schema
        allow(Arima::App).to receive(:search_schema) { schema }
      end

      it "returns one" do
        expect(Arima::Searcher.schema.size).to eq 1
      end

      it 'returns array with Arima::Column object' do
        expect(Arima::Searcher.schema[0]).to be_kind_of(Arima::Column)
      end
    end

    context "without config" do
      it "returns Arima::Searcher::DEFAULT_SCHEMA.size" do
        expect(Arima::Searcher.schema.size).to eq Arima::Searcher::DEFAULT_SCHEMA.size
      end

      it 'returns array with Arima::Column object' do
        expect(Arima::Searcher.schema.all? {|v| v.kind_of?(Arima::Column) }).to eq true
      end
    end
  end
end
