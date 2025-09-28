ESX = exports['es_extended']:getSharedObject()

function GetActivePoliceCount()
    local count = 0

    for _, job in pairs(Config.PoliceJobs) do
        local jobCount = ESX.GetExtendedPlayers('job', job)

        count = count + #jobCount
    end
    
    return count
end

RegisterCommand('pdcount', function(source, args, rawCommand)
    local policeCount = GetActivePoliceCount()
    
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'PD Count',
        description = string.format('Momentálně je na serveru **%d** aktivních ozbrojených složek', policeCount),
        duration = 7000
    })
end, false)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        while not GetResourceState('chat') == 'started' do
            Wait(100)
        end
        
        TriggerEvent('chat:addSuggestion', '/pdcount', 'Zobrazí počet aktivních ozbrojených složek', {})
    end
end)