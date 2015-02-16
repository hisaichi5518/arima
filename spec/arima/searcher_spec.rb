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
end
