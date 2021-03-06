module Game

  MAP_X = 640
  MAP_Y = 480

  BUILIDING_LIST = []
  ENEMY_LIST = []
  FORTIFICATION_LIST = []

  def self.closest_target(origin, possible_targets)
    min_distance = 0
    first_time = true
    target = nil

    possible_targets.each do |structure|
      distance = Gosu::distance(origin.x, origin.y, structure.x, structure.y)

      if first_time || min_distance > distance
        min_distance = distance
        target = structure
        first_time = false
      end
    end
    target
  end
end