ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_reputation:updateReputation')
AddEventHandler('esx_reputation:updateReputation', function(data)
	local _source		= source
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local rep			= data
	local identifier	= GetPlayerIdentifiers(source)[1]

	if xPlayer ~= nil then
		MySQL.Sync.execute("UPDATE user_reputation SET reputation=@reputation WHERE identifier=@identifier", {
			['@identifier']	= xPlayer.identifier,
			['@reputation']	= rep
		})
	end
end)

RegisterServerEvent('esx_reputation:findReputation')
AddEventHandler('esx_reputation:findReputation', function()
	local _source		= source
	local xPlayer		= ESX.GetPlayerFromId(source)
	local identifier	= GetPlayerIdentifiers(source)[1]
	local defaultRep	= 0

	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM user_reputation WHERE identifier=@identifier', {
			['@identifier']	= xPlayer.identifier,
			['@reputation']	= reputation
		}, function(result)
			if result[1] == nil then
				print('No reputation found for '..identifier..'. Creating Row with value of: '..defaultRep)
				MySQL.Async.execute('INSERT INTO user_reputation (identifier, reputation) VALUES (@identifier, @reputation)', {
					['@identifier']	= xPlayer.identifier,
					['@reputation']	= defaultRep
				})
			else
				local user 	= result[1]
				local rep 	= user['reputation']
				
				print('Loading '..identifier..'\'s Reputation: '..rep)
				TriggerClientEvent('esx_reputation:updateReputation', _source, rep)
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_reputation:getReputation', function(source, cb)
	local _source		= source
	local xPlayer		= ESX.GetPlayerFromId(source)
	local identifier	= GetPlayerIdentifiers(source)[1]

	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM user_reputation WHERE identifier=@identifier', {
			['@identifier']	= xPlayer.identifier,
			['@reputation']	= reputation
		}, function(result)
			local user 	= result[1]
			local rep 	= user['reputation']
			
			cb(rep)
		end)
	end
end)