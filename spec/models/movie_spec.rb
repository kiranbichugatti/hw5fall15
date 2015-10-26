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
    describe 'searchng Tmdb by keyword' do
        context 'with valid key' do
            it 'should call Tmdb with title keywords' do
                expect(Tmdb::Movie).to receive(:find).with('inception')
                Movie.find_in_tmdb('inception')
            end
        end
        
        context 'with invalid key' do
            it 'should raise invalidKeyError if key is missing or invalid' do
                allow(Tmdb::Movie).to receive(:find).and_raise(NoMethodError)
                allow(Tmdb::Api).to receive(:response).and_return({'code'=>'401'})
                expect{Movie.find_in_tmdb('Inception')}.to raise_error(Movie::InvalidKeyError)
            end
        end
    end
       
  
end


