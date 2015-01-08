get '/' do
  # Call auto-script method to get updated data
  # @elements = get_screen_elements

  haml :index
end

post '/run_script' do
  # Script.run
  # Script.get_parsed_data

  redirect '/'
end