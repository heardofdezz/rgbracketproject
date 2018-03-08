module SessionsHelper
  #User Logs in
    def log_in(user)
      session[:user_id] = user.id
    end

  #Remembers a user in a persistent session (user that usually logs in on th same computer on a regular basis)
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # Returns true if the given user is the current user.
     def current_user?(user)
       user == current_user
     end

    # Display the current logged-in user if there is any / user correcponding to the remember token cookie
    def current_user
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: session[:user_id])
      elsif (user_id = cookies.signed[:user_id])
        #raise #beug sur le controller avec login param ligne 27
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end

    #Display true if the user is logged in, false otherwise

      def logged_in?
        !current_user.nil?
      end

      def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
      end

      #Logs out the current user method
      def log_out
        session.delete(:user_id)
        @current_user = nil
      end
      # Redirects to stored location (or to the default).
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    # Stores the URL trying to be accessed.
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
end
