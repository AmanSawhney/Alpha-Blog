class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id] # returns a user if the browser has a user in the session
    end

    def logged_in?
        !!current_user
    end

    def require_user
        unless logged_in?
            flash[:danger] = 'You must be logged in to preform that action'
            redirect_to root_path
        end
    end
end
