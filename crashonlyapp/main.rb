require "sinatra"
require 'thread'

get "/" do
    return "crash-only-app"
end

get "/deadlock" do
    q = Queue.new
    Thread.new do
        q.deq
    end.join
end

get "/infiniteloop" do
    sum = 1
    loop {
        sum += sum
    }
end

get "/devide" do
    num = 100 / 0
    return num
end

get "/type" do
    return 100 + "200"
end