require "./point.rb"
require "matrix"

class SparseMatrix

    @sparse_hash
    @sparse_matrix
    @width
    @height

    # Iterate through the passed array, only adding non-zero values to the hash.
    def initialize(array)
        # Take the array and shove it into whatever
        @sparse_hash = Hash.new


        @height = array.length
        if (array.empty? || array[0].empty?)
            @height = 0
            @width = 0
        else
            @width = array[0].length
        end

        @sparse_hash.default = 0
        @equality_hash = 0
        @sparse_matrix = Matrix.rows(array)

        @i = 0
        while @i < @height do

            @j = 0
            while @j < @width do

                if (array[@i][@j] != 0)

                    point = Point.new(@i, @j)
                    @sparse_hash[point] = array[@i][@j]
                    @equality_hash += array[@i][@j].hash
                end

                @j += 1
            end

            @i += 1
        end
    end

    def hash
        return @equality_hash
    end

    def [](x, y)
        point = Point.new(x, y)
        return @sparse_hash[point]
    end

    def set_size(rows, columns)
        @height = rows
        @width  = columns
    end

    alias get []

    def set_element(key,value)
        if @sparse_hash[key] != 0
            @equality_hash = @equality_hash - @sparse_hash[key].hash
        end
        @sparse_hash[key] = value
        @equality_hash += value.hash
        begin
            arr = @sparse_matrix.to_a
            arr[key.x][key.y] = value
            @sparse_matrix = Matrix.rows(arr)
        rescue
            
        end
    end

    def add(m)

        typeerror_msg = "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        raise TypeError, typeerror_msg unless m.is_a? Matrix or m.is_a? SparseMatrix

        # Implement adding functionality.

    end

    def subtract(array)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."
        end

    end

    def column_vector(column)
        vec = []
        c = 0
        while c < @height do
            vec.push([self[c, column]])
            c += 1
        end
        return SparseMatrix.new(vec)
    end

    def row_vector(row)
        vec = [[]]
        c = 0
        while c < @width do
            vec[0].push(self[row, c])
            c += 1
        end
        return SparseMatrix.new(vec)
    end


    def matrix_multiply(array)
        case array
        when Fixnum
            product_matrix = self.clone
            @sparse_hash.each do |key, value|
                product_matrix.set_element(
                    key,
                    value*array
                )
            end
            return product_matrix
        when Array
            array = SparseMatrix.new(array)
        end

        m = array
        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        typeerror_msg = "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        raise TypeError, typeerror_msg unless m.is_a? Matrix or m.is_a? SparseMatrix


        if self.size[1] == array.size[0] && self.size[0] == 1 && array.size[1] == 1 then
            # return scalar
            # args are vectors
            val = 0
            @sparse_hash.each do |key, value|
                val += value * array[key.y, key.x]
            end
            return val
        elsif self.size[1] == array.size[0] && (self.size[0] != 1 || array.size[1] != 1) then
            product_matrix = SparseMatrix.new([[]])
            product_matrix.set_size(self.size[1], array.size[0])
            x=0
            while x < self.size[0] do
                y=0
                while y < array.size[1] do
                    t = self.row_vector(x)
                    r = array.column_vector(y)
                    product_matrix.set_element(Point.new(x,y), (t * r).to_int)
                    y += 1
                end
                x += 1
            end
            return product_matrix
            # product_matrix = Hash.new
            # product_matrix.default = 0
            # @sparse_hash.each do |key, value|
            #     product_matrix[key.x, key.y] += array[key] * value
            # end
        end


    end

    alias * matrix_multiply
    alias scalar_multiply matrix_multiply
    # # This function may not need to exist. It could just be part of the other multiply function
    # def scalar_multiply(value)

    #     # Check pre-conditions: value must be an Integer
    #     if !(value.is_a? Integer)
    #         raise TypeError, "The input object is not an Integer. It is a #{value.class}."
    #     end

    # end

    def elementwise_multiply(array)
        case array
        when Array
            array = SparseMatrix.new(array)
        end
        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."
        end

        product_matrix = self.clone
        @sparse_hash.each do |key, value|
            product_matrix.set_element(
                Point.new(key.x,key.y),
                value * array[key.x,key.y]
            )
        end
        return product_matrix
    end

    def inverse()
        # Pre-conditions. Non-square matrices are non-invertible.
        if !(self.square?)
            raise ArgumentError, "The object must be square to be invertible."
        end

        # Delegate to Matrix
        return @sparse_matrix.inverse

        # Doing the post-condition by multiplying A*B=I would slow down our package.
    end

    def transpose()
        transposed = SparseMatrix.new(@sparse_matrix.transpose.to_a)

        # Post conditions
        if !(self.row_count() == transposed.column_count()) or !(self.column_count() == transposed.row_count())
            raise Error, "The transpose failed."
        end

        return transposed
    end

    def rank()
        # Pre-conditions: The current object (self) is already a SparseMatrix.

        rankVal = @sparse_matrix.rank

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.

        return rankVal
    end

    def trace()
        # Pre-conditions. Non-square matrices are non-invertible.
        if !(self.square?)
            raise ArgumentError, "The object must be square to find the trace."
        end

        traceVal = @sparse_matrix.trace

        # Post-condition: We return a trace of the matrix.

        return traceVal
    end

    def determinant()
        # Pre-conditions: The current object (self) is already a SparseMatrix.

        detVal = @sparse_matrix.determinant

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        return detVal
    end

    def row_count()
        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.

        return @height
    end

    def column_count()
        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.

        return @width
    end

    def empty?()

        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.

        return @sparse_hash.empty?
    end

    # Array*Array^T=Identity=Array^T*Array
    def orthogonal?()
        return false unless self.square?
        return (self * self.transpose) == Matrix.identity(self.size[0]) ? true : false

        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        return @sparse_matrix.orthogonal?
    end

    def square?()

        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        return @sparse_matrix.square?
    end

    def singular?()

        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        return @sparse_matrix.singular?

    end

    def invertible?()

        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        return @sparse_matrix.invertible?
    end

    def diagonal?()

        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        if self.square?
            return @sparse_matrix.diagonal?
        else
            return false
        end
    end

    def SparseMatrix.identity(size)
        raise ArgumentError unless size.is_a? Integer
        sparse_m1 = SparseMatrix.new(Matrix.identity(size).to_a)
        return sparse_m1.size() == [size,size] ? sparse_m1 : nil
    end

    def symmetric?()
        # http://mathworld.wolfram.com/SymmetricMatrix.html

        # Pre-conditions: The current object (self) is already a SparseMatrix.
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        if self.size[0] == self.size[1]
            return @sparse_matrix.symmetric?
        else
            return false
        end

    end

    def eql?(m)
        #        puts "tried"
        case m
        when Array
            if m == self.to_a
                return true
            else
                m = SparseMatrix.new(m)
            end
            return self.hash == m.hash

        when Matrix
            m = SparseMatrix.new(m.to_a)
            return self.to_a == m.to_a
        when SparseMatrix
            return self.to_a == m.to_a
        end

        return false
        # # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        # if !(m.is_a? Matrix) and !(m.is_a? SparseMatrix) and !(m.is_a? Array)
        #     raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."
        # end

        # Implement eql.
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.

    end

    alias eql eql?
    alias == eql?
    alias equals eql?

    def to_a
        if [@sparse_matrix.row_count,@sparse_matrix.column_count] == self.size
            return @sparse_matrix.to_a
        end
        # @height = @sparse_matrix.row_count
        # @width = @sparse_matrix.column_count
        @sparse_matrix = []
        @i = 0
        while @i < @height do
            @sparse_matrix.push([])
            @j = 0
            while @j < @width do
                @sparse_matrix[@i].push(self[@i,@j])
                @j += 1
            end
            @i += 1
        end
        @sparse_matrix = Matrix.rows(@sparse_matrix)
        return @sparse_matrix.to_a
    end

    def size()

        # Pre-conditions: The current object (self) is already a SparseMatrix.

        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.

        return [row_count, column_count]
    end
end
