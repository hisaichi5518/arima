require 'spec_helper'

describe Arima::Output do
  describe ".raw_schema" do
    context "with config" do
      let :output_schema do
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
        schema = output_schema
        allow(Arima::App).to receive(:output_schema) { schema }
      end

      it 'returns array' do
        expect(Arima::Output.raw_schema).to eq output_schema
      end
    end

    context "without config" do
      it 'returns DEFAULT_SCHEMA' do
        expect(Arima::Output.raw_schema).to eq Arima::Output::DEFAULT_SCHEMA
      end
    end
  end

  describe ".schema" do
    context "with config" do
      let :output_schema do
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
        schema = output_schema
        allow(Arima::App).to receive(:output_schema) { schema }
      end

      it "returns one" do
        expect(Arima::Output.schema.size).to eq 1
      end

      it 'returns array with Arima::Column object' do
        expect(Arima::Output.schema[0]).to be_kind_of(Arima::Column)
      end
    end

    context "without config" do
      it "returns Arima::Output::DEFAULT_SCHEMA.size" do
        expect(Arima::Output.schema.size).to eq Arima::Output::DEFAULT_SCHEMA.size
      end

      it 'returns array with Arima::Column object' do
        expect(Arima::Output.schema.all? {|v| v.kind_of?(Arima::Column) }).to eq true
      end
    end
  end
end
