-- setup
SHB.setting = {}
SHB.theme = {}
SHB.board = {}

include( "shboard/shb_functions.lua" )
include( "shboard/shb_theme.lua" )

-- hook
local GM = {}
hook.Add( "Initialize", "setup_newscore", function()
	GM = gmod.GetGamemode()

	function GM:ScoreboardShow()
		SHB:Open()
	end

	function GM:ScoreboardHide()
		SHB:Close()
	end
end)

-- includes
include( "shboard/shb_settings.lua" )

include( "shboard/shb_actions.lua" )
include( "shboard/shb_player.lua" )
include( "shboard/shb_board.lua" )

timer.Simple(0.1,function()
	include( "shboard/shb_settings.lua" ) -- post refresh
end)

print("====================================")
print("Initialised scoreboard by Cptn.Sheep")
print("====================================")
