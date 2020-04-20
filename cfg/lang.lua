local lang = {
	pin = {
		ask_changing = "Wha PIN do you want to enter (5 digits)?",
		changed = "You card PIN is {1}, be careful with it!",
		notavailable = "~r~The inserted PIN isn't available!",
		insert = "Insert the PIN...",
		wrong = "~r~You wrote in the wrong PIN!",
		ask_to_enter = "{1} wants you to insert your PIN for a payment...",
		refused_to_enter = "~r~{1} refused to enter the PIN."
	},
	card = {
		notfound = "~r~You don't have any card on you!",
		cracked_ok = "Il pin della carta è ~g~{1}~w~!",
		cracked_failed = "~r~The machine wasn't able to get the card PIN! Law enforcement was alerted!",
		police_alerted = "[Security system] Failed attempt to crack a card PIN.",
		freeze = "Write the card you want to freeze user ID...",
		freeze_alert = "Your card will be frozed within 5 minutes.",
		freeze_alert_banker = "The card will be frozed within 5 minutes.",
		freeze_confirm = "You blocked ~g~{1} {2}~w~ card.",
		freezed = "You card has been blocked.",
		amount_transfer = "How much do you want to transfer?",
		reached_withdraw_amount = "~r~You cannot withdraw more than ~w~2500$~r~!",
		ask_transfer_confirm = "{1} wants to transfer you money by a card payment."
	},
	buy = {
		contract = "How many contracts do you want to print?",
		paid = "You paid ~r~{1}$~w~.",
		not_enough_money = "~r~You don't have enough money.",
		wrong_amount = "~r~The entered amount is incorrect!",
		not_valid_amount = "~r~Not valid amount!",
		contract_description = "Print a card contract.",
		pen = "How many pens do you need?",
		pen_desc = "Grab some pens to give customers, they'll need them to sign their card's contracts.",
		charge_amount = "How much do you want to charge?"
	},
	account = {
		total_amount = "There are ~g~{1}$~w~ in the city.",
		total_amount_desc = "Returns the total amount of money deposited on bank accounts and cards opened in this city.",
		freezed = "~r~Your account has been frozed.",
		freeze_desc = "Freeze a player's account so he can't withdraw cash or transfer money.",
		unfreezed = "~g~Your account has been unfrozen.",
		unfreeze_desc = "Unfreeze a player's account and card.",
		money_deposit = "Write the user ID of the account to deposit on...",
		money_deposit_amount = "How much cash do you want to deposit?",
		deposit_confirmation = "~g~{1}$~w~ were deposited on your account.",
		deposit_desc = "Deposit cash on a player's bank account.",
		money_withdraw = "Write the user ID of the account to withdraw from...",
		money_withdraw_amount = "How much cash do you want to withdraw?",
		withdraw_confirmation = "~g~{1}$~w~ were withdrawn from your account.",
		withdraw_desc = "Withdraw cash from a player's bank account.",
		card_freeze_desc = "Freeze a player's card without issuing a new one (will be unfrozen when a new card is issued).",
		currently_freezed = "~r~Il the account is frozed.",
		refund_confirmation = "{1} wants to refund you...",
		refund_amount = "How much do you need to refund?",
		account_price = "2000$.",
		pen_price = "10$."
	},
	common = {
		near_players_long = "Insert [user_id] (Player vicini): {1}",
		near_players = "Players near: {1}",
		request_sent_receiver = "Request sent to the receipient...",
		sent_amount = "You paid ~r~{1}$~w~.",
		paid_amount = "You paid ~r~{1}$~w~.",
		received_amount = "You received ~g~{1}$~w~.",
		fee_amount = "You paid ~r~{1}$~w~ in fees.",
		payment_refused = "~r~{1} refused the payment.",
		payment_refused_receiver = "~r~You refused the payment from {1}.",
		no_id_specified = "~r~No ID specified.",
		no_players_near = "~r~No players near.",
		customer = "Customer: {1}",
		request_sent_customer = "Request sent to the customer...",
		refused_to_confirm = "~r~You refused the transaction from {1}.",
		select_card = "Card to use [User ID]: {1}"
	},
	display = {
		div = "<span class=\"symbol\">€</span> {1}"
	},
	tracking = {
		ask_confirmation = "Do you want to record the transaction?",
		cash_deposit = "Bank cash deposit",
		cash_withdraw = "Bank cash withdraw",
		withdraw = "Withdraw",
		payment = "Payment",
		refund = "Refund",
		purchase = "Purchase",
		transaction_recordered = "Transaction recorded.",
		transaction_not_recordered = "~r~Transaction not recorded.",
		withdraw_permission_denied = "~r~Only the bank director can withdraw cash.",
		not_found = "Non found",
		std_number = "000-0000",
		std_card_number = "1111111111111111",
		discord = {
			communityname = "FBI - Reports",
			title = "FBI | Flagged transactions",
			username = "IRS"
		}
	},
	menu = {
		banca = {
			name = "Bank PC",
			contract = "Print card contract",
			card_account_freeze = "Freeze bank account/card",
			card_account_unfreeze = "Unfreeze bank account/card",
			city_capital = "Show money in the city",
			cash_deposit = "Deposit cash",
			cash_withdraw = "Withdraw cash",
			block_card = "Freeze a card",
			buy_pen = "Buy pens"
		},
		card = {
			name = "Negozio",
			buy_contract = "Print card contract",
			buy_pen = "Buy pens"
		},
		pos = {
			name = "POS Terminal",
			payment = "Payment",
			refund = "Refund",
			cash_deposit = "Cash deposit"
		},
		main = {
			name = "Bank Card",
			transfer_ac = "Transfer from bank to card",
			transfer_ca = "Transfer from card to bank",
			pay_user = "Pay player",
			pin_change = "PIN change"
		}
	}
}

return lang