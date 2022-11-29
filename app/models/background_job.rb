class BackgroundJob < Delayed::Job
  rails_admin do
    navigation_label "Maintenance"
  end
end

