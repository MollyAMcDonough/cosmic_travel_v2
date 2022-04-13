class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    #GET /scientists
    def index
        render json: Scientist.all, status: :ok
    end

    #GET /scientists/:id
    def show
        scientist = Scientist.find(params[:id])
        render json: scientist, serializer: ScientistPlanetsSerializer, status: :ok
    end

    #POST /scientists
    def create
        scientist = Scientist.create!(sci_params)
        render json: scientist, status: :created
    end

    #PATCH /scientists/:id
    def update
        scientist = Scientist.find(params[:id])
        scientist.update!(sci_params)
        render json: scientist, status: :accepted
    end

    #DELETE /scientists/:id
    def destroy
        scientist = Scientist.find(params[:id])
        scientist.destroy
        head :no_content
    end

    private

    def record_invalid(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
    
    def record_not_found
        render json: {error: "Scientist not found"}, status: :not_found
    end

    def sci_params
        params.permit(:name, :field_of_study, :avatar)
    end

end
