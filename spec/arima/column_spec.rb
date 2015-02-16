require 'spec_helper'

describe Arima::Column do

  let :column_info do
    {
      "name"          => "column.name",
      "jp"            => "column.jp",
      "type"          => "column.type",
      "placeholder"   => "column.placeholder",
      "hidden"        => true,
      "default_value" => "column.default_value",
    }
  end

  let :column do
    Arima::Column.new(column_info)
  end

  describe "#name" do
    it 'returns name' do
      expect(column.name).to eq "column.name"
    end
  end

  describe "#label_name" do
    it 'returns label_name' do
      expect(column.label_name).to eq "column.jp"
    end
  end

  describe "#type" do
    it 'returns label_name' do
      expect(column.type).to eq "column.type"
    end
  end

  describe "#placeholder" do
    it 'returns placeholder' do
      expect(column.placeholder).to eq "column.placeholder"
    end
  end

  describe "#hidden?" do
    it 'returns hidden?' do
      expect(column.hidden?).to eq true
    end
  end

  describe "#default_value" do
    it 'returns default_value' do
      expect(column.default_value).to eq "column.default_value"
    end
  end
end
