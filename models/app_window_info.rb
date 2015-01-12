class AppWindowInfo
  SCREENSHOT_PATH = './public/screenshot.png'

  def self.info
    raw_info = AppiumConnector.update_data SCREENSHOT_PATH
    elements = self.elements_hash raw_info['window_source']
    info = {'elements' => elements, 'size' => raw_info['window_size']}
  end

  private

  def self.elements_hash source
    output = {}
    # Remove starting and ending '{' '}'
    clean_source = source.slice(1..-2)
    # Splitting source into element hashes
    # First - all along with children items
    first_split = clean_source.split(/\}, \{/)
    # Second - divide children into elements
    second_split = first_split.flat_map { |el| el.split(/\[\{/) }

    hashes_array = flat_list.map do |str|
      # Remove all 'children' stuff from the end of element description
      str = str.slice(0..(str.index(', "children"')-1))
      # Evaluate string as hash
      eval('{' + str + '}')  
    end

    # hashes_array.each_with_object(output).with_index { |(e, h), i| h[i] = e }
  end
end
