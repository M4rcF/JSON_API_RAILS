class AddressesController < ActionController::API
    before_action :set_address, only: [:show, :update, :destroy]
    before_action :address_params, only: [:update, :create]

    def show
        render json: @address
    end

    def update
        if @address.update(address_params)
            render json: @address
        else
            render json: @address.errors, status: :unprocessable_entity
        end
    end

    def create
        @address = Address.new(address_params)
        @address.contact_id = params[:contact_id]
        if @address.save
            render json: @address
        else 
            render json: @address.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @address.destroy
    end

    private

    def address_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    def set_address
        @address = Contact.find(params[:contact_id]).address
    end
end