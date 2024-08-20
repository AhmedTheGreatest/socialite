class ProfilesController < ApplicationController
  skip_before_action :check_profile!

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile

    if @profile.save
      redirect_to root_path, notice: 'Account successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end
end
