class Point
    def initialize(x,y)  
        @x, @y = x,y  
    end

    def ==(other)
        return other.instance_of?(self.class) && @x == other.x && @y == other.y
    end

    attr_reader :x, :y
end