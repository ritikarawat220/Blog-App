class Devise::PasswordsController < DeviseController
  respond_to :html, :json

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      respond_to do |format|
        format.html { redirect_to after_sending_reset_password_instructions_path_for(resource_name) }
        format.json { head :no_content }
        format.any { raise ActionController::UnknownFormat }
      end
    else
      respond_with(resource)
    end
  rescue ActionController::UnknownFormat
    redirect_to root_path
  end

  def new
    self.resource = resource_class.new
  end
end
