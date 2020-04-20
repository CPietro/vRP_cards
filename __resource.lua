description "vrp_cards"
dependency "vrp"

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
	"client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"server/core.lua",
	"server/menus.lua",
	"server/tracking.lua",
	"server/payments.lua",
	"cfg/coin.lua",
	"cfg/lang.lua"
}
files {
    "fonts/Pdown.woff"
}