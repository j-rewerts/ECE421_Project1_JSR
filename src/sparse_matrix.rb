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

    # Format is [row, column]
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

        if key.x >= @width
            @width = key.x + 1
        end
        if key.y >= @height
            @height = key.y + 1
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

    # Returns a flipped version of the sparse matrix.
    # 0 3 5 0       0 7 0
    # 7 1 0 0  ==>  3 1 0
    # 0 0 1 3       5 0 1
    #               0 0 3
    def transpose()
        # Initialize the array based upon size of the hash
        arrayOuter = Array.new(@width)        
        for i in 0..@width - 1
            arrayOuter[i] = Array.new(@height, 0)
        end

        # Iterate through, flipping all the spots x and y
        @sparse_hash.each { |key, value|
            arrayOuter[key.y][key.x] = value
        }

        transposed = SparseMatrix.new(arrayOuter)

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

    # The inverse of a matrix is defined as inv(A)=adj(A)/det(A)
    def inverse()
        # Pre-conditions. Non-square matrices are non-invertible.
        if !(self.square?)
            raise ArgumentError, "The object must be square to be invertible."
        end

        detValue = determinant()
        
        adjugateMatrix = adjugate()

        return adjugateMatrix.scalar_multiply(1.0 / detValue)

        # Doing the post-condition by multiplying A*B=I would slow down our package.
    end

    # The cofactor is the matrix you get if you get the determinant of 
    # all the minors in a square matrix and multiply the cofactor value by it.
    # NOTE: returns an Array
    def cofactor()
        coArray = Array.new(@height)  
        for i in 0..@height - 1
            coArray[i] = Array.new(@width, 0)
        end

        for column in 0..coArray[0].size - 1
            for row in 0..coArray.size - 1
                detVal = SparseMatrix.new(get_minor(row, column)).determinant()
                coVal = (-1) ** ((row + 1) + (column + 1))
                coArray[row][column] = coVal * detVal
            end

        end

        return coArray
    end

    # The adjugate is defined as the transpose of the cofactor matrix or:
    # adj(A)=C^T
    def adjugate()
        cofactor = SparseMatrix.new(cofactor())

        return cofactor.transpose()
    end

    # Determinant for a 2x2 matrix: [a b] ==> ad - bc
    #                               [c d]
    #
    # Determinants for larger square matrices (3x3): [a b c]
    #                                                [d e f] ==> a * [e f] - b * [d f] + c * [e f]  
    #                                                [g h i]         [h i]       [g i]       [h i]
    # Then get the determinants for the smaller matrices.
    def determinant()
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        if !(self.square?)
            raise ArgumentError, "The object must be square to find the determinant."
        end

        #puts "Size: #{@width}"
        #print()

        row = 0

        # When the internal array is a 2x2, just return the current det value.
        if @height == 2 and @width == 2
            rVal = get(0, 0) * get(1, 1) - get(0, 1) * get(1, 0)
            #puts "  Value: #{rVal}"
            return get(0, 0) * get(1, 1) - get(0, 1) * get(1, 0) # ad-bc

        end        

        rVal = 0
        # recursively break up the array
        for i in 0..@width - 1
            babyArray = get_minor(row, i)

            babyMatrix = SparseMatrix.new(babyArray)

            rVal = rVal + (-1) ** ((row + 1) + (i + 1)) * get(row, i) * babyMatrix.determinant

        end



        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
        return rVal
    end

    # A helper function for getting the determinant. This will get the subarray
    # for this sparse matrix. 
    # Note: This returns an array object
    def get_minor(row, column)
        # Pre-condition
        if (column >= @width)
            raise ArgumentError, "The row and column must be less than the matrix size."
        end

        # build an array to hold the new sub-array
        subArray = Array.new(@height - 1)  
        for subi in 0..@height - 2
            subArray[subi] = Array.new(@width - 1, 0)
        end

        # Fill the array with data so long as it isn't from the current value's row/col
        @sparse_hash.each { |key, value|
            if key.y == column
                next
            end
            if key.x == row
                next
            end

            if key.y > column

                if key.x > row
                    subArray[key.x - 1][key.y - 1] = value
                elsif key.x < row
                    subArray[key.x][key.y - 1] = value
                end
                
            elsif key.y < column

                if key.x > row
                    subArray[key.x - 1][key.y] = value
                elsif key.x < row
                    subArray[key.x][key.y] = value
                end

            end
            #puts "X: #{key.x} Y: #{key.y} Value: #{value}"

            
        }

        return subArray
    end

    def print()
        array = to_a
        
        array.cycle(1) { |inner| 
            p inner
        }
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
