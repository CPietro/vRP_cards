function vRPca.transactionTrack(user_id, id_dest, tipo, amount, place, cc_number, is_business, is_business_dest) -- DA SISTEMARE CON IL CFG
	if user_id ~= nil then
		if cc_number ~= nil then
			vRPca.getNumeroID(cc_number, function(user_id)
				vRP.getUserIdentity({user_id, function(identity)
					os_time = os.date("%X")
					os_date = os.date("%x")
					if tipo == nil then
						tipo = lang.tracking.not_found()
					end
					if place == nil then
						place = lang.tracking.not_found()
					end
					amount = parseInt(amount)
					if id_dest ~= nil then
						vRP.getUserIdentity({id_dest, function(identity1)
							if is_business == nil then
								is_business = 0
							end
							if is_business_dest == nil then
								is_business_dest = 0
							end
							if amount == nil then
							amount = tonumber("0")
							end
							MySQL.execute("vRP/transaction_track", {user_id = user_id, tipo = tipo, amount = amount, os_time = os_time, os_date = os_date, nome = identity.firstname, cognome = identity.name, telefono = identity.phone, age = tonumber(identity.age), place = place, cc_number = tonumber(cc_number), is_business = is_business, id_destinatario = id_dest, nome_dest = identity1.firstname, cognome_dest = identity1.name, telefono_dest = identity1.phone, age_dest = identity1.age, is_business_dest = is_business_dest})
							math.randomseed(os.time())
							local calcolo = math.random(1,12)
							if calcolo >= 9 then
								vRPca.SendToDiscord(user_id,tipo,amount,os_time,os_date,identity.firstname,identity.name,identity.phone,tonumber(identity.age),place,tonumber(cc_number),is_business,id_dest,identity1.firstname,identity1.name,identity1.phone,identity1.age,is_business_dest)							
							end
						end})
					end
					if id_dest == nil then
						if is_business == nil then
							is_business = 0
						end
						if is_business_dest == nil then
							is_business_dest = 0
						end
						id_dest = 0
						local nome_dest = lang.tracking.not_found()
						local cognome_dest = lang.tracking.not_found()
						local age_dest = 99
						local telefono_dest = lang.tracking.std_number()
						if amount == nil then
							amount = tonumber("0")
						end
						MySQL.execute("vRP/transaction_track", {user_id = user_id, tipo = tipo, amount = amount, os_time = os_time, os_date = os_date, nome = identity.firstname, cognome = identity.name, telefono = identity.phone, age = tonumber(identity.age), place = place, cc_number = tonumber(cc_number), is_business = is_business, id_destinatario = id_dest, nome_dest = nome_dest, cognome_dest = cognome_dest, telefono_dest = telefono_dest, age_dest = age_dest, is_business_dest = is_business_dest})
						math.randomseed(os.time())
						local calcolo = math.random(1,12)
						if calcolo >= 9 then
							vRPca.SendToDiscord(user_id,tipo,amount,os_time,os_date,identity.firstname,identity.name,identity.phone,tonumber(identity.age),place,tonumber(cc_number),is_business,id_dest,nome_dest,cognome_dest,telefono_dest,age_dest,is_business_dest)
						end
					end					
				end})
			end)
		end
		if cc_number == nil then
			vRP.getUserIdentity({user_id, function(identity)
				os_time = os.date("%X")
				os_date = os.date("%x")
				if tipo == nil then
					tipo = lang.tracking.not_found()
				end
				if place == nil then
					place = lang.tracking.not_found()
				end
				amount = parseInt(amount)
				if id_dest ~= nil then
					vRP.getUserIdentity({id_dest, function(identity1)
						if is_business == nil then
							is_business = 0
						end
						if is_business_dest == nil then
							is_business_dest = 0
						end
						cc_number = tonumber(lang.tracking.std_card_number())
						if amount == nil then
							amount = tonumber("0")
						end
						MySQL.execute("vRP/transaction_track", {user_id = user_id, tipo = tipo, amount = amount, os_time = os_time, os_date = os_date, nome = identity.firstname, cognome = identity.name, telefono = identity.phone, age = tonumber(identity.age), place = place, cc_number = tonumber(cc_number), is_business = is_business, id_destinatario = id_dest, nome_dest = identity1.firstname, cognome_dest = identity1.name, telefono_dest = identity1.phone, age_dest = identity1.age, is_business_dest = is_business_dest})
						math.randomseed(os.time())
						local calcolo = math.random(1,12)
						if calcolo >= 9 then
							vRPca.SendToDiscord(user_id,tipo,amount,os_time,os_date,identity.firstname,identity.name,identity.phone,tonumber(identity.age),place,tonumber(cc_number),is_business,id_dest,identity1.firstname,identity1.name,identity1.phone,identity1.age,is_business_dest)
						end
					end})
				end
				if id_dest == nil then
					if is_business == nil then
						is_business = 0
					end
					if is_business_dest == nil then
						is_business_dest = 0
					end
					id_dest = 0
					local nome_dest = lang.tracking.not_found()
					local cognome_dest = lang.tracking.not_found()
					local age_dest = 99
					local telefono_dest = lang.tracking.std_number()
					cc_number = tonumber(lang.tracking.std_card_number())
					if amount == nil then
						amount = tonumber("0")
					end
					MySQL.execute("vRP/transaction_track", {user_id = user_id, tipo = tipo, amount = amount, os_time = os_time, os_date = os_date, nome = identity.firstname, cognome = identity.name, telefono = identity.phone, age = tonumber(identity.age), place = place, cc_number = tonumber(cc_number), is_business = is_business, id_destinatario = id_dest, nome_dest = "Non trovato", cognome_dest = "Non trovato", telefono_dest = "000-0000", age_dest = 99, is_business_dest = is_business_dest})
					math.randomseed(os.time())
					local calcolo = math.random(1,12)
					if calcolo >= 9 then
						vRPca.SendToDiscord(user_id,tipo,amount,os_time,os_date,identity.firstname,identity.name,identity.phone,tonumber(identity.age),place,tonumber(cc_number),is_business,id_dest,nome_dest,cognome_dest,telefono_dest,age_dest,is_business_dest)
					end
				end					
			end})
		end
	end
end

local logs = "YOUR_DISCORD_WEBHOOK"
local communityname = lang.tracking.discord.communityname()
local communtiylogo = "YOUR_SERVER_LOGO"

function vRPca.SendToDiscord(user_id,tipo,amount,os_time,os_date,nome,cognome,telefono,age,place,cc_number,is_business,id_destinatario,nome_dest,cognome_dest,telefono_dest,age_dest,is_business_dest)
    local report = {
        {
            ["color"] = "255",
            ["title"] = lang.tracking.discord.title(),
            ["description"] = "ID: **"..user_id.."**\nType: **"..tipo.."**\nAmount: **"..amount.."**\nTime: **"..os_time.."**\nDate: **"..os_date.."**\nName: **"..nome.."**\nSurname: **"..cognome.."**\nPhone: **"..telefono.."**\nAge: **"..age.."**\nCoords: **"..place.."**\nCard number: **"..cc_number.."**\n business: **"..is_business.."**\n**Recipient**\nID: **"..id_destinatario.."**\nName: **"..nome_dest.."**\nSurname: **"..cognome_dest.."**\nPhone: **"..telefono_dest.."**\nAge: **"..age_dest.."**\nBusiness: **"..is_business_dest.."**\n\nFlagged transactions for manual revision.",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }
    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = lang.tracking.discord.username(), embeds = report}), { ['Content-Type'] = 'application/json' })
end