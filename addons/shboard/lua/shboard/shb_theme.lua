surface.CreateFont( "SBTitle", {
	font = "Roboto",
	size = 40,
	weight = 800
})
surface.CreateFont( "SBText1", {
	font = "Tahoma",
	size = 22,
	weight = 500
})
surface.CreateFont( "SBText2", {
	font = "Tahoma",
	size = 14,
	weight = 600
})
surface.CreateFont( "SBplyText", {
	font = "Tahoma",
	size = 16,
	weight = 600
})

local title_line_space = 20
local title_space = 50
local basetcolor = Color(240,110,0)
local backgcolor = Color(0,1,2)

function SHB.theme.topspace()
	return (table.Count( SHB.setting.titlelines ) - 1) * title_line_space + title_space
end
function SHB.theme.teamspace()
	return 80
end
function SHB.theme.spaceing()
	return 6
end
function SHB.theme.subteamspace()
	return 130
end

function SHB.theme.DrawBackground( w, h )
	
	local verts = {
		{x=1,y=h-20},
		{x=1,y=1},
		{x=w-1,y=1},
		{x=w-1,y=h-1},
		{x=20,y=h-1},
	}
	
	surface.SetDrawColor(ColorAlpha( backgcolor, 220))
	draw.NoTexture()
	surface.DrawPoly( verts )
	surface.SetDrawColor(ColorAlpha( basetcolor, 180))
	for i = 1,4 do
		surface.DrawLine( verts[i].x,verts[i].y,verts[i+1].x,verts[i+1].y )
		surface.DrawLine( verts[i].x-1,verts[i].y-1,verts[i+1].x-1,verts[i+1].y-1 )
	end
	surface.DrawLine( verts[5].x,verts[5].y,verts[1].x,verts[1].y )
	surface.DrawLine( verts[5].x,verts[5].y-1,verts[1].x,verts[1].y-1 )
	surface.DrawLine( verts[5].x-1,verts[5].y,verts[1].x-1,verts[1].y )
	
end

function SHB.theme.DrawTitle( w, title )

	draw.Text( {
		text = title,
		font = "SBTitle",
		pos = { w/2 + 1, title_space/2 + 2 },
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
		color = Color(0,0,0,200)
	})
	draw.Text( {
		text = title,
		font = "SBTitle",
		pos = { w/2, title_space/2 },
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
		color = Color(230,50,30)
	})
	
end

function SHB.theme.DrawTLines( w, tlines )

	if tlines == {} then return end
	local posy = title_space - title_line_space / 2
	for k, tline in pairs( tlines ) do
		draw.Text( {
			text = SHB:TLineEdit(tline[1]),
			font = "SBText1",
			pos = { SHB.theme.spaceing(), posy },
			yalign = TEXT_ALIGN_CENTER,
			color = basetcolor
		})
		draw.Text( {
			text = SHB:TLineEdit(tline[2]),
			font = "SBText1",
			pos = { w/2, posy },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = basetcolor
		})
		draw.Text( {
			text = SHB:TLineEdit(tline[3]),
			font = "SBText1",
			pos = { w-SHB.theme.spaceing(), posy },
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_CENTER,
			color = basetcolor
		})
		
		posy = posy + title_line_space
	end
	
end

function SHB.theme.DrawMainTeam( w, h, tab, inw )

	surface.SetDrawColor( ColorAlpha( tab.col, 12 ) )
	surface.DrawRect( 0, 0, w, SHB.theme.teamspace() - 20 )
	surface.SetDrawColor( tab.col )
	surface.DrawOutlinedRect( 0, 0, w, SHB.theme.teamspace() - 20 )
	surface.DrawOutlinedRect( 1, 1, w-2, SHB.theme.teamspace() - 22 )
	
	draw.Text( {
		text = tab.name,
		font = "SBText1",
		pos = { SHB.theme.spaceing(), SHB.theme.spaceing() }
	} )
	draw.Text( {
		text = "Players: " .. tab.numply,
		font = "SBplyText",
		yalign = TEXT_ALIGN_BOTTOM,
		pos = { SHB.theme.spaceing(), SHB.theme.teamspace() - 26 }
	} )
	draw.Text( {
		text = team.GetScore( tab.team ),
		font = "SBTitle",
		xalign = TEXT_ALIGN_RIGHT,
		pos = { w-SHB.theme.spaceing(), SHB.theme.spaceing() }
	} )
	
	local posx = inw
	for k, ptext in pairs( SHB.setting.plyRtext ) do
		posx = posx - ptext.width
		draw.Text( {
			text = ptext.title,
			font = "SBText2",
			yalign = TEXT_ALIGN_CENTER,
			xalign = TEXT_ALIGN_CENTER,
			color = tab.col,
			pos = { posx + 2, SHB.theme.teamspace() - 10 }
		} )
	end
	posx = 6
	for k, ptext in pairs( SHB.setting.plyLtext ) do
		draw.Text( {
			text = ptext.title,
			font = "SBText2",
			yalign = TEXT_ALIGN_CENTER,
			color = tab.col,
			pos = { posx, SHB.theme.teamspace() - 10 }
		} )
		posx = posx + ptext.width
	end
	
	surface.SetDrawColor( ColorAlpha( tab.col, 1 ) )
	surface.DrawRect( 0, SHB.theme.teamspace(), w, h-SHB.theme.teamspace() )
	surface.SetDrawColor( tab.col )
	surface.DrawOutlinedRect( 0, SHB.theme.teamspace(), w, h-SHB.theme.teamspace() )
	surface.DrawOutlinedRect( 1, SHB.theme.teamspace()+1, w-2, h-2-SHB.theme.teamspace() )

