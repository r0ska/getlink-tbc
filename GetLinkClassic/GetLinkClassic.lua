--[[To do:
!!Add support for scaled ilevels.
Add a very minor UI and integrate into the options menu.
Look up better LUA table practices.
Use a compression to reduce the size of the database.
Allow removed items to stay in the database while keeping maintenance automatic.
Spell lookup.
]]

local SearchFrame = CreateFrame("Frame")
local nTopID = 213988 --Update this for new item IDs, https://classic.wowhead.com/items?filter=151;2;213088
local tclassic = {172070, 122284, 122270} --Weird ids for classic.
local nStepSize = 52 --Database build speed.  This can be set to 500+ on beefier computers.
local nVersion = 5
local bBuilding = false
local nCurrentID = 0
local tc = {
	["a335ee"] = "1",
	["0070dd"] = "2",
	["1eff00"] = "3",
	["ffffff"] = "4",
	["9d9d9d"] = "5",
	["ff8000"] = "6",
	["e6cc80"] = "8",
	["00ccff"] = "9"
}
local rtc = {
	["1"] = "a335ee",
	["2"] = "0070dd",
	["3"] = "1eff00",
	["4"] = "ffffff",
	["5"] = "9d9d9d",
	["6"] = "ff8000",
	["8"] = "e6cc80",
	["9"] = "00ccff"
}

SLASH_GetLink1 = "/gl"
SLASH_GetLink2 = "/getlink"
SLASH_DevLink1 = "/gldev"

SlashCmdList["GetLink"] = function(msg) GetLink_Command(msg) end

SlashCmdList["DevLink"] = function(msg)
	if msg == "purge" then
		GLTable = nil
		GLOptions = nil
		print("Saved variables purged.")
	else
		GLTest(msg)
	end
end

function GLTest(msg) 
	AddItem(msg)
end

--[[Checks the query to make sure it's a decent length to prevent full on spam.
Then it turns it and the results into lower case and generates the saved link if there's
a match.  If there's a - then we need to replace that to %%- to work around the search
filters built into LUA strings.  May need to add other filters in the future.]]

function GetLink_Command(msg)
	if not bBuilding then
		if msg:len() > 2 then
			msg = string.lower(msg:gsub("-", "%%-"))
			for id, name in pairs(GLTable) do
				if string.find(name:lower(), msg, 2) then
					if string.find(name:sub(1,2), "|") then
						print(name)
					else
						print("|cff" .. rtc[name:sub(1,1)] .. "|Hitem:" .. id .. ":::::::::::::::|h[" .. name:sub(2) .. "]|h|r")
					end
				end
			end
			print("End of results.")
		else
			print("The query is too short.")
		end
	elseif bBuilding then print("Working, " ..  math.floor(100 * (1 - (nCurrentID / nTopID))) .. "% complete.") end
end

--[[Splits the potential item pool into groups of fifty, checks if there's already
an entry in the saved database.  If there isn't an entry it requests the item information.]]

function GetSearch(self, elapsed)
	if bBuilding and nCurrentID > 0 then
		TickStop = nCurrentID - nStepSize
		if TickStop < 0	then TickStop = 0 end
		while nCurrentID > TickStop do
			if C_Item.DoesItemExistByID(nCurrentID) then
				AddItem(nCurrentID)
			end
			nCurrentID = nCurrentID - 1
		end
	elseif bBuilding then
		bBuilding = false
		SearchFrame:SetScript("OnUpdate", nil)
		print("Get Link: The database has been updated.  Use /gl [text] to search.")
	end
end

--[[Clean item links then save them.  If the item link can't be cleaned just add it whole.]]

function AddItem(idnum)
	idnum = tonumber(idnum)
	if(idnum and idnum > 0) then name, link = GetItemInfo(idnum) end --Thanks islerwow for pointing out a stack overflow.
	if name then
		if tc[link:sub(5, 10)] then
			GLTable[tostring(idnum)] = string.format("%s%s", tc[link:sub(5, 10)], name)
		else
			GLTable[idnum] = link
		end
	end
end

--[[SearchFrame registers this function to activate whenever the addon is loaded
and whenever item data is received.  If the addon deteects it's running a different
version than the database it will purge and make a new one.]]

function EventHandler(self, event, arg1, arg2)
	if event == "ADDON_LOADED" and arg1 == "GetLinkClassic" then
		if not GLOptions or GLOptions["Version"] ~= nVersion then 
			GLTable = {}
			GLOptions = {}
			GLOptions["Version"] = nVersion
			for i, id in pairs(tclassic) do AddItem(id) end
			bBuilding = true
			nCurrentID = nTopID
			SearchFrame:SetScript("OnUpdate", GetSearch)
			print("Get Link: Updating the database.")
		end
	elseif event == "GET_ITEM_INFO_RECEIVED" and arg1 > 0 then
		AddItem(arg1)
	end
end

SearchFrame:RegisterEvent("ADDON_LOADED")
SearchFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
SearchFrame:SetScript("OnEvent", EventHandler)