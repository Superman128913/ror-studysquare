class User < ActiveRecord::Base
  has_paper_trail

  ROLES = %w(Customer Tutor Manager Admin)
  def role?(base_role)
    ROLES.index(base_role.to_s.capitalize) <= ROLES.index(type)
  end
  default_value_for :type, ROLES.first

  def type_enum
    ROLES
  end

  belongs_to :institute
  belongs_to :faculty
  belongs_to :faculty_program

  has_many :messages

  #
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, # :async,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  COMMON_ATTRS = [:first_name, :insertion, :last_name, :telephone, :password,
    :address_zip, :address_residence, :institute_id, :faculty_id, :faculty_program_id,
    :student_number, :email, :address_street, :address_number, :password_confirmation]

  attr_accessible *COMMON_ATTRS + [:remember_me]
  attr_accessible *COMMON_ATTRS + [:type, :program_course_ids], as: :admin

  validates_presence_of *COMMON_ATTRS - [:student_number, :insertion, :password, :password_confirmation, :address_zip, :address_street, :address_number, :address_residence]

  def to_s
    name
  end

  def name
    [first_name, insertion, last_name].compact.delete_if(&:empty?).join ' '
  end

  def address_1
    "#{address_street} #{address_number}"
  end

  def address_2
    "#{address_zip} #{address_residence}"
  end

  # bypasses Devise's requirement to re-enter current password to edit
  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end
end
