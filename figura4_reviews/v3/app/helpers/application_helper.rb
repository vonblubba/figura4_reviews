# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_away(name, options = {}, html_options = nil)
    link_to(name, { :return_uri => url_for(:only_path => true) }.update(options.symbolize_keys), html_options)
  end
  
  def tags_multiple_select(tag_id, tag_name, node_id)
    all_tags = Tag.find(:all, :order => "name")
    @node = Node.find(node_id)
    result = "<select id='#{tag_id}' multiple='multiple' name='#{tag_name}[]' size='#{all_tags.size.to_s}'>"
    all_tags.each do |t|
      if @node.tag_list.include?(t.name)
        result += "<option value='#{t.name}' selected='selected'>#{t.name}</option>"
      else
        result += "<option value='#{t.name}'>#{t.name}</option>"
      end
    end
    result += "</select>"
    result
  end

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
    smiley(some_html(text))
  end
  
  def my_text_formatter(text)
    paragraphs = text.to_s.gsub('\r\n', '\n').
                           gsub('\r', '\n').
                           gsub('\n\n', '</p>\n\n<p>').
                           gsub('\n', '<br />\n')
    smileys = paragraphs.gsub(' :)', ' <img src="/images/smiley/smellie_smile.gif" alt="smile" /> ').
                         gsub(' :-)', ' <img src="/images/smiley/smellie_smile.gif" alt="smile" /> ').
                         gsub(' ;)', ' <img src="/images/smiley/smellie_wink.gif" alt="wink" /> ').
                         gsub(' ;-)', ' <img src="/images/smiley/smellie_wink.gif" alt="wink" /> ').
                         gsub(' :p', ' <img src="/images/smiley/smellie_tongue.gif" alt="tongue" /> ').
                         gsub(' :-p', ' <img src="/images/smiley/smellie_tongue.gif" alt="tongue" /> ').
                         gsub(' :P', ' <img src="/images/smiley/smellie_tongue.gif" alt="tongue" /> ').
                         gsub(' :-P', ' <img src="/images/smiley/smellie_tongue.gif" alt="tongue" /> ').
                         gsub(' :D', ' <img src="/images/smiley/smellie_lol.gif" alt="lol" /> ').
                         gsub(' lol', ' <img src="/images/smiley/smellie_lol.gif" alt="lol" /> ').
                         gsub(' :-D', ' <img src="/images/smiley/smellie_lol.gif" alt="lol" /> ').
                         gsub(' B)', ' <img src="/images/smiley/smellie_cool.gif" alt="cool" /> ').
                         gsub(' B-)', ' <img src="/images/smiley/smellie_cool.gif" alt="cool" /> ').
                         gsub(' 8)', ' <img src="/images/smiley/smellie_cool.gif" alt="cool" /> ').
                         gsub(' 8-)', ' <img src="/images/smiley/smellie_cool.gif" alt="cool" /> ')
    smileys
  end
  
  def some_html(s)
    # converting newlines
    s.gsub!(/\r\n?/, "\n")
 
    # escaping HTML to entities
    s = s.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;')
 
    # blockquote tag support
    s.gsub!(/\n?&lt;blockquote&gt;\n*(.+?)\n*&lt;\/blockquote&gt;/im, "<blockquote>\\1</blockquote>")
 
    # other tags: b, i, em, strong, u
    %w(b i em strong u).each { |x|
         s.gsub!(Regexp.new('&lt;(' + x + ')&gt;(.+?)&lt;/('+x+')&gt;',
                 Regexp::MULTILINE|Regexp::IGNORECASE), 
                 "<\\1>\\2</\\1>")
        }
 
    # A tag support
    # href="" attribute auto-adds http://
    s = s.gsub(/&lt;a.+?href\s*=\s*['"](.+?)["'].*?&gt;(.+?)&lt;\/a&gt;/im) { |x|
            '<a href="' + ($1.index('://') ? $1 : 'http://'+$1) + "\">" + $2 + "</a>"
          }
 
    # replacing newlines to <br> ans <p> tags
    # wrapping text into paragraph
    s = "<p>" + s.gsub(/\n\n+/, "</p>\n\n<p>").
            gsub(/([^\n]\n)(?=[^\n])/, '\1<br />') + "</p>"
 
    s      
  end

  def smiley(s)
    s_smiley = s.gsub(/:\)|:-\)/, ' <img src="/images/smiley/smellie_smile.gif" alt="smile" /> ').
                 gsub(/;\)|;-\)/, ' <img src="/images/smiley/smellie_wink.gif" alt="wink" /> ').
                 gsub(/:p|:-p|:P|:-P/, ' <img src="/images/smiley/smellie_tongue.gif" alt="tongue" /> ').
                 gsub(/:D|[ \n\r]lol|:-D/, ' <img src="/images/smiley/smellie_lol.gif" alt="lol" /> ').
                 gsub(/B\)|B-\)|8\)|8-\)/, ' <img src="/images/smiley/smellie_cool.gif" alt="cool" /> ')
    s_smiley
    #;; The XEmacs version has a baroque, if not rococo, set of these.
#(defcustom smiley-regexp-alist
 # '(("\\(:-?)\\)\\W" 1 "smile")
  #  ("\\(;-?)\\)\\W" 1 "blink")
   # ("\\(:-]\\)\\W" 1 "forced")
    #("\\(8-)\\)\\W" 1 "braindamaged")
#    ("\\(:-|\\)\\W" 1 "indifferent")
 #   ("\\(:-[/\\]\\)\\W" 1 "wry")
  #  ("\\(:-(\\)\\W" 1 "sad")
   # ("\\(X-)\\)\\W" 1 "dead")
    #("\\(:-{\\)\\W" 1 "frown"))
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

