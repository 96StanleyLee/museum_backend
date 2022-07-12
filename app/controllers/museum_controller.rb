class MuseumController < ApplicationController
    
    before_action :set_departments
    
    def index
            woman_with_vase = HTTParty.get('https://collectionapi.metmuseum.org/public/collection/v1/objects/436121')
            combined = {
                'women_with_vase': woman_with_vase,
                'departments': @departments['departments']
            }
            render json: combined
    end

    def show 
        painting_id = params[:id]
        painting = HTTParty.get("https://collectionapi.metmuseum.org/public/collection/v1/objects/#{painting_id}")
        render json: combined
    end


    private

    def set_departments
        @departments ||= HTTParty.get('https://collectionapi.metmuseum.org/public/collection/v1/departments')
    end


end
