module FatModelAuth
  class AuthException < Exception; end
  
  module ControllerHelpers
    protected
    
    def auth_required
      authority = get_authority
      
      access_granted = authority.allows(current_user).send "to_#{params[:action]}?"
      respond_with_404_page unless access_granted
    end
    
    def access_denied?
      authority = get_authority
      
      access_granted = authority.allows(current_user).send "to_#{params[:action]}?"
      if access_granted
        false
      else
        respond_with_404_page
        true
      end
    end
    
    private
    
    def get_authority
      if self.respond_to? :override_authority
        authority = override_authority
        raise FatModelAuth::AuthException, "override_authority defined but nil" if authority.nil?
      else
        authority_name = params[:controller].singularize
        authority = instance_variable_get("@#{authority_name}")
        raise FatModelAuth::AuthException, "#{authority_name} is nil" if authority.nil?
      end
      
      return authority
    end
    
    def respond_with_404_page
      render "#{RAILS_ROOT}/public/404.html", :status => 404
    end
  end
end
