require 'spec_helper'

module ArimaTestSchema
  extend Arima::Schema

  schema_name :test_schema
  default_schema [{
    "name"          => "default.name",
    "jp"            => "default.jp",
    "type"          => "default.type",
    "placeholder"   => "default.placeholder",
    "hidden"        => false,
    "default_value" => "default.default_value",
  }]
end

describe ArimaTestSchema do
  describe ".raw_schema" do
    context "with config" do
      let :test_schema do
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
        schema = test_schema
        allow(Arima::App).to receive(:test_schema) { schema }
      end

      it 'returns array' do
        expect(ArimaTestSchema.raw_schema).to eq test_schema
      end
    end

    context "without config" do
      it 'returns default_schema' do
        expect(ArimaTestSchema.raw_schema).to eq ArimaTestSchema.default_schema
      end
    end
  end

  describe ".schema" do
    context "with config" do
      let :test_schema do
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
        schema = test_schema
        allow(Arima::App).to receive(:test_schema) { schema }
      end

      it "returns one" do
        expect(ArimaTestSchema.schema.size).to eq 1
      end

      it 'returns array with Arima::Column object' do
        expect(ArimaTestSchema.schema[0]).to be_kind_of(Arima::Column)
      end
    end

    context "without config" do
      it "returns ArimaTestSchema.default_schema.size" do
        expect(ArimaTestSchema.schema.size).to eq ArimaTestSchema.default_schema.size
      end

      it 'returns array with Arima::Column object' do
        expect(ArimaTestSchema.schema.all? {|v| v.kind_of?(Arima::Column) }).to eq true
      end
    end
  end
end
