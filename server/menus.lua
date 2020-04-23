function displayCoin(value)
	return "<span class=\"symbol\">$</span> "..value
end

local ch_stampa = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRP.prompt({player,lang.buy.contract(),"",function(player,amount)
	local amount = parseInt(amount)
	  if amount > 0 then
	    if vRP.tryPayment({user_id,amount*50}) then
	    vRP.giveInventoryItem({user_id,"cardcontract",amount,true})
		vRPclient.notify(player,{lang.buy.paid({amount*50})})	
		vRP.closeMenu({player})
		else
	    vRPclient.notify(player,{lang.buy.not_enough_money()})		
		end
	  else
	    vRPclient.notify(player,{lang.buy.not_valid_amount()})
		vRP.closeMenu({player})
	  end
	end})
  end
end,lang.buy.contract_description()}

local ch_pagamentoPOS = {function(player,choice)
local user_id = vRP.getUserId({player})
if user_id ~= nil then
	vRPca.pagamentoPOS(user_id,busi)
end
end}

local ch_rimborsoPOS = {function(player,choice)
local user_id = vRP.getUserId({player})
if user_id ~= nil then
	vRPca.rimborsoPOS(user_id,busi)
end
end}

local ch_depositaPOS = {function(player,choice)
local user_id = vRP.getUserId({player})
if user_id ~= nil then
	vRPcc.depositaCash({user_id,busi,player})
end
end}

local ch_comperacontr = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
	  vRP.prompt({player,lang.buy.contract(),"",function(player,amount)
	  local amount = parseInt(amount)
		if amount > 0 then
		  if vRP.tryPayment({user_id,amount*2000}) then
		  vRP.giveInventoryItem({user_id,"cardcontract",amount,true})
		  vRPcc.addBankMoney({"bank", 2000, nil})
		  vRPclient.notify(player,{lang.buy.paid({amount*2000})})	
		  vRP.closeMenu({player})
		  else
		  vRPclient.notify(player,{lang.buy.not_enough_money()})		
		  end
		else
		  vRPclient.notify(player,{lang.buy.not_valid_amount()})
		  vRP.closeMenu({player})
		end
	  end})
	end
  end,lang.account.account_price()}

  local ch_comperapenne = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
	  vRP.prompt({player,lang.buy.pen(),"",function(player,amount)
	  local amount = parseInt(amount)
		if amount > 0 then
		  if vRP.tryPayment({user_id,amount*10}) then
		  vRP.giveInventoryItem({user_id,"penna",amount,true})
		  vRPcc.addBankMoney({"bank", 10, nil})
		  vRPclient.notify(player,{lang.common.paid_amount({amount*10})})	
		  vRP.closeMenu({player})
		  else
		  vRPclient.notify(player,{lang.buy.not_enough_money()})		
		  end
		else
		  vRPclient.notify(player,{lang.buy.not_valid_amount()})
		  vRP.closeMenu({player})
		end
	  end})
	end
  end,lang.account.pen_price()}

local ch_getsoldi = {function(player,choice)
	vRPcc.getCapSoc({function(totale)
		vRPclient.notify(player,{lang.account.total_amount({totale})})
	end})
end,lang.account.total_amount_desc()}

local ch_bloccaconto = {function(player,choice) 
  local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      vRPclient.getNearestPlayers(player,{15},function(nplayers)
      usrList = ""
        for k,v in pairs(nplayers) do
          usrList = usrList .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
        end
        vRP.prompt({player,lang.common.near_players_long({usrList}),"",function(player,nuser_id_p) 
          local nuser_id = tonumber(nuser_id_p)
          local nplayer = vRP.getUserSource({nuser_id})
		  local contenutocoin = vRPca.getCoins(nuser_id)
		  local contenutobanca = vRP.getBankMoney({nuser_id})
            if nuser_id ~= nil and nuser_id ~= "" then 
              vRP.addUserGroup({nuser_id,"nowithdraw"})
              vRPclient.removeDiv(nplayer,{"bmoney"})
              vRPclient.removeDiv(nplayer,{"coins"})
              vRPclient.setDiv(nplayer,{"bmoney",cfg.display_css_red,"<span class=\"symbol\">€</span> "..contenutobanca})
              vRPclient.setDiv(nplayer,{"coins",cfg.display_css_red,"<span class=\"symbol\">€</span> "..contenutocoin})
              vRPclient.notify(nplayer,{lang.account.freezed()})
            end
        end})
      end)
    end
end,lang.account.freeze_desc()}

local ch_sbloccaconto = {function(player,choice) 
  local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      vRPclient.getNearestPlayers(player,{15},function(nplayers)
      usrList = ""
        for k,v in pairs(nplayers) do
          usrList = usrList .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
        end
        vRP.prompt({player,lang.common.near_players_long({usrList}),"",function(player,nuser_id_p) 
          local nuser_id = tonumber(nuser_id_p)
          local nplayer = vRP.getUserSource({nuser_id})
		  local contenutocoin = vRPca.getCoins(nuser_id)
		  local contenutobanca = vRP.getBankMoney({nuser_id})
            if nuser_id ~= nil and nuser_id ~= "" then 
              vRP.removeUserGroup({nuser_id,"nowithdraw"})
              vRPclient.removeDiv(nplayer,{"bmoney"})
              vRPclient.removeDiv(nplayer,{"coins"})
              vRPclient.setDiv(nplayer,{"bmoney",cfg.display_css,"<span class=\"symbol\">€</span> "..contenutobanca})
              vRPclient.setDiv(nplayer,{"coins",cfg.display_css,"<span class=\"symbol\">€</span> "..contenutocoin})
              vRPclient.notify(nplayer,{lang.account.unfreezed()})
            end
        end})
      end)
    end
end,lang.account.unfreeze_desc()}

local ch_depositaSoldi = {function(player,choice)
local user_id = vRP.getUserId({player})
if user_id ~= nil then
	vRP.prompt({player,lang.account.money_deposit(),"",function(player,id_conto) 
		id_conto = parseInt(id_conto)
		if id_conto ~= nil and id_conto > 0 then
			vRP.prompt({player,lang.account.money_deposit_amount(),"",function(player,amount)
				amount = parseInt(amount)
				if vRP.tryPayment({user_id,amount}) then
					vRP.giveBankMoney({id_conto,amount})
					local target = vRP.getUserSource({id_conto})
					vRPclient.notify(target,{lang.account.deposit_confirmation({amount})})
					vRP.request({player,lang.tracking.ask_confirmation(), 15, function(player,ok)
						if ok then
							vRPclient.getPosition(player, {}, function(x,y,z)
								vRPca.transactionTrack(user_id, id_conto, lang.tracking.cash_deposit(), amount, "x="..x..", y="..y..", z="..z..".", nil, 1, nil)
								vRPclient.notify(player,{lang.tracking.transaction_recordered()})
							end)
						else
							vRPclient.notify(player,{lang.tracking.transaction_not_recordered()})
						end
					end})
				else
					vRPclient.notify(player,{lang.buy.not_enough_money()})
				end
			end})
		end
	end})
end
end,lang.account.deposit_desc()}

local ch_prelevaSoldi = {function(player,choice)
local user_id = vRP.getUserId({player})
if user_id ~= nil then
	if vRP.hasPermission({user_id,"propr.banca_tax"}) then
		vRP.prompt({player,lang.account.money_withdraw(),"",function(player,id_conto) 
			id_conto = parseInt(id_conto)
			if id_conto ~= nil and id_conto > 0 then
				vRP.prompt({player,lang.account.money_withdraw_amount(),"",function(player,amount)
					amount = parseInt(amount)
					if vRP.tryBankMoney({id_conto,amount}) then
						vRP.giveMoney({user_id,amount})
						local target = vRP.getUserSource({id_conto})
						vRPclient.notify(target,{lang.account.withdraw_confirmation({amount})})
						vRP.request({player,lang.tracking.ask_confirmation(), 15, function(player,ok)
							if ok then
								vRPclient.getPosition(player, {}, function(x,y,z)
									vRPca.transactionTrack(user_id, id_conto, lang.tracking.cash_withdraw(), amount, "x="..x..", y="..y..", z="..z..".", nil, 1, nil)
									vRPclient.notify(player,{lang.tracking.transaction_recordered()})
								end)
							else
								vRPclient.notify(player,{lang.tracking.transaction_not_recordered()})
							end
						end})
					else
						vRPclient.notify(player,{lang.buy.not_enough_money()})
					end
				end})
			end
		end})
	else
		vRPclient.notify(player,{lang.tracking.withdraw_permission_denied()})
	end
end
end,lang.account.withdraw_desc()}

