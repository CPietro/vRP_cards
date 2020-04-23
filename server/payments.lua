function vRPca.trasferisciContoCC(user_id)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.userIdentification(player, function(player, cardnumber, userid, useridentity)
			if userid ~= nil then
				vRP.prompt({player,lang.card.amount_transfer(),"",function(player,amount)
					amount = parseInt(amount)
					if amount > 0 then
						if vRP.tryBankMoney({userid,amount}) then 
							vRPca.giveCoins(userid,amount)
						else
							vRPclient.notify(player, {lang.buy.not_enough_money()})
						end
					end
				end})
			end
		end)
	end
end

function vRPca.trasferisciCCconto(user_id)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.userIdentification(player, function(player, cardnumber, userid, useridentity)
			if userid ~= nil then
				vRP.prompt({player,lang.card.amount_transfer(),"",function(player,amount)
					amount = parseInt(amount)
					if amount > 0 then
						if vRPca.tryCoinPayment(userid,amount) then 
							vRP.giveBankMoney({userid,amount})
						else
							vRPclient.notify(player, {lang.buy.not_enough_money()})
						end
					end
				end})
			end
		end)
	end
end

function vRPca.preleva(user_id)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.userIdentification(player, function(player, cardnumber, num_utente, useridentity)
			if num_utente ~= nil then
				vRP.prompt({player,lang.account.money_withdraw_amount(),"",function(player,amount)
					amount = parseInt(amount)
					if amount > 0 and amount <= 2500 then
						if vRPca.tryCoinPayment(num_utente,amount) then 
							vRP.giveMoney({user_id,amount})
							vRPclient.getPosition(player, {}, function(x,y,z)
								vRPca.transactionTrack(num_utente, nil, lang.tracking.withdraw(), amount, "x="..x..", y="..y..", z="..z..".", cardnumber, nil, nil)
							end)
						else
							vRPclient.notify(player, {lang.buy.not_enough_money()})
						end
					else
						if amount > 2500 then
							vRPclient.notify(player, {lang.card.reached_withdraw_amount()})
						else
							vRPclient.notify(player, {lang.buy.wrong_amount()})
						end
					end
				end})
			end			
		end)
	end
end

function vRPca.paga_utente(user_id)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.userIdentification(player, function(player, cardnumber, num_utente, useridentity)
			if num_utente ~= nil then
				vRPclient.getNearestPlayers(player,{15},function(nplayers)
					usrList = ""
					for k,v in pairs(nplayers) do
						usrList = usrList .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
					end
					if usrList ~= "" then
						vRP.prompt({player,lang.common.near_players({usrList}),"",function(player,user_id1) 
							user_id1 = user_id1
							if user_id1 ~= nil and user_id1 ~= "" then 
								local target = vRP.getUserSource({tonumber(user_id1)})
								if target ~= nil then
									vRP.request({target,lang.card.ask_transfer_confirm({GetPlayerName(player)}), 10, function(target,ok)
										vRPclient.notify(player, {lang.common.request_sent_receiver()})
										if ok then
											destinatario = vRP.getUserId({target})
											vRP.prompt({player,lang.buy.charge_amount(),"",function(player,amount)
												amount = parseInt(amount)
												if amount > 0 then
													if vRPca.tryCoinPayment(num_utente,math.floor(amount*1.02)) then 																				
														vRPca.getCardNumber(destinatario, function(card_nbr)
															if card_nbr ~= 0 and card_nbr ~= 1111111111111111 then
																vRPca.giveCoins(destinatario,amount)
															else
																vRP.giveBankMoney({destinatario,amount})
															end
															vRPclient.notify(player, {lang.common.sent_amount({amount})})
															vRPclient.notify(target, {lang.common.received_amount({amount})})
															vRPclient.notify(player, {lang.common.fee_amount({amount*0.02})})
															vRPcc.addBankMoney({"bank", math.floor(amount*0.02), nil})
															vRPclient.getPosition(player, {}, function(x,y,z)
																vRPca.transactionTrack(num_utente, nil, lang.tracking.payment(), amount, "x="..x..", y="..y..", z="..z..".", cardnumber, nil, nil)
															end)
														end)	
													else
														vRPclient.notify(player, {lang.buy.not_enough_money()})
													end
												else
													vRPclient.notify(player, {lang.buy.not_valid_amount()})
												end
											end})
										else --iiii
											vRPclient.notify(player,{lang.common.payment_refused({GetPlayerName(target)})})
											vRPclient.notify(target,{lang.common.payment_refused_receiver({GetPlayerName(player)})})
										end
									end})
								end
							else
								vRPclient.notify(player,{lang.common.no_id_specified()})
							end
						end})
					else
						vRPclient.notify(player,{lang.common.no_players_near()})
					end
				end) --cc
			end
		end)
	end
end

