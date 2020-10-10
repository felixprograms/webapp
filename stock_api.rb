require 'faraday'


class StockApi

    def self.get_stock_price(ticker_name)
        response = Faraday.get "https://sandbox.iexapis.com/stable/stock/#{ticker_name}/price?token=Tsk_620fca762f4c427c98eead688e7df20f"
        return Float(response.body)
    end

end