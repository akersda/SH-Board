local SHB = GetSHBTable()

local PLAYERBAR = {}

function PLAYERBAR:Init()
	
	self.data = {}
	self.time = 0
	self:SetText("")
	
end

function PLAYERBAR:SetPlayer(ply)
	
	self.data.player = ply
	self.data.nick = ply:Nick()
	self.data.rank = "rank"
	self.data.rtext = {}
	for k, ptext in pairs( SHB.setting.plyRtext ) do
		table.insert( self.data.rtext, {width = ptext.width, text="nil"} )
	end
	self.data.team = ply:Team()
	
end

function PLAYERBAR:Paint( w, h )
	
	SHB.theme.DrawPlayerLeft( w, h, self.data.nick, self.data.rank )
	SHB.theme.DrawPlayerRight( w, h, self.data.rtext )
	
end

function PLAYERBAR:DoClick()
	
	--shb playeraction
	
end

function PLAYERBAR:UpdateData()

	if self.data != {} then
		if IsValid(self.data.player) then
			if self.data.team != self.data.player:Team() then
				self:Remove()
			end
			self.data.nick = self.data.player:Nick()
			for k, ptext in pairs( SHB.setting.plyRtext ) do
				self.data.rtext[k].text = ptext.func(self.data.player)
			end
		else
			self:Remove()
		end
	end
	
end

function PLAYERBAR:Think()
	
	if self.time < CurTime() then
		self.time = CurTime() + 1
		self:UpdateData()
	end
	
end

vgui.Register( "PlayerBar", PLAYERBAR, "DButton" )
