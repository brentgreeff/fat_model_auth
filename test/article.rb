class FatModelAuthTest < ActionController::TestCase
	class Article
	  extend FatModelAuth::ModelHelpers
	  attr_accessor :id

	  def initialize(id = 1)
	    @id = id
	  end

	  allows :edit, if: proc { |article, editor| editor == :admin }
	  allows :destroy, unless: proc { |article, type| type == :important }
	end
end