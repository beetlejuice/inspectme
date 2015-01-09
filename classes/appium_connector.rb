module AppiumConnector
  require 'net/http'
  require 'uri'
  require 'json'
  require 'base64'

  extend self

  WINDOW_SOURCE_CMD = '{"script":"UIATarget.localTarget().frontMostApp().windows()[0].getTree()","args":[]}' 
  SERVER_URL = 'http://0.0.0.0:4723/wd/hub/session/'

  def update_data screenshot_path
    window_source = get_window_source
    window_size = get_window_size
    make_screenshot screenshot_path
  end

  private

  attr_writer :session_id

  def get_window_source
    uri = command_uri
    req = Net::HTTP::Post.new(uri)
    req.body = WINDOW_SOURCE_CMD
    # req.content_type = 'application/json'
    res = Net::HTTP.start(uri.host, uri.port).request(req)
    res_hash = JSON[res.body]
    res_hash['value']
  end

  def make_screenshot path
    uri = screenshot_uri
    res = Net::HTTP.get uri
    res_hash = JSON[res]
    screenshot_base64 = res_hash['value']
    screenshot_png = Base64.decode64(screenshot_base64)
    # TODO: add exception handling - other classes need to be aware about success or fail
    File.open(path, 'wb').write(screenshot_png)
  end

  def get_window_size
    uri = size_uri
    res = Net::HTTP.get uri
    res_hash = JSON[res]
    size = res_hash['value']
  end
  
  def session_id
    return
      if !@session_id.nil?
        @session_id
      else 
        load_session_id  
  end 

  def load_session_id
    # TODO: Exception handling
    @session_id = File.open('/tmp/appium_lib_session', 'r').read.strip
  end

  def command_uri
    URI(URI.encode(SERVER_URL + session_id + '/execute'))
  end

  def screenshot_uri
    URI(URI.encode(SERVER_URL + session_id + '/screenshot'))
  end

  def size_uri
    URI(URI.encode(SERVER_URL + session_id + '/window/current/size'))
  end
end
