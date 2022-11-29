class FacultyScholier < Faculty

  default_scope includes(:institute).where('institutes.level = ?', 'MS')

  protected

  rails_admin do
    parent Institute
    label_plural "Niveaus"


    field :name
    field :acronym
    field :institute

    configure :institute do
      associated_collection_cache_all false
      associated_collection_scope do
        Proc.new { |scope|
          scope = scope.where('institutes.level = ?', 'MS')
        }
      end
    end

    list do
      sort_by :institute, :name
    end
  end
end