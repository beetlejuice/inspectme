get '/' do
  @elements, @size = AppWindowInfo.info

  haml :index
end