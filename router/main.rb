require "sinatra"
require 'faraday'

$stdout.sync = true
count = 0

before do
    ave =  `uptime`.chomp.split(":")[-1].split
    count += 1
    puts "[#{count}]LoadAverage:#{ave[0]}"
end

get "/" do
    return "It works!"
end

def getAddress(prefix)
    prefix = prefix.to_s.upcase
    ip_address = ENV["#{prefix}_PORT_4567_TCP_ADDR"].to_s
    port = ENV["#{prefix}_PORT_4567_TCP_PORT"].to_s
    addr = "http://#{ip_address}:#{port}"
end

# 階乗を計算する
get "/factorial/:num" do
    num = params["num"].to_s
    addr = getAddress("factorial")
    
    conn = Faraday.new(:url => addr) do |builder|
        builder.request  :url_encoded
        builder.response :logger
        builder.adapter  :net_http
    end

    response = conn.get("/#{num}")
    
    return response.body
end

# フィボナッチ数を計算する
get "/fibonacci/:num" do
    num = params["num"].to_s
    addr = getAddress("fibonacci")
    
    conn = Faraday.new(:url => addr) do |builder|
        builder.request  :url_encoded
        builder.response :logger
        builder.adapter  :net_http
    end

    response = conn.get("/#{num}")
    
    return response.body
end

# 簡易掲示板
get "/bbs" do
    addr = getAddress("bbs")
    
    conn = Faraday.new(:url => addr) do |builder|
        builder.request  :url_encoded
        builder.response :logger
        builder.adapter  :net_http
    end

    response = conn.get("/")
    
    return response.body
end

# クラッシュオンリーアプリ
get "/crash" do
    addr = getAddress("crash")
    
    conn = Faraday.new(:url => addr) do |builder|
        builder.request  :url_encoded
        builder.response :logger
        builder.adapter  :net_http
    end

    response = conn.get("/")
    
    return response.body
end

get "/crash/:something" do
    addr = getAddress("crash")
    cmd = params[:something].to_s
    
    conn = Faraday.new(:url => addr) do |builder|
        builder.request  :url_encoded
        builder.response :logger
        builder.adapter  :net_http
    end

    response = conn.get("/#{cmd}")
    
    return response.body
end
