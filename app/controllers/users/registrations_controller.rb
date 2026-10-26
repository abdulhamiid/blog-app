
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save

    unless resource.persisted?
      clean_up_passwords resource
      set_minimum_password_length
      puts "SIGNUP ERRORS: #{resource.errors.full_messages.inspect}"
      return render :new, status: :unprocessable_entity
    end

    sign_up(resource_name, resource)
    respond_with resource, location: after_sign_up_path_for(resource)
  end
end
