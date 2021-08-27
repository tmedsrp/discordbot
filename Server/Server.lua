Citizen.CreateThread(function()

    Citizen.CreateThread(function() TriggerEvent('DiscordBot:ScriptReady') end)
    Ready = false
    ESX = nil
    if Config.EnableESX then
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj)
                    ESX = obj
                end)
                Citizen.Wait(0)
            end
        end)
    end
    local RegisteredCommands = {}
    local CommandDescriptions = {}
    SavedDiscordids = {}
    AddEventHandler("DiscordBot:NewCommand",
                    function(content, channelid, discordid, prefix, roles)

        local t = mysplit(content, " ")
        local rawcommand = string.gsub(t[math.floor(1)], prefix, "")
        if not RegisteredCommands[rawcommand] or
            type(RegisteredCommands[rawcommand]) ~= 'function' then
            return TriggerEvent('DiscordBot:SendChannelMessage', channelid,
                                '<@' .. discordid .. '> ' .. ' => ' ..
                                    Config.Texts['unknown_command'])

        end
        if Config.RestrictChannelUsage and not IsAuthorizedChannel(channelid) then
            return TriggerEvent('DiscordBot:SendChannelMessage', channelid,
                                '<@' .. discordid .. '> ' .. ' => ' ..
                                    Config.Texts['unknown_channel'])
        end
        if Config.CustomCommandRestriction and
            Config.RestrictedCommands[rawcommand] and
            not IsRolesAuthorized(roles) then
            return TriggerEvent('DiscordBot:SendChannelMessage', channelid,
                                '<@' .. discordid .. '> ' .. ' => ' ..
                                    Config.Texts['require_role'])
        end
        local finalmessage

        if Config.EnableESX then
            finalmessage = RegisteredCommands[rawcommand](t, channelid,
                                                          discordid, roles, ESX)
        else
            finalmessage = RegisteredCommands[rawcommand](t, channelid,
                                                          discordid, roles)
        end

        if finalmessage and finalmessage ~= true then
            return TriggerEvent('DiscordBot:SendChannelMessage', channelid,
                                '<@' .. discordid .. '> ' .. ' => ' ..
                                    finalmessage)
        elseif finalmessage == true then

        else
            return TriggerEvent('DiscordBot:SendChannelMessage', channelid,
                                '<@' .. discordid .. '> ' .. ' => ' ..
                                    Config.Texts['command_error'])
        end
    end)

    AddEventHandler('DiscordBot:Ready', function()
        Ready = true
        if Config.AnnounceStarting then
            TriggerEvent('DiscordBot:SendChannelMessage',
                         Config.ChannelToAnnounce, Config.AnnounceMessage)
        end
    end)

    IsAuthorizedChannel = function(channelid)
        local rtn = false
        if not channelid then return false end
        for _, v in pairs(Config.AllowedChannels) do
            if v == channelid then rtn = true end
        end
        return rtn
    end
    IsRolesAuthorized = function(roles)

        local rtn = false
        if not roles or type(roles) ~= 'table' then return false end
        for _, v in pairs(Config.AdminRoles) do
            for targeti, targetv in pairs(roles) do
                if targeti == v or targetv == v then
                    rtn = true
                    break
                end
            end
        end

        return rtn

    end

    function mysplit(inputstr, sep)
        if sep == nil then sep = "%s" end
        local t = {}
        for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
            table.insert(t, str)
        end
        return t
    end

    if Config.EnableESX then
        AddEventHandler('esx:setJob', function(target, newjob, lastjob)
            print('hi')
            local discordid = GetPlayerDiscordId(target)
            local lastjobrole = Config.JobRoles[lastjob.name]
            if not discordid then return end
            if lastjobrole then
                TriggerEvent('DiscordBot:RemoveRole', Config.GuildID, discordid,
                             lastjobrole.BaseRole)
            end
            if lastjobrole and lastjobrole.GradeRoles[lastjob.grade_name] then
                TriggerEvent('DiscordBot:RemoveRole', Config.GuildID, discordid,
                             lastjobrole.GradeRoles[lastjob.grade_name])
            end
            local newjobrole = Config.JobRoles[newjob.name]
            if newjobrole then
                TriggerEvent('DiscordBot:AddRole', Config.GuildID, discordid,
                             newjobrole.BaseRole)
            end
            if newjobrole and newjobrole.GradeRoles[newjob.grade_name] then
                TriggerEvent('DiscordBot:AddRole', Config.GuildID, discordid,
                             newjobrole.GradeRoles[newjob.grade_name])
            end

        end)
    end
    if Config.ForceDiscordID then
        AddEventHandler('playerConnecting',
                        function(name, setKickReason, deferrals)
            local player = source
            local discordid
            local identifiers = GetPlayerIdentifiers(player)
            for _, v in pairs(identifiers) do
                if string.find(v, "discord") then
                    discordid = v
                    break
                end
            end
            if not discordid then
                CancelEvent()
                setKickReason(Config.Texts['force_discord'])
            end
        end)
    end

    RegisterNetEvent('playerJoining')
    AddEventHandler('playerJoining', function()

        local src = source
        local identifier = GetPlayerDiscordId(src)
        if identifier then SavedDiscordids[identifier] = src end
    end)

    AddEventHandler('playerDropped', function()
        local src = source
        local identifier = GetPlayerDiscordId(src)
        if identifier then SavedDiscordids[identifier] = nil end
    end)

    GetPlayerDiscordId = function(src)
        local discordid
        local identifiers = GetPlayerIdentifiers(src)
        for _, v in pairs(identifiers) do
            if string.find(v, "discord") then
                discordid = string.gsub(v, 'discord:', "")
                break
            end
        end
        return discordid
    end

    RegisterDiscordCommand = function(command, description, esx, callback)

        if esx and not Config.EnableESX then return end
        if RegisteredCommands[command] then
            print('Overwritting ' .. command)
        end
        if type(callback) == 'function' then
            RegisteredCommands[command] = callback
            CommandDescriptions[command] = description
        end

    end

    if Config.EnableRichPresence then
        Citizen.CreateThread(function()
            while not Ready do Wait(0) end
            while true do
                local rawrpc = Config.RichPresenceText
                local playercounts = tostring(GetNumPlayerIndices())
                local rpc = string.gsub(rawrpc, 'playercount', playercounts)
                TriggerEvent('DiscordBot:UpdatePresence', rpc)
                Wait(Config.UpdateTick * math.floor(1000))

            end
        end)
    end
    RegisterDiscordCommand(Config.HelpCommandText.commandname,
                           Config.HelpCommandText.commanddescription, false,
                           function(args, channelid, discordid, roles)

        local fields = {}

        for i, _ in pairs(RegisteredCommands) do
            local desc = CommandDescriptions[i]
            if not desc then desc = 'Description Unknown' end
            if Config.RestrictedCommands[i] and Config.CustomCommandRestriction then
                if IsRolesAuthorized(roles) then
                    table.insert(fields, {name = i, value = desc, inline = true})

                end
            else
                table.insert(fields, {name = i, value = desc, inline = true})
            end
        end
        TriggerEvent('DiscordBot:SendEmbed', channelid, {

            color = Config.HelpCommandText.color,
            title = Config.HelpCommandText.title,
            description = Config.HelpCommandText.description,
            thumbnail = {url = Config.HelpCommandText.thumbnailurl},
            author = {
                name = Config.HelpCommandText.authorname,
                icon_url = Config.HelpCommandText.authoricon,
                url = Config.HelpCommandText.authorurl
            },
            footer = {text = Config.HelpCommandText.footertext},
            fields = fields
        })
        return true
    end)

end)

