class Cost < ActiveRecord::Base
  attr_accessible :name, :price, as: :admin
  has_and_belongs_to_many :courses

  validates_numericality_of :price

  protected

  rails_admin do
    navigation_label "Manager"

    field :name
    field :price do
      pretty_value do
        ActionController::Base.helpers.number_to_currency value
      end
    end

    show do
      fields :courses
    end
  end
end
