# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def text_formatter_parless(text) 
    text.gsub(/\r\n?/, "\n").               # \r\n and \r -> \n
    gsub(/\n\n+/, "<br />\n")               # 2+ newline  -> br
  end
  
  def text_formatter(text)
    content_tag 'p', text.to_s.
    gsub(/\r\n?/, "\n").                    # \r\n and \r -> \n
    gsub(/\n\n+/, "</p>\n\n<p>").           # 2+ newline  -> paragraph
    gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')  # 1 newline   -> br
  end
  
  def smart_truncate(text, length = 30, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.chars.length
    text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
   
   
  def authors_select(css_class)
    authors = Author.find(:all, :order => "second_name")
    result = "<select class='" + css_class + "' name='search[author]' >\n"
    result = result + "<option value='' selected='selected' >--Ricerca per autore</option>\n"
    authors.each do |a|
        result = result + "<option value='" + a.id.to_s + "' >" + a.second_name + ', ' + a.first_name + "</option>\n"
    end
    result = result + "</select>\n"
    result
  end
  
  def tags_select(css_class)
    all_tags = Tag.find(:all)
    result = "<select class='" + css_class + "' name='search[tags]'>\n"
    result = result + "<option value=''>--Ricerca per tag</option>\n"
    all_tags.each do |t|
        result = result + "<option value='" + t.id.to_s + "'>" + t.name + "</option>\n"
    end
    result = result + "</select>\n"
    result
  end
  
  def vote_title(vote)
    case vote
      when 1
        "1/10 - Una ciofeca"
      when 2
        "2/10 - Terrificante"
      when 3
        "3/10 - Orribile"
      when 4
        "4/10 - Brutto"
      when 5
        "5/10 - Scarso"
      when 6
        "6/10 - Passabile"
      when 7
        "7/10 - Discreto"
      when 8
        "8/10 - Ottimo"
      when 9
        "9/10 - Imperdibile"
      when 10
        "10/10 - Capolavoro!"
    end
  end
  
  def language_to_display(review)
    if review.language == 0
      "Lingua italiana"
    else
      "Lingua inglese"
    end
  end
  
  def media_to_display(review)
    case
    when review.media == 0
      "Serie TV"
    when review.media == 1
      "Libro"
    when review.media == 2
      "Film"
    when review.media == 3
      "Fumetto"
    end
  end 
   
   
end
