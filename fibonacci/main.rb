require "sinatra"

get "/" do
    return "fibonacci"
end

get "/:num" do
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
