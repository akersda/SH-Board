local SHB = GetSHBTable()

local PLAYERBAR = {}

function PLAYERBAR:Init()
	
	self.data = {}
	self.time = 0
	self:SetText("")
	self.OLshow = false
	self.OLthick = 0
	self.counter = 20
	
end

function PLAYERBAR:SetPlayer(ply)
	
	self.data.player = ply
	self.data.rtext = {}
	self.data.ltext = {}
	for k, ptext in pairs( SHB.setting.plyRtext ) do
		table.insert( self.data.rtext, {width = ptext.width, text="nil"} )
	end
	for k, ptext in pairs( SHB.setting.plyLtext ) do
		table.insert( self.data.ltext, {width = ptext.width, text="nil", col = Color(255,255,255)} )
	end
	self.data.team = ply:Team()
	
end

function PLAYERBAR:Paint( w, h )
	
	SHB.theme.DrawPlayerLeft( w, h, self.data.ltext, self.data.alive )
	SHB.theme.DrawPlayerRight( w, h, self.data.rtext, self.data.alive )
	SHB.theme.DrawPlayerOutline( w, h, self.OLshow, self.OLthick )
	
end

function PLAYERBAR:DoClick()
	
	SHB:actionpopup( self.data.player )
	
end

function PLAYERBAR:UpdateData()

	if self.data != {} then
		if IsValid(self.data.player) then
			if self.data.team != self.data.player:Team() then
				self:Remove()
			end
			self.data.alive = self.data.player:Alive()
			for k, ptext in pairs( SHB.setting.plyRtext ) do
				self.data.rtext[k].text = ptext.func(self.data.player)
			end
			for k, ptext in pairs( SHB.setting.plyLtext ) do
				if isfunction( ptext.func ) then
					self.data.ltext[k].text = ptext.func(self.data.player)[1]
					self.data.ltext[k].col = ptext.func(self.data.player)[2] or Color(255,255,255)
				elseif ptext.func == "AVATAR" then
					if !self.avatar then
						self.avatar = vgui.Create( "AvatarImage", self )
						self.avatar:SetSize( 32, 32 )
						self.avatar:SetPos( 3, 3 )
						self.avatar:SetPlayer( self.data.player, 32 )
						function self.avatar:PaintOver( w, h )
							if self:GetParent().data.alive == false then
								surface.SetDrawColor( Color(40,40,40,100) )
								surface.DrawRect( 0, 0, w, h )
								surface.SetDrawColor( Color(240,0,0,180) )
								surface.DrawLine( 4,4,28,28 )
								surface.DrawLine( 5,4,28,27 )
								surface.DrawLine( 4,5,27,28 )
								surface.DrawLine( 28,4,4,28 )
								surface.DrawLine( 28,5,5,28 )
								surface.DrawLine( 27,4,4,27 )
							end
						end
					end
				end
			end
		else
			self:Remove()
		end
	end
	
end

function PLAYERBAR:Think()
	
	if self.time < CurTime() then
	
		self.time = CurTime() + 0.05
		
		if self.counter == 20 then
			self:UpdateData()
			self.counter = 1
		else
			self.counter = self.counter + 1
		end
		
		if self:IsHovered() && self.OLshow then
			if self.OLthick < 3 then
				self.OLthick = self.OLthick + 1
			end
		elseif self:IsHovered() == false && self.OLshow then
			self.OLthick = self.OLthick - 1
			if self.OLthick < 0 then
				self.OLshow = false
			end
		elseif self:IsHovered() && self.OLshow == false then
			self.OLshow = true
			surface.PlaySound( "UI/buttonrollover.wav" )
			self.OLthick = 1
		end
		
	end
	
end

vgui.Register( "PlayerBar", PLAYERBAR, "DButton" )


SUBPLAYERBAR = {}

function SUBPLAYERBAR:Init()
	
	self.data = {}
	self.time = 0
	self:SetText("")
	self.data.comma = false
	self.data.player = ""
	
end

function SUBPLAYERBAR:SetPlayer(ply)
	
	self.data.player = ply
	self.data.nick = ply:Nick()
	self.data.team = ply:Team()
	local width = SHB.theme.GetPlayerTW( self.data.nick ) + SHB.theme.spaceing() *2
	self:SetWidth( width )
	self:Dock(LEFT)
	
end

function SUBPLAYERBAR:Paint( w, h )
	
	SHB.theme.DrawPlayerSubTeam( w, h, self.data.nick, self.data.comma )
	
end

function SUBPLAYERBAR:DoClick()
	
	SHB:actionpopup( self.data.player )
	
end

function SUBPLAYERBAR:Think()
	
	if self.time < CurTime() then
	
		self.time = CurTime() + 1
		
		if IsValid(self.data.player) then
			if self.data.team != self.data.player:Team() then
				self:Remove()
			end
		else
			self:Remove()
		end
		
	end
end

vgui.Register( "SubPlayerBar", SUBPLAYERBAR, "DButton" )
