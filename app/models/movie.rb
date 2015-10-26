class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  class Movie::InvalidKeyError<StandardError;end
  def Movie::find_in_tmdb(name = String.new)
    temp = Array.new
    output = Array.new
    if(name==nil or name=="")
      return 0
    else
     begin  
      Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
      temp = Tmdb::Movie.find(name)
      rescue NoMethodError=>tmdb_gem_exception
      if Tmdb::Api.response['code']=='401'
         raise Movie::InvalidKeyError,'Invalid API key'
      else
        raise tmdb_gem_exception
      end
     end
      if temp==nil or temp ==[]
       return 1
     else
       temp.each do |movie|
       output << {:title => movie.title, :rating =>"R",:release_date =>movie.release_date,:id => movie.id}
       
     end
     return output
      end
     
    end
  end
  
  def Movie::create_from_tmdb(movieid=Array.new)
    temp = Hash.new
    movieid.each do |id|
      temp = Tmdb::Movie.detail(id)
    Movie.create!({:title => temp["title"], :rating =>"R", :description => nil, :release_date =>temp["release_date"]})
    end
    
    
  end 
  
end
