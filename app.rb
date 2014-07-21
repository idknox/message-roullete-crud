require "sinatra"
require "active_record"
require "rack-flash"
require_relative "./lib/models/table_connection"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @db = Table_connection.new
  end

  get "/" do
    messages = @db.get_all

    erb :home, locals: {messages: messages}
  end

  get "/messages/:id/edit" do

    erb :edit, :locals => {:message => @db.get_msg(params[:id])}
  end

  post "/messages" do
    message = params[:message]
    if message.length <= 140
      @db.add_msg(message)
    else
      flash[:error] = "Message must be less than 140 characters."
    end
    redirect "/"
  end

  patch "/messages/:id" do
    @db.update_msg(params[:msg], params[:id])
    redirect "/"
  end

end