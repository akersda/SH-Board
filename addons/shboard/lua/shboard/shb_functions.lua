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
			name = name or team.GetName( teamn ),
			col = col or team.GetColor( teamn )
		})
	elseif main == false then
		table.insert( SHB.setting.teams.sub, {
			team = teamn,
			name = name or team.GetName( teamn ),
			col = col or team.GetColor( teamn )
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
