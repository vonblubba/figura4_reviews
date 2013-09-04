class Review < Node
  has_one  :cover,    :dependent => :destroy
  belongs_to :author
  validates_presence_of :original_title, :author_id
  validates_numericality_of :vote, :only_integer => true, :allow_nil => true
  validates_associated :cover, :message => "non valida"
  before_validation :update_calculated_fields
  after_create :generate_page_url
  
  def Review.complex_search(params)
    escaped_author = Review.text_escaper(params[:author])
    escaped_rating = Review.text_escaper(params[:rating])
    escaped_media = Review.text_escaper(params[:media])
    escaped_tags = Review.text_escaper(params[:tags])
    escaped_key_word = Review.text_escaper(params[:key_word])
    escaped_order_by = Review.text_escaper(params[:order_by])
    conditions =  "type LIKE '%Review' AND "
    conditions += "published = 1 AND "
    conditions += "author_id = " + escaped_author + " AND " unless escaped_author.blank? 
    conditions += "vote = " + escaped_rating + " AND " unless escaped_rating.blank? 
    conditions += "type = '" + escaped_media + "' AND " unless escaped_media.blank? 
    conditions += "(id IN (SELECT taggable_id FROM taggings WHERE taggable_type='Review' AND tag_id = " + escaped_tags + ")) AND " unless escaped_tags.blank? 
    puts conditions
    if escaped_key_word.blank?
      4.times { conditions.chop! }
      conditions = 0 if conditions.blank?
      @reviews = Node.find(:all, :conditions => conditions, :order => escaped_order_by)
    else
      conditions += " (original_title LIKE ? OR "
      conditions += " italian_title LIKE ? OR "
      conditions += " review LIKE ? OR "
      conditions += " plot LIKE ?)"
      @reviews = Node.find(:all, :conditions => [conditions, "%#{escaped_key_word}%", "%#{escaped_key_word}%", "%#{escaped_key_word}%", "%#{escaped_key_word}%"], :order => escaped_order_by)
    end
    puts @reviews
    @reviews
  end
  
  def Review.text_escaper(text)
    # caratteri ammessi nella ricerca recensione
    unless text.nil?
      valid_chars = Array.new
      valid_chars =  ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
      valid_chars += ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
      valid_chars += ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
      valid_chars += [' ', '_']
      escaped_text = ""
      0.upto(text.size - 1) do |i|
        escaped_text += text[i].chr if valid_chars.include?(text[i].chr)
      end
      escaped_text
    end
  end
  
  def media
    case
    when self.class == TvReview
      "serie tv"
    when self.class == BookReview
      "libro"
    when self.class == MovieReview
      "film"
    when self.class == ComicReview
      "fumetto"
    end
  end
  
  def full_title
    if self.italian_title.blank?
      full_original_title
    else
      full_italian_title
    end
  end
  
  def full_italian_title
    if self.italian_article.blank?
      if self.italian_title.blank?
        "Inedito in Italia"
      else
        self.italian_title
      end
    else
      self.italian_article + ' ' + self.italian_title
    end
  end
  
  def full_original_title
    if self.original_article.blank?
      self.original_title
    else
      self.original_article + ' ' + self.original_title
    end
  end
  
  def formal_original_title
    if self.original_article.blank?
      self.original_title
    else
      self.original_title + ', ' +  self.original_article 
    end
  end
  
  def formal_italian_title
    if self.italian_article.blank?
      if self.italian_title.blank?
        nil
      else
        self.italian_title
      end
    else
      self.italian_title + ', ' +  self.italian_article 
    end
  end
  
  def formal_title
    if self.formal_italian_title.blank?
      formal_original_title
    else
      formal_italian_title
    end
  end
  
  def subtitle
    if self.italian_subtitle.blank?
      if self.original_subtitle.blank?
        nil
      else
        self.original_subtitle
      end
    else
      self.italian_subtitle
    end
  end
  
  def language_to_display
    if self.language == 0
      "lingua italiana"
    else
      "lingua inglese"
    end
  end
  
  def update_calculated_fields
    self.meta_keywords = "recensione, #{self.media}, #{self.full_title}, #{self.author.second_name}, #{self.author.first_name}, #{self.tag_list}"
    self.meta_description = "recensione del #{self.media} #{self.full_title} di #{self.author.full_name}, con note biografiche sull'autore e link sul tema"
    self.page_title = "'#{self.full_title}' by  #{self.author.full_name}"
  end
  
  def generate_page_url
    self.url = "#{self.id}-#{self.full_title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') 
    self.save
  end
end
