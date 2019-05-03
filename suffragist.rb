require 'sinatra'
require 'sinatra/activerecord'
require 'yaml/store'
require './models/candid.rb'
require './models/vote.rb'

set :database_file, 'config/database.yml'

class Appl < Sinatra::Base

  get '/' do
    @title = 'SINCE THE ELECTION BECAME A GAME VOTE AS MUCH AS YOU WANT' # Courtesy of Boris S.
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
      @new_vote = Vote.create(vote_id: Vote.all.count, voted_for: @vote.downcase)
      @new_vote.save
      # @store = YAML::Store.new 'votes.yml'
      # @store.transaction do
      #   @store['votes'] ||= {}
      #   @store['votes'][@vote.downcase] ||= 0 #Ignore case
      #   @store['votes'][@vote.downcase] += 1 #Ignore case
      # end
      erb :cast
    end
  end

  get '/results' do # Show the results!
    @title = 'Preliminary Results'
    @candids = Candid.all
    @sort_by = params['sort']
    if @sort_by != 'name' && @sort_by != 'num_votes'
      @sort_by = 'candid_id'
    end
    @dir = params['dir']
    if @dir != 'DESC'
      @dir = 'ASC'
    end
    # Setting defaults for these two variables to cover all grounds (perhaps also dodging some SQL injections)
    erb :results
  end

  get '/candid/:id' do
    @candid = Candid.find_by(candid_id: params[:id])
    @title = @candid.name.split.map(&:capitalize).join(' ')
    @votes = Vote.where(voted_for: @candid.name) # Get the votes that actually voted for this person
    puts @votes
    erb :candid_page
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
