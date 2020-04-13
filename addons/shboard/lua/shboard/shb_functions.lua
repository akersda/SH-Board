local SHB = GetSHBTable()

-- map name edit
function SHB:GetFormattedMap()
	local ttab = string.Explode("_",game.GetMap())
	return table.concat( ttab, " ", 2 )
end

-- get alive memebers on a team
function SHB:GetAliveTeam( teamn )
	local players = team.GetPlayers( teamn )
	palive = 0
	for k,ply in pairs( players ) do
		if ply:Alive() then
			palive = palive + 1
		end
	end
	return palive
end

-- add teams
function SHB:AddTeam( teamn, main, name, col )
	if teamn == nil then 
		print("SBoard: Settings error: AddTeam must have team number.")
		return
	end
	if main == nil or main == true then
		table.insert( SHB.setting.teams.main, {
			team = teamn,
			name = name or "none",
			col = col or "none"
		})
	elseif main == false then
		table.insert( SHB.setting.teams.sub, {
			team = teamn,
			name = name or "none",
			col = col or "none"
		})
	end
end

-- add title lines
function SHB:AddLine( ltext, midtext, rtext )
	table.insert( SHB.setting.titlelines, { ltext, midtext, rtext } )
end

-- title line edits
function SHB:TLineEdit( text )
	if text == nil then return "" end
	if isfunction(text) then return text() end
	return text
end

-- add player text
function SHB:AddRText( title, ptext, width )
	table.insert( SHB.setting.plyRtext, {title = title, func = ptext, width = width} )
end

function SHB:AddLText( title, ptext, width )
	table.insert( SHB.setting.plyLtext, {title = title, func = ptext, width = width} )
end

-- get alive team number
function SHB:GetNPAlive( teamn )
	local atnum = 0
	for k, ply in pairs(team.GetPlayers( teamn )) do
		if ply:Alive() then
			atnum = atnum + 1
		end
	end
	return atnum
end

-- grey scale colour
function SHB:GreyCol( col )
	return Color( col.r*0.7, col.g*0.7, col.b*0.7, col.a )
end

-- get board status
function SHB:IsOpen()
	if !IsValid( SHB.board ) or SHB.board == {} then
		return false
	else
		return true
	end
end

-- open board
function SHB:Open()

	for k, teams in pairs( SHB.setting.teams.main ) do
		if teams.name == "none" then
			SHB.setting.teams.main[k].name = team.GetName( teams.team ) or "unknown"
		end
		if teams.col == "none" then
			SHB.setting.teams.main[k].col = team.GetColor( teams.team ) or "unknown"
		end
	end
	for k, teams in pairs( SHB.setting.teams.sub ) do
		if teams.name == "none" then
			SHB.setting.teams.sub[k].name = team.GetName( teams.team ) or "unknown"
		end
		if teams.col == "none" then
			SHB.setting.teams.sub[k].col = team.GetColor( teams.team ) or "unknown"
		end
	end

	SHB.board = vgui.Create("SHBoard")
	
end

-- close board
function SHB:Close()
	SHB.board:Remove()
end

-- reset settings
function SHB:ResetSettings()
	SHB.setting = {}
	SHB.setting.titlelines = {}
	SHB.setting.teams = {}
	SHB.setting.teams.main = {}
	SHB.setting.teams.sub = {}
	SHB.setting.plyRtext = {}
	SHB.setting.plyLtext = {}
end
