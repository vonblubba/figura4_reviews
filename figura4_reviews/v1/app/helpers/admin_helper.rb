module AdminHelper
  
  def tags_multiple_select()
    selected_tags = @review.tags
    all_tags = Tag.find_all
    result = "<select id='tags' multiple='multiple' name='tags[]' size='" + all_tags.size.to_s + "'>"
    all_tags.each do |t|
      if selected_tags.include?(t)
        result = result + "<option value='" + t.id.to_s + "' selected='selected'>" + t.name + "</option>"
      else
        result = result + "<option value='" + t.id.to_s + "'>" + t.name + "</option>"
      end
    end
    result = result + "</select>"
    result
  end

  def authors_select()
    selected_author = @review.author
    authors = Author.find(:all, :order => "second_name")
    result = "<select id='review[author_id]' name='review[author_id]' >\n"
    result = result + "<option value='' >Seleziona l'autore</option>\n"
    authors.each do |a|
      if a == selected_author
        result = result + "<option value='" + a.id.to_s + "' selected='selected'>" + a.second_name + ', ' + a.first_name + "</option>\n"
      else
        result = result + "<option value='" + a.id.to_s + "' >" + a.second_name + ', ' + a.first_name + "</option>\n"
      end
    end
    result = result + "</select>\n"
    result
  end

end
