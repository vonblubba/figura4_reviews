module ReviewHelper
  def tags_multiple_select()
    all_tags = Tag.find(:all, :order => "name")
    result = "<select id='tags' multiple='multiple' name='tags[]' size='" + all_tags.size.to_s + "'>"
    all_tags.each do |t|
      if @review.tag_list.include?(t.name)
        result = result + "<option value='" + t.name + "' selected='selected'>" + t.name + "</option>"
      else
        result = result + "<option value='" + t.name + "'>" + t.name + "</option>"
      end
    end
    result = result + "</select>"
    result
  end
  
  def pro_title(review)
    if review.is_a?(BookReview)
      "Motivi per leggere questo libro"
    else
      if review.is_a?(MovieReview)
        "Motivi per guardare questo film"
      else
        if review.is_a?(TvReview)
          "Motivi per guardare questa serie tv"
        else
          "Motivi per leggere questo fumetto"
        end
      end
    end
  end
  
  def vs_title(review)
    if review.is_a?(BookReview)
      "Motivi per evitare questo libro"
    else
      if review.is_a?(MovieReview)
        "Motivi per evitare questo film"
      else
        if review.is_a?(TvReview)
          "Motivi per evitare questa serie tv"
        else
          "Motivi per evitare questo fumetto"
        end
      end
    end
  end
end
