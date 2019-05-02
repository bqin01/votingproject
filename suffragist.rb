require 'sinatra'
require 'sinatra/activerecord'
require 'yaml/store'
require './models/candid.rb'
require './models/vote.rb'

set :database_file, 'config/database.yml'

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
    if @vote == nil || @vote == "" # Invalid votes!
      @title = 'Your vote didn\'t seem to go through.'
      erb :voteerror
    else
      @candid = Candid.find_by(name: @vote.downcase)
      if @candid == nil
        @candid = Candid.create(name: @vote.downcase, candid_id: Candid.all.count, num_votes: 0)
      end
      @candid.num_votes += 1
      @candid.save
      # @store = YAML::Store.new 'votes.yml'
      # @store.transaction do
      #   @store['votes'] ||= {}
      #   @store['votes'][@vote.downcase] ||= 0 #Ignore case
      #   @store['votes'][@vote.downcase] += 1 #Ignore case
      # end
      erb :cast
    end
  end

  get '/results' do
    @title = 'Preliminary Results'
    @candids = Candid.all
    erb :results
  end

end
Choices = [
  'bernie sanders',
  'joe biden',
  'boris shmuylovich',
  'donald trump',
  'vladimir putin',
  'deng xiaoping'
]
