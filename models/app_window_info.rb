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

    hashes_array = flat_list.map do |str|
      # Remove all 'children' stuff from the end of element description
      str = str.slice(0..(str.index(', "children"')-1))
      # Evaluate string as hash
      eval('{' + str + '}')  
    end

    hash = {}
    hashes_array.each_with_object(hash).with_index { |(e, h), i| h[i] = e }
  end
end
