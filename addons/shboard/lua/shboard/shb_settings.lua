local SHB = GetSHBTable()

SHB:ResetSettings() -- refeshes tables so that settengs can be changed on live server

-- board screen space
SHB.setting.width = 0.6 * ScrW()
SHB.setting.length = 0.7 * ScrH()

-- title lines
SHB.setting.title = "Vulcan Network"
SHB:AddLine( function() return os.date( "%H:%M:%S" , os.time()) end , "" , "Map: " .. SHB:GetFormattedMap() )

-- teams
SHB:AddTeam( 1, false, "Spectate", Color(240,240,240) )
SHB:AddTeam( 2, true )
SHB:AddTeam( 3, true )

-- player
SHB:AddRText( "P", function(ply) return ply:Ping() end, 20 )
SHB:AddRText( "K", function(ply) return ply:Frags() end, 20 )
SHB:AddRText( "D", function(ply) return ply:Deaths() end, 20 )
SHB:AddRText( "pos", function(ply) return math.Round(ply:GetPos().x) end, 40 )
