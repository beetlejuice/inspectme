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
    first_split = clean_source.split(/\}, \{/)
    second_split = first_split.map { |el| el.split(/\[\{/) }
    # Remove unneeded deeper array levels produced by split
    flat_list = second_split.flatten

    hashes_array = flat_list.map do |str|
      # Remove all 'children' stuff from the end of element description
      str = str.slice(0..(str.index(', "children"')-1))
      # Evaluate string as hash
      eval('{' + str + '}')  
    end

    # hashes_array.each_with_object(output).with_index { |(e, h), i| h[i] = e }
  end
end
