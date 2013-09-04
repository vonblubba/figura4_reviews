class Quote < ActiveRecord::Base
  belongs_to :review
  
  def validate
    errors.add(nil, "testo assente") if original_text.nil? and italian_text.nil?
    errors.add(nil, "fonte assente") if author.nil? and source.nil?
  end
  
  def Quote.random_quote
    conditions = "random = 1 AND CHAR_LENGTH(IFNULL(original_text,'')) < 5000 AND CHAR_LENGTH(IFNULL(italian_text, '')) < 5000"
    offset = rand(Quote.count(:conditions => conditions))
    Quote.find :first, :conditions => conditions, :offset => offset
  end
  
  def text_to_display
    if self.italian_text.nil? or self.italian_text.blank?
      self.original_text
    else
      self.italian_text
    end
  end
  
  def source_to_display
    if self.source.nil? or self.source.blank?
      self.author
    else
      self.source
    end
  end
  
end
