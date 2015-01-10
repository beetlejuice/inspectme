class AppWindowInfo
  SCREENSHOT_PATH = './public/screenshot.png'

  def self.info
    window_source, window_size = AppiumConnector.update_data SCREENSHOT_PATH
    elements_hash = self.parse_source window_source
    [elements_hash, window_size]
  end

  private

  def self.parse_source source
    source
  end
end
