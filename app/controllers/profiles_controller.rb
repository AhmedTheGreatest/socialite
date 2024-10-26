class ProfilesController < ApplicationController
  skip_before_action :check_profile!, except: [:show, :index]
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :authorize_owner!, only: [:edit, :update]

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    @profile.avatar_url = gravatar_url(current_user.email)

    if @profile.save
      redirect_to root_path, notice: 'Account successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @posts = @profile.posts
  end

  def index
    @profiles = Profile.all
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def authorize_owner!
    unless @profile.user == current_user
      redirect_to @profile, alert: "You are not authorized to edit or update this profile."
    end
  end

  def profile_params
    params.require(:profile).permit(:name)
  end

  def gravatar_url(email, size = 200)
    email_hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{email_hash}?s=#{size}&d=identicon"
  end
end
