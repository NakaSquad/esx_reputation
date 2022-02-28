ESX = nil
player = {}
coords = {}

playerReputation = nil

Citizen.CreateThread(function()
    while true do
		player = PlayerPedId()
		coords = GetEntityCoords(player)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if ESX.IsPlayerLoaded() then
			if playerReputation == nil then
				TriggerServerEvent('esx_reputation:findReputation')
			end
		end
	end
end)

RegisterNetEvent('esx_reputation:updateReputation')
AddEventHandler('esx_reputation:updateReputation', function(reputation)
	playerReputation = reputation
	print('Found Reputation: '..playerReputation)
end)

RegisterNetEvent('esx_reputation:addReputation')
AddEventHandler('esx_reputation:addReputation', function(reputation)
	playerReputation = playerReputation + reputation
	if playerReputation < 0 then
		playerReputation = 0
	elseif playerReputation > 100 then
		playerReputation = 100
	end
	print('Player Reputation: '..playerReputation)
	TriggerServerEvent('esx_reputation:updateReputation', playerReputation)
end)

RegisterCommand('checkrep', function()
	print(playerReputation)
end)