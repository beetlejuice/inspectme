require 'appium_lib'
# require 'net/http'

APP_PATH = './UICatalog.app'

attr_accessor :source

def desired_caps
  {
    caps: {
      platformName: 'iOS',
      platformVersion: '6.1',
      deviceName:  'iPhone Simulator',
      app: APP_PATH,
      newCommandTimeout: 0
    },
    appium_lib: {
      wait: 10
    }
  }
end

def connect
  Appium::Driver.new(desired_caps).start_driver
  Appium.promote_appium_methods Object # TODO: need to avoid calling this method
end

def make_screenshot 

end

def get_screen_source
  @source = source_window
end

connect
get_screen_source

# def get_page_source
#   Appium::Driver.new(desired_caps).start_driver
#   Appium.promote_appium_methods Object # TODO: need to avoid calling this method
#   source = source_window
#   driver_quit
#   source
# end
# 
# find_elements(:class_name, 'UIATableCell')[0].click
# 
# source = get_page_source
# p source
