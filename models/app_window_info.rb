class AppWindowInfo
  SCREENSHOT_PATH = './public/screenshot.png'

  def self.info
    raw_info = AppiumConnector.update_data SCREENSHOT_PATH
    elements = self.elements_list raw_info['window_source']
    info = {'elements': elements, 'size': raw_info['window_size']}
  end

  private

  def self.elements_list source
    output = {}

    first_split = source.split(/\}, \{/)
    second_split = first_split.map { |el| el.split(/\[\{/) }
    flat_list = second_split.flatten

    # Preparing a Hash
    elements = {}

    test.each_with_object(hash).with_index do |(e, h), i|
      # Divide element info into blocks
      element_array = e.split(', "')
      # Clean up double quotes
      element_array.each { |el| el.gsub!('"', '') }
      # Preparing arrays for hashing
      element_array.map! { |el| el.split('=>') }
      # Hashing element with index in the list as key
      h[i] = Hash[element_array]
    end
  end
end
