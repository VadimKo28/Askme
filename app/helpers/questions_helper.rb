module QuestionsHelper
  def author_to_question(question)
    if question.author
      link_to "@#{question.author.nickname}", question.author 
    else
      content_tag :i, "Аноним"
    end
  end
end
