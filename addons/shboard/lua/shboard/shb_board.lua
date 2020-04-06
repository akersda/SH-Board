local SHB = GetSHBTable()

local SBOARD = {}

function SBOARD:Init()

	self:MakePopup()
	self:SetKeyBoardInputEnabled( false )
	self:DockPadding( 4, SHB.theme.topspace(), 4, 4 )
	
	for k, teamd in pairs( SHB.setting.teams.sub ) do
		local teambox = vgui.Create("SubTeam",self)
		teambox:AddData(teamd)
		teambox.main = false
	end
	for k, teamd in pairs( SHB.setting.teams.main ) do
		local teambox = vgui.Create("MainTeam",self)
		teambox:AddData(teamd)
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
	local boxwidth = ((SHB.setting.width-8) / table.Count(SHB.setting.teams.main)) - 8*(table.Count(SHB.setting.teams.main)-1)
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
	
	self.data = {}
	
end

function MAIMTEAM:AddData( tab )
	
	self.data = tab
	for k, ply in pairs( team.GetPlayers( self.data.team ) ) do
		local plybar = vgui.Create("PlayerBar",self)
		plybar:SetTall(30)
		plybar:Dock(TOP)
		plybar:SetPlayer(ply)
	end
	
end

function MAIMTEAM:Paint( w, h )

	SHB.theme.DrawMainTeam( w, h )

end

vgui.Register( "MainTeam", MAIMTEAM, "EditablePanel" )


local SUBTEAM = {}

function SUBTEAM:Init()

	self.data = {}

end

function SUBTEAM:AddData( tab )

	self.data = tab
	
end

function SUBTEAM:Paint( w, h )

	SHB.theme.DrawSubTeam( w, h )
	
end

vgui.Register( "SubTeam", SUBTEAM, "EditablePanel" )
