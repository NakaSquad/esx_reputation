# esx_reputation
A simple reputation system for ESX V1 Final

## Requirements
- [mysql-async](https://github.com/brouznouf/fivem-mysql-async)

## Installation
- Import `esx_reputation.sql` in your database.
- Add this in your server.cfg
```
ensure esx_reputation
```

## How to Use
When players load into the server esx_reputation will check for an existing reputation. If no reputation is found one will be made.

To add/remove reputation points use the following (Client):
```lua
TriggerEvent('esx_reputation:addReputation', value)
```

To add/remove reputation points use the following (Server):
```lua
TriggerClientEvent('esx_reputation:addReputation', source, value)
```

To check for players reputation use the following:
```lua
ESX.TriggerServerCallback('esx_reputation:getReputation', function(reputation)
    -- Insert Code Here --
end)
```

Here is an example how it can be used:
```lua
ESX.TriggerServerCallback('esx_reputation:getReputation', function(reputation)
    local playerReputation = reputation

    if playerReputation >= 70 then   -- If the player's reputation is greater than or equal to 70, do the following
        print('You passed the test!')
    else
        print('You failed the test!')
    end
end)
```

## Note:
The minimum reputation value is 0 while the maximum reputation is 100.
No need to worry about going over/under the minimum and maximum, when reputation is added or subtracted it will check to make sure it stays above 0 and below 100.
