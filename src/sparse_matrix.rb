
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
        
        # Implement equals.
    
    end
    
    def eql(m)

        # Check pre-conditions: +m+ must be a Matrix or a SparseMatrix.
        if !(m.is_a? Matrix) and !(m.is_a? SparseMatrix)
            raise TypeError, "The input object is not a Matrix or SparseMatrix. It is a #{m.class}."
        
        # Implement eql.
    
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end

    def size()

        # Pre-conditions: The current object (self) is already a SparseMatrix.
        
        # Post-conditions: The current object (self) is still a SparseMatrix. It is untouched.
    
    end
end
