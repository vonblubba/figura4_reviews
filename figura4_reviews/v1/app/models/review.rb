class Review < ActiveRecord::Base
  has_many :quotes
  has_many :comments
  has_and_belongs_to_many :tags
  belongs_to :author
  belongs_to :user
  
  validates_presence_of :review, :vote, :media, :original_title, :author_id, :user_id
  validates_numericality_of :vote, :only_integer => true
  
  @@cover_path = "images/covers/"
  
  def validate
    unless cover.nil? or cover.blank?
      splitted = cover.split(".")
      format_ok = (splitted.last == "gif" or splitted.last == "jpg" or splitted.last == "jpeg" or splitted.last == "png") 
      errors.add(:cover, "Immagine non valida") unless format_ok 
    end
  end
  
  def to_param
    if self.full_italian_title.nil? or self.full_italian_title.blank?
      "#{id}-#{self.full_original_title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
    else
      "#{id}-#{self.full_italian_title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
    end
  end 
  
  def Review.save_cover(picture)
    unless picture.nil? or picture.blank? or picture[:picture].nil? or picture[:picture].blank?
      file_name = Review.base_part_of(picture[:picture].original_filename)
      f = File.new(@@cover_path + file_name, "w+")
      #f = File.new("images/covers/prova.jpg", "w+") 
      while !picture[:picture].eof
        f.write(picture[:picture].read(4096))
      end
      file_name
    else
      nil
    end
  end

  def Review.base_part_of(file_name)
    name = File.basename(file_name)
    name.gsub(/[^\w._-]/, '' )
  end
  
  def Review.cover_path
    "/" + @@cover_path
  end
    
  def update_tags(params)
    self.tags.delete_all
    #Tags esistenti
    unless params[:tags].nil?
      params[:tags].each do |t|
        unless t.nil?
          tag = Tag.find(t)
          self.tags << tag
        end
      end
    end
    #Tags da creare
    unless params[:create_tag].nil?
      params[:create_tag].each do |t|
        unless t[:name].nil? or t[:name].blank?
          tag = Tag.new(t)
          tag.save
          self.tags << tag
        end
      end
    end
  end
    
  def full_original_title
    if self.original_article.nil? or self.original_article.blank?
      self.original_title
    else
      self.original_article + ' ' + self.original_title
    end
  end
  
  def formal_original_title
    if self.original_article.nil? or self.original_article.blank?
      self.original_title
    else
      self.original_title + ', ' +  self.original_article 
    end
  end
  
  def formal_italian_title
    if self.italian_article.nil? or self.italian_article.blank?
      self.italian_title
    else
      self.italian_title + ', ' +  self.italian_article 
    end
  end
  
  def full_italian_title
    if self.italian_article.nil? or self.italian_article.blank?
      self.italian_title || "Inedito in Italia"
    else
      self.italian_article + ' ' + self.italian_title
    end
  end
  
  def full_title_to_display
    if self.full_italian_title.nil? or self.full_italian_title.blank?
      full_original_title
    else
      full_italian_title
    end
  end
  
  def second_title_to_display
    if self.full_italian_title.nil? or self.full_italian_title.blank?
      second_original_title
    else
      second_italian_title
    end
  end
  
  def page_title
    if self.italian_title.nil? or self.italian_title.blank?
      title = self.original_title
      title = self.original_article + ' ' + title unless self.original_article.nil? or self.original_article.blank?
    else
      title = self.italian_title
      title = self.italian_article + ' ' + title unless self.italian_article.nil? or self.italian_article.blank?
    end
    title = "'" + title + "'" + ' by ' + self.author.first_name + ' ' + self.author.second_name
    title 
  end
  
  def post_comment(params)
    nickname = params[:nickname]
    email = params[:email]
    homepage = params[:homepage]
    text = params[:body]
    comment = Comment.new( :author   => nickname,
                           :email    => email,
                           :homepage => homepage,
                           :body     => text
                         )
    self.comments << comment
  end
  
  def Review.complex_search(params)
    escaped_author = Review.text_escaper(params[:author])
    escaped_rating = Review.text_escaper(params[:rating])
    escaped_media = Review.text_escaper(params[:media])
    escaped_tags = Review.text_escaper(params[:tags])
    escaped_key_word = Review.text_escaper(params[:key_word])
    escaped_order_by = Review.text_escaper(params[:order_by])
    conditions = "published = 1 AND "
    conditions += "author_id = " + escaped_author + " AND " unless escaped_author.blank? 
    conditions += "vote = " + escaped_rating + " AND " unless escaped_rating.blank? 
    conditions += "media = " + escaped_media + " AND " unless escaped_media.blank? 
    conditions += "(id IN (SELECT review_id FROM reviews_tags WHERE tag_id = " + escaped_tags + ")) AND " unless escaped_tags.blank? 
    if escaped_key_word.blank?
      4.times { conditions.chop! }
      conditions = 0 if conditions.blank?
      @reviews = Review.find(:all, :conditions => conditions, :order => escaped_order_by)
    else
      conditions += " (original_title LIKE ? OR "
      conditions += " italian_title LIKE ? OR "
      conditions += " review LIKE ? OR "
      conditions += " plot LIKE ?)"
      @reviews = Review.find(:all, :conditions => [conditions, "%#{escaped_key_word}%", "%#{escaped_key_word}%", "%#{escaped_key_word}%", "%#{escaped_key_word}%"], :order => escaped_order_by)
    end
    @reviews
  end
  
  def Review.text_escaper(text)
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
  
  def meta_description
    if self.italian_title.nil? or self.italian_title.blank?
      title = self.full_italian_title
    else
      title = self.full_original_title
    end
    case
    when self.media == 0
      media_desc = "serie TV"
    when self.media == 1
      media_desc = "libro"
    when self.media == 2
      media_desc = "film"
    when self.media == 3
      media_desc = "fumetto"
    end    
    "Recensione del #{media_desc} #{title} di #{self.author.full_name}"
  end
  
  def meta_keywords
    "recensione, fantascienza, fantasy, #{self.author.full_name}, #{self.full_original_title}, libro, film"
  end
  
  def actors_to_display
    if self.actors.nil? or self.actors.blank? or self.media == 1 or self.media == 3
      nil
    else
      self.actors
    end
  end
end
