local SBOARD = {}

function SBOARD:Init()

	self:MakePopup()
	self:SetKeyBoardInputEnabled( false )
	self:DockPadding( 4, SHB.theme.topspace(), 4, 4 )
	
	for k, teamd in pairs( SHB.setting.teams.sub ) do
		local teambox = vgui.Create("SubTeam",self)
		teambox.data = teamd
		teambox.main = false
	end
	if SHB.setting.layout == "teams" then
		for k, teamd in pairs( SHB.setting.teams.main ) do
			local teambox = vgui.Create("MainTeam",self)
			teambox.data = teamd
			teambox.main = true
		end
	else
		local teambox = vgui.Create("MainTeam",self)
		teambox.data = {}
		teambox.main = true
	end
	self:InvalidateLayout()

end

function SBOARD:Paint( w, h )

	SHB.theme.DrawBackground( w, h )
	SHB.theme.DrawTitle( w, SHB.setting.title )
	SHB.theme.DrawTLines( w, SHB.setting.titlelines )

end

function SBOARD:PerformLayout( w, h )
	
	self:SetSize( SHB.setting.width, SHB.setting.length )
	self:Center()
	local boxwidth = SHB.setting.width-8
	if SHB.setting.layout == "teams" then
		local boxwidth = ((SHB.setting.width-8) / table.Count(SHB.setting.teams.main)) - 8*(table.Count(SHB.setting.teams.main)-1)
	end
	for k, teambox in pairs( self:GetChildren() ) do
		if teambox.main == false then
			teambox:SetTall(60)
			teambox:DockMargin(4,4,4,4)
			teambox:Dock(BOTTOM)
		end
	end
	for k, teambox in pairs( self:GetChildren() ) do
		if teambox.main then
			teambox:SetWide(boxwidth)
			teambox:DockMargin(4,4,4,4)
			teambox:Dock(LEFT)
		end
	end
	
end

vgui.Register( "SHBoard", SBOARD, "EditablePanel" )


local MAIMTEAM = {}

function MAIMTEAM:Init()

end

function MAIMTEAM:Paint( w, h )

	SHB.theme.DrawMainTeam( w, h )

end

vgui.Register( "MainTeam", MAIMTEAM, "EditablePanel" )


local SUBTEAM = {}

function SUBTEAM:Init()

end

function SUBTEAM:Paint( w, h )

	SHB.theme.DrawSubTeam( w, h )
	
end

vgui.Register( "SubTeam", SUBTEAM, "EditablePanel" )
