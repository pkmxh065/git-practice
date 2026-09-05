class RelationshipsController < ApplicationController
    before_action :require_authentication
    def create
        user = User.find(params[:user_id])
        Current.user.follow(user)
        redirect_to request.referer || users_path, status: :see_other
    end

    def destroy
        user = User.find(params[:user_id])
        Current.user.unfollow(user)
        redirect_to request.referer || users_path, status: :see_other
    end

end
