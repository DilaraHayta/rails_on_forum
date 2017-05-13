class CompaniesController < ApplicationController
  before_action :select_company, only: [:show, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    validate_permission! select_company
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      company_login(@company)
      redirect_to root_url, notice: 'Aramıza hoş geldin!'
    else
      render :new
    end
  end

  def show
    sayfa = params[:sayfa] || 'konular'

    if sayfa == 'konular'
      @company = Company.includes(:topics).find_by_username(params[:id])
      @data = @company.topics.includes(:forum)
    else
      @company = Company.includes(:comments).find_by_username(params[:id])
      @data = @company.comments.includes(:topic)
    end

    render layout: "com_profile", locals: {page: sayfa}
  end

  def edit
    render layout: "com_profile"
  end

  def update
    update_params = company_params
    if update_params.has_key?(:password)
      update_params.delete([:password, :password_confirmation])
    end

    if @company.update(update_params)
      redirect_to profile_url(@company), notice: 'Profil bilgileriniz güncellendi.'
    else
      render :edit, layout: "com_profile"
    end
  end

  def destroy
    com_logout
    @company.destroy
    redirect_to root_url
  end

  private

  def company_params
    params.require(:company).permit!
  end

  def select_company
    @company = Company.find_by_username(params[:id])
  end
end
