SHB:ResetSettings() -- refeshes tables so that settengs can be changed on live server

-- board screen space
SHB.setting.width = 0.6 * ScrW()
SHB.setting.length = 0.7 * ScrH()

-- title lines
SHB.setting.title = "Vulcan Network"
SHB:AddLine( "{OSTIME}" , "" , "Map: " .. SHB:GetFormattedMap() )

-- teams
SHB.setting.layout = "teams" -- either 'teams' or 'list'

SHB:AddTeam( 1, false, "Spectate", Color(240,240,240) )
SHB:AddTeam( 2, true )
SHB:AddTeam( 3, true )

-- player
SHB:AddText( "P", function(ply) return ply:Ping() end, 20 ) -- will change to hook
SHB:AddText( "K", function(ply) return ply:Frags() end, 20 )
SHB:AddText( "D", function(ply) return ply:Deaths() end, 20 )
