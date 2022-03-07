RegisterServerEvent('esx_reputation:updateReputation')
AddEventHandler('esx_reputation:updateReputation', function(action, job, amount)
	local _source		= source
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local identifier 	= xPlayer.identifier
	local CharacterName	= xPlayer.getName()


	if xPlayer ~= nil then
		-- Make sure we have a table to update if it doesnt exist
		MySQL.query('SELECT * FROM user_reputation WHERE identifier=@identifier AND job=@job', {
			['@identifier']	= xPlayer.identifier,
			['@job']		= job,
			['@reputation']	= reputation
		}, function(result)
			if result[1] == nil then
				MySQL.update('INSERT INTO user_reputation (identifier, job, reputation) VALUES (@identifier, @job, @reputation)', {
					['@identifier']	= xPlayer.identifier,
					['@job']	= job,
					['@reputation']	= 0
				})
			end
		end)

		-- do actions
		if action == 'add' then
			MySQL.update.await("UPDATE user_reputation SET reputation=reputation + @reputation WHERE identifier=@identifier AND job=@job", {
				['@identifier']	= xPlayer.identifier,
				['@job']		= job,
				['@reputation']	= amount
			}, function (addcomplete)
				if addcomplete then
					print('Added '..amount..' reputation ('..job..') to '..CharacterName..' ('..identifier..')')
				end
			end)
		elseif action == 'remove' then
			MySQL.query('SELECT * FROM user_reputation WHERE identifier=@identifier AND job=@job', {
				['@identifier']	= xPlayer.identifier,
				['@job']		= job
			}, function(currentrep)
				if currentrep ~= nil then
					local newrep	= currentrep + amount
					MySQL.update.await("UPDATE user_reputation SET reputation=@reputation WHERE identifier=@identifier AND job=@job", {
						['@identifier']	= xPlayer.identifier,
						['@job']		= job,
						['@reputation']	= newrep
					}, function (removecomplete)
						if removecomplete then
							print('Removed '..amount..' reputation ('..job..') from '..CharacterName..' ('..identifier..')')
						end
					end)
				end
			end)
		else
			print('Invalid action. Currently supported actions are `add`/`remove`')
		end
	end
end)

RegisterServerEvent('esx_reputation:resetReputation')
AddEventHandler('esx_reputation:resetReputation', function()
	local xPlayer		= ESX.GetPlayerFromId(source)
	local identifier 	= xPlayer.identifier
	local CharacterName	= xPlayer.getName()

	if xPlayer ~= nil then
		MySQL.update('DELETE FROM user_reputation WHERE identifier=@identifier', {
			['@identifier']	= xPlayer.identifier
		}, function(done)
			if done then
				print('Reset reputation for '..identifier..'.')
			else
				print('Error resetting reputation for '..CharacterName..' ('..identifier..')')
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_reputation:getReputation', function(source, cb, job)
	local xPlayer		= ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		MySQL.query('SELECT * FROM user_reputation WHERE identifier=@identifier AND job=@job', {
			['@identifier']	= xPlayer.identifier,
			['@job']		= job,
			['@reputation']	= reputation
		}, function(result)
			if result[1] == nil then
				-- return default reputation, 0
				cb(0)
			else
				local user 	= result[1]
				local rep 	= user['reputation']
			
				cb(rep)
			end
		end)
	end
end)