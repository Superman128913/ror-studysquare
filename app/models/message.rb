class Message < ActiveRecord::Base
  has_paper_trail

  belongs_to :messageable, polymorphic: true
  belongs_to :user

  attr_accessible :body, :subject, :messageable, :messageable_type,
    :messageable_id
  attr_accessible :body, :subject, :messageable, :messageable_type,
    :messageable_id, as: :admin

  validates_presence_of :subject, :body
  after_create :send_mails

  def customers
    messageable ? messageable.customers : Customer
  end

  def send_mails
    begin
      mail_users = customers.all
      mail_users << user
      mail_users.compact.uniq.each do |user|
        begin
          Notifications.delay.generic_message(self.id, user.id)
        rescue
          puts "Email #{id} failed for user #{user.id}"
        end
      end
    rescue => e; puts e end
  end
  handle_asynchronously :send_mails

  def description
    subject
  end

  protected

  rails_admin do
    navigation_label "Manager"

    field :user
    field :subject
    field :body
    field :messageable
    field :updated_at
  end
end
