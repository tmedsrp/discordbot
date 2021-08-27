RegisterNetEvent("DiscordBot:Kill")
AddEventHandler("DiscordBot:Kill", function()
   
   SetEntityHealth(PlayerPedId(), 0)
   
end)
RegisterNetEvent("DiscordBot:SpawnCar")
AddEventHandler("DiscordBot:SpawnCar", function(model)
  local hash = GetHashKey(model) 
  if not IsModelAVehicle(hash) then
   return
  end
  RequestModel(hash)
  while not HasModelLoaded(hash) do
   RequestModel(hash)
   Wait(100)
  end
  local coords = GetEntityCoords(PlayerPedId())
  CreateVehicle(hash, coords.x,coords.y,coords.z,GetEntityHeading(PlayerPedId()),true,false)
   
end)

RegisterNetEvent("DiscordBot:GiveWeapon")
AddEventHandler("DiscordBot:GiveWeapon", function(model,ammo)
  local hash = GetHashKey(model) 
  GiveWeaponToPed(PlayerPedId(), hash,tonumber(ammo),false,true)
   
end)
RegisterNetEvent("DiscordBot:SetArmour")
AddEventHandler("DiscordBot:SetArmour", function(amount)
  if tonumber(amount) < 0 and tonumber(amount) > 101 then
   return
  end
  SetPedArmour(PlayerPedId(),tonumber(amount))
end)
RegisterNetEvent("DiscordBot:SetHealth")
AddEventHandler("DiscordBot:SetHealth", function(amount)
  SetEntityHealth(PlayerPedId(),amount)
end)






