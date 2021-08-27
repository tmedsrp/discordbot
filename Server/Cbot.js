const { Client, Guild, GuildEmojiStore, MessageEmbed } = require("discord.js");
const client = new Client();
global.config = require("./Server/BotConfig.json");
// Discord events
client.on("ready", () => {
  emit("DiscordBot:Ready");
  console.log("\n ^3Discord Bot Is Now Online");
});

client.on("message", (message) => {
  if (!message.guild) return;
  if (message.author.bot) return;

  if (message.content.startsWith(config.prefix)) {
    let playerroles = [];
    let temproles = message.guild.member(message.author.id).roles;
    temproles.map((at, id) => {
      playerroles.push(id);
    });
    emit(
      "DiscordBot:NewCommand",
      message.content,
      message.channel.id,
      message.author.id,
      config.prefix,
      playerroles
    );
  }
});

// Server Events

on("DiscordBot:UpdatePresence", (text) => {
  client.user.setPresence({
    activity: { name: text, type: "WATCHING" },
    status: "online",
  });
});
on("DiscordBot:SendChannelMessage", (channel, text) => {
  if (channel) {
    let targetchanel = client.channels.get(channel);
    if (targetchanel) {
      targetchanel.send(text);
    }
  }
});
on("DiscordBot:SendEmbed", (channel, cosembed) => {
  if (channel) {
    let targetchanel = client.channels.get(channel);
    if (targetchanel) {
      targetchanel.send({ embed: cosembed });
    }
  }
});

on("DiscordBot:AddRole", (guild, discordid, roleid) => {
  let targetguild = client.guilds.get(guild);
  if (targetguild) {
    let target = targetguild.member(discordid);
    if (target) {
      let myRole = targetguild.roles.get(roleid);

      if (myRole) {
        target.roles.add(roleid);
      }
    }
  }
});
on("DiscordBot:RemoveRole", (guild, discordid, roleid) => {
  let targetguild = client.guilds.get(guild);
  if (targetguild) {
    let myRole = targetguild.roles.get(roleid);
    if (myRole) {
      let target = targetguild.member(discordid);
      if (target) {
        if (target.roles.has(roleid)) {
          target.roles.remove(roleid);
        }
      }
    }
  }
});
on('DiscordBot:ScriptReady', () => {

  client.login(config.token);
  
});


