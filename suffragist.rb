require 'sinatra'
require 'yaml/store'


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
    puts "Error detected!"
    @title = 'Your vote didn\'t seem to go through.'
    erb :voteerror
  else
    @store = YAML::Store.new 'votes.yml'
    @store.transaction do
      @store['votes'] ||= {}
      @store['votes'][@vote] ||= 0
      @store['votes'][@vote] += 1
    end
    erb :cast
  end
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end

Choices = {
  'BERN' => 'Bernie Sanders',
  'BID' => 'Joe Biden',
  'BOR' => 'Boris Shmuylovich',
  'DJT' => 'Donald Trump',
  'VLD' => 'Vladimir Putin',
  'DXP' => 'Deng Xiaoping',
}
