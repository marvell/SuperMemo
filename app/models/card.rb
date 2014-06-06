class Card < ActiveRecord::Base
  # attr_accessor :last_shown, :shows

  has_many :show

  validates :front_side, {
    presence: true,
    length: { maximum: 255}
  }
  validates :back_side,  {
    presence: true
  }


  after_save do
    Show.create(card: self, remembered: true)
  end

  # after_find do | card |
  #   self.last_shown = nil
  #   self.shows = 0

  #   if card.show.any?
  #     self.last_shown = card.show.order(shown_at: :desc).take.shown_at
  #     self.shows = card.show.count
  #   else
  # end
end
