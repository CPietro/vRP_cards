MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Lang = module("vrp", "lib/Lang")

vRP = Proxy.getInterface("vRP")
vRPbm = Proxy.getInterface("vRP_basic_menu")

vRPca = {}
Tunnel.bindInterface("vRP_cards",vRPca)
Proxy.addInterface("vRP_cards",vRPca)
NCclient = Tunnel.getInterface("vRP_cards","vRP_cards")

vRPclient = Tunnel.getInterface("vRP","vRP_cards")
vRPcc = Proxy.getInterface("vRP_companyaccs")
cfg = module("vrp_cards", "cfg/coin")
lang = Lang.new(module("vrp_cards", "cfg/lang"))

MySQL.createCommand("vRP/cards_table", [[
	CREATE TABLE IF NOT EXISTS vrp_cards(
	user_id INT(255) NOT NULL,
	coins INT(255) NOT NULL,
	numerocarta BIGINT(16) NOT NULL DEFAULT '0',
	pin INT(5) NOT NULL DEFAULT '0',
	PRIMARY KEY (user_id)
);
	CREATE TABLE IF NOT EXISTS money_transactions (
	user_id INT(11) NOT NULL DEFAULT '0',
	tipo VARCHAR(255) NULL DEFAULT NULL,
	amount INT(11) NULL DEFAULT '0',
	os_time VARCHAR(50) NULL DEFAULT NULL,
	os_date VARCHAR(50) NULL DEFAULT NULL,
	nome VARCHAR(255) NULL DEFAULT NULL,
	cognome VARCHAR(255) NULL DEFAULT NULL,
	telefono VARCHAR(255) NULL DEFAULT NULL,
	age INT(11) NULL DEFAULT '0',
	place VARCHAR(255) NULL DEFAULT NULL,
	cc_number VARCHAR(255) NULL DEFAULT NULL,
	is_business INT(1) NULL DEFAULT '0',
	id_destinatario INT(11) NULL DEFAULT NULL,
	nome_dest VARCHAR(255) NULL DEFAULT NULL,
	cognome_dest VARCHAR(255) NULL DEFAULT NULL,
	telefono_dest VARCHAR(255) NULL DEFAULT NULL,
	age_dest VARCHAR(255) NULL DEFAULT NULL,
	is_business_dest INT(1) NULL DEFAULT '0'
);
]])
MySQL.createCommand("vRP/coins_init_user","INSERT IGNORE INTO vrp_cards(user_id,coins) VALUES(@user_id,@coins)")
MySQL.createCommand("vRP/get_coins","SELECT * FROM vrp_cards WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_coins","UPDATE vrp_cards SET coins = @coins WHERE user_id = @user_id")
MySQL.createCommand("vRP/transaction_track","INSERT INTO money_transactions(user_id,tipo,amount,os_time,os_date,nome,cognome,telefono,age,place,cc_number,is_business,id_destinatario,nome_dest,cognome_dest,telefono_dest,age_dest,is_business_dest) VALUES(@user_id,@tipo,@amount,@os_time,@os_date,@nome,@cognome,@telefono,@age,@place,@cc_number,@is_business,@id_destinatario,@nome_dest,@cognome_dest,@telefono_dest,@age_dest,@is_business_dest)")
MySQL.createCommand("vRP/get_num_id","SELECT * FROM vrp_cards WHERE numerocarta = @numerocarta")
MySQL.createCommand("vRP/get_id_num","SELECT * FROM vrp_cards WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_carte","SELECT * FROM vrp_cards")
MySQL.createCommand("vRP/get_pin","SELECT * FROM vrp_cards WHERE numerocarta = @numerocarta")
MySQL.createCommand("vRP/insert_card_pin","UPDATE vrp_cards SET pin = @pin WHERE user_id = @user_id")
MySQL.createCommand("vRP/blocca_carta","UPDATE vrp_cards SET numerocarta = @numerocarta WHERE user_id = @user_id")

MySQL.execute("vRP/cards_table")
tmpCoins = {}
busi = {}

function vRPca.getCoins(user_id)
	local coins = tonumber(tmpCoins[user_id])
	if coins ~= nil then
		return tonumber(tmpCoins[user_id])
	else
		return 0
	end
end

function vRPca.setCoins(user_id,value)
	local coins = tonumber(tmpCoins[user_id])
	if coins ~= nil then
		tmpCoins[user_id] = tonumber(value)
	end
	local source = vRP.getUserSource({user_id})
	if source ~= nil then
		if vRP.hasGroup({user_id,"nowithdraw"}) then
			vRPclient.setDiv(source,{"coins",cfg.display_css_red,lang.display.div({value})})
		else
			vRPclient.setDiv(source,{"coins",cfg.display_css,lang.display.div({value})})
		end
	end
end

function vRPca.getCoinsOffline(user_id, cbr)
local task = Task(cbr,{""})	
	if user_id ~= nil then
		MySQL.query("vRP/get_coins", {user_id = user_id}, function(rows, affected)
			if #rows > 0 then
				task({rows[1].coins})
			else
				task()
			end
		end)
	end
end

function vRPca.setCoinsOffline(user_id,value)
	value = parseInt(value)
	vRPca.getCoinsOffline(user_id, function(amount)
		amount = parseInt(amount)
		if amount ~= nil then
			MySQL.execute("vRP/set_coins", {user_id = user_id, coins = value})
		end
	end)
end

function vRPca.getPIN(numero_cc, cbr)
	local task = Task(cbr,{""})
	MySQL.query("vRP/get_pin", {numerocarta = numero_cc}, function(rows, affected)
		if #rows > 0 then		
			task({rows[1].pin})
		else
			task()
		end
	end)
end

function vRPca.cambia_PIN(user_id, player)
	if user_id ~= nil then
		vRP.prompt({player,lang.pin.ask_changing(),"",function(player,pin)
			pin = parseInt(pin)
			if #tostring(pin) == 5 and pin >= 0 and pin <= 99999 then
				MySQL.execute("vRP/insert_card_pin", {user_id = user_id, pin = pin}, function(affected)	
					vRPclient.notify(player, {lang.pin.changed({pin})})
				end)	
			else
				vRPclient.notify(player, {lang.pin.notavailable()})
			end
		end})		
	end
end

function vRPca.giveCoins(user_id,amount)
	local coins = vRPca.getCoins(user_id)
	local newCoins = coins + amount
	vRPca.setCoins(user_id,newCoins)
end

function vRPca.tryCoinPayment(user_id,amount)
	local coins = vRPca.getCoins(user_id)
	if coins >= amount then
		vRPca.setCoins(user_id,coins-amount)
		return true
	else
		return false
	end
end

function vRPca.getNumeroID(numerocc, cbr)
	local task = Task(cbr,{""})
	MySQL.query("vRP/get_num_id", {numerocarta = numerocc}, function(rows, affected)
		if #rows > 0 then
			task({rows[1].user_id})
		else
			task()
		end
	end)
end

function vRPca.getCardNumber(user_id, cbr)
	local task = Task(cbr,{""})
	MySQL.query("vRP/get_id_num", {user_id = user_id}, function(rows, affected)
		if #rows > 0 then
			task({rows[1].numerocarta})
		else
			task()
		end
	end)
end

function vRPca.userIdentification(player, cbr)
	local task = Task(cbr,{""})	
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPca.getCards(user_id, function(carta_num, carte)
			if carte == 0 then
				vRPclient.notify(player, {lang.card.notfound()})
			elseif carte >= 1 then
				usrList = ""
				usrData = {}
				for k,v in ipairs(carta_num) do
					vRPca.getNumeroID(v, function(num_utente)
						vRP.getUserIdentity({num_utente, function(identity)
							usrList = usrList .. "[" .. num_utente .. "]" ..identity.firstname.." "..identity.name.. " | "
							table.insert(usrData, {
								cardnumber = v,
								userid = num_utente,
								useridentity = identity
							})
							if k == carte then
								vRP.prompt({player, lang.common.select_card({usrList}),"",function(player,nome)
									for key,value in ipairs(usrData) do
										if tonumber(nome) == value.useridentity.user_id then
											vRPca.getPIN(value.cardnumber, function(pin_giusto)	
												vRP.prompt({player,lang.pin.insert(),"",function(player,pin_inserito)
													if tonumber(pin_inserito) == pin_giusto then
														task({player, value.cardnumber, value.userid, value.useridentity})
													else
														vRPclient.notify(player, {lang.pin.wrong()})
													end
												end})
											end)
										end
									end
								end})
							end
						end})						
					end)
				end
			end
		end)
	end
end

function vRPca.basicUserIdentification(user_id, player, cbr)
	local task = Task(cbr,{""})	
	if user_id ~= nil then
		vRPca.getCards(user_id, function(carta_num, carte)
			if carte == 0 then
				vRPclient.notify(player, {lang.card.notfound()})
			elseif carte >= 1 then
				usrList = ""
				usrData = {}
				for k,v in ipairs(carta_num) do
					vRPca.getNumeroID(v, function(num_utente)
						vRP.getUserIdentity({num_utente, function(identity)
							usrList = usrList .. "[" .. num_utente .. "]" ..identity.firstname.." "..identity.name.. " | "
							table.insert(usrData, {
								cardnumber = v,
								userid = num_utente,
								useridentity = identity
							})
							if k == carte then
								vRP.prompt({player, lang.common.select_card({usrList}),"",function(player,nome)
									for key,value in ipairs(usrData) do
										if tonumber(nome) == value.useridentity.user_id then
											vRPca.getPIN(value.cardnumber, function(pin_giusto)	
												task({player, value.cardnumber, value.userid, value.useridentity, pin_giusto})
											end)
										end
									end
								end})
							end
						end})						
					end)
				end
			end
		end)
	end
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local cfg = getCoinConfig()
	MySQL.execute("vRP/coins_init_user", {user_id = user_id, coins = cfg.open_coins}, function(affected)
		MySQL.query("vRP/get_coins", {user_id = user_id}, function(rows, affected)
			if #rows > 0 then
				tmpCoins[user_id] = tonumber(rows[1].coins)
			end
		end)
	end)
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	local coins = tmpCoins[user_id]
	if coins and coins ~= nil then
		MySQL.execute("vRP/set_coins", {user_id = user_id, coins = coins})
	end
end)

AddEventHandler("vRP:save", function()
	for i, v in pairs(tmpCoins) do
		if v ~= nil then
			MySQL.execute("vRP/set_coins", {user_id = i, coins = v})
		end
	end
end)

function vRPca.getCards(user_id, cbr)
	local task = Task(cbr,{""})
	local carta_num = {}
	local carte = 0
	MySQL.query("vRP/get_carte", {}, function(rows, affected)
		if #rows > 0 then
			for i=1,#rows do
				local cc_num = rows[i].numerocarta
				if vRP.getInventoryItemAmount({user_id,"bank_cards_"..cc_num}) > 0 then
					carte = carte + 1
					carta_num[carte] = cc_num
				end
			end
			task({carta_num, carte})
		end
		task({carta_num, carte})
	end)
end

function vRPca.crackPIN(user_id)
	if user_id ~= nil then
		player = vRP.getUserSource({user_id})
		vRPca.basicUserIdentification(user_id, player, function(player3, cardnumber, num_utente, useridentity, pin_giusto)
			if num_utente ~= nil then
				math.randomseed(os.time())
				local probabilita = math.random(1,10)
				if tonumber(probabilita) < 8 then
					vRPclient.notify(player, {lang.card.cracked_ok({pin_giusto})})
				else
					vRPclient.notify(player, {lang.card.cracked_failed()})
					vRPclient.getPosition(player,{},function(x,y,z)
						vRP.sendServiceAlert({nil, "polizia",x,y,z,lang.card.police_alerted()})
					end)
				end
			end
		end)
	end
end
