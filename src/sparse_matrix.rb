
class SparseMatrix

    def initialize(array)
    # Take the array and shove it into whatever
    end

    def add(m)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(m.is_a? Matrix) and !(m.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."
        
        # Implement adding functionality.
   
    end

    def subtract(array)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."

    end

    def matrix_multiply(array)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."

    end

    # This function may not need to exist. It could just be part of the other multiply function
    def scalar_multiply(value)

        # Check pre-conditions: value must be an Integer
        if !(value.is_a? Integer)
            raise TypeError, "The input object is not an Integer. It is a #{value.class}."

    end

    def elementwise_multiply(array)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(array.is_a? Matrix) and !(array.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{array.class}."
    end

    def inverse()

    end

    def transpose()

    end

    def rank()

    end

    def trace()

    end

    def determinant()

    end

    def row_count()
        
    end
    
    def column_count()
        
    end
    
    def empty?()

    end

    # Array*Array^T=Identity=Array^T*Array
    def orthogonal?()

    end

    def square?()
      return true
    end

    def singular?()

    end

    def invertible?()

    end

    def diagonal?()

    end

    def SparseMatrix.identity(size)

    end

    def symmetric?()

    end    
    
    def equals(array)

    end
    
    def eql(array)

    end

    def size()

    end
end
