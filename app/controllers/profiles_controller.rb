class ProfilesController < ApplicationController
  skip_before_action :check_profile!, except: [:show, :index]

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

  def show
    @profile = Profile.find(params[:id])
    @posts = @profile.posts
  end

  def index
    @profiles = Profile.all
  end

  private

  def profile_params
    params.require(:profile).permit(:name)
  end

  def gravatar_url(email, size = 200)
    email_hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{email_hash}?s=#{size}&d=identicon"
  end
end
