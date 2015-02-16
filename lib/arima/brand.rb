module Arima
  module Brand
    class << self
      def name
        Arima::App.settings.brand["name"] || "有馬"
      end

      def title
        name + " - 行動ログ閲覧"
      end
    end
  end
end
