class DepartmentsController < ApplicationController
    
    before_action :set_departments
    
    def index
        render json: @departments
    end

    def show
        if @departments.any? {|department| department["departmentId"].to_i == params[:id].to_i}
            random_painting_id = HTTParty.get("https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds=#{params[:id]}")["objectIDs"].sample()
            painting = HTTParty.get("https://collectionapi.metmuseum.org/public/collection/v1/objects/#{random_painting_id}")
    
            
            combined = {
                department: { departmentId: params[:id],
                    displayName: painting["department"]},
                painting: painting
            }
        
            render json: combined
        else
            render json: { error: 'Department not found'}, status: :not_found
        end

    end

    private

    def set_departments
        @departments = HTTParty.get('https://collectionapi.metmuseum.org/public/collection/v1/departments')['departments']
    end


end
