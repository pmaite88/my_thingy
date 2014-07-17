require_relative 'game'
require_relative 'bullet'

class Fortification
  attr_reader :x, :y, :bullet
  attr_accessor :health

  DIR = File.dirname __FILE__

  def initialize(window)
    @health = 500
    @time_to_build = 5000

    @x = rand * 600
    @y = rand * 400

    @target = nil
    @shot_bullet = nil

    @fortification = Gosu::Image.new(window, "#{DIR}/media/fortification.png", false)
    @bullet = Gosu::Image.new(window, "#{DIR}/media/bullet.png", false)
  end

  def defend
    @target = Game::closest_target(self, Game::ENEMY_LIST) if @target == nil

    unless @target.nil?
      if Gosu::distance(x, y, @target.x, @target.y ) < 1000
        @shot_bullet = Bullet.new(self, @target) if @shot_bullet.nil?
        @shot_bullet.move
      end

      if Gosu::distance(@shot_bullet.x, @shot_bullet.y, @target.x, @target.y) <= 15
        @target.health -= 1
        @shot_bullet = nil
        @target = nil if @target.health <= 0
      end
    end


  end

  def draw
    @fortification.draw(x, y, 0)
    @shot_bullet.draw unless @shot_bullet.nil?
  end
end