require_relative './menu_item'

class Menu
  attr_reader :x, :y

  DIR = File.dirname __FILE__

  def initialize (window)
    @window = window
    @items = Array.new
    @menu = Gosu::Image.new(window, "#{DIR}/../../media/menu.png", false)
    @x = 10
    @y = 10
  end

  def add_item (image, item_number, callback, hover_image = nil)
    item = MenuItem.new(@window, self, item_number, image, callback, hover_image)
    @items << item
    self
  end

  def draw
    @menu.draw(x, y, 0)

    @items.each do |i|
      i.draw
    end
  end

  def update
    @items.each do |i|
      i.update
    end
  end

  def clicked
    @items.each do |i|
      i.clicked
    end
  end
end