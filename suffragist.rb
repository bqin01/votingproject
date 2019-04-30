require 'sinatra'
require 'yaml/store'

class Appl < Sinatra::Base

  get '/' do
    @title = 'SINCE THE ELECTION BECAME A GAME VOTE AS MUCH AS YOU WANT'
    erb :index
  end

  post '/cast' do
    @title = 'Thanks for casting your vote!'
    if params['vote'] == ".new"
      @vote = params['new_candid']
    else
      @vote = params['vote']
    end
    if @vote == nil || @vote == ""
      @title = 'Your vote didn\'t seem to go through.'
      erb :voteerror
    else
      @store = YAML::Store.new 'votes.yml'
      @store.transaction do
        @store['votes'] ||= {}
        @store['votes'][@vote.downcase] ||= 0
        @store['votes'][@vote.downcase] += 1
      end
      erb :cast
    end
  end

  get '/results' do
    @title = 'Preliminary Results'
    @store = YAML::Store.new 'votes.yml'
    @votes = @store.transaction { @store['votes'] }
    erb :results
  end
end
Choices = {
  'BERN' => 'bernie sanders',
  'BID' => 'joe biden',
  'BOR' => 'boris shmuylovich',
  'DJT' => 'donald trump',
  'VLD' => 'vladimir putin',
  'DXP' => 'deng xiaoping',
}
