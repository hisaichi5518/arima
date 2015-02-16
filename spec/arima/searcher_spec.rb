require 'spec_helper'

describe Arima::Searcher do
  it "extend Arima::Schema" do
    expect(Arima::Output).to be_kind_of(Arima::Schema)
  end
  it "set default_schema" do
    expect(Arima::Output.default_schema.size).to eq 4
  end
  it "set schema_name" do
    expect(Arima::Output.schema_name).to eq :output_schema
  end

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
end
