require 'spec_helper'

describe Arima::Brand do
  describe ".name" do
    context "with config" do
      before do
        allow(Arima::App).to receive(:brand) { {"name" => "TestName"} }
      end

      it 'returns settings.brand.name' do
        expect(Arima::Brand.name).to eq "TestName"
      end
    end

    context "without config" do
      before do
        allow(Arima::App).to receive(:brand) { {} }
      end

      it 'returns default name' do
        expect(Arima::Brand.name).to eq "有馬"
      end
    end

  end

  describe ".title" do
    context "with config" do
      before do
        allow(Arima::App).to receive(:brand) { {"name" => "TestName"} }
      end

      it 'returns settings.brand.name' do
        expect(Arima::Brand.title).to eq "TestName - 行動ログ閲覧"
      end
    end

    context "without config" do
      before do
        allow(Arima::App).to receive(:brand) { {} }
      end

      it 'returns default name' do
        expect(Arima::Brand.title).to eq "有馬 - 行動ログ閲覧"
      end
    end

  end
end
