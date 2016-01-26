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

end
