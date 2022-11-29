class CourseType < ActiveRecord::Base
  attr_accessible :name, :description, as: :admin

  has_many :courses
  has_many :coupons

  def to_s
    name
  end

  private

  rails_admin do
    navigation_label "Admin"
    object_label_method do
      :name
    end

    field :name
    field :description

    show do
      field :courses
      field :coupons
    end
  end
end
