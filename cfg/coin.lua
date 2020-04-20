local cfg = {}

cfg.open_coins = 0
cfg.open_numero = tonumber(math.random(4000000000000001,4999999999999999))

cfg.pos = {
	{"bank","banca.pos",248.97190856934,224.39764404297,106.28702545166}
}

cfg.display_css = [[
@font-face {
    font-family: Pricedown;
    src: url(fonts/Pdown.woff);
}

.div_money{
  position: absolute;
  top: 42px;
  right: 10px;
  font-size: 42px;
  font-family: Pricedown;
  color: #FFFFFF;
  font-weight: bold;
  text-shadow: rgb(0, 0, 0) 2px 0px 0px, rgb(0, 0, 0) 1.75px 0.966667px 0px, rgb(0, 0, 0) 1.08333px 1.68333px 0px, rgb(0, 0, 0) 0.133333px 2px 0px, rgb(0, 0, 0) -0.833333px 1.81667px 0px, rgb(0, 0, 0) -1.6px 1.2px 0px, rgb(0, 0, 0) -1.98333px 0.283333px 0px, rgb(0, 0, 0) -1.86667px -0.7px 0px, rgb(0, 0, 0) -1.3px -1.51667px 0px, rgb(0, 0, 0) -0.416667px -1.95px 0px, rgb(0, 0, 0) 0.566667px -1.91667px 0px, rgb(0, 0, 0) 1.41667px -1.41667px 0px, rgb(0, 0, 0) 1.91667px -0.566667px 0px; 
}
.div_bmoney{
  position: absolute;
  top: 76px;
  right: 10px;
  font-size: 42px;
  font-family: Pricedown;
  color: #FFFFFF;
  font-weight: bold;
  text-shadow: rgb(0, 0, 0) 2px 0px 0px, rgb(0, 0, 0) 1.75px 0.966667px 0px, rgb(0, 0, 0) 1.08333px 1.68333px 0px, rgb(0, 0, 0) 0.133333px 2px 0px, rgb(0, 0, 0) -0.833333px 1.81667px 0px, rgb(0, 0, 0) -1.6px 1.2px 0px, rgb(0, 0, 0) -1.98333px 0.283333px 0px, rgb(0, 0, 0) -1.86667px -0.7px 0px, rgb(0, 0, 0) -1.3px -1.51667px 0px, rgb(0, 0, 0) -0.416667px -1.95px 0px, rgb(0, 0, 0) 0.566667px -1.91667px 0px, rgb(0, 0, 0) 1.41667px -1.41667px 0px, rgb(0, 0, 0) 1.91667px -0.566667px 0px; 
}
.div_coins{
	position: absolute;
	top: 110px;
	right: 10px;
	font-size: 42px;
	font-family: Pricedown;
    font-weight: bold;
	color: #FFFFFF;
  text-shadow: rgb(0, 0, 0) 2px 0px 0px, rgb(0, 0, 0) 1.75px 0.966667px 0px, rgb(0, 0, 0) 1.08333px 1.68333px 0px, rgb(0, 0, 0) 0.133333px 2px 0px, rgb(0, 0, 0) -0.833333px 1.81667px 0px, rgb(0, 0, 0) -1.6px 1.2px 0px, rgb(0, 0, 0) -1.98333px 0.283333px 0px, rgb(0, 0, 0) -1.86667px -0.7px 0px, rgb(0, 0, 0) -1.3px -1.51667px 0px, rgb(0, 0, 0) -0.416667px -1.95px 0px, rgb(0, 0, 0) 0.566667px -1.91667px 0px, rgb(0, 0, 0) 1.41667px -1.41667px 0px, rgb(0, 0, 0) 1.91667px -0.566667px 0px;
}
  .div_money .symbol{

  content: url('https://i.imgur.com/ffo7E92.png'); 
 
}

.div_bmoney .symbol{
  content: url('https://i.imgur.com/NredYMT.png');
  
}
.div_coins .symbol{
	content: url('https://i.imgur.com/vk1aYCD.png'); 
}
]]

