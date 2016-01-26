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
        array1 = Matrix[[7, 9, 11], [6, 8, 10], [5, 7, 9]]
        array2 = Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        result = array1 - array2

        assert(SparseMatrix.new(array1).subtract(array2).equals(result));
    end

    def test_get_rank
        array1 = Matrix[[7, 9, 11], [6, 8, 10], [5, 7, 9]]

        assert_equal(SparseMatrix.new(array1).get_rank(), array1.rank())
    end

end