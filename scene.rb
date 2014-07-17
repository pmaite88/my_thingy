require 'rubygems'
require 'gosu'

require_relative 'fortification'
require_relative 'building'
require_relative 'enemy'
require_relative 'game'

class GameWindow < Gosu::Window
  DIR = File.dirname __FILE__

  def initialize
    super(Game::MAP_X, Game::MAP_Y, false)
    self.caption = "Gosu AEGIS"

    @building = Building.new(self)
    @other_building = Building.new(self)
    @yet_another_building = Building.new(self)

    @fortification = Fortification.new(self)
    @other_fortification = Fortification.new(self)

    @enemy_spawn = Gosu::Image.new(self, "#{DIR}/media/enemy.png", false)

    Game::BUILIDING_LIST << @building << @other_building << @yet_another_building

    Game::FORTIFICATION_LIST << @fortification << @other_fortification
  end

  def update
    if rand(100) < 4 and Game::ENEMY_LIST.count < Enemy::HORDE_SIZE then
      Game::ENEMY_LIST << Enemy.new(@enemy_spawn)
    end

    Game::FORTIFICATION_LIST.each { |fortification| fortification.defend }

    Game::ENEMY_LIST.each { |enemy| enemy.move }

    Game::ENEMY_LIST.each do |enemy|
      if enemy.health <= 0
        Game::ENEMY_LIST.delete(enemy)
      end
    end

    Game::BUILIDING_LIST.each do |building|
      if building.health <= 0
        Game::BUILIDING_LIST.delete(building)
      end
    end
  end

  def draw

   Game::FORTIFICATION_LIST.each { |fortification| fortification.draw }

    Game::BUILIDING_LIST.each { |building| building.draw }

    Game::ENEMY_LIST.each { |enemy| enemy.draw }
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show