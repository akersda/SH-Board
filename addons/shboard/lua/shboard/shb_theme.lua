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

local title_line_space = 20
local title_space = 50
function SHB.theme.topspace()
	return (table.Count( SHB.setting.titlelines ) - 1) * title_line_space + title_space
end

function SHB.theme.DrawBackground( w, h )
	
	local verts = {
		{x=1,y=h-20},
		{x=1,y=1},
		{x=w-1,y=1},
		{x=w-1,y=h-1},
		{x=20,y=h-1},
	}
	
	surface.SetDrawColor(Color(0,1,2,220))
	draw.NoTexture()
	surface.DrawPoly( verts )
	surface.SetDrawColor(Color(240,90,0,180))
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
		color = Color(230,30,30)
	})
	
end

function SHB.theme.DrawTLines( w, tlines )

	if tlines == {} then return end
	local posy = title_space - title_line_space / 2
	for k, tline in pairs( tlines ) do
		draw.Text( {
			text = SHB:TLineEdit(tline[1]),
			font = "SBText1",
			pos = { 6, posy },
			yalign = TEXT_ALIGN_CENTER,
			color = Color(255,255,255)
		})
		draw.Text( {
			text = SHB:TLineEdit(tline[2]),
			font = "SBText1",
			pos = { w/2, posy },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(255,255,255)
		})
		draw.Text( {
			text = SHB:TLineEdit(tline[3]),
			font = "SBText1",
			pos = { w-6, posy },
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(255,255,255)
		})
		
		posy = posy + title_line_space
	end
	
end

function SHB.theme.DrawMainTeam( w, h )
	
				surface.SetDrawColor( Color(0,255,255) )
				surface.DrawOutlinedRect( 0, 0, w, h )
end

function SHB.theme.DrawSubTeam( w, h )
	
				surface.SetDrawColor( Color(0,255,255) )
				surface.DrawOutlinedRect( 0, 0, w, h )
end
