class MainController < ApplicationController
  before_filter do
    @card_count = get_card.count
  end

  def learning
    @cards = get_card
  end

  def add
    @card = Card.new
    if request.post?
      @card.front_side = params[:card][:front_side]
      @card.back_side = params[:card][:back_side]
      if @card.save
        @card = Card.new
      end
    end
  end

  def statistics
    @all = Card.count
    @hits = []

    Show.card_shows.each do |r|
      @hits[r.shows] = 0 if @hits[r.shows].nil?
      @hits[r.shows] += 1
    end
  end

  def save_show
    render json: Show.create(card: Card.find(params[:card_id]), remembered: params[:remembered])
  end

  private
    def get_card
      cards_out = []

      cards = Show.select('card_id, COUNT(*) as shows, MAX(shown_at) as last_shown').group(:card_id).order('shows')
      cards.each do | card |
        if Period.exists?(card.shows)
          period = Period.find(card.shows).period
          if Time.now - card.last_shown >= period
            cards_out << Card.find(card.card_id)
          end
        end
      end

      cards_out
    end
end
