require "test/unit"
require_relative "sparse_matrix"

class SparseMatrixTest < Test::Unit::TestCase

    def test_add
        

        assert(SparseMatrix.new(array1).add(array2).equals(result));
    end

    def test_subtract

    end

end