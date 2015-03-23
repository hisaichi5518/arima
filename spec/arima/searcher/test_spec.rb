require 'spec_helper'
require 'arima/searcher/test'

describe Arima::Searcher do
  it "extend Arima::Schema" do
    expect(Arima::Searcher).to be_kind_of(Arima::Schema)
  end

  describe ".search" do
    it 'returns Array' do
      expect(Arima::Searcher::Test.search({}).class).to eq Array
    end
  end
end
