get '/' do
  current_info = AppWindowInfo.info
  @elements = current_info['elements']
  @size = current_info['size']

  haml :index
end