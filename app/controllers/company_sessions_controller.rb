class CompanySessionsController < ApplicationController
  def new
  end

  def create
    company = Company.find_by_username(params[:company_session][:user_name])

    if company && company.authenticate(params[:company_session][:password])
      company_login(company)
      redirect_to root_url, notice: 'Oturum açıldı.'
    else
      flash[:error] = "Kullanıcı adı/parola hatalı."
      redirect_to com_login_url
    end
  end

  def destroy
    company_logout
    redirect_to root_url, notice: 'Oturumunuz sonlandırıldı.'
  end
end
