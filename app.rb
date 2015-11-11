require 'board.rb'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, 'app/views'
  set :public_folder, 'public'

  register Sinatra::AssetPack

  configure :development do
    register Sinatra::Reloader
  end

  assets do
    css :application, ['/css/app.css']
    js :application, ['/js/app.js', '/js/board.js']
    css_compression :sass
  end

  # Controllers
  get '/' do
    erb :start
  end

  post '/board' do
    @board = Board.new('players' => [params['player1'], params['player2']])
    erb :board
  end

  post '/play' do
    content_type :json

    board = Board.new(JSON.parse(params[:board]))
    board.play(params[:move])

    board.as_json.to_json
  end
end
