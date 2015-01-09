get '/' do
  @elements, @scr_path = AppWindowInfo.info

  haml :index
end