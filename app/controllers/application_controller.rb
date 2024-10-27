class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_profile!, unless: :devise_controller?

  helper_method :current_profile  # Make this method available in views as well

  def current_profile
    current_user&.profile  # Retrieves the profile associated with the logged-in user
  end

  private

  def check_profile!
    if current_user && !current_user.profile
      redirect_to new_profile_path
    end
  end
end
