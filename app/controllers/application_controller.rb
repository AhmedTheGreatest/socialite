class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_profile!

  private

  def check_profile!
    if !current_user.profile
      redirect_to new_profile_path
    end
  end
end
