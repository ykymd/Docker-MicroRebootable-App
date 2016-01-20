require "sinatra"
require "active_record"
require "thread"

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

ActiveRecord::Base.establish_connection(
    "adapter" => "sqlite3",
    "database" => "./bbs.db"
)

class Comment < ActiveRecord::Base
end

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end

get "/bbs" do
    @comments = Comment.order("id desc").all
    erb :index
end

post "/bbs/new" do
    Comment.create({:body => params[:body]})
    redirect "/bbs"
    erb :index
end

get "/bbs/detail/:id" do
    num = params[:id].to_i
    @comment = Comment.find(num)
    erb :detail
end

post "/bbs/edit" do
    id = params[:id].to_i
    comment = Comment.find(id)
    comment.body = params[:body].to_s
    comment.save
end

post "/bbs/delete" do
    Comment.find(params[:id]).destroy
end

get "/factorial/:num" do
    number = getFactorial(params["num"])
    return "Number:#{number}\n"
end

def getFactorial(index)
    index = index.to_i
    ans = 1
    
    for i in 1..index do
        ans = ans * i
    end
    
    return ans
end

get "/fibonacci/:num" do
    fib = params["num"].to_s
    ans = getFibonacci(fib.to_i)
    return "Fibonacci Number[#{fib}]:#{ans}\n"
end

def getFibonacci(index)
    if index == 1 || index == 2 then
        return 1
    end
    
    fib = []
    fib.push(1)
    fib.push(1)
    
    for i in 2...index do
        fib.push(fib[i-1] + fib[i-2])
    end
    
    return fib[index-1]
end

get "/crash/deadlock" do
    q = Queue.new
    Thread.new do
        q.deq
    end.join
end

get "/crash/infiniteloop" do
    sum = 1
    loop {
        sum += sum
    }
end

get "/crash/devide" do
    num = 100 / 0
    return num
end

get "/crash/type" do
    return 100 + "200"
end
