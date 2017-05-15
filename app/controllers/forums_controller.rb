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
    if current_user
      @forum  = Forum.find(params[:id])
      @topics = @forum.topics.includes(:user)
    elsif current_company
      @forum  = Forum.find(params[:id])
      @topics = @forum.topics.includes(:company)
    end     
  end
end
