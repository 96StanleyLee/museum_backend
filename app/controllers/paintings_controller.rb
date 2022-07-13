class PaintingsController < ApplicationController
    
    before_action :set_departments
    
    def index
            woman_with_vase = HTTParty.get('https://collectionapi.metmuseum.org/public/collection/v1/objects/436121')
            combined = {
                'women_with_vase': woman_with_vase,
                'departments': @departments['departments']
            }
            render json: woman_with_vase
    end

    def show 
        painting_id = params[:id]
        painting = HTTParty.get("https://collectionapi.metmuseum.org/public/collection/v1/objects/#{painting_id}")
        render json: combined
    end

    def random
        random_department = @departments['departments'].sample()
        random_painting_id = HTTParty.get("https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds=#{random_department["departmentId"]}")["objectIDs"].sample()
        painting = HTTParty.get("https://collectionapi.metmuseum.org/public/collection/v1/objects/#{random_painting_id}")
        
        combined = {
            department: random_department,
            painting: painting
        }
    
        binding.break
        render json: combined
    end

    private

    def set_departments
        @departments = HTTParty.get('https://collectionapi.metmuseum.org/public/collection/v1/departments')
    end


end
