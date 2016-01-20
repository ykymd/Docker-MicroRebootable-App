require "sinatra"
require "active_record"

$stdout.sync = true
count = 0

ActiveRecord::Base.establish_connection(
    "adapter" => "sqlite3",
    "database" => "./bbs.db"
)

class Comment < ActiveRecord::Base
end

before do
    ave =  `uptime`.chomp.split(":")[-1].split
    count += 1
    puts "[#{count}]LoadAverage:#{ave[0]}"
    puts `free`
end

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end

get "/" do
    @comments = Comment.order("id desc").all
    erb :index
end

post "/new" do
    Comment.create({:body => params[:body]})
    redirect "/"
    erb :index
end

get "/detail/:id" do
    num = params[:id].to_i
    @comment = Comment.find(num)
    erb :detail
end

post "/edit" do
    id = params[:id].to_i
    comment = Comment.find(id)
    comment.body = params[:body].to_s
    comment.save
end

post "/delete" do
    Comment.find(params[:id]).destroy
end
