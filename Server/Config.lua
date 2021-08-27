Config = {}
Config.EnableESX = false

Config.GuildID = 'Your Server ID'

Config.JobRoles = { -- only ESX.
    ['job1 name'] = {
        BaseRole = 'Base Role id', -- base Role ID
        GradeRoles = {
            ['grade0 name'] = 'Grade role id 1',
            ['grade1 name'] = 'grade role id 2'
        }
    },
    ['job2 name'] = {
        BaseRole = 'Base Role id',
        GradeRoles = {
            ['grade0 name'] = 'grade role id 1',
            ['grade1 name'] = 'grade role id 2'
        }

    }
}

Config.ForceDiscordID = true -- Force Player to have Discord Linked to FIVEM.

Config.RestrictChannelUsage = false
Config.AllowedChannels = {'123123', '123123', '123123'}

Config.AnnounceStarting = false
Config.ChannelToAnnounce = 'Channel ID'
Config.AnnounceMessage = '@everyone Server Is Now Online.'

Config.CustomCommandRestriction = false -- Enable This if you Want Certain Commands to Be Usable By Everyone.
Config.RestrictedCommands = {
    ['kick'] = true,
    ['slay'] = true,
    ['setarmour'] = true,
    ['sethealth'] = true,
    ['giveweapon'] = true,
    ['revive'] = true,
    ['setjob'] = true,
    ['addbank'] = true,
    ['removebank'] = true,
    ['removemoney'] = true,
    ['addmoney'] = true,
    ['notific'] = true,
    ['announce'] = true,
    ['getidentifiers'] = true,
    ['getmoney'] = true,
    ['getloadout'] = true,
    ['spawncar'] = true,
    ['getjob'] = true,
    ['getbank'] = true,
    ['getinventory'] = true
}
Config.AdminRoles = { -- If you Restrict a Command Only Admins Can Use It
    'Admin role 1', 'Admin role 2', 'Admin role 3'
}

Config.EnableRichPresence = true
Config.RichPresenceText = 'playercount / 128' -- Key words : playercount , 
Config.UpdateTick = 25 -- second.

Config.Texts = {
    ['force_discord'] = 'To Play On This Server You Need to Link Your Discord To Your Fivem.',
    ['require_role'] = 'You Cannot Use This Command',
    ['unknown_command'] = 'Command Not Found',
    ['unknown_channel'] = 'You Cannot Use The Bot in This Channel',
    ['command_error'] = 'Command Did Not Return Anything.'
}

Config.HelpCommandText = {
    ['commandname'] = 'help',
    ['commanddescription'] = 'See Current Commands List',
    ['title'] = '** Commands List **',
    ['color'] = 123,
    ['description'] = '** Interact With Server With This Commands : -> **',
    ['thumbnailurl'] = 'https://cdn.discordapp.com/avatars/416968936437841932/45ce0d0badbf554514253b1a1dfdd0c1.png?size=512',
    ['authorname'] = 'Cyber Developments',
    ['authoricon'] = 'https://cdn.discordapp.com/avatars/416968936437841932/45ce0d0badbf554514253b1a1dfdd0c1.png?size=128',
    ['authorurl'] = 'https://cyberwebshop.tebex.io/',
    ['footertext'] = 'By Cyber Developments'
}
