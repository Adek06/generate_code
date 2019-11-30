require 'sinatra'

get '/' do
  '游先生的个人工具箱'
end

get '/g_code' do
    send_file './views/test.html'
end

post '/g_code/f' do
    request.body.rewind  # in case someone already read it
    data = JSON.parse request.body.read
    function_name = data['function_name']
    must_vars = data['must_vars']
    maybe_vars = data['maybe_vars']
    mode = data['mode']
    
    require_relative "gener_code"
    r = Gener_Code.main(function_name, must_vars, maybe_vars, mode)
    r
end
