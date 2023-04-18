class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys
    render({ :template => "currency_templates/step_one.html.erb" })
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys

    #params are
    # Parameters: {"from_currency"=>"AED"}

    @from_symbol = params.fetch("from_currency")
    render({ :template => "currency_templates/step_two.html.erb" })
  end

  def currency_result
    # params = {"from_currency"=>"AED", "to_currency"=>"AED"}

    @from_currency = params.fetch("from_currency")
    @to_currency = params.fetch("to_currency")

    url = "https://api.exchangerate.host/convert?from=#{@from_currency}&to=#{@to_currency}"
    @raw_data = open(url).read
    @parsed_data = JSON.parse(@raw_data)

    @exchange_rate = @parsed_data.dig("info", "rate")

    render({ :template => "currency_templates/currencies_results.html.erb" })
  end
end
