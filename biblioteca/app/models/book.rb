class Book < ActiveRecord::Base
	validates_presence_of :nome, message: " deve ser preenchido"
	validates_presence_of :autor, message: " deve ser preenchido"
 
	validates_numericality_of :quantidade_estoque, greater_than: 0.9, message: " deve ser de no mínimo 1"

  	self.per_page = 10

  	def self.search(search, id)
   		where(['nome LIKE ? or autor LIKE ?', "%#{search}%", "%#{search}%"])
	end
end
