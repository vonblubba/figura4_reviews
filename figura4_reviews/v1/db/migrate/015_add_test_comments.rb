class AddTestComments < ActiveRecord::Migration
  def self.up
    comment = Comment.create(:body => "Ed il 22 Agosto esce 'Hunters of Dune' !!!!!!!!!!!!!!!!" ,
                   :author => 'Hasimir',
                   :email => 'figura4@tin.it',
                   :homepage => 'www.figura4.com')
    comment.review = Review.find_by_original_title("Dune")
    comment.save
    
    comment = Comment.create(:body => "Per un attimo mi sono lasciato prendere dall'entusiasmo. Poi mi sono ricordato chi sono gli autori....",
                   :author => 'figura4.it',
                   :email => 'figura4@tin.it',
                   :homepage => 'www.figura4.com')
    comment.review = Review.find_by_original_title("Dune")
    comment.save
  end

  def self.down
    Comment.delete_all
  end
end

