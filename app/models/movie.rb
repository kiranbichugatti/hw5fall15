class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def Movie::find_in_tmdb(name = String.new)
    temp = Array.new
    output = Array.new
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    temp = Tmdb::Movie.find(name)
     if temp!=nil
      temp.each do |movie|
      output << {:title => movie.title, :rating =>movie.rating,:release_date =>movie.release_date,:id => movie.id}
      return output
     end
     end
  end
  
  def Movie::create_from_tmdb(movieid=Array.new)
    temp = Hash.new
    movieid.each do |id|
      temp = Tmdb::Movie.detail(id)
    Movie.create!({:title => temp["title"], :rating =>temp["rating"], :description => nil, :release_date =>temp["release_date"]})
    end
    
    
  end 
  
end
