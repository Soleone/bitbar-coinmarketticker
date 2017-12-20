#!/usr/bin/env ruby
# encoding: utf-8
#
# <bitbar.title>Coinmarketcap Ticker</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Dennis Theisen</bitbar.author>
# <bitbar.author.github>Soleone</bitbar.author.github>
# <bitbar.desc>
#   Shows selected cryptocurrencies rates from Coinmarketcap using Ruby.
#   * Edit your coins of choice below by editing COINS.
#   * Change your period between 1h, 24h or 7d by editing DEFAULT_PERIOD.
# </bitbar.desc>
# <bitbar.image>https://i.imgur.com/dyJPNy7.png</bitbar.image>

require 'open-uri'
require 'json'

# Edit the coins you care about here:
COINS = %w(
  XMR
  ETN
  SUB
).freeze

DEFAULT_PERIOD = '24h'

URL = 'https://api.coinmarketcap.com/v1/ticker/'

class Coin
  TIME_PERIODS = %w(
    1h
    24h
    7d
  ).freeze

  def initialize(data)
    @data = data
  end

  def price_usd
    format_price(data['price_usd'])
  end

  def name
    data['name']
  end

  def symbol
    data['symbol']
  end

  def rising?(period = DEFAULT_PERIOD)
    sign == '+'
  end

  def falling?(period = DEFAULT_PERIOD)
    sign == '-'
  end

  def to_s
    "#{rising? ? '📈' : '📉'} #{symbol} $#{price_usd} (#{sign}#{percent_change}%)"
  end

  def percent_change(period = DEFAULT_PERIOD)
    format_price(percent_change_number(period).to_s.delete('-'))
  end

  def percent_change_number(period = DEFAULT_PERIOD)
    data["percent_change_#{period}"].to_f
  end

  def url
    "https://coinmarketcap.com/currencies/#{name.downcase}"
  end

  def updated_at
    Time.at(data['last_updated'].to_i)
  end

  private

  attr_reader :data

  def sign(period = DEFAULT_PERIOD)
    data["percent_change_#{period}"].to_f < 0 ? '-' : '+'
  end

  def format_price(amount)
    sprintf('%.2f', amount)
  end
end


def all_coins
  data = open(URL).read
  all_coin_data = JSON.parse(data)

  all_coin_data.map do |coin_data|
    Coin.new(coin_data)
  end
end

def filter(coins)
  coins.select do |coin|
    COINS.include?(coin.symbol)
  end
end

def sort(coins)
  coins.sort_by(&:percent_change_number)
end

# Start processing script
coins = filter(all_coins)
coins = sort(coins)

# Start outputting to BitBar API
output = ''

coins.each do |coin|
  output << "#{coin}\n"
end

output << "---\nLast updated at #{coins.first.updated_at} | size=11"

puts output
