require_relative 'game'

class Bullet
  attr_reader :x, :y

  DIR        = File.dirname __FILE__

  def initialize(parent, target)
    @parent = parent
    @target = target

    @x = parent.x
    @y = parent.y

    @vel = 6
  end

  def move
    angle = Gosu::angle(x, y, @target.x, @target.y)

    @x += Gosu::offset_x(angle, @vel)
    @y += Gosu::offset_y(angle, @vel)
  end

  def draw
    @parent.bullet.draw(x, y, 0)
  end
end