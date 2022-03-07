RegisterNetEvent('esx_reputation:resetReputation')
AddEventHandler('esx_reputation:resetReputation', function()
	TriggerServerEvent('esx_reputation:resetReputation')
end)

RegisterNetEvent('esx_reputation:updateReputation')
AddEventHandler('esx_reputation:updateReputation', function(action, job, amount)
	TriggerServerEvent('esx_reputation:updateReputation', action, job, amount)
end)

function AddReputation(job, addamount)
	TriggerServerEvent('esx_reputation:updateReputation', 'add', job, addamount)
end
function RemoveReputation(job, remamount)
	TriggerServerEvent('esx_reputation:updateReputation', 'remove', job, remamount)
end
function ResetReputation()
	TriggerServerEvent('esx_reputation:resetReputation')
end

function GetReputation(job)
	local myReputation = nil
	ESX.TriggerServerCallback('esx_reputation:getReputation', function(reputation)
		myReputation = reputation
	end, job)
	while myReputation = nil do
		Wait(1)
	end
	return myReputation
end