require "test/unit"
require "matrix"
require_relative "sparse_matrix"

class SparseMatrixTest < Test::Unit::TestCase

    def test_add
        array1 = Matrix[[7, 9, 11], [6, 8, 10], [5, 7, 9]]
        array2 = Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        result = array1 + array2

        assert(SparseMatrix.new(array1).add(array2).equals(result));
    end

    def test_subtract

    end

    def test_transpose
      # http://matrix.reshish.com/transCalculation.php
      # assign 2d array to make into sparse matrices
      m1 = [[1,0,2],[0,3,0]] # transpose of m1
      m2 = [[1,0],[0,3],[2,0]] # transpose of m2

      # get corresponding sparse matrix objects
      sparse_m1 = SparseMatrix.new(m1)
      sparse_m2 = SparseMatrix.new(m2)

      # calculate transposes
      sparse_m1_transposed = sparse_m1.transpose()
      sparse_m2_transposed = sparse_m2.transpose()

      # check for correct transposition (?)
      assert(sparse_m1_transposed == sparse_m2)
      assert(sparse_m2_transposed == sparse_m1)
    end

    def test_size
      # https://en.wikipedia.org/wiki/Matrix_%28mathematics%29#Size
      # assign 2d array to make into sparse matrices
      m1 = [[1,0,2],[0,3,0]] # transpose of m1
      m2 = [[1,0],[0,3],[2,0]] # transpose of m2

      # get corresponding sparse matrix objects
      sparse_m1 = SparseMatrix.new(m1)
      sparse_m2 = SparseMatrix.new(m2)

      # get sizes
      m1_size = sparse_m1.size()
      m2_size = sparse_m2.size()

      # check sizes
      assert(m1_size == [2,3])
      assert(m2_size == [3,2])
    end


    def test_trace
      # http://matrix.reshish.com/transCalculation.php
      # assign 2d array to make into sparse matrices
      m1 = [[1,0,2],[0,3,0],[1,0,1]] # transpose of m1
      m2 = [[1,0],[0,3],[2,0]] # transpose of m2

      # get corresponding sparse matrix objects
      sparse_m1 = SparseMatrix.new(m1)
      sparse_m2 = SparseMatrix.new(m2)

      # calculate traces
      sparse_m1_trace = sparse_m1.trace()
      sparse_m2_trace = sparse_m2.trace()

      # check for correct trace
      assert(sparse_m2_trace == 1 + 3 + 1) # sum of diagonals
      assert_not_equal(sparse_m1_trace, sparse_m1)
      assert(sparse_m1_trace == -1) # bad number or exception?
    end

end
