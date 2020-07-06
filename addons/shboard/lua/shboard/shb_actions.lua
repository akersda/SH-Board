function SHB:actionpopup( ply )

	local actions = DermaMenu()
	
	if ply != LocalPlayer() then
		local t = "Mute"
		if ply:IsMuted() then
			t = "Unmute"
		end
		local mute = actions:AddOption( t )
		mute:SetIcon("icon16/sound_mute.png")
		function mute:DoClick()
			if IsValid(ply) then
				ply:SetMuted(!ply:IsMuted())
			end
		end
	end
	
	local t = "Copy SteamID"
	local stid = actions:AddOption( t )
	function stid:DoClick()
		SetClipboardText( ply:SteamID() )
		LocalPlayer():ChatPrint( ply:Nick() .. "'s SteamID is " .. ply:SteamID() )
		LocalPlayer():ChatPrint( "Copied SteamID to clipboard" )
	end
	
	local t = "Open Profile"
	local profile = actions:AddOption( t )
	function profile:DoClick()
		ply:ShowProfile()
	end
end
