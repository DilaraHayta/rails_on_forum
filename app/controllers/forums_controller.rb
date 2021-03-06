class ForumsController < ApplicationController
  before_action {@forums = Forum.all}

  def index
  	if current_user
    	@topics = Topic.includes(:forum, :user)
    elsif current_company
    	@topics = Topic.includes(:forum, :company)
    else
    	@topics = Topic.includes(:forum)
    end
  end

  def show
    if current_company
      @forum  = Forum.find(params[:id])
      @topics = @forum.topics.includes(:company)
    else
        @forum  = Forum.find(params[:id])
        @topics = @forum.topics.includes(:user)
    end
  end
end