local ch_bloccaCarta = {function(player,choice)
local user_id = vRP.getUserId({player})
if user_id ~= nil then
	vRP.prompt({player,lang.card.freeze(),"",function(player,id_carta) 
		id_carta = parseInt(id_carta)
		if id_carta ~= nil and id_carta > 0 then
			local numerocarta = 1111111111111111
			numerocarta = tonumber(numerocarta)
			MySQL.execute("vRP/blocca_carta", {user_id = id_carta, numerocarta = numerocarta})
			target = vRP.getUserSource({id_carta})
			if target ~= nil then
				vRPclient.notify(target,{lang.card.freeze_alert()})
			end	
			vRPclient.notify(player,{lang.card.freeze_alert_banker()})
			vRP.getUserIdentity({id_carta, function(identity)
				vRPclient.notify(player,{lang.card.freeze_confirm({identity.firstname,identity.name})})
				if target ~= nil then
					vRPclient.notify(target,{lang.card.freezed()})
				end
			end})
		end
	end})
end
end,lang.account.card_freeze_desc()}

local ch_penne = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRP.prompt({player,lang.buy.pen(),"",function(player,amount)
	local amount = parseInt(amount)
	  if amount > 0 then
	    if vRP.tryPayment({user_id,amount*10}) then
	    vRP.giveInventoryItem({user_id,"penna",amount,true})
		vRPclient.notify(player,{lang.common.paid_amount({amount*50})})	
		vRP.closeMenu({player})
		else
	    vRPclient.notify(player,{lang.buy.not_enough_money()})		
		end
	  else
	    vRPclient.notify(player,{lang.buy.not_valid_amount()})
		vRP.closeMenu({player})
	  end
	end})
  end
end,lang.buy.pen_desc()}

local menu_banca = {name=lang.menu.banca.name(),css={top="75px",header_color="rgba(0,255,255,0.75)"}}
menu_banca[lang.menu.banca.contract()] = ch_stampa
menu_banca[lang.menu.banca.card_account_freeze()] = ch_bloccaconto
menu_banca[lang.menu.banca.card_account_unfreeze()] = ch_sbloccaconto
menu_banca[lang.menu.banca.city_capital()] = ch_getsoldi
menu_banca[lang.menu.banca.cash_deposit()] = ch_depositaSoldi
menu_banca[lang.menu.banca.cash_withdraw()] = ch_prelevaSoldi
menu_banca[lang.menu.banca.block_card()] = ch_bloccaCarta
menu_banca[lang.menu.banca.buy_pen()] = ch_penne
menu_banca.onclose = function(source) vRP.closeMenu({source}) end