cfg.display_css_red = [[
@font-face {
    font-family: Pricedown;
    src: url(fonts/Pdown.woff);
}

.div_money{
  position: absolute;
  top: 42px;
  right: 10px;
  font-size: 42px;
  font-family: Pricedown;
  color: #FFFFFF;
  font-weight: bold;
  text-shadow: rgb(0, 0, 0) 2px 0px 0px, rgb(0, 0, 0) 1.75px 0.966667px 0px, rgb(0, 0, 0) 1.08333px 1.68333px 0px, rgb(0, 0, 0) 0.133333px 2px 0px, rgb(0, 0, 0) -0.833333px 1.81667px 0px, rgb(0, 0, 0) -1.6px 1.2px 0px, rgb(0, 0, 0) -1.98333px 0.283333px 0px, rgb(0, 0, 0) -1.86667px -0.7px 0px, rgb(0, 0, 0) -1.3px -1.51667px 0px, rgb(0, 0, 0) -0.416667px -1.95px 0px, rgb(0, 0, 0) 0.566667px -1.91667px 0px, rgb(0, 0, 0) 1.41667px -1.41667px 0px, rgb(0, 0, 0) 1.91667px -0.566667px 0px; 
}
.div_bmoney{
  position: absolute;
  top: 76px;
  right: 10px;
  font-size: 42px;
  font-family: Pricedown;
  color: #FF3300;
  font-weight: bold;
  text-shadow: rgb(0, 0, 0) 2px 0px 0px, rgb(0, 0, 0) 1.75px 0.966667px 0px, rgb(0, 0, 0) 1.08333px 1.68333px 0px, rgb(0, 0, 0) 0.133333px 2px 0px, rgb(0, 0, 0) -0.833333px 1.81667px 0px, rgb(0, 0, 0) -1.6px 1.2px 0px, rgb(0, 0, 0) -1.98333px 0.283333px 0px, rgb(0, 0, 0) -1.86667px -0.7px 0px, rgb(0, 0, 0) -1.3px -1.51667px 0px, rgb(0, 0, 0) -0.416667px -1.95px 0px, rgb(0, 0, 0) 0.566667px -1.91667px 0px, rgb(0, 0, 0) 1.41667px -1.41667px 0px, rgb(0, 0, 0) 1.91667px -0.566667px 0px; 
}
.div_coins{
	position: absolute;
	top: 110px;
	right: 10px;
	font-size: 42px;
	font-family: Pricedown;
    font-weight: bold;
	color: #FF3300;
  text-shadow: rgb(0, 0, 0) 2px 0px 0px, rgb(0, 0, 0) 1.75px 0.966667px 0px, rgb(0, 0, 0) 1.08333px 1.68333px 0px, rgb(0, 0, 0) 0.133333px 2px 0px, rgb(0, 0, 0) -0.833333px 1.81667px 0px, rgb(0, 0, 0) -1.6px 1.2px 0px, rgb(0, 0, 0) -1.98333px 0.283333px 0px, rgb(0, 0, 0) -1.86667px -0.7px 0px, rgb(0, 0, 0) -1.3px -1.51667px 0px, rgb(0, 0, 0) -0.416667px -1.95px 0px, rgb(0, 0, 0) 0.566667px -1.91667px 0px, rgb(0, 0, 0) 1.41667px -1.41667px 0px, rgb(0, 0, 0) 1.91667px -0.566667px 0px;
}
  .div_money .symbol{

  content: url('https://i.imgur.com/ffo7E92.png'); 
 
}

.div_bmoney .symbol{
  content: url('https://i.imgur.com/NredYMT.png');
  
}
.div_coins .symbol{
	content: url('https://i.imgur.com/vk1aYCD.png'); 
}
]]

function getCoinConfig()
	return cfg
end

return cfg