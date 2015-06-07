require_relative '../main/game'

class HealthBar
  attr_reader :x, :y

  DIR = File.dirname __FILE__

  def initialize(window, parent)
    @parent = parent
    @x = parent.x + 4
    @y = parent.y - 8

    @health_bar = Gosu::Image.new(window, "#{DIR}/../media/empty_health_bar.png", false)
    @health = Gosu::Image.new(window, "#{DIR}/../media/health.png", false)
  end

  def draw
    @health_bar.draw(x, y, 0, 0.1, 0.09)
    @health.draw(x, y, 1, @parent.health / 10 * 0.028, 0.1)
  end
end