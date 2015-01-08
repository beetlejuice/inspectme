class AppiumConnector
  require 'net/http'
  require 'uri'
  require 'json'

  WINDOW_SOURCE_CMD = '{"script":"UIATarget.localTarget().frontMostApp().windows()[0].getTree()","args":[]}' 
  SERVER_URL = '0.0.0.0:4723/wd/hub/session/'

  def self.get_window_source
    path = command_path
    res = Net::HTTP.post path, WINDOW_SOURCE_CMD, initheader = {'Content-type': 'application/json'}
    res_hash = JSON[res.body]
    window_source = res_hash['value']
  end

  def self.make_screenshot
    path = screenshot_path
    res = Net::HTTP.get path
    res_hash = JSON[res.body]
    screenshot = res_hash['value']
    File.open('/tmp/screenshot_123.png', 'wb').write(screenshot)
  end

  private

  def self.session_id
    id = File.open('/tmp/appium_lib_session', 'r').read.strip
  end

  def self.command_path
    URI(SERVER_URL + self.session_id + '/execute')
  end

  def self.screenshot_path
    URI(SERVER_URL + self.session_id + '/screenshot')
  end
end
