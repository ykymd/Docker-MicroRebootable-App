require "sinatra"

get "/" do
    return "factorial"
end

get "/:num" do
    num = params[:num]
    if num == -1
        # わざと0除算をしてエラーを起こす
        return 1 / 0
    else
        number = getFactorial(num)
        return "Number:#{number}\n"
    end
end

def getFactorial(index)
    index = index.to_i
    ans = 1
    
    for i in 1..index do
        ans = ans * i
    end
    
    return ans
end
