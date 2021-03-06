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

    erb :home, locals: {
      messages: messages,
      comments: @db.get_comments_all
    }
  end

  get "/messages/:id" do
    erb :message, :locals => {
      :message => @db.get_msg(params[:id]),
      :comments => @db.get_comments(params[:id])
    }
  end

  get "/messages/:id/edit" do
    erb :edit, :locals => {:message => @db.get_msg(params[:id])}
  end

  get "/messages/:id/comment/new" do
    erb :comment, :locals => {:id => params[:id]}
  end

  post "/messages" do
    message = params[:message]
    if too_long(message)
      flash[:error] = "Message must be less than 140 characters."
    else
      @db.add_msg(message)
    end
    redirect "/"
  end

  post "/messages/:id/comment" do
    @db.insert_comment(params[:comment], params[:id])
    redirect "/"
  end

  patch "/messages/:id" do
    message = params[:message]
    if too_long(message)
      flash[:error] = "Message must be less than 140 characters."
      redirect back
    else
      @db.update_msg(params[:msg], params[:id])
      redirect "/"
    end
  end

  delete "/messages/:id" do
    @db.del_msg(params[:id])
    redirect "/"
  end

  private

  def too_long(msg)
    msg.length > 140
  end

end