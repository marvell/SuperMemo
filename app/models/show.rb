class Show < ActiveRecord::Base
  belongs_to :card
  before_save :timestamp

   def timestamp
     self.shown_at = DateTime.now
   end

   scope :card_shows, -> { select(:card_id, 'COUNT(id) as shows').group(:card_id) }
end
