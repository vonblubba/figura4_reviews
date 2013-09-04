class Quote < ActiveRecord::Base
  belongs_to :node
  validates_presence_of :random, :message => "è necessario impostare il campo"

  def Quote.random_quote
    conditions = "random = 1"
    num_quotes = Quote.count(:conditions => conditions)
    if num_quotes > 0 
      offset = rand(num_quotes)
      Quote.find :first, :conditions => conditions, :offset => offset
    else
      nil
    end
  end
  
  protected
  
  def validate
    if (body.nil? or body.blank?)
      errors.add_to_base("testo assente")
    end
  end
end
