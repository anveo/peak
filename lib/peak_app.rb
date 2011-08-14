require 'sinatra/base'

class PeakApp < Sinatra::Base
  get '/' do
    "Hello World!!!"
  end
end
