class Quote < ActiveRecord::Base
  belongs_to :review
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
  
  def text
    if self.italian_text.nil? or self.italian_text.blank?
      self.original_text
    else
      self.italian_text
    end
  end
  
  def source_to_display
    if self.source.nil? or self.source.blank?
      if self.author.nil? or self.author.blank?
        self.author
      else
        nil
      end
    else
      self.source
    end
  end
  
  protected
  
  def validate
    if (original_text.nil? or original_text.blank?) and (italian_text.nil? or italian_text.blank?)
      errors.add_to_base("testo assente")
    end
  end
end
