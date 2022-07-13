class ApplicationController < ActionController::API

    private

    def set_departments
        @departments = HTTParty.get('https://collectionapi.metmuseum.org/public/collection/v1/departments')['departments']
    end
end
