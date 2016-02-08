class Point

    attr_reader :x, :y

    def initialize(x,y)  
        @x, @y = x,y  
    end

    def ==(other)
        return other.instance_of?(self.class) && @x == other.x && @y == other.y
    end

    alias eql? ==

    def hash
      [x,y].hash
    end
    
    # Overrides Object#to_s
    # Printout for Point.
    def to_s
        "#{self.class}[" + @x.to_s + ", " + @y.to_s + "]"
    end
    
    # Overrides Object#inspect
    # Printout for Point.
    def inspect
        "#{self.class}[" + @x.inspect + ", " + @y.inspect + "]"
    end
    
end
