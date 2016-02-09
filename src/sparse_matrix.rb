require_relative "point.rb"
require "matrix"

class SparseMatrix

    # Instance variables for SparseMatrix:
    # @sparse_hash
    # @width
    # @height

    attr_reader :sparse_hash
    
    # Exception for mismatching/incompatible dimensions during matrix operations.
    class DimensionError < StandardError
    end
    
    # Iterate through the passed-in array, only adding non-zero values to the hash.
    def initialize(array)
        @sparse_hash = Hash.new
        @sparse_hash.default = 0
        array.length == 1 && array[0].length == 0 ? @height = 0 : @height = array.length
        array[0] ? @width = array[0].length : @width = 0

        # Populate the hash for the sparse matrix.
        # Insert a value only if it is not 0.
        array.each_with_index do |row, row_num|
            row.each_with_index do |val, col_num|
                @sparse_hash[Point.new(row_num, col_num)] = val unless val == 0
            end
        end
    end

    # Format is [row, column]
    def [](x, y)
        raise IndexError, "The specified index is out of bounds. The matrix is of size #{@height}x#{@width}." unless x < @height and x >= 0 and y < @width and y >= 0
        raise IndexError, "The index cannot contain negatives." if x < 0 or y < 0
        @sparse_hash[Point.new(x, y)]
    end

    def set_size(rows, columns)
        @height = rows
        @width  = columns
    end

    alias get []

    def set_element(key,value)
        end

        if key.x > @width
            @width = key.x + 1
        end
        if key.y > @height
            @height = key.y + 1
        end

        @sparse_hash[key] = value

    end

    def get_copy
        # http://stackoverflow.com/questions/4157399/how-do-i-copy-a-hash-in-ruby User: Wayne
        return Marshal.load(Marshal.dump(self))
    end

    # Returns a new, empty (zeroed) SparseMatrix of size {height x width}.
    #
    # Example:
    # empty(2, 3) --> [[0, 0, 0], [0, 0, 0]]
    #
    def empty(height, width)
        SparseMatrix.new(Array.new(height) {Array.new(width) {0}})
    end
    
    def add(m)

        typeerror_msg = "The input object is not a Matrix, SparseMatrix, or Array. It is a(n) #{m.class}."
        diimenesionerror_msg = "Dimension mismatch. Matrix sizes must be identical."

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        raise TypeError, typeerror_msg unless m.is_a? Matrix or m.is_a? SparseMatrix or m.is_a? Array

        # Matrix addition is only defined when the sizes are exactly the same.
        case m
        when Array
            raise DimensionError, diimenesionerror_msg unless m.length == @height and m[0].length == @width
        when Matrix, SparseMatrix
            raise DimensionError, diimenesionerror_msg unless m.row_count == @height and m.column_count == @width
        end
        
        sum_matrix = SparseMatrix.new(m.to_a)
        @sparse_hash.each {|p, v| sum_matrix.set_element(p, v + sum_matrix[p.x, p.y])}
        sum_matrix
    end

    alias + add
    
    def subtract(m)

        typeerror_msg = "The input object is not a Matrix, SparseMatrix, or Array. It is a(n) #{m.class}."
        diimenesionerror_msg = "Dimension mismatch. Matrix sizes must be identical."    
    
        raise TypeError, typeerror_msg unless m.is_a? Matrix or m.is_a? SparseMatrix or m.is_a? Array

        # Matrix subtraction is only defined when the sizes are exactly the same.
        case m
        when Array
            raise DimensionError, diimenesionerror_msg unless m.length == @height and m[0].length == @width
        when Matrix, SparseMatrix
            raise DimensionError, diimenesionerror_msg unless m.row_count == @height and m.column_count == @width
        end
        
        difference_matrix = empty(@height, @width)
        m.to_a.each_with_index {|row, row_num| row.each_with_index {|val, col_num| difference_matrix.set_element(Point.new(row_num, col_num), -val)}}
        @sparse_hash.each {|p, v| difference_matrix.set_element(p, v + difference_matrix[p.x, p.y])}
        difference_matrix
    end

    alias - subtract    

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


    def matrix_multiply(value)
        case value
        when Fixnum
            return self.scalar_multiply(value)
        when Array
            array = SparseMatrix.new(value)
        when SparseMatrix
            array = value
        else
            # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
            typeerror_msg = "The input object is not a Matrix, SparseMatrix or Array. It is a #{value.class}."

            # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
            raise TypeError, typeerror_msg
        end

        if self.size[1] == array.size[0] && self.size[0] == 1 && array.size[1] == 1 then
            # return scalar
            # args are vectors
            val = 0
            @sparse_hash.each do |key, value|
                val += (value * array[key.y, key.x]).round(4)
            end
            return SparseMatrix.new([[val]])
        elsif self.size[1] == array.size[0] && (self.size[0] != 1 || array.size[1] != 1) then
            product_matrix = SparseMatrix.new([[]])
            product_matrix.set_size(self.size[1], array.size[0])
            x=0
            while x < self.size[0] do
                y=0
                while y < array.size[1] do
                    t = self.row_vector(x)
                    r = array.column_vector(y)
                    product_matrix.set_element(Point.new(x,y), (t * r)[0,0])
                    y += 1
                end
                x += 1
            end
            return product_matrix
        end


    end

    alias * matrix_multiply

    # Scalar multiply increases/decreases itself by value.
    def scalar_multiply(value)

        # Check pre-conditions: value must be an Integer
        if !(value.is_a? Integer) and !(value.is_a? Float)
            raise TypeError, "The input object is not an Integer or Float. It is a #{value.class}."
        end
        product_matrix = self.get_copy
        @sparse_hash.each { |key, hashValue|
            product_matrix.set_element(key, hashValue * value )
        }

        return product_matrix
    end

    def elementwise_multiply(array)
        case array
        when Array
            array = SparseMatrix.new(array)
        end
        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."
        end

        product_matrix = self.get_copy
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
        array_outer = Array.new(@width)        
        array_outer.each_with_index {|row, row_num|
            array_outer[row_num] = Array.new(@height, 0)
        }

        # Iterate through, flipping all the spots x and y
        @sparse_hash.each { |key, value|
            array_outer[key.y][key.x] = value
        }

        transposed = SparseMatrix.new(array_outer)

        # Post conditions
        if !(self.row_count() == transposed.column_count()) or !(self.column_count() == transposed.row_count())
            raise ArgumentError, "The transpose failed."
        end

        return transposed
    end

    # The inverse of a matrix is defined as inv(A)=adj(A)/det(A)
    def inverse
        if !(self.square?)
            raise ArgumentError, "The object must be square to be invertible."
        end

        det_value = determinant()
        if (det_value == 0)
            raise ArgumentError, "The determinant can't be 0."
        end
        
        adj_matrix = adjugate()

        return adj_matrix.scalar_multiply(1.0 / det_value)
    end

    # The cofactor is the matrix you get if you get the determinant of 
    # all the minors in a square matrix and multiply the cofactor value by it.
    # NOTE: returns an Array
    def cofactor
        co_array = Array.new(@height)        
        co_array.each_with_index {|row, row_num|
            co_array[row_num] = Array.new(@width, 0)
        }

        co_array.each_with_index {|row, row_num|
            row.each_with_index {|column, column_num|
                det_val = SparseMatrix.new(get_minor(row_num, column_num)).determinant()
                co_val = (-1) ** ((row_num + 1) + (column_num + 1)) # (-1) ^ (i + j)
                co_array[row_num][column_num] = co_val * det_val
            }
        }

        return co_array
    end

    # The adjugate is defined as the transpose of the cofactor matrix or:
    # adj(A)=C^T
    def adjugate
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
    def determinant
        if !(self.square?)
            raise ArgumentError, "The object must be square to find the determinant."
        end

        row = 0

        # When the internal array is a 2x2, just return the current det value.
        if @height == 2 and @width == 2
            return get(0, 0) * get(1, 1) - get(0, 1) * get(1, 0) # ad-bc
        end        

        r_val = 0
        # recursively break up the array
        for i in 0..@width - 1
            baby_array = get_minor(row, i)

            baby_matrix = SparseMatrix.new(baby_array)

            r_val = r_val + (-1) ** ((row + 1) + (i + 1)) * get(row, i) * baby_matrix.determinant()

        end

        return r_val
    end

    # A helper function for getting the determinant. This will get the subarray
    # for this sparse matrix. 
    # Note: This returns an array object
    def get_minor(row, column)
        if (column >= @width)
            raise ArgumentError, "The row and column must be less than the matrix size."
        end

        # build an array to hold the new sub-array
        sub_array = Array.new(@height - 1)        
        sub_array.each_with_index {|row, row_num|
            sub_array[row_num] = Array.new(@width - 1, 0)
        }

        # Fill the array with data so long as it isn't from the current value's row/col
        @sparse_hash.each { |key, value|
            next if key.y == column or key.x == row

            if key.y > column
                if key.x > row
                    sub_array[key.x - 1][key.y - 1] = value
                elsif key.x < row
                    sub_array[key.x][key.y - 1] = value
                end                
            elsif key.y < column
                if key.x > row
                    sub_array[key.x - 1][key.y] = value
                elsif key.x < row
                    sub_array[key.x][key.y] = value
                end
            end 
        }

        return sub_array
    end

    def rank
        to_m.rank
    end

    def trace
        raise DimensionError, "The Matrix must be square to find the trace." if !square?
        0.upto(@width-1).inject(0) {|trace, i| trace + get(i, i)}
    end
    
    # Prints the matrix to console. Each row uses a separate line.
    def print
        to_a.cycle(1) {|inner| p inner}
    end

    # Returns the number of rows in the matrix.
    def row_count
        return @height
    end

    # Returns the number of columns in the matrix.
    def column_count
        return @width
    end

    # A matrix is empty if all entries are 0.
    def empty?
        return @sparse_hash.empty?
    end

    # A matrix M is orthogonal if M * M Transpose == Identity.
    def orthogonal?
        return false unless square?
        return self * transpose == SparseMatrix.identity(size[0])
    end

    # A matrix is square if its dimensions are equal.
    def square?
        @width == @height and @width != 0
    end

    # A matrix is singular (noninvertible) if it is square and its determinant is 0.    
    def singular?
        square? and determinant == 0
    end

    # A matrix is invertible (nonsingular) if it is square and its determinant is not 0.
    def invertible?
        square? and determinant != 0
    end

    # A matrix is diagonal if all entries outside the main diagonal are 0.
    def diagonal?
        return false if not square?
        @sparse_hash.each {|point, val| return false if point.x != point.y}
        true
    end

    # Returns an identity matrix with the dimensions: size x size.
    def SparseMatrix.identity(size)
        raise ArgumentError, "Size of identity matrix must be an integer." unless size.is_a? Integer
        SparseMatrix.new(Array.new(size) {|i| Array.new(size) {|j| i == j ? 1 : 0}})
    end

    # A matrix M is symmetric if and only if M[i, j] == M [j, i]. M == M Transpose.
    def symmetric?
        return false if not square?
        @sparse_hash.each {|point, val| return false if get(point.x, point.y) != get(point.y, point.x)}
        true
    end

    def eql?(m)
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
    end

    alias eql eql?
    alias == eql?
    alias equals eql?

    # Returns an Array representation of the matrix.
    def to_a
        array = Array.new(@height) {Array.new(@width, 0)}
        @sparse_hash.each {|key, value| array[key.x][key.y] = value}
        array
    end

    # Returns a Matrix representation of the matrix.
    def to_m
        Matrix.rows(to_a())
    end

    # Returns the dimensions of the matrix.
    def size
        [row_count, column_count]
    end
    
    # Sparsity is defined as the fraction of zero-elements over the total number of elements.
    def sparsity
        total_elements = size[0]*size[1]
        (total_elements - @sparse_hash.size) / total_elements.to_f
    end
    
    # Density is defined as the fraction of nonzero-elements over the total number of elements.
    def density
        total_elements = size[0]*size[1]
        @sparse_hash.size / total_elements.to_f
    end
    
    # Overrides Object#to_s
    # Printout for SparseMatrix. Delegates to the Matrix class.
    def to_s
        to_m().to_s.sub("Matrix", "SparseMatrix")
    end

    # Overrides Object#inspect
    # Printout for SparseMatrix. Delegates to the Matrix class.
    def inspect
        to_m().inspect.sub("Matrix", "SparseMatrix")
    end

end