function vRPca.pagamentoPOS(user_id,business)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.basicUserIdentification(user_id, player, function(player, cardnumber, num_utente, useridentity, pin_giusto)
			if num_utente ~= nil then
				if not vRP.hasPermission({num_utente,"no.withdraw"}) then
					vRPclient.getNearestPlayers(player,{15},function(nplayers)
						usrList = ""
						for k,v in pairs(nplayers) do
							usrList = usrList .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
						end
						if usrList ~= "" then
							vRP.prompt({player,lang.common.customer({usrList}),"",function(player,user_id1) 
								user_id1 = parseInt(user_id1)
								if user_id1 ~= nil and user_id1 ~= "" then 
									local target = vRP.getUserSource({tonumber(user_id1)})
									if target ~= nil then
										vRP.request({target,lang.pin.ask_to_enter({GetPlayerName(player)}), 10, function(target,ok)
											vRPclient.notify(player, {lang.common.request_sent_customer()})
											if ok then
												destinatario = vRP.getUserId({target})	
												vRP.prompt({target,lang.pin.insert(),"",function(target,pin_inserito)	
													if parseInt(pin_inserito) == pin_giusto then
														vRP.prompt({player,lang.buy.charge_amount(),"",function(player,amount)
															amount = parseInt(amount)
															if amount > 0 then
																if vRPca.tryCoinPayment(num_utente,amount) then 
																	vRPcc.addBankMoney({business,amount,player})
																	vRPclient.notify(target, {lang.common.paid_amount({amount})})
																	vRPclient.notify(player, {lang.common.received_amount({amount})})
																	vRPcc.addBankMoney({"bank", math.floor(amount*0.04), nil})
																	vRPclient.getPosition(target, {}, function(x,y,z) vRPca.transactionTrack(destinatario, user_id, lang.tracking.payment(), amount, "x="..x..", y="..y..", z="..z..".", cardnumber, nil, 1) end)
																else
																	vRPclient.notify(target, {lang.buy.not_enough_money()})
																end
															else
																vRPclient.notify(player, {lang.buy.not_valid_amount()})
															end
														end})
													else
														vRPclient.notify(player, {lang.pin.wrong()})
													end
												end})
											else
												vRPclient.notify(player,{lang.pin.refused_to_enter({GetPlayerName(target)})})
												vRPclient.notify(target,{lang.common.refused_to_confirm({GetPlayerName(player)})})
											end
										end})
									end
								else
									vRPclient.notify(player,{lang.common.no_id_specified()})
								end
							end})
						else
							vRPclient.notify(player,{lang.common.no_players_near()})
						end
					end) --cc
				else
					vRPclient.notify(player,{lang.account.currently_freezed()})
				end
			end
		end)
	end
end

function vRPca.rimborsoPOS(user_id,business)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.basicUserIdentification(user_id, player, function(player, cardnumber, num_utente, useridentity, pin_giusto)
			if num_utente ~= nil then
				vRPclient.getNearestPlayers(player,{15},function(nplayers)
					usrList = ""
					for k,v in pairs(nplayers) do
						usrList = usrList .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
					end
					if usrList ~= "" then
						vRP.prompt({player,lang.common.customer({usrList}),"",function(player,user_id1) 
							user_id1 = parseInt(user_id1)
							local target = vRP.getUserSource({tonumber(user_id1)})
							if target ~= nil then
								vRP.request({target,lang.account.refund_confirmation({GetPlayerName(player)}), 10, function(target,ok)
									vRPclient.notify(player, {lang.common.request_sent_customer()})
									if ok then
										destinatario = vRP.getUserId({target})	
										vRP.prompt({player,lang.account.refund_amount(),"",function(player,amount)
											amount = parseInt(amount)
											if amount > 0 then
												vRPcc.getBankBalance({business, function(balance)
													balance = parseInt(balance)
													if balance >= amount then 
														vRPcc.removeBankMoney({business, amount, player})
														vRPca.giveCoins(num_utente,amount)
														vRPclient.notify(player, {lang.common.paid_amount({amount})})
														vRPclient.notify(target, {lang.common.received_amount({amount})})
														vRPclient.getPosition(player, {}, function(x,y,z) vRPca.transactionTrack(num_utente, destinatario, lang.tracking.refund(), amount, "x="..x..", y="..y..", z="..z..".", cardnumber, 1, nil) end)
													else
														vRPclient.notify(player, {lang.buy.not_enough_money()})
													end
												end})																																
											else
												vRPclient.notify(player, {lang.buy.not_valid_amount()})
											end
										end})
									else --iiii
										vRPclient.notify(player,{lang.pin.refused_to_enter({GetPlayerName(target)})})
										vRPclient.notify(target,{lang.common.refused_to_confirm({GetPlayerName(player)})})
									end
								end})
							end
						end})
					else
						vRPclient.notify(player,{lang.common.no_players_near()})
					end
				end)
			end
		end)
	end
end

function vRPca.pagamento(user_id, amount, itemname, quantity)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.userIdentification(player, function(player, cardnumber, userid, useridentity)
			if userid ~= nil then
				amount = parseInt(amount)
				if amount > 0 then
					if vRPca.tryCoinPayment(userid,amount) then 
						vRP.giveInventoryItem({user_id,itemname,quantity,true})
						vRPclient.getPosition(player, {}, function(x,y,z)
							vRPca.transactionTrack(userid, nil, lang.tracking.purchase(), amount, "x="..x..", y="..y..", z="..z..".", cardnumber, nil, nil)
						end)
					else
						vRPclient.notify(player, {lang.buy.not_enough_money()})
					end
				else
					vRPclient.notify(player, {lang.buy.wrong_amount()})
				end
			end
		end)
	end
end
