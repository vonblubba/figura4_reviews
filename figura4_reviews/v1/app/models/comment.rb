class Comment < ActiveRecord::Base
  belongs_to :review
  validates_presence_of :body, :author
  
  def validate
    errors.add(:email, "non valida") unless email.nil? or email.blank? or (email.include?("@") and email.include?("."))
    errors.add(:homepage, "non valida") unless homepage.nil? or homepage.blank? or homepage.include?(".")  
    #errors.add(:author, "non puoi usare nickname simili a quello del gestore del sito!") if !author.nil? and (author.include?("figura4") or author.include?("Figura4"))
  end

end
