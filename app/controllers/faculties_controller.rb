class FacultiesController < InheritedResources::Base
  actions :index
  belongs_to :institute

  def index
    index! do
      render 'courses/index' and return unless request.xhr? 
    end
  end
end
