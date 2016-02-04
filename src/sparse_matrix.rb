require "./point.rb"

class SparseMatrix    

    @sparse_hash
    @width
    @height

    # Iterate through the passed array, only adding non-zero values to the hash.
    def initialize(array)
        # Take the array and shove it into whatever
        @sparse_hash = Hash.new
        @height = array.length
        @width = array[0].length
        @sparse_hash.default = 0
        
        @j = 0
        while @j < @height do

            @i = 0
            while @i < @width do
                puts @i
                if (array[@j][@i] != 0)
                    puts "Test"
                    @point = Point.new(@i, @j)
                    @sparse_hash[@point] = array[@j][@i]
                end

                @i += 1
            end

            @j += 1
        end
    end

    def get(x, y)
        @point = Point.new(@i, @j)
        return @sparse_hash[@point]
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

    def matrix_multiply(array)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."
        end

    end

    # This function may not need to exist. It could just be part of the other multiply function
    def scalar_multiply(value)

        # Check pre-conditions: value must be an Integer
        if !(value.is_a? Integer)
            raise TypeError, "The input object is not an Integer. It is a #{value.class}."
        end

    end

    def elementwise_multiply(array)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."
        end
    end

    def inverse()
        # Pre-conditions. Non-square matrices are non-invertible.
        if !(self.square?)
            raise ArgumentError, "The object must be square to be invertible."
        end

        # Doing the post-condition by multiplying A*B=I would slow down our package.
    end

    def transpose()

        # No Pre-conditions

        transposed = self

        # Post conditions
        if !(self.row_count() == transposed.column_count()) or !(self.column_count() == transposed.row_count())
            raise Error, "The transpose failed."
        end
    end

    def rank()
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.

    end

    def trace()
        # Pre-conditions. Non-square matrices are non-invertible.
        if !(self.square?)
            raise ArgumentError, "The object must be square to find the trace."
        end

        # Post-condition: We return a trace of the matrix.
    end

    def determinant()
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    end

    def row_count()
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    end
    
    def column_count()
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    end
    
    def empty?()

        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end

    # Array*Array^T=Identity=Array^T*Array
    def orthogonal?()

        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end

    def square?()
    
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
      
    end

    def singular?()
    
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end

    def invertible?()
    
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end

    def diagonal?()
    
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end

    def SparseMatrix.identity(size)
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    end

    def symmetric?()
    
        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end 
    
    def equals(m)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(m.is_a? Matrix) and !(m.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."
        end
        
        # Implement equals.
    
    end
    
    def eql(m)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(m.is_a? Matrix) and !(m.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."
        end
        
        # Implement eql.
    
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end

    def size()

        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end
end
