class TopicsController < ApplicationController
  # before_action :validate_user!, except: [:show]
  before_action :validate_company!, except: [:show]
  before_action only: [:edit, :update, :destroy] do
    # validate_permission!(set_topic.user)
    company_validate_permission!(set_topic.company)
  end
  before_action :set_topic, only: [:edit, :update, :destroy]
  before_action only: [:new, :create] {@forum = Forum.find(params[:forum_id])}


  def new
    @topic = @forum.topics.new
  end

  def create
    @topic = @forum.topics.new(topic_params)
    if current_user
      @topic.user = current_user
    elsif current_company
      @topic.company = current_company
    end

    if @topic.save
      redirect_to topic_url(@topic), notice: 'Konu başarıyla oluşturuldu'
    else
      render :new
    end
  end

  def show

    if current_company
      @topic = Topic.includes(:forum, :comments, :company).find(params[:id])
      @comments = @topic.comments.includes(:company)
    else
      @topic = Topic.includes(:forum, :comments, :user).find(params[:id])
      @comments = @topic.comments.includes(:user)
    end


  end

  def edit() end

  def update
    if @topic.update(topic_params)
      redirect_to topic_url(@topic), notice: 'Konu başarıyla güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to root_url, notice: 'Konu başarıyla silindi'
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
