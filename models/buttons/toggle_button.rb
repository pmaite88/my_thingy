class ToggleButton
  attr_reader :x, :y

  DIR = File.dirname __FILE__

  def initialize(window, name, flipped_name, callback, flipped_callback)
    @x = 256
    @y = 10
    @window = window
    @callback = callback
    @flipped_callback = flipped_callback
    @image = Gosu::Image.new(window, "#{DIR}/../../media/#{name}.png", false)
    @flipped_image = Gosu::Image.new(window, "#{DIR}/../../media/#{flipped_name}.png", false)
    @state = 0
  end

  def draw
    if @state == 0
      @image.draw(x, y, 0)
    elsif @state == 1
      @flipped_image.draw(x, y, 0)
    end
  end

  def is_mouse_hovering
    mx = @window.mouse_x
    my = @window.mouse_y

    (mx >= @x and my >= @y) and (mx <= @x + @image.width) and (my <= @y + @image.height)
  end

  def clicked
    if is_mouse_hovering
      if @state == 0
        @state = 1
        @callback.call
      elsif @state == 1
        @state = 0
        @flipped_callback.call
      end
    end
  end
end