local SHB = GetSHBTable()

SHB:ResetSettings() -- refeshes tables

-- board screen space
SHB.setting.width = 0.6 * ScrW()
SHB.setting.length = 0.7 * ScrH()

-- title lines
SHB.setting.title = "TITLE"
-- function SHB:AddLine( left text, middle text, right text ) adds a line in the title space
SHB:AddLine( "Map: " .. SHB:GetFormattedMap(), "" , function() return os.date( "%H:%M:%S" , os.time()) end )

-- teams
-- function SHB:AddTeam( team, main/sub, name override, colour override ) adds a team to the main board (or under if false)
-- function SHB:AddTeam( {team,team,team....} ) adds a multi team, note each 'team' in this table is a table of {team, name override, colour override}
SHB:AddTeam( 1, false, "{SPEC}", Color(240,240,240) )
SHB:AddTeam( 2, true )
SHB:AddTeam( 3, true )

SHB.setting.jointeam = function( teamnum ) -- click on the title box of that team
	LocalPlayer():ConCommand( "jointeam " .. teamnum )
end

-- player
-- function SHB:AddRText( title, player text, box width ) adds player text to the right
SHB:AddRText( "P", function(ply) return ply:Ping() end, 20 )
SHB:AddRText( "D", function(ply) return ply:Deaths() end, 30 )
SHB:AddRText( "K", function(ply) return ply:Frags() end, 30 )

-- function SHB:AddLText( title, {player text,colour}, box width ) adds player text to the left
SHB:AddLText( "", "AVATAR", 34 )
SHB:AddLText( "Rank", function(ply) return {ply:GetUserGroup(),nil} end, 70 )
SHB:AddLText( "Player", function(ply) return {ply:Nick(),nil} end, 40 )
