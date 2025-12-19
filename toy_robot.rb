class ToyRobot
  DIRECTIONS = %w[NORTH EAST SOUTH WEST]
  TABLE_SIZE = 5

  def initialize
    @x = nil
    @y = nil
    @facing = nil
  end

  def execute(command)
    case command
    when /^PLACE\s+(\d+)\s*,\s*(\d+)\s*,\s*(NORTH|SOUTH|EAST|WEST)$/
      place($1.to_i, $2.to_i, $3)
    when "MOVE"
      move
    when "LEFT"
      left
    when "RIGHT"
      right
    when "REPORT"
      report
    when "EXIT"
      exit
    else
      puts "Invalid command: #{command}"
    end
  end

  private

  def valid_position?(x, y)
    x.between?(0, TABLE_SIZE - 1) && y.between?(0, TABLE_SIZE - 1)
  end

  def placed?
    !@x.nil?
  end

  def place(x, y, facing)
    return unless valid_position?(x, y) && DIRECTIONS.include?(facing)

    @x = x
    @y = y
    @facing = facing
  end

  def move
    return unless placed?

    new_x, new_y = @x, @y

    case @facing
    when "NORTH"
      new_y += 1
    when "SOUTH"
      new_y -= 1
    when "EAST"
      new_x += 1
    when "WEST"
      new_x -= 1
    end

    if valid_position?(new_x, new_y)
      @x = new_x
      @y = new_y
    end
  end

  def left
    return unless placed?

    index = DIRECTIONS.index(@facing)
    @facing = DIRECTIONS[(index - 1) % DIRECTIONS.size]
  end

  def right
    return unless placed?

    index = DIRECTIONS.index(@facing)
    @facing = DIRECTIONS[(index + 1) % DIRECTIONS.size]
  end

  def report
    return unless placed?

    puts "#{@x},#{@y},#{@facing}"
  end
end


robot = ToyRobot.new

puts "Game started, please enter commands (type 'EXIT' to quit):"

ARGF.each_line do |line|
  command = line.strip.upcase.squeeze(" ")
  robot.execute(command)
end
