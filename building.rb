require_relative 'game'

class Building
  attr_reader :x, :y
  attr_accessor :health

  DIR = File.dirname __FILE__

  def initialize(window)
    @health = 500
	  @time_to_build = 5000

    @x = rand * 600
    @y = rand * 400

    @building = Gosu::Image.new(window, "#{DIR}/media/building.png", false)
  end

  def draw
    @building.draw(x, y, 0)
  end
end