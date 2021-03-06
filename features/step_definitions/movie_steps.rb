# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
    # Remove this statement when you finish implementing the test step
    movies_table.hashes.each do |movie|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    Movie.create!(movie)
    end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
    visit movies_path
    all("ratings").each do |rating|
      rating = rating.strip
      uncheck("ratings_#{rating}")
    end
    ratings = arg1.split(",")
    ratings.each do |rating|
        rating = rating.strip
        check("ratings_#{rating}")
    end
    click_button('Refresh')

end
   
Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
 temp1 = Array.new
 temp2 = Array.new
 output = true
  ratings = arg1.split(',')
  ratings.size.times do |n|
      ratings[n] = ratings[n].strip
  end
  all("tr").each do |tr|
    if !tr.has_content?("Rating")  
      pagerating = tr.text.split(/[\s]/)
       ratings.size.times do |n|
       if(pagerating.include?(ratings[n]))
         temp1 << ratings[n]
       else
         temp2 << ratings[n]
       end
    end
    end
end  
  if !((temp2.to_set-temp1.to_set).empty?)
     output = false
  end
  expect(output).to be_truthy
end

Then /^I should see all of the movies$/ do
  rowcount =-1
  all("tr").each do
      rowcount = rowcount+1
  end
  expect(rowcount).to eq(Movie.all.count)
  
end

When /^I follow "(.*?)"$/ do |arg1|
    visit movies_path
    if arg1 == "Movie Title"
      click_on("Movie Title")
    else
      click_on("Release Date")
    end
end

Then /^I should see "(.*?)" before "(.*?)"$/ do |movie1, movie2|
    result = false
    body = page.body.to_s
    if(body.index(movie1)<body.index(movie2))
      result = true  
    else
      result = false
    end
  expect(result).to be_truthy
end

