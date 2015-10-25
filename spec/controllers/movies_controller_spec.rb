require 'spec_helper'
require 'rails_helper'

describe MoviesController do 
    describe '#search_tmdb' do
        before :each do
            @fake_results= [double('movie1'), double('movie2')]
        end
     it 'should call the model method that performs TMDb search' do
        Movie.should_receive(:find_in_tmdb).with('295831').and_return(@fake_results)
        post :search_tmdb, {:search_terms => '295831'}
     end
     describe 'after valid search' do
         before :each do
             Movie.stub(:find_in_tmdb).and_return(@fake_results)
             post :search_tmdb, {:search_terms => '295831'}
         end
      it 'should select the search results template for rendering' do
           expect(response).to render_template(:search_tmdb)
         end
      it 'should make the TMDb search results avaialble to that template' do
          expect(assigns(:movie)).to eq @fake_results
        end
      end
    end 
    describe '#add_tmdb' do
        it 'should add the selected movies into the database and display on the view' do
           Movie.should_receive(:create_from_tmdb).with(["295831"]).and_return(@fake_results)
           post :add_tmdb, {"tmdb_movies"=>{"295831"=>"1"}}
        end
    end

end
             