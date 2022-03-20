--[[To do:
!!Add support for scaled ilevels.
Add a very minor UI and integrate into the options menu.
Look up better LUA table practices.
Use a compression to reduce the size of the database.
Allow removed items to stay in the database while keeping maintenance automatic.
Spell lookup.
]]

local SearchFrame = CreateFrame("Frame")
local nTopID = 190325 --Update this for new item IDs, https://tbc.wowhead.com/items?filter=151;2;190325 Setting this to an obscenely large number should future proof the addon provided you run '/gldev build' each update, unless Blizzard changes the way item info is retrieved.
local nStepSize = 50 --Database build speed.  This can be set to 500+ on beefier computers.
local nVersion = 5 --Used to check if the addon needs to rebuild the database because of a new update.
local bBuilding = false 
local nCurrentID = 0
local tc = {
	["a335ee"] = "1",
	["0070dd"] = "2",
	["1eff00"] = "3",
	["ffffff"] = "4",
	["9d9d9d"] = "5",
	["ff8000"] = "6",
	["00ccff"] = "7",
	["e6cc80"] = "8"
} --Table to save some memory.
local rtc = {
	["1"] = "a335ee",
	["2"] = "0070dd",
	["3"] = "1eff00",
	["4"] = "ffffff",
	["5"] = "9d9d9d",
	["6"] = "ff8000",
	["7"] = "00ccff",
	["8"] = "e6cc80"
} --"

SLASH_GetLink1 = "/gl"
SLASH_GetLink2 = "/getlink"
SLASH_DevLink1 = "/gldev"

SlashCmdList["GetLink"] = function(msg) GetLink_Command(msg) end

--[[If you want to keep removed items in the game then you can do that with manually updating the nTopID without updating nVersion.  I'm not sure if Blizzard ever reuses item IDs but if they do and you use this method to update you won't be able to find those new items.  Eventually I'll update the addon to handle that automatically because it is cool to look back on some of those.]]

SlashCmdList["DevLink"] = function(msg)
	if msg == "purge" then
		GLTable = nil
		GLOptions = nil
		print("Saved variables purged.")
	elseif msg == "build" then
		bBuilding = true
		nCurrentID = nTopID
		SearchFrame:SetScript("OnUpdate", GetSearch)
		print("Get Link: Updating the database.")
		GLTest(msg)
	end
end

function GLTest(msg) 
	print("'purge' will delete the database, you'll need to reload to rebuild it.  'build' will run the database build again without purging.")
end

--[[Checks the query to make sure it's a decent length to prevent full on spam.  Then it turns it and the results into lower case and generates the saved link if there's a match.  If there's a - then we need to replace that to %%- to work around the search filters built into LUA strings.  May need to add other filters in the future.]]

function GetLink_Command(msg)
	if not bBuilding then
		if msg:len() > 2 then
			msg = string.lower(msg:gsub("-", "%%-"))
			for id, name in pairs(GLTable) do
				if string.find(name:lower(), msg, 2) then
					print("|cff" .. rtc[name:sub(1,1)] .. "|Hitem:" .. id .. ":::::::::::::::|h[" .. name:sub(2) .. "]|h|r")
				end
			end
			print("End of results.")
		else
			print("The query is too short.")
		end
	elseif bBuilding then print("Working, " ..  math.floor(100 * (1 - (nCurrentID / nTopID))) .. "% complete.") end
end

--[[Splits the potential item pool into groups of fifty (nStepSize), checks if there's already an entry in the saved database.  If there isn't an entry it requests the item information.]]

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

--[[Clean item links then save them.]]

function AddItem(idnum)
	name, link = GetItemInfo(idnum)
	if name then GLTable[tostring(idnum)] = string.format("%s%s", tc[link:sub(5, 10)], name) end												   
end

--[[SearchFrame registers this function to activate whenever the addon is loaded and whenever item data is received.  If the addon deteects it's running a different version than the database it will purge and make a new one.]]

function EventHandler(self, event, arg1, arg2)
	if event == "ADDON_LOADED" and arg1 == "GetLinkTBC" then
		if not GLOptions or GLOptions["Version"] ~= nVersion then 
			GLTable = {}
			GLOptions = {}
			GLOptions["Version"] = nVersion
			bBuilding = true
			nCurrentID = nTopID
			SearchFrame:SetScript("OnUpdate", GetSearch)
			print("Get Link: Updating the database.")
		end
	elseif event == "GET_ITEM_INFO_RECEIVED" then AddItem(arg1) end
end

SearchFrame:RegisterEvent("ADDON_LOADED")
SearchFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
SearchFrame:SetScript("OnEvent", EventHandler)
