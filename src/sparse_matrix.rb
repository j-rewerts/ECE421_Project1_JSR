
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
        # Pre-conditions. Non-square matrices are non-invertible.
        if !(self.square?)
            raise ArgumentError, "The object must be square to be invertible."

        # Doing the post-condition by multiplying A*B=I would slow down our package.
    end

    def transpose()

        # No Pre-conditions

        transposed = self

        # Post conditions
        if !(self.row_count() == transposed.column_count()) or !(self.column_count() == transposed.row_count())
            raise Error, "The transpose failed."
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

        # Pre-conditions: None. The current object is already a SparseMatrix.
    
    end

    # Array*Array^T=Identity=Array^T*Array
    def orthogonal?()

        # Pre-conditions: None. The current object is already a SparseMatrix.
    
    end

    def square?()
    
        # Pre-conditions: None. The current object is already a SparseMatrix.
      
    end

    def singular?()
    
        # Pre-conditions: None. The current object is already a SparseMatrix.

    end

    def invertible?()
    
        # Pre-conditions: None. The current object is already a SparseMatrix.

    end

    def diagonal?()
    
        # Pre-conditions: None. The current object is already a SparseMatrix.

    end

    def SparseMatrix.identity(size)

    end

    def symmetric?()
    
        # Pre-conditions: None. The current object is already a SparseMatrix.

    end    
    
    def equals(m)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(m.is_a? Matrix) and !(m.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."
        
        # Implement equals.
    
    end
    
    def eql(m)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(m.is_a? Matrix) and !(m.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."
        
        # Implement eql.
    
    end

    def size()

        # Pre-conditions: None. The current object is already a SparseMatrix.

    end
end
