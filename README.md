# esx_reputation
A simple reputation system for ESX V1 Final

## Requirements
- [oxmysql](https://github.com/overextended/oxmysql/releases)
- [esx-legacy](https://github.com/esx-framework/esx-legacy/releases)

## Installation
- Import `esx_reputation.sql` in your database.
- Add this in your server.cfg after es_extended
```
ensure esx_reputation
```

## How to Use
To add/remove reputation points use the following (client):
```lua
exports['esx_reputation']:AddReputation(job, value)
exports['esx_reputation']:RemoveReputation(job, value)
exports['esx_reputation']:ResetReputation()
exports['esx_reputation']:GetReputation(job)
```

To add/remove reputation points use the following (Server):
```lua
TriggerEvent('esx_reputation:updateReputation', action, job, value) -- possible actions are 'add' and 'remove'
```

Examples:
```lua
-- Adding Reputation
exports['esx_reputation']:AddReputation('taxi', 2)
-- Remove Reputation
exports['esx_reputation']:AddReputation('taxi', 5)
-- Reset Reputation
exports['esx_reputation']:ResetReputation()
-- Get Reputation
local taxirep = exports['esx_reputation']:GetReputation('taxi')
if taxirep > 10 then
    print('madlad. current rep for taxi: '..taxirep)
else
    print('sadboy. current rep for taxi: '..taxirep)
end
```

## Note:
The minimum reputation value is 0 while the maximum reputation is 100.
No need to worry about going over/under the minimum and maximum, when reputation is added or subtracted it will check to make sure it stays above 0 and below 100.
