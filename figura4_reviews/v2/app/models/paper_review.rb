class PaperReview < Review
  validates_numericality_of :pages, :message => "non valido", :allow_nil => true
end