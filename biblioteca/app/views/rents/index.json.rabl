collection @rents
attributes :id, :book_id
node(:book_name) {|rent| rent.book.nome if !rent.book.blank?} 
node(:book_author) {|rent| rent.book.autor if !rent.book.blank?} 