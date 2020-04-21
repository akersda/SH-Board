local SHB = GetSHBTable()

SHB:ResetSettings() -- refeshes tables so that settings can be changed on live server

-- board screen space
SHB.setting.width = 0.6 * ScrW()
SHB.setting.length = 0.7 * ScrH()

-- title lines
SHB.setting.title = "TITLE"
SHB:AddLine( "Map: " .. SHB:GetFormattedMap(), "" , function() return os.date( "%H:%M:%S" , os.time()) end )

-- teams
SHB:AddTeam( 1, false, "{SPEC}", Color(240,240,240) )
SHB:AddTeam( 2, true )
SHB:AddTeam( 3, true )

SHB.setting.jointeam = function( teamnum )
	LocalPlayer():ConCommand( "jointeam " .. teamnum )
end

-- player
SHB:AddRText( "P", function(ply) return ply:Ping() end, 20 )
SHB:AddRText( "D", function(ply) return ply:Deaths() end, 30 )
SHB:AddRText( "K", function(ply) return ply:Frags() end, 30 )

SHB:AddLText( "", "AVATAR", 34 )
SHB:AddLText( "Rank", function(ply) return {ply:GetUserGroup(),nil} end, 70 )
SHB:AddLText( "Player", function(ply) return {ply:Nick(),nil} end, 40 )
