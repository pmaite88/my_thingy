class MenuItem

  def initialize (window, menu, item_number, image, callback, hover_image = nil)
    @window = window
    @main_image = image
    @hover_image = hover_image
    @x = menu.x + 20
    @y = menu.y + 20 * item_number**2
    @callback = callback
    @active_image = @main_image
  end

  def draw
    @active_image.draw(@x, @y, 0)
  end

  def update
    @active_image = @main_image
  end

  def is_mouse_hovering
    mx = @window.mouse_x
    my = @window.mouse_y

    (mx >= @x and my >= @y) and (mx <= @x + @active_image.width) and (my <= @y + @active_image.height)
  end

  def clicked
    if is_mouse_hovering then
      @callback.call
    end
  end
end