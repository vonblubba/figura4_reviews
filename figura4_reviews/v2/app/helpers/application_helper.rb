# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def authors_select(css_class, name = "search[author]", prompt = "--Ricerca per autore", selected_id = nil)
    authors = Author.find(:all, :order => "second_name")
    result = "<select class='#{css_class}' name='#{name}' >\n"
    if selected_id.nil?
      result += "<option value='' selected='selected' >#{prompt}</option>\n"
    else
      result += "<option value='' >#{prompt}</option>\n"
    end   
    authors.each do |a|
      if a.id == selected_id
        result += "<option value='" + a.id.to_s + "' selected='selected' >" + a.second_name + ', ' + a.first_name + "</option>\n"
      else
        result += "<option value='" + a.id.to_s + "' >" + a.second_name + ', ' + a.first_name + "</option>\n"
      end
    end
    result = result + "</select>\n"
    result
  end
  
  def tags_select(css_class)
    all_tags = Tag.find(:all, :order => "name")
    result = "<select class='" + css_class + "' name='search[tags]'>\n"
    result = result + "<option value=''>--Ricerca per tag</option>\n"
    all_tags.each do |t|
        result = result + "<option value='" + t.id.to_s + "'>" + t.name + "</option>\n"
    end
    result = result + "</select>\n"
    result
  end
  
  def smart_truncate(text, length = 30, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.chars.length
    text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
  
  def text_formatter(text)
    content_tag 'p', text.to_s.
    gsub(/\r\n?/, "\n").                    # \r\n and \r -> \n
    gsub(/\n\n+/, "</p>\n\n<p>").           # 2+ newline  -> paragraph
    gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')  # 1 newline   -> br
  end
  
  def vote_comment(vote)
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
  
  def comment_avatar_tag(comment)
    if comment.user
      if comment.user.avatar
        "<img src=\"#{url_for(:action => 'picture', :id => comment.user.avatar.id)}\" alt=\"#{comment.user.name}\" title=\"#{comment.user.name}\" />"
      else
        "<img src=\"/images/no_avatar.png\" alt=\"#{comment.user.name}\" title=\"#{comment.user.name}\" />"
      end
    else
      "<img src=\"/images/no_avatar.png\" alt=\"#{comment.author}\" title=\"#{comment.author}\" />"
    end
  end
  
  def avatar_tag(user)
    if user.avatar
      "<img src=""#{url_for(:action => 'picture', :id => user.avatar.id)}"" alt=""#{user.name}"" title=""#{user.name}"" />"
    else
      "<img src=""/images/no_avatar.png"" alt=""#{user.name}"" title=""#{user.name}"" />"
    end
  end
  
  def author_picture_tag(author)
    if author.author_picture
      "<img src=\"#{url_for(:action => 'picture', :id => author.author_picture.id)}\" alt=\"#{author.full_name}\" title=\"#{author.full_name}\" />"
    else
      "<img src=\"/images/no_author_picture.png\" alt=\"#{author.full_name}\" title=\"#{author.full_name}\" />"
    end
  end
  
  def cover_tag(review, css_class = nil)
    cover_text = "Leggi la recensione del #{h(review.media)} '#{h(review.full_title)}' di #{h(review.author.full_name)}"
    if css_class
      class_property = "class='#{css_class}' "
    end
    if review.cover
      "<img #{class_property}src=\"#{url_for(:action => 'picture', :id => review.cover.id)}\" alt=\"#{cover_text}\" title=\"#{cover_text}\" />"
    else
      "<img #{class_property}src=\"/images/no_cover.png\" alt=\"Copertina non disponibile\" title=\"Copertina non disponibile\" />"
    end
  end
  
  def media_icon_tag(review)
    if review.is_a?(BookReview)
      icon = "book.png"
    else
      if review.is_a?(MovieReview)
        icon = "movie.png"
      else
        if review.is_a?(TvReview)
          icon = "tv.png"
        else
          icon = "comic.png"
        end
      end
    end
    "<img src=\"/images/#{icon}\" alt=\"#{review.media}\" title=\"#{review.media}\" />"
  end
end
