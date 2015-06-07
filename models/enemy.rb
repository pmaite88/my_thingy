require_relative '../main/game'

class Enemy
  attr_reader :x, :y
  attr_accessor :health

  DIR        = File.dirname __FILE__
  HORDE_SIZE = 5

  def initialize(window, enemy)
    @health = 2
    @enemy = enemy

    puts [-1, 1].sample

    @x = (window.width / 2) + [-1, 1].sample * rand * 640
    @y = (window.height / 2) + [-1, 1].sample * rand * 480

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