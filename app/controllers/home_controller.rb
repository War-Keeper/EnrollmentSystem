class HomeController < ApplicationController
  before_action :create_admin
  before_action :authenticate_user!

  def index

  end

  private

  def create_admin

    if User.all.where(role: "admin").length < 1
      @user = User.new(:role => "admin",
                       :name => "admin",
                       :user_id => "123",
                       :date_of_birth => "2020-03-04",
                       :email => "a@a.com",
                       :password => "123456",
                       :password_confirmation => "123456",
                       :phone_number => "1111111111")
      @user.save
    end
  end
end
