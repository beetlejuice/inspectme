class AppWindowInfo
SCREENSHOT_PATH = './../assets/screenshot/screenshot.png'

  def self.info
    window_source, window_size = AppiumConnector.update_data SCREENSHOT_PATH
    elements_hash = self.parse_source window_source
    [elements_hash, SCREENSHOT_PATH]
  end

  private

  def self.parse_source raw_data
    raw_data
  end
end