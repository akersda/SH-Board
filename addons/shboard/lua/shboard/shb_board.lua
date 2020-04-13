local SHB = GetSHBTable()

local SBOARD = {}

function SBOARD:Init()

	self:MakePopup()
	self:SetKeyBoardInputEnabled( false )
	self.spacing = SHB.theme.spaceing()
	self:DockPadding( self.spacing, SHB.theme.topspace(), self.spacing, self.spacing )
	
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
	local boxwidth = ((SHB.setting.width-self.spacing*2) / table.Count(SHB.setting.teams.main)) - self.spacing*(table.Count(SHB.setting.teams.main)-1)
	local tspace = self.spacing/2
	for k, teambox in pairs( self:GetChildren() ) do
		if teambox.main == false then
			teambox:SetTall(50)
			teambox:DockMargin(tspace,tspace,tspace,tspace)
			teambox:Dock(BOTTOM)
		end
	end
	for k, teambox in pairs( self:GetChildren() ) do
		if teambox.main then
			teambox:SetWide(boxwidth)
			teambox:DockMargin(tspace,tspace,tspace,tspace)
			teambox:Dock(LEFT)
		end
	end
	
end

vgui.Register( "SHBoard", SBOARD, "EditablePanel" )


local MAIMTEAM = {}

function MAIMTEAM:Init()
	
	self.data = {}
	self.timer = 0
	self.data.numply = "none"
	
	self:DockPadding( 0, SHB.theme.teamspace(), 0, 0 )
	
	self.scroller = vgui.Create("DScrollPanel",self)
	self.scroller:DockMargin(2,2,2,2)
	self.scroller:Dock(FILL)
	SHB.theme.EditVBar( self.scroller:GetVBar() )
	
	
end

function MAIMTEAM:AddData( tab )
	
	self.data = tab
	
	self.joinbut = vgui.Create("DButton",self)
	self.joinbut:SetText("")
	self.joinbut:SetPos(2,2)
	self.joinbut:SetSize(10, 10)
	function self.joinbut:Paint()
		-- nothing
	end
	function self.joinbut:DoClick()
		SHB.setting.jointeam( tab.team )
	end
	
end

function MAIMTEAM:PerformLayout( w, h )
	self.joinbut:SetSize(w-4, SHB.theme.teamspace()-24)
end

function MAIMTEAM:Paint( w, h )

	SHB.theme.DrawMainTeam( w, h, self.data, self.scroller:InnerWidth() )

end

function MAIMTEAM:Think()
	
	if !self.data.team then return end
	if self.timer < CurTime() then
		self.data.numply = SHB:GetNPAlive( self.data.team ) .. "/" .. team.NumPlayers( self.data.team )
		
		for k, ply in pairs( team.GetPlayers( self.data.team ) ) do
			local haspnl = false
			for kk, pnl in pairs( self.scroller:GetCanvas():GetChildren() ) do
				if pnl.data.player == ply then
					haspnl = true
				end
			end
			if haspnl == false then
				local plybar = vgui.Create("PlayerBar",self.scroller)
				plybar:SetTall(38)
				plybar:Dock(TOP)
				plybar:SetPlayer(ply)
			end
		end
		
		self.timer = CurTime() + 1
	end
	
end

vgui.Register( "MainTeam", MAIMTEAM, "EditablePanel" )


local SUBTEAM = {}

function SUBTEAM:Init()

	self.data = {}
	
	self.timer = 0

end

function SUBTEAM:AddData( tab )

	self.data = tab
	
	self.joinbut = vgui.Create("DButton",self)
	self.joinbut.data = {}
	self.joinbut.data.player = "joinbutton"
	self.joinbut:SetText("")
	self.joinbut:SetWidth( SHB.theme.subteamspace() )
	self.joinbut:Dock(LEFT)
	function self.joinbut:Paint( w, h )
		SHB.theme.DrawSTButton( w, h, tab )
	end
	function self.joinbut:DoClick()
		SHB.setting.jointeam( tab.team )
	end
	
end

function SUBTEAM:Paint( w, h )

	SHB.theme.DrawSubTeam( w, h, self.data )
	
end

function SUBTEAM:Think()
	
	if !self.data.team then return end
	if self.timer < CurTime() then
		for k, ply in pairs( team.GetPlayers( self.data.team ) ) do
			local haspnl = false
			for kk, pnl in pairs( self:GetChildren() ) do
				if pnl.data.player == ply then
					haspnl = true
				end
			end
			if haspnl == false then
				for kk, pnl in pairs( self:GetChildren() ) do
					pnl.data.comma = true
				end
				local plybar = vgui.Create("SubPlayerBar",self)
				plybar:SetPlayer(ply)
			end
		end
		
		self.timer = CurTime() + 1
	end
	
end

vgui.Register( "SubTeam", SUBTEAM, "EditablePanel" )
