Skillet.AttunableFilters = {
    { label = "Show all items",    value = "NONE" },
    { label = "Hide unattunable",         value = "UNATTUNABLE" },
    { label = "Hide attuned lightforged", value = "LIGHTFORGED" },
    { label = "Hide attuned warforged",   value = "WARFORGED" },
    { label = "Hide attuned titanforged", value = "TITANFORGED" },
    { label = "Hide attuned base",        value = "BASE" }
}

local lastFilter = "NONE"

function Skillet:AttunableFilterDropdown_OnLoad()
    UIDropDownMenu_Initialize(SkilletAttunableFilterDropdown, Skillet.AttunableFilterDropdown_Initialize)
    SkilletAttunableFilterDropdown.displayMode = "MENU"  -- changes the pop-up borders to be rounded instead of square
    UIDropDownMenu_SetWidth(SkilletAttunableFilterDropdown, 140)

    for i, filter in ipairs(Skillet.AttunableFilters) do
        if filter.value == lastFilter then
            UIDropDownMenu_SetSelectedID(SkilletAttunableFilterDropdown, i)
        end
    end 
end

function Skillet:AttunableFilterDropdown_Initialize()
    for _, filter in ipairs(Skillet.AttunableFilters) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = filter.label
        info.value = filter.value
        info.func = function()
            UIDropDownMenu_SetSelectedID(SkilletAttunableFilterDropdown, this:GetID())
            Skillet:SetTradeSkillOption(Skillet.currentTrade, "attunementfilter", this.value)
            lastFilter = this.value
            Skillet:UpdateTradeSkillWindow()
        end
        UIDropDownMenu_AddButton(info)
    end
end

function Skillet.AttunableFilterDropdown_OnShow()
    UIDropDownMenu_Initialize(SkilletAttunableFilterDropdown, Skillet.AttunableFilterDropdown_Initialize)
    SkilletAttunableFilterDropdown.displayMode = "MENU"  -- changes the pop-up borders to be rounded instead of square
    UIDropDownMenu_SetWidth(SkilletAttunableFilterDropdown, 160)

    for i, filter in ipairs(Skillet.AttunableFilters) do
        if filter.value == lastFilter then
            UIDropDownMenu_SetSelectedID(SkilletAttunableFilterDropdown, i)
        end
    end
end