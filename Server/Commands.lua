AddEventHandler('DiscordBot:Ready', function()

    RegisterDiscordCommand('myinfo',
                           'Get Your Info If you are Online in the server',
                           true,
                           function(args, channelid, discordid, roles, ESX)
        if SavedDiscordids[discordid] then
            local src = SavedDiscordids[discordid]
            local xPlayer = ESX.GetPlayerFromId(src)
            if xPlayer then
                local serverid = src
                local job = xPlayer.getJob()
                local jobname = job.label
                local jobgrade = job.grade_label
                local bank = xPlayer.getAccount('bank').money
                return 'Server ID : ' .. serverid .. ' | Job ' .. jobname ..
                           ',Grade : ' .. jobgrade .. ', Bank : ' .. bank
            else
                return 'Something Went Wrong'
            end
        else
            return 'You Are Not In The Server.'
        end
    end)
    RegisterDiscordCommand('playercount', 'Get Current PlayerCount', false,
                           function(args, channelid, discordid, roles)
        return 'Current Player Counts : ' .. GetNumPlayerIndices()
    end)
    RegisterDiscordCommand('kick','Kick A Player', false,
                           function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local name = GetPlayerName(args[2])
            DropPlayer(tonumber(args[2]), "KICKED FROM DISCORD CONSOLE")
            return "Succesfuly Kicked " .. name
        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('slay', 'Slay a Player Ped', false,
                           function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local name = GetPlayerName(args[2])
            TriggerClientEvent('DiscordBot:Kill', args[2])
            return "Succesfuly Killed " .. name
        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('spawncar', 'Spawn a Car For A Player', false,
                           function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil and args[3] then
            local name = GetPlayerName(args[2])
            TriggerClientEvent('DiscordBot:SpawnCar', args[2],args[3])
            return "Succesfuly Executed The Command : SPawnCar "
        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('setarmour', 'Set Armour for A Player', false,
                           function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil and args[3] then
            local armr = tonumber(args[3])
            if armr > 0 and armr < 100 then
                TriggerClientEvent('DiscordBot:SetArmour',args[2], armr)
                return "Succesfuly Executed The Command : SetArmour "
            else
                return 'armor should be between 100 and 0'
            end
        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('sethealth', 'Set health For A Player', false,
                           function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil and args[3] then
            local armr = tonumber(args[3])
            if armr > 0 and armr < 200 then
                TriggerClientEvent('DiscordBot:SetHealth',args[2], armr)
                return "Succesfuly Executed The Command : SetHealth"
            else
                return 'health should be between 200 and 0'
            end
        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('giveweapon', 'Give Weapon to a Player', false,
                           function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil and args[3] then
            local name = GetPlayerName(args[2])
            if args[4] and tonumber(args[4]) then
                TriggerClientEvent('DiscordBot:GiveWeapon',args[2], args[3],
                                   tonumber(args[4]))
                return "Succesfuly Executed The Command : GiveWeapon "
            else
                return 'Please Check your INput'
            end
        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('playerlist', 'DISABLED', false,
                           function(args, channelid, discordid, roles)
        return 'Currently Disabled Due To Discord Limitations.'
    end)
    RegisterDiscordCommand('revive', 'Revive a Player', true,
                           function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local name = GetPlayerName(args[2])
            TriggerClientEvent("esx_ambulancejob:revive", args[2])
            return "Succesfuly Revived " .. name
        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('setjob', 'Set Job for a Player', true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer and args[3] and args[4] and tonumber(args[4]) then
                xPlayer.setJob(args[3], tonumber(args[4]))
                return 'Succesfuly setjob For ' .. xPlayer.getName()
            else
                return 'Invalid Job Or Grade'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('getinventory', 'Get a Player Inventory', true,
                           function(args, channelid, discordid, roles, ESX)
        if GetPlayerName(tonumber(args[2])) then
            local inventory = 'INVENTORY : '
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer and xPlayer.getInventory() then
                for i, v in pairs(xPlayer.getInventory()) do
                    if v.count > 0 then
                        inventory = inventory .. " |ItemName : " .. v.label ..
                                        ",Count : " .. v.count
                    end
                end
                return inventory
            else
                return 'Something Went Wrong'
            end
        else
            return 'invalid Server ID '
        end
    end)
    RegisterDiscordCommand('getloadout', 'Get a Player Loadout', true,
                           function(args, channelid, discordid, roles, ESX)
        if GetPlayerName(tonumber(args[2])) then
            local inventory = 'LoadOut : '
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer and xPlayer.getLoadout() then
                for i, v in pairs(xPlayer.getLoadout()) do

                    inventory = inventory .. " | WeaponName : " .. v.label ..
                                    ",Ammo : " .. v.ammo

                end
                return inventory
            else
                return 'Something Went Wrong'
            end
        else
            return 'invalid Server ID '
        end
    end)

    RegisterDiscordCommand('getjob', 'Get a Player Job', true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer then
                local job = xPlayer.getJob()
                return 'Target JOB : ' .. job.name .. ' | Target Grade : ' ..
                           job.grade_label

            else
                return 'Invalid Job Or Grade'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('getmoney', 'Get a Player Money', true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer then
                local job = xPlayer.getMoney()
                return 'Target Has ' .. job .. '$'

            else
                return 'Invalid Input'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('getbank', 'Get a Player Bank Money', true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer then
                local job = xPlayer.getAccount('bank').money
                return 'Target Has ' .. job .. '$ In Bank'

            else
                return 'Invalid Input'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('removemoney', 'Remove Money From a Player', true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer and args[3] and tonumber(args[3]) then
                xPlayer.removeMoney(tonumber(args[3]))
                return 'Removed Money From ' .. xPlayer.getName()
            else
                return 'Invalid Input'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('addmoney', 'Add Money To a Player', true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer and args[3] and tonumber(args[3]) then
                xPlayer.addMoney(tonumber(args[3]))
                return 'Added Money To ' .. xPlayer.getName()
            else
                return 'Invalid Input'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('addbank', 'Add Bank Money to a Player', true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer and args[3] and tonumber(args[3]) then
                xPlayer.addAccountMoney('bank', tonumber(args[3]))
                return 'Added Bank Money To ' .. xPlayer.getName()
            else
                return 'Invalid Input'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('removebank', 'Remove Bank MOney From a Player',
                           true,
                           function(args, channelid, discordid, roles, ESX)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[2]))
            if xPlayer and args[3] and tonumber(args[3]) then
                xPlayer.removeAccountMoney('bank', tonumber(args[3]))
                return 'Removed Bank Money From ' .. xPlayer.getName()
            else
                return 'Invalid Input'

            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('notific', 'Send Notification to a In Game Player',
                           false, function(args, channelid, discordid, roles)
        if args ~= nil and GetPlayerName(args[2]) ~= nil then
            if args[3] then
                local message = ''
                for i, v in pairs(args) do
                    if i == 1 or i == 2 then

                    else
                        message = message .. ' ' .. v
                    end
                end
                if message and message ~= '' then
                    TriggerClientEvent('chat:addMessage', args[2], {
                        color = {255, 0, 0},
                        multiline = true,
                        args = {"Discord Bot", "^1 " .. message}
                    })
                    return 'Succesfuly sended the Message to ' ..
                               GetPlayerName(args[2])
                else
                    return 'Please Enter A Valid Message'
                end
            else
                return 'Please Enter a Message'
            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('announce', 'Send Announcement to Online Players',
                           false, function(args, channelid, discordid, roles)
        if args ~= nil and args[2] then

            local message = ''
            for i, v in pairs(args) do
                if i == 1 then

                else
                    message = message .. ' ' .. v
                end
            end
            if message and message ~= '' then
                TriggerClientEvent('chat:addMessage', -1, {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"Discord Bot", "^1 " .. message}
                })
                return 'Succesfuly sended the Message to Every Online Player'
            else
                return 'Please Enter A Valid Message'
            end

        else
            return 'Could Not Find An ID. Make Sure To Input Valid ID'
        end
    end)
    RegisterDiscordCommand('getidentifiers', 'Get a player Identifiers', false,
                           function(args, channelid, discordid, roles)
        if args[2] then
            if GetPlayerName(tonumber(args[2])) then
                local identifiers = "Identifiers : "

                for i, v in pairs(GetPlayerIdentifiers(tonumber(args[2]))) do
                    identifiers = identifiers .. " | " .. v
                end

                return identifiers

            else

                return
                    'Please Make Sure You Input Correctly, prefix + getidentifiers + id'
            end
        else
            return
                'Please Make Sure You Input Correctly, prefix + getidentifiers + id'
        end
    end)

end)
