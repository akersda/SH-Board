SHB = {}

if SERVER then
	
	AddCSLuaFile( "shboard/shb_init.lua" )
	AddCSLuaFile( "shboard/shb_theme.lua" )
	AddCSLuaFile( "shboard/shb_functions.lua" )
	AddCSLuaFile( "shboard/shb_actions.lua" )
	AddCSLuaFile( "shboard/shb_board.lua" )
	AddCSLuaFile( "shboard/shb_player.lua" )
	AddCSLuaFile( "shboard/shb_settings.lua" )
	
else
	
	include( "shboard/shb_init.lua" )
	
end
