require "test/unit"
require "matrix"
require_relative "sparse_matrix"

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

    def test_get_rank
        array1 = [[7, 9, 11], [6, 8, 10], [5, 7, 9]]

        assert_equal(SparseMatrix.new(array1).get_rank(), Matrix.rows(array1).rank())
    end

    def test_is_empty
        array1 = [[]]

        # passing an empty array should result in the sparse matrix being empty
        assert(SparseMatrix.new(array1).is_empty())
    end

    def test_determinant()
        array1 = [[3, 4, 9], [2, 1, 6], [1, 2, 7]]

        assert_equal(SparseMatrix.new(array1).determinant(), Matrix.rows(array1).determinant())
    end

    def test_is_singular()
        array1 = [[7, 9, 11], [6, 8, 10], [5, 7, 9]]

        assert_equal(SparseMatrix.new(array1).is_singular(), Matrix.rows(array1).singular?())
    end

    def test_transpose
      # http://matrix.reshish.com/transCalculation.php
      # assign 2d array to make into sparse matrices
      m1 = [[1,0,2],[0,3,0]] # transpose of m1
      m2 = [[1,0],[0,3],[2,0]] # transpose of m2
      m3 = [[0,0],[0,0]]

      # get corresponding sparse matrix objects
      sparse_m1 = SparseMatrix.new(m1)
      sparse_m2 = SparseMatrix.new(m2)
      sparse_m3 = SparseMatrix.new(m3)

      # pre-conditions & invariants
      assert(sparse_m1.is_a SparseMatrix)
      assert(sparse_m2.is_a SparseMatrix)
      assert(sparse_m3.is_a SparseMatrix)


      # calculate transposes
      sparse_m1_transposed = sparse_m1.transpose()
      sparse_m2_transposed = sparse_m2.transpose()
      sparse_m3_transposed = sparse_m3.transpose()

      # post-conditions & invariants
      assert(sparse_m1.is_a SparseMatrix)
      assert(sparse_m2.is_a SparseMatrix)
      assert(sparse_m3.is_a SparseMatrix)

      assert(sparse_m1_transposed == sparse_m2)
      assert(sparse_m2_transposed == sparse_m1)
      assert(sparse_m3_transposed == sparse_m3)

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

      # pre-conditions & invariants
      assert(sparse_m1.is_a SparseMatrix)
      assert(sparse_m2.is_a SparseMatrix)
      assert(sparse_m3.is_a SparseMatrix)

      assert(sparse_m1 == SparseMatrix.new(m1))
      assert(sparse_m2 == SparseMatrix.new(m2))
      assert(sparse_m3 == SparseMatrix.new(m3))

      # get sizes
      m1_size = sparse_m1.size()
      m2_size = sparse_m2.size()
      m3_size = sparse_m3.size()

      # post-conditions & invariants
      assert(sparse_m1.is_a SparseMatrix)
      assert(sparse_m2.is_a SparseMatrix)
      assert(sparse_m3.is_a SparseMatrix)

      assert(sparse_m1 == SparseMatrix.new(m1))
      assert(sparse_m2 == SparseMatrix.new(m2))
      assert(sparse_m3 == SparseMatrix.new(m3))

      assert(m1_size == [2,3])
      assert(m2_size == [3,2])
      assert(m3_size == [0,0])
    end


    def test_trace
      # assign 2d array to make into sparse matrices
      m1 = [[1,0,2],[0,3,0],[1,0,1]] # square matrix
      m2 = [[1,0],[0,3],[2,0]] # not square matrix --> error or bad number...

      # get corresponding sparse matrix objects
      sparse_m1 = SparseMatrix.new(m1)
      sparse_m2 = SparseMatrix.new(m2)

      # pre-conditions & invariants
      assert(sparse_m1.is_a SparseMatrix)
      assert(sparse_m2.is_a SparseMatrix)
      assert(sparse_m3.is_a SparseMatrix)

      assert(sparse_m1 == SparseMatrix.new(m1))
      assert(sparse_m2 == SparseMatrix.new(m2))
      assert(sparse_m3 == SparseMatrix.new(m3))

      # calculate traces
      sparse_m1_trace = sparse_m1.trace()
      sparse_m2_trace = sparse_m2.trace()

      # pre-conditions & invariants
      assert(sparse_m1.is_a SparseMatrix)
      assert(sparse_m2.is_a SparseMatrix)
      assert(sparse_m3.is_a SparseMatrix)

      assert(sparse_m1 == SparseMatrix.new(m1))
      assert(sparse_m2 == SparseMatrix.new(m2))
      assert(sparse_m3 == SparseMatrix.new(m3))

      assert(sparse_m1_trace == 1 + 3 + 1) # sum of diagonals
      assert(sparse_m2_trace == -1) # bad number or exception?
    end

    def test_diagonal
      # http://calculator.tutorvista.com/math/430/diagonal-matrix-calculator.html
      # Note: requires square matrix
      # assign 2d array to make into sparse matrices
      m1 = [[1,0,0],[0,3,0],[0,32,0]] # transpose of m1
      m2 = [[1,0],[0,3],[2,0]] # transpose of m2

      # get corresponding sparse matrix objects
      sparse_m1 = SparseMatrix.new(m1)
      sparse_m2 = SparseMatrix.new(m2)

      # calculate traces
      sparse_m1_is_diagonal = sparse_m1.is_diagonal?
      sparse_m2_is_diagonal = sparse_m2.is_diagonal?
      assert(sparse_m1_is_diagonal == true)
      assert(sparse_m2_is_diagonal == false)
    end

    def test_symmetric
      # https://en.wikipedia.org/wiki/Symmetric_matrix
      # assign 2d array to make into sparse matrices
      m1 = [[1,0,2],[0,3,0]] # not symmetric
      m2 = [[1,0],[0,3],[2,0]] # not symmetric
      m3 = [[1,5,7],[5,4,8],[7,8,0]]
      #
      #       1,5,7
      # m3 =  5,4,8   #---> symmetric
      #       7,8,0
      #
      # get corresponding sparse matrix objects
      sparse_m1 = SparseMatrix.new(m1)
      sparse_m2 = SparseMatrix.new(m2)
      sparse_m3 = SparseMatrix.new(m3)

      # calculate transposes
      sparse_m1_transposed = sparse_m1.transpose()
      sparse_m2_transposed = sparse_m2.transpose()
      sparse_m3_transposed = sparse_m3.transpose()

      # check
      assert_not_equal(sparse_m1_transposed == sparse_m1) # not symmetric
      assert_not_equal(sparse_m2_transposed == sparse_m2) # not symmetric
      assert(sparse_m3_transposed == sparse_m3)  # symmetric!
    end

end
