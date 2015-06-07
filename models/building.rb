require_relative '../main/game'
require_relative 'health_bar'

class Building
  attr_reader :x, :y
  attr_accessor :health

  DIR = File.dirname __FILE__

  def initialize(window)
    @health = 500
	  @time_to_build = 5000

    @x = rand * 600
    @y = rand * 400

    @building = Gosu::Image.new(window, "#{DIR}/../media/building.png", false)
    @health_bar = HealthBar.new(window, self)
  end

  def draw
    @building.draw(x, y, 0)
    @health_bar.draw
  end
end