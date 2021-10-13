class PhonesController < ApplicationController
    before_action :set_phone, only: [:show, :create, :update]
    before_action :phone_params, only: [:update, :create, :destroy]

    # GET /kinds/1
    def show
        render json: @contact.phones
    end

    def update
        @phone = Phone.find(phone_params[:id])
        if @phone.update(phone_params)
            render json: @contact.phones
        else
            render json: @contact.errors, status: :unprocessable_entity
        end
    end

    def create
        @contact.phones << Phone.new(phone_params)
        if @contact.save
            render json: @contact.phones
        else 
            render json: @contact.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @phone = Phone.find(phone_params[:id])
        @phone.destroy
    end

    private

    def phone_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_phone
        @contact = Contact.find(params[:contact_id])
    end
end