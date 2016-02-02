
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

    end

    def matrix_multiply(array)

    end

    # This function may not need to exist. It could just be part of the other multiply function
    def scalar_multiply(value)

    end

    def elementwise_multiply(array)

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
