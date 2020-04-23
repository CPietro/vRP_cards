# vRP Bank Cards

## Description
 With this script you can use a debit card (which is an item) to make purchases or pay people. It's even possible to steal another player's card and use it to make buy something on your own, even if the owner is offline. To avoid fraudolent use of the cards you have to approve every transaction with your very own PIN that you can change in the menu. Criminals can also get a bruteforcing machine, that will enable them to gather the code for any card they stole, so be very careful!

 By default there is a blip at the Pacific Standard Bank where players can get a card contract, but it's even possible to set up the bank as a [business](https://github.com/CPietro/vRP_business), then you can roleplay as a bank teller and issue players their card, or even deposit and withdraw cash for them! The script is also complete with a transaction tracking feature, that you can use wherever you want to track where and how everyone spends their money!

 There is even a POS terminal at every vRP market and at every [player owned business](https://github.com/CPietro/vRP_business), so the card will be usable everywhere!

## Pictures
<details><summary>SHOW</summary>
<p>

![Image1](https://i.postimg.cc/k4bg42YH/image.png)\
![Image2](https://i.postimg.cc/15xJ4bX7/image.png)\
![Image3](https://i.postimg.cc/sfJvZhgF/image.png)\
![Image4](https://i.postimg.cc/nhF5cNwb/image.png)
</p>
</details>

## Dependencies
 #### Mandatory
 * [vRP_business](https://github.com/CPietro/vRP_business) - Companies that can be bought by players.
 * [vRP_companyaccs](https://github.com/CPietro/vRP_companyaccs) - Bank accounts for [vRP_business](https://guides.github.com/).
 * [Changes](#changes-to-vrp-mandatory) - Mandatory modifications to vRP.
#### Optionals
 * [vRP_atms]() - ATMs you can withdraw cash with the cards from this script. - COMING SOON
 * [Changes](#changes-to-vrp-optional) - It's possible to have more features and use cases if all of them are installed.

## Installation
1. [IMPORTANT!] Install the dependencies first;
2. Move the [vrp_cards](#vrp-cards) folder to your ```resources``` directory (the folder name must be all lowercase characters);
3. Add "```start vrp_cards```" to your server.cfg file;
4. Make any changes you like to the files in the cfg folder;
5. Enjoy!

## Changes to vRP (mandatory)
* Add the code below at line 38 to your ```vrp\base.lua``` file:
  <details><summary>SHOW</summary>
   
  ```lua    
  vRPca = Proxy.getInterface("vRP_cards")
  ```
  </details>

* Add the ```nowithdraw``` group to your ```vrp\cfg\groups.lua``` file to be able to block players bank accounts and cards:
  <details><summary>SHOW</summary>
  
  ```lua
  ["nowithdraw"] = {
      _config = {
      onspawn = function(player) vRPclient.notify(player,{"~r~Your account is freezed!"}) end
      },
      "no.withdraw"
  },  
  ```
  </details>

* Edit the fine function in your ```vrp\modules\police.lua``` file to sum the balance of the player's card when issuing a fine:
  <details><summary>SHOW</summary>
    
  ```lua 
  local money = vRPca.getCoins({nuser_id})+vRP.getMoney(nuser_id)+vRP.getBankMoney(nuser_id)
  ```
  </details>

## Changes to vRP (optional)
* To be able to crack players' PIN code in order to pay with stolen cards, add to the ```vrp\cfg\item\drugs.lua``` file the code below:
  <details><summary>SHOW</summary>
  <p>

  ```lua 
  local macchinetta_choices = {}
  macchinetta_choices["Use"] = {function(player,choice)
      local user_id = vRP.getUserId(player)
      vRPclient.notify(player,{"~g~Cracking..."})
      vRPca.crackPIN({user_id})
  end}
  ------
  items["macchinettapin"] = {"Bruteforcing machine","An item you can use to obtain the PIN of a stolen card.",function(args) return macchinetta_choices end,3}  
  ``` 
  </p>
  </details>

* To be able to withdraw money using your card from standard vRP ATMs, replace your ```vrp\modules\basic_atm.lua``` file with [this](https://github.com/CPietro/vRP_misc_files/blob/master/basic_atm.lua) one.

* To be able to pay with your card at the markets, replace your ```vrp\modules\basic_market.lua``` file with [this](https://github.com/CPietro/vRP_misc_files/blob/master/basic_market.lua) one.

* Replace the ```vRP.tryFullPayment``` function in the ```vrp\modules\money.lua``` file to include the card balance:
  <details><summary>SHOW</summary>
  <p>

  ```lua
  function vRP.tryFullPayment(user_id,amount)
      local money = vRP.getMoney(user_id)
      if money >= amount then -- enough, simple payment
          return vRP.tryPayment(user_id, amount)
      else  -- not enough, withdraw -> payment
          if vRP.tryWithdraw(user_id, amount-money) then -- withdraw to complete amount
          return vRP.tryPayment(user_id, amount)
          else
          local cardbal = vRPca.getCoins({user_id})
          local bankbal = vRP.getBankMoney(user_id)
          totale = money + cardbal + bankbal
          prelevare = amount - money - bankbal
          if totale >= amount then
              if vRPca.tryCoinPayment({user_id,prelevare}) then
              vRP.giveMoney(user_id,prelevare)
              vRP.tryWithdraw(user_id, bankbal)
              return vRP.tryPayment(user_id, amount)
              end
          end
          end
      end
      return false
  end
  ```
  </p>
  </details>
  
## Instructions
  * To add a new ATM Terminal (there should be one for each business), simply add the code below to the ```cfg.pos``` table in the ```vrp_cards\cfg\coin.lua``` file:
    <details><summary>SHOW</summary>

    ```lua
    {"bank","banca.pos",248.97190856934,224.39764404297,106.28702545166}
    ```
    "bank" -> The internal name of the business;\
    "banca.pos" -> The permission people should have to be able to use the POS Terminal (employees);\
    x,y,z -> Coordinates for the blip;
    </details> 

## License
  ```
  vRP Bank Cards
  Copyright (C) 2020  CPietro - Discord: @TBGaming#9941

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as published
  by the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
  ```
