require_relative '../main/game'

class Enemy
  attr_reader :x, :y
  attr_accessor :health

  DIR        = File.dirname __FILE__
  HORDE_SIZE = 5

  def initialize(window, enemy)
    @health = 2
    @enemy = enemy

    @x = rand * 640 # - rand * 600
    @y = rand * 480 # + rand * 600

    @vel_x = 1
    @vel_y = 1

    @attack_speed = 1
  end

  def draw
    @enemy.draw(x, y, 0)
  end

  def move
    target = Game::closest_target(self, Game::BUILIDING_LIST)

    unless target.nil?
      if Gosu::distance(x, y, target.x, target.y) > 28
        angle = Gosu::angle(x, y, target.x, target.y)

        @x += Gosu::offset_x(angle, @vel_x)
        @y += Gosu::offset_y(angle, @vel_y)
      else
        target.health -= 1 * @attack_speed
      end
    end
  end
end