require 'rubygems'
require 'gosu'

require_relative '../models/fortification'
require_relative '../models/building'
require_relative '../models/enemy'
require_relative '../models/fence'
require_relative './game'

require_relative '../models/menu/menu'
require_relative '../models/buttons/toggle_button'

class Scene < Gosu::Window
  DIR = File.dirname __FILE__

  def needs_cursor?
    true
  end

  def initialize
    super(Game::MAP_X, Game::MAP_Y, false)
    self.caption = "Gosu AEGIS"

    @building = Building.new(self)
    @other_building = Building.new(self)
    # @yet_another_building = Building.new(self)

    @fortification = Fortification.new(self)
    @other_fortification = Fortification.new(self)

    @enemy_spawn = Gosu::Image.new(self, "#{DIR}/../media/enemy.png", false)

    Game::BUILIDING_LIST << @building << @other_building # << @yet_another_building
    Game::FORTIFICATION_LIST << @fortification << @other_fortification

    # Menu
    @menu = Menu.new(self)
    @menu.add_item(Gosu::Image.new(self, "#{DIR}/../media/building.png", false), 1, lambda { puts 'building deployed!' }, nil)
    @menu.add_item(Gosu::Image.new(self, "#{DIR}/../media/fortification.png", false), 2, lambda { puts 'building deployed!' }, nil)

    Game::MENU << @menu

    @toggle_button = ToggleButton.new(self, 'pause', 'continue', lambda { Game.pause }, lambda { Game.continue })
    Game::BUTTONS << @toggle_button
  end

  def update
    if rand(100) < 4 and Game::ENEMY_LIST.count < Enemy::HORDE_SIZE then
      Game::ENEMY_LIST << Enemy.new(self, @enemy_spawn)
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

    Game::MENU.each { |menu| menu.draw }

    Game::BUTTONS.each { |button| button.draw }
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end

    if id == Gosu::MsLeft then
      @toggle_button.clicked
      @menu.clicked
    end

    # if id == Gosu::MsLeft
    #   # fence = Fence.new(self)
    #   # Game::BUILIDING_LIST << fence

    #   Game::ENEMY_LIST << Enemy.new(self, @enemy_spawn)
    # end
  end
end

window = Scene.new
window.show