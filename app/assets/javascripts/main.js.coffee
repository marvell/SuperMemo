$ ->
	cards = $('.card')
	active_card = cards.first()

	active_card.addClass 'active'

	$(document).keydown (event) ->
		if event.keyCode == 32
			active_card.toggleClass 'flipped'

		if event.keyCode == 37 or event.keyCode == 39
			last_card = active_card
			active_card = last_card.next()
			remembered = event.keyCode == 39

			last_card.addClass if remembered then 'remembered' else 'dont-remembered'

			$.post '/save_show',
				card_id: last_card.data('id')
				remembered: remembered
				->
					last_card.addClass('slide-down').removeClass('active')
					active_card.addClass('active')