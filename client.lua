vRPca = {}
Tunnel.bindInterface("vRP_cards",vRPca)
vRPserver = Tunnel.getInterface("vRP","vRP_cards")
NCserver = Tunnel.getInterface("vRP_cards","vRP_cards")
vRP = Proxy.getInterface("vRP")