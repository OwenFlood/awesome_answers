class InsightsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    question         = Question.find params[:question_id]
    insight          = Insight.new insight_params
    insight.question = question

    if insight.save
      render json: {success: true, insight: insight}
    else
      render json: {errors: insight.errors.full_messages}
    end
  end

  private

  def insight_params
    params.require(:insight).permit(:body)
  end
end