end

function SHB.theme.DrawSubTeam( w, h, tab )
	
	-- nothing
	
end

function SHB.theme.DrawSTButton( w, h, tab )
	
	if tab.name == "{SPEC}" then
		local textname = "No Spectators"
		if team.NumPlayers(tab.team) > 0 then
			textname = "Spectators: "
		end
		draw.Text( {
			text = textname,
			font = "SBText1",
			color = tab.col,
			yalign = TEXT_ALIGN_CENTER,
			xalign = TEXT_ALIGN_RIGHT,
			pos = { w - 2, h/2 }
		} )
	else
		draw.Text( {
			text = tab.name,
			font = "SBText1",
			color = tab.col,
			yalign = TEXT_ALIGN_CENTER,
			xalign = TEXT_ALIGN_RIGHT,
			pos = { w - 2, h/2 }
		} )
	end
	
end

function SHB.theme.DrawPlayerRight( w, h, tab, alive )

	if tab == {} then return end
	local posx = w
	local tcol = Color(255, 255, 255)
	if alive == false then
		tcol = SHB:GreyCol( tcol )
	end
	for k, textd in pairs( tab ) do
		posx = posx - textd.width
		draw.Text( {
			text = textd.text,
			font = "SBplyText",
			yalign = TEXT_ALIGN_CENTER,
			xalign = TEXT_ALIGN_CENTER,
			color = tcol,
			pos = { posx, h/2 }
		} )
	end
	
end

function SHB.theme.DrawPlayerLeft( w, h, tab, alive )

	if tab == {} then return end
	local posx = 6
	for k, textd in pairs( tab ) do
		local tcol = textd.col
		if alive == false then
			tcol = SHB:GreyCol( tcol )
		end
		draw.Text( {
			text = textd.text,
			font = "SBplyText",
			yalign = TEXT_ALIGN_CENTER,
			color = tcol,
			pos = { posx, h/2 }
		} )
		posx = posx + textd.width
	end

end

function SHB.theme.DrawPlayerOutline( w, h, show, thick )
	
	if show == true then
		if thick == 0 then return end
		for i = 1,thick do
			local offs = i - 1
			surface.SetDrawColor( basetcolor )
			surface.DrawOutlinedRect( offs, offs, w-offs-offs, h-offs-offs )
		end
	end
	
end

function SHB.theme.DrawPlayerSubTeam( w, h, nick, comma )
	
	local disptext = nick
	if comma == true then
		disptext = nick .. ","
	end
	draw.Text( {
		text = disptext,
		font = "SBplyText",
		yalign = TEXT_ALIGN_CENTER,
		color = Color(255, 255, 255),
		pos = { 1, h/2 + 2 }
	} )
	
end

function SHB.theme.GetPlayerTW( nick )
	surface.SetFont("SBplyText")
	local tw,th = surface.GetTextSize(nick)
	return tw
end

function SHB.theme.EditVBar( sbar )
	sbar:SetWidth(12)
	function sbar:Paint(w, h)
		-- nothing
	end
	function sbar.btnUp:Paint(w, h)
		draw.Text( {
			text = "5",
			font = "Marlett",
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(200, 200, 200, 180),
			pos = { w/2, h/2 }
		} )
	end
	function sbar.btnDown:Paint(w, h)
		draw.Text( {
			text = "6",
			font = "Marlett",
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(200, 200, 200, 180),
			pos = { w/2, h/2 }
		} )
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 2, 0, w-5, h, Color(200, 200, 200, 180))
	end
end
