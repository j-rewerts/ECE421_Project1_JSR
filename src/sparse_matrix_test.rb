require "test/unit"
require "matrix"
require "./src/sparse_matrix.rb"

class SparseMatrixTest < Test::Unit::TestCase

    def test_add
        array1 = [[7, 9, 11], [6, 8, 10], [5, 7, 9]]
        array2 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        result = Matrix.rows(array1) + Matrix.rows(array2)

        assert_equal(SparseMatrix.new(array1).add(array2), result.to_a)
    end

    def test_subtract
        array1 = [[7, 9, 11], [6, 8, 10], [5, 7, 9]]
        array2 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        result = Matrix.rows(array1) - Matrix.rows(array2)

        assert_equal(SparseMatrix.new(array1).subtract(array2), result.to_a)
    end
    
    def test_matrix_multiply
        array1 = [[4, 0, 3], [3, 4, 0], [4, 6, 8]]
        array2 = [[1, 3, 0], [8, 7, 3], [9, 9, 4]]
        result = Matrix.rows(array1) * Matrix.rows(array2)
        
        assert_equal(SparseMatrix.new(array1).matrix_multiply(array2), result.to_a)
    end
    
    def test_scalar_multiply
        array1 = [[4, 0, 3], [3, 4, 0], [4, 6, 8]]
        scale = 2
        result1 = Matrix.rows(array1) * scale
        
        assert_equal(SparseMatrix.new(array1).scalar_multiply(scale).to_m(), result1)
    end
    
    def test_elementwise_multiply
        array1 = [[4, 0, 3], [3, 4, 0], [4, 6, 8]]
        array2 = [[1, 3, 0], [8, 7, 3], [9, 9, 4]]
        
        # For each row of +array1+, multiply each element by the corresponding element in +array2+.
        result = array1.collect.with_index {|x, i| x.collect.with_index {|y, j| y * array2[i][j]} }
        
        assert_equal(SparseMatrix.new(array1).elementwise_multiply(array2), result.to_a)
    end
    
    def test_inverse
        array1 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]]

        result = Matrix.rows(array1).inverse().to_a()   

        sparseArray = SparseMatrix.new(array1).inverse().to_a()

        deltaTolerance = 0.00001
        # Iterate through, verifying within a certain delta tolerance
        for row in 0..result.size() - 1
            for column in 0..result[0].size() - 1
                assert_in_delta(result[row][column], sparseArray[row][column], deltaTolerance)
            end

        end
    end

    def test_transpose
        # http://matrix.reshish.com/transCalculation.php
        # assign 2d array to make into sparse matrices
        m1 = [[1,0,2],[0,3,0]] # transpose of m1
        m2 = [[1,0],[0,3],[2,0]] # transpose of m2
        m3 = [[0,0],[0,0]]
        m4 = [[]]

        # get corresponding sparse matrix objects
        sparse_m1 = SparseMatrix.new(m1)
        sparse_m2 = SparseMatrix.new(m2)
        sparse_m3 = SparseMatrix.new(m3)
        sparse_m4 = SparseMatrix.new(m4)

        # calculate transposes
        sparse_m1_transposed = sparse_m1.transpose()
        sparse_m2_transposed = sparse_m2.transpose()
        sparse_m3_transposed = sparse_m3.transpose()
        sparse_m4_transposed = sparse_m4.transpose()

        assert(sparse_m1_transposed == sparse_m2)
        assert(sparse_m2_transposed == sparse_m1)
        assert(sparse_m3_transposed == sparse_m3)
        assert(sparse_m4_transposed == SparseMatrix.new([[]]))

    end    
    
    def test_rank
        array1 = [[7, 9, 11], [6, 8, 10], [5, 7, 9]]

        assert_equal(SparseMatrix.new(array1).rank(), Matrix.rows(array1).rank())
    end

    def test_trace
        # assign 2d array to make into sparse matrices
        m1 = [[1,0,2],[0,3,0],[1,0,1]] # square matrix
        m2 = [[8,0,1],[0,3,1],[2,0,4]] # not square matrix --> error or bad number...

        # get corresponding sparse matrix objects
        sparse_m1 = SparseMatrix.new(m1)
        sparse_m2 = SparseMatrix.new(m2)

        # calculate traces
        sparse_m1_trace = sparse_m1.trace()
        sparse_m2_trace = sparse_m2.trace()

        assert(sparse_m1_trace.eql? (1 + 3 + 1)) # sum of diagonals
        assert(sparse_m2_trace.eql? (8 + 3 + 4)) # bad number or exception?

    end
    
    def test_determinant
        array1 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]]

        assert_equal(SparseMatrix.new(array1).determinant(), Matrix.rows(array1).determinant())
    end

    def test_cofactor
        array1 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]]
        cofactor = [[-5, -8, 3], [-10, 12, -2], [15, 0, -5]]

        assert_equal(SparseMatrix.new(array1).cofactor(), cofactor)
    end

    def test_adjugate
        array1 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]]
        adj = [[-5, -10, 15], [-8, 12, 0], [3, -2, -5]]

        assert_equal(SparseMatrix.new(array1).adjugate(), adj)
    end
    
    def test_empty?
        array1 = [[]]

        # passing an empty array should result in the sparse matrix being empty
        assert(SparseMatrix.new(array1).empty?)
    end
    
    def test_orthogonal?   
        # Orthogonality implies: A*A' == I.
    
        array1 = [[-0.3092, -0.9510], [-0.9510, 0.3092]] # orthogonal
        array2 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]] # not orthogonal
        array3 = [[3, 4, 9], [2, 1, 6]] # not orthogonal
        array4 = [[-3, -4], [-4, 3]] # not orthogonal
        
        assert(SparseMatrix.new(array1).orthogonal?)
        assert(!SparseMatrix.new(array2).orthogonal?)
        assert(!SparseMatrix.new(array3).orthogonal?)
        assert(!SparseMatrix.new(array4).orthogonal?)
    end
    
    def test_square?
        # Square implies: num_rows == num_columns.
    
        array1 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]]
        array2 = [[3, 4, 9], [2, 1, 6]]
        
        assert(SparseMatrix.new(array1).square?)
        assert(!SparseMatrix.new(array2).square?)
    end
    
    def test_singular?
        # Singular implies: the determinant of the matrix is 0.
    
        array1 = [[7, 9, 11], [6, 8, 10], [5, 7, 9]]

        assert_equal(SparseMatrix.new(array1).singular?, Matrix.rows(array1).singular?())
    end

    def test_invertible?
        # Invertibility implies: the matrix is square and its determinant is not 0. 
    
        array1 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]]
        array2 = [[3, 4, 9], [2, 1, 6]]
        
        assert(SparseMatrix.new(array1).invertible?)
        assert(!SparseMatrix.new(array2).invertible?)
    end    
    
    def test_diagonal?
        # http://calculator.tutorvista.com/math/430/diagonal-matrix-calculator.html
        # Note: requires square matrix
        # assign 2d array to make into sparse matrices
        m1 = [[1,0,0],[0,3,0],[0,32,0]] # not diagonal
        m2 = [[1,0,0],[0,3,0],[0,0,0]] # diagonal
        m3 = [[]]

        # get corresponding sparse matrix objects
        sparse_m1 = SparseMatrix.new(m1)
        sparse_m2 = SparseMatrix.new(m2)
        sparse_m3 = SparseMatrix.new(m3)

        # calculate diagonality
        sparse_m1_is_diagonal = sparse_m1.diagonal?
        sparse_m2_is_diagonal = sparse_m2.diagonal?
        sparse_m3_is_diagonal = sparse_m3.diagonal?

        assert(sparse_m1_is_diagonal == false)
        assert(sparse_m2_is_diagonal == true)
        assert(sparse_m3_is_diagonal == false)
    end

    def test_symmetric?
        # https://en.wikipedia.org/wiki/Symmetric_matrix
        # assign 2d array to make into sparse matrices
        m1 = [[1,0,2],[0,3,0]] # not symmetric
        m2 = [[1,0],[0,3],[2,0]] # not symmetric
        m3 = [[1,5,7],[5,4,8],[7,8,0]] # symmetric
        #
        #       1,5,7
        # m3 =  5,4,8   #---> symmetric
        #       7,8,0
        #
        # get corresponding sparse matrix objects
        sparse_m1 = SparseMatrix.new(m1)
        sparse_m2 = SparseMatrix.new(m2)
        sparse_m3 = SparseMatrix.new(m3)

        # check
        assert(sparse_m1.symmetric? == false)
        assert(sparse_m2.symmetric? == false)
        assert(sparse_m3.symmetric? == true)

    end
    
    def test_size
        # https://en.wikipedia.org/wiki/Matrix_%28mathematics%29#Size
        # assign 2d array to make into sparse matrices
        m1 = [[1,0,2],[0,3,0]] # transpose of m1
        m2 = [[1,0],[0,3],[2,0]] # transpose of m2
        m3 = [[]] # empty

        # get corresponding sparse matrix objects
        sparse_m1 = SparseMatrix.new(m1)
        sparse_m2 = SparseMatrix.new(m2)
        sparse_m3 = SparseMatrix.new(m3)

        # get sizes
        m1_size = sparse_m1.size()
        m2_size = sparse_m2.size()
        m3_size = sparse_m3.size()

        assert(m1_size == [2,3])
        assert(m2_size == [3,2])
        assert(m3_size == [0,0])

    end
    
    # Sparsity is defined as the fraction of zero-elements over the total number of elements.
    def test_sparsity()
        m = [[0, 1], [0, 0]]
        m_sparsity = 3/4.to_f
        assert_equal(SparseMatrix.new(m).sparsity, m_sparsity)
    end
    
    # Density is defined as the fraction of nonzero-elements over the total number of elements.
    def test_density()
        m = [[0, 1], [0, 0]]
        m_density = 1/4.to_f
        assert_equal(SparseMatrix.new(m).density, m_density)
    end
    
    def test_identity
        i_2 = [[1,0], [0,1]]
        i_3 = [[1,0,0], [0,1,0], [0,0,1]]
        i_4 = [[1,0,0,0], [0,1,0,0], [0,0,1,0], [0,0,0,1]]

        # generate the identity matrices
        sparse_i_2 = SparseMatrix.identity(2)
        sparse_i_3 = SparseMatrix.identity(3)
        sparse_i_4 = SparseMatrix.identity(4)

        # convert test identity matrices to sparse matrices
        sparse_m1 = SparseMatrix.new(i_2)
        sparse_m2 = SparseMatrix.new(i_3)
        sparse_m3 = SparseMatrix.new(i_4)

        # check for equality
        assert(sparse_m1 == sparse_i_2)
        assert(sparse_m2 == sparse_i_3)
        assert(sparse_m3 == sparse_i_4)
    end

    def test_equal
        array1 = [[7, 9, 11], [6, 8, 10], [5, 7, 9]]
        assert(SparseMatrix.new(array1).equals(Matrix.rows(array1)))
    end

end
