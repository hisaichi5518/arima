require 'spec_helper'

describe Arima::Output do
  it "extend Arima::Schema" do
    expect(Arima::Output).to be_kind_of(Arima::Schema)
  end
  it "set default_schema" do
    expect(Arima::Output.default_schema.size).to eq 4
  end
  it "set schema_name" do
    expect(Arima::Output.schema_name).to eq :output_schema
  end
end
