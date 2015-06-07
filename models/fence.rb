require_relative '../main/game'

class Fence
  attr_reader :x, :y
  attr_accessor :health

  DIR = File.dirname __FILE__

  def initialize(window)
    @health = 10

    @x = window.mouse_x - 10
    @y = window.mouse_y - 10

    @fence = Gosu::Image.new(window, "#{DIR}/../media/fence.png", false)
  end

  def draw
    @fence.draw(x, y, 0)
  end
end