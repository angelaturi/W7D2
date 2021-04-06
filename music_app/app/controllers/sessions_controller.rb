class SessionsController < ApplicationController
    
    def new
        render :new
    end

    def create # should re-set the appropriate user's session_token and session[:session_token]
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ["Invalid credentials"]
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end

end