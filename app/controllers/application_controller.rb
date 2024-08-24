class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_profile!, unless: :devise_controller?

  private

  def check_profile!
    if current_user && !current_user.profile
      redirect_to new_profile_path
    end
  end
end
