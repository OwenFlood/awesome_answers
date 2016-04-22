class AnswersMailer < ApplicationMailer

  def notify_question_owner(answer)
    @answer = answer
    @question = answer.question
    @owner = @question.user
    return unless @owner
    mail(to: "obeflo@gmail.com", subject: "You got an answer!")
  end
end
