class AddTestQuotes < ActiveRecord::Migration
  def self.up
    quote = Quote.create(:original_text => "",
                         :italian_text => "Pensaci, Chani: quella principessa avrà il nome, e tuttavia sarà meno di una concubina... non avrà mai un momento di tenerezza dall'uomo cui sarà unita. Mentre noi, Chani, noi che portiamo il nome di concubine...la storia ci chiamerà spose.",
                         :author => "Lady Jessica Atreides",
                         :random => 1)
    quote.review = Review.find_by_original_title("Dune")
    quote.save

    quote = Quote.create(:original_text => "There is probably no more terrible instant of enlightenment than the one in which you discover your father is a man--with human flesh.",
                         :italian_text => "",
                         :author => "",
                         :source => "from 'Collected Sayings of Muad'Dib' by the Princess Irulan",
                         :random => 1)
    quote.review = Review.find_by_original_title("Dune")
    quote.save
    
    quote = Quote.create(:original_text => "To make a thief, make an owner; to create crime, create laws.",
                         :italian_text => "",
                         :author => "Shevek",
                         :source => "",
                         :random => 1)
                         
    quote.review = Review.find_by_original_title("Dispossessed")
    quote.save
  end

  def self.down
    Quote.delete_all
  end
end
