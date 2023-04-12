outfits = json.decode(LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'uniform_file')))

function string.split(inputstr, sep)
    if sep == nil then
    sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
    end

    return t
end

local function convertInput(input)
	local t1 = tonumber(string.split(input, ":")[1])-1
	local t2 = tonumber(string.split(input, ":")[2])-1
	return({t1, t2})
end

local function setOutfit(outfit)
	local ped = PlayerPedId()

	if (outfit.Gender == "Male" and GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) or (outfit.Gender == "Female" and GetEntityModel(ped) == GetHashKey("mp_f_freemode_01")) then
		SetPedComponentVariation(ped, 1, convertInput(outfit.Mask)[1], convertInput(outfit.Mask)[2], 0)
		SetPedComponentVariation(ped, 3, convertInput(outfit.UpperSkin)[1], convertInput(outfit.UpperSkin)[2], 0)
		SetPedComponentVariation(ped, 4, convertInput(outfit.Pants)[1], convertInput(outfit.Pants)[2], 0)
		SetPedComponentVariation(ped, 5, convertInput(outfit.Parachute)[1], convertInput(outfit.Parachute)[2], 0)
		SetPedComponentVariation(ped, 6, convertInput(outfit.Shoes)[1], convertInput(outfit.Shoes)[2], 0)
		SetPedComponentVariation(ped, 7, convertInput(outfit.Accessories)[1], convertInput(outfit.Accessories)[2], 0)
		SetPedComponentVariation(ped, 8, convertInput(outfit.UnderCoat)[1], convertInput(outfit.UnderCoat)[2], 0)
		SetPedComponentVariation(ped, 9, convertInput(outfit.Armor)[1], convertInput(outfit.Armor)[2], 0)
		SetPedComponentVariation(ped, 10, convertInput(outfit.Decal)[1], convertInput(outfit.Decal)[2], 0)
		SetPedComponentVariation(ped, 11, convertInput(outfit.Top)[1], convertInput(outfit.Top)[2], 0)

		if convertInput(outfit.Hat)[1] == -1 then
			ClearPedProp(ped, 0)
		else
			SetPedPropIndex(ped, 0, convertInput(outfit.Hat)[1], convertInput(outfit.Hat)[2], true)
		end

		if convertInput(outfit.Glasses)[1] == -1 then
			ClearPedProp(ped, 1)
		else
			SetPedPropIndex(ped, 1, convertInput(outfit.Glasses)[1], convertInput(outfit.Glasses)[2], true)
		end

		if convertInput(outfit.Watch)[1] == -1 then
			ClearPedProp(ped, 6)
		else
			SetPedPropIndex(ped, 6, convertInput(outfit.Watch)[1], convertInput(outfit.Watch)[2], true)
		end
	end
end

local categoryOutfitsM = {}
local categoryOutfitsF = {}

for x, outfit in ipairs(outfits) do
	found = false
	if outfit.Gender == "Male" then
		for i, j in ipairs(categoryOutfitsM) do
			if categoryOutfitsM[i][1] == outfit.Category2 then
				table.insert(categoryOutfitsM[i], outfit)
				found = true
			end
		end
		if found == false then
			table.insert(categoryOutfitsM, {outfit.Category2, outfit})
		end
	else
		for i, j in ipairs(categoryOutfitsF) do
			if categoryOutfitsF[i][1] == outfit.Category2 then
				table.insert(categoryOutfitsF[i], outfit)
				found = true
			end
		end
		if found == false then
			table.insert(categoryOutfitsF, {outfit.Category2, outfit})
		end
	end
end





openM = function()
	local Man = RageUI.CreateMenu('EUP', 'Catégorie :')
	local Category = RageUI.CreateSubMenu(Man, "Catégorie", "Liste : ")
	local itemList = {}
	RageUI.Visible(Man, not RageUI.Visible(Man))
	while Man do
		Wait(1)
		RageUI.IsVisible(Man, function()
			for i, list in pairs(categoryOutfitsM) do
				RageUI.Item.Button(list[1], nil, {RightLabel = '→'}, true, {
					onSelected = function()
						itemList = {}
						itemList = list
					end,
				}, Category)
			end 
		end)
		RageUI.IsVisible(Category, function()
			for id, outfit in ipairs(itemList) do
				if id ~= 1 then 
					RageUI.Item.Button(outfit.Name, nil, {RightLabel = '→'}, true, {
						onSelected = function()
							setOutfit(outfit)
						end,
					})
				end 
			end 
		end)
		if not RageUI.Visible(Man) and not RageUI.Visible(Category) then
			Man = RMenu:DeleteType('Man', true)
		end
	end
end


openF = function()
	local Female = RageUI.CreateMenu('EUP', 'Catégories : ')
	local Category = RageUI.CreateSubMenu(Female, "Catégorie", "Liste : ")
	local itemList = {}
	RageUI.Visible(Female, not RageUI.Visible(Female))
	while Female do
		Wait(1)
		RageUI.IsVisible(Female, function()
			for i, list in pairs(categoryOutfitsF) do
				RageUI.Item.Button(list[1], nil, {RightLabel = '→'}, true, {
					onSelected = function()
						itemList = {}
						itemList = list
					end,
				}, Category)
			end 
		end)
		RageUI.IsVisible(Category, function()
			for id, outfit in ipairs(itemList) do
				if id ~= 1 then 
					RageUI.Item.Button(outfit.Name, nil, {RightLabel = '→'}, true, {
						onSelected = function()
							setOutfit(outfit)
						end,
					})
				end 
			end 
		end)
		if not RageUI.Visible(Female) and not RageUI.Visible(Category) then
			Female = RMenu:DeleteType('Female', true)
		end
	end
end


RegisterCommand('eup', function()
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		openM()
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		openF()
	else
		ShowInfo("You need to use an MP ped with EUP")
	end
end, false)






function ShowInfo(text)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end