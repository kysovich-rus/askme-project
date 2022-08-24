module QuestionsHelper

  def author_link
    if author.present?
      link_to "#{question&.author&.link_name}", '#'
    else
      content_tag :i, "Aнонимус"
    end
  end

end