local function build_client_pcbanca(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local function pcbanca_enter()
			local user_id = vRP.getUserId({source})
			if vRP.hasPermission({user_id,"banca.menu"}) then
				vRP.openMenu({source,menu_banca})
			end
		end
		local function pcbanca_leave()
			vRP.closeMenu({source})
		end
		vRPclient.addMarker(source,{251.70816040039,228.95999145508,106.28684234619-1,0.7,0.7,0.3,0,125,255,125,150})
		vRP.setArea({source,"vRP:banca:pc",251.70816040039,228.95999145508,106.28684234619,1,1.5,pcbanca_enter,pcbanca_leave})
    end
end

local menu_cards = {name=lang.menu.card.name(),css={top="75px",header_color="rgba(0,255,255,0.75)"}}
menu_cards[lang.menu.card.buy_contract()] = ch_comperacontr
menu_cards[lang.menu.card.buy_pen()] = ch_comperapenne
menu_cards.onclose = function(source) vRP.closeMenu({source}) end

local function build_client_card_menu(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local function menu_cards_enter()
			local user_id = vRP.getUserId({source})
			vRP.openMenu({source,menu_cards})
		end
		local function menu_cards_leave()
			vRP.closeMenu({source})
		end
		vRPclient.addMarker(source,{248.24145507813,222.41792297363,106.28671264648-1,0.7,0.7,0.3,0,125,255,125,150})
		vRP.setArea({source,"vRP:cartao:pc",248.24145507813,222.41792297363,106.28671264648,1,1.5,menu_cards_enter,menu_cards_leave})
    end
end

local menu_pos = {}

for k,v in pairs(cfg.pos) do
	local biz,perm,x,y,z = table.unpack(v)
	menu_pos[biz] = {name=lang.menu.pos.name(),css={top="75px",header_color="rgba(0,255,255,0.75)"}}
	menu_pos[biz][lang.menu.pos.payment()] = ch_pagamentoPOS
	menu_pos[biz][lang.menu.pos.refund()] = ch_rimborsoPOS
	menu_pos[biz][lang.menu.pos.cash_deposit()] = ch_depositaPOS
	menu_pos[biz].onclose = function(source) vRP.closeMenu({source}) end
end

local function build_client_pos(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local cfg = getCoinConfig()
		local pos = cfg.pos
		for k,v in pairs(pos) do
			local biz,perm,x,y,z = table.unpack(v)			  
			local function pos_enter()
				local user_id = vRP.getUserId({source})
				if user_id ~= nil then
					if vRP.hasPermission({user_id,perm}) then
						if not vRP.hasPermission({user_id,"no.withdraw"}) then
							local menu = "menu_pos_"..biz
							busi = biz
							vRP.openMenu({source,menu_pos[biz]})
						else
							vRPclient.notify(player, {lang.account.freezed()})
						end
					end
				end				
			end
			local function pos_leave()
				vRP.closeMenu({source})
			end
			vRPclient.addBlip(source,{x,y,z,108,4,"POS"})
			vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.3,0,125,255,125,150})
			vRP.setArea({source,"vRP:pos"..k,x,y,z,1,1.5,pos_enter,pos_leave})
		end 
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		local cfg = getCoinConfig()
		local myCoins = vRPca.getCoins(user_id)
		if vRP.hasGroup({user_id,"nowithdraw"}) then
			vRPclient.setDiv(source, {"coins", cfg.display_css_red, displayCoin(myCoins)})
		else
			vRPclient.setDiv(source, {"coins", cfg.display_css, displayCoin(myCoins)})
		end
		build_client_pcbanca(source)
		build_client_pos(source)
		build_client_card_menu(source)
	end
end)

local ch_trasferisci_cc = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    if not vRP.hasPermission({user_id,"no.withdraw"}) then
		vRPca.trasferisciContoCC(user_id)
	else
		vRPclient.notify(player,{lang.account.freezed()})
	end
  end
end}

local ch_trasferisci_conto = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		if not vRP.hasPermission({user_id,"no.withdraw"}) then
			vRPca.trasferisciCCconto(user_id)
		else
			vRPclient.notify(player,{lang.account.freezed()})
		end
	end
end}

local ch_paga_utente = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    if not vRP.hasPermission({user_id,"no.withdraw"}) then
		vRPca.paga_utente(user_id)
	else
		vRPclient.notify(player,{lang.account.freezed()})
	end
  end
end}

local ch_pin_change = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		if not vRP.hasPermission({user_id,"no.withdraw"}) then
			vRPca.cambia_PIN(user_id, player)
		else
			vRPclient.notify(player,{lang.account.freezed()})
		end
	end
end}

local ch_carta_credito_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = lang.menu.main.name()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
    if vRP.hasPermission({user_id,"player.player_menu",}) then
      menu[lang.menu.main.transfer_ac()] = ch_trasferisci_cc
    end
	
	if vRP.hasPermission({user_id,"player.player_menu",}) then
      menu[lang.menu.main.pay_user()] = ch_paga_utente
    end
	
	if vRP.hasPermission({user_id,"player.player_menu",}) then
	  menu[lang.menu.main.pin_change()] = ch_pin_change
	end
	
	if vRP.hasPermission({user_id,"player.player_menu",}) then
	  menu[lang.menu.main.transfer_ca()] = ch_trasferisci_conto
	end
	
	vRP.openMenu({player, menu})
end}

vRP.registerMenuBuilder({"main", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}	
	if vRP.hasPermission({user_id,"player.player_menu"}) then
      choices[lang.menu.main.name()] = ch_carta_credito_menu
    end
    add(choices)
  end
end})
