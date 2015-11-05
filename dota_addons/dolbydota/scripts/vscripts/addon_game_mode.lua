--[[
Dota PvP game mode
]]
--require ("winapi")

print( "Dota PvP game mode loaded." )

if DotaPvP == nil then
	DotaPvP = class({})
end

--------------------------------------------------------------------------------
-- ACTIVATE
--------------------------------------------------------------------------------
function Activate()
    print("what")
	GameRules.DotaPvP = DotaPvP()
    GameRules.DotaPvP:InitGameMode()
end

--------------------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------------------
function DotaPvP:InitGameMode()
	print("what")
	local GameMode = GameRules:GetGameModeEntity()

	-- Enable the standard Dota PvP game rules
	GameRules:GetGameModeEntity():SetTowerBackdoorProtectionEnabled( true )

	
	self.ent = Entities:First()
	-- winapi.server(function(file)
			-- file:read_async(function(s)
				-- print('['..s..']')
			-- end)
		-- end)

	
	
	
	-- Register Think
	GameMode:SetContextThink( "DotaPvP:GameThink", function() return self:GameThink() end, 5 )

	-- Register Game Events
end

--------------------------------------------------------------------------------
function DotaPvP:GameThink()	
	local data_to_send = "none"
	for key,value in pairs(Entities:FindAllByName("npc_dota_hero_abaddon")) do 
		print(key,value) 
		print(value:GetCenter())
		data_to_send = string.format("abaddon: %d, %d", value:GetCenter().x, value:GetCenter().y)
	end
	local file = assert(io.open("\\dota_dolby", "w"))	
	print("to file:", data_to_send)
	file:write(data_to_send)
	file:write("\r\n\r\n")
	file:flush()
	file:close()	
	
	--local location = CBaseEntity.GetCenter()
	--print("is it working? : ", location)
	return 5
end