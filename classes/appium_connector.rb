class AppiumConnector
  require 'net/http'
  require 'uri'

  WINDOW_SOURCE_CMD = '{"script":"UIATarget.localTarget().frontMostApp().windows()[0].getTree()","args":[]}' 
  SCREENSHOT_CMD = ''

  def self.get_window_source
    self.execute_request WINDOW_SOURCE_CMD
  end

  def self.make_screenshot
    self.execute_request SCREENSHOT_CMD
  end

  private

  def self.session_id
    id = File.open('/tmp/appium_lib_session', 'r').read.strip
  end

  def self.server_url

  end

  def self.server_full_path
    self.server_url + self.session_id + '/execute'
  end

  def self.execute_request command
    Net::HTTP.post server_full_path, command, initheader = {'Content-type': 'application/json'}
  end
end
