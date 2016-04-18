class Answer < ActiveRecord::Base
  # Belongs to lets us fetch the question for an answer by running:
  # ans = Answer.find(14)
  # q = ans.question
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def user_full_name
    user ? user.full_name : ""
  end
  
  private

end
