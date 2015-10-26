require 'spec_helper'
require 'rails_helper'

describe Movie, :type => :model do
    describe 'search the Tmdb database for the entered movie' do
    it 'should call the Tmdb database with the movie search string' do
      expect(Tmdb::Movie).to receive(:find).with('11324')
      Movie.find_in_tmdb('11324')
    end
  end 
    describe 'Insert movies to the Rotten Potatoes Database' do
    it 'should insert the movie into the Rotten Potatoes Database' do
       array =["264491","597","453"]
       Movie.create_from_tmdb(array)
       movie = Movie.find_by_title("Titanic")
       expect(movie).not_to eq(nil)
     end
    end
       
  
end


