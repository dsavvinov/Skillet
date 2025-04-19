Skillet.AttunableFilters = {
    { label = "Show all items",    value = "NONE" },
    { label = "Hide unattunable",         value = "UNATTUNABLE" },
    { label = "Hide attuned lightforged", value = "LIGHTFORGED" },
    { label = "Hide attuned warforged",   value = "WARFORGED" },
    { label = "Hide attuned titanforged", value = "TITANFORGED" },
    { label = "Hide attuned base",        value = "BASE" }
}

function Skillet.UpdateSelectedDropdownToActualFilter()
    local lastFilter = Skillet:GetTradeSkillOption(Skillet.currentTrade, "attunementfilter")
    if not lastFilter then
        Skillet:SetTradeSkillOption(Skillet.currentTrade, "attunementfilter", "NONE")
        UIDropDownMenu_SetSelectedID(SkilletAttunableFilterDropdown, 1)
    else
        for i, filter in ipairs(Skillet.AttunableFilters) do
            if filter.value == lastFilter then
                UIDropDownMenu_SetSelectedID(SkilletAttunableFilterDropdown, i)
            end
        end
    end
end

function Skillet:AttunableFilterDropdown_OnLoad()
    UIDropDownMenu_Initialize(SkilletAttunableFilterDropdown, Skillet.AttunableFilterDropdown_Initialize)
    SkilletAttunableFilterDropdown.displayMode = "MENU"  -- changes the pop-up borders to be rounded instead of square
    UIDropDownMenu_SetWidth(SkilletAttunableFilterDropdown, 160)
end

function Skillet.AttunableFilterDropdown_Initialize(self, level)
    for i, filter in ipairs(Skillet.AttunableFilters) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = filter.label
        info.func = function()
            UIDropDownMenu_SetSelectedID(self, i)
            Skillet:SetTradeSkillOption(Skillet.currentTrade, "attunementfilter", filter.value)
            Skillet:UpdateTradeSkillWindow()
        end
        UIDropDownMenu_AddButton(info, level)
    end
end

function Skillet:AttunableFilterDropdown_OnShow()
    UIDropDownMenu_Initialize(SkilletAttunableFilterDropdown, Skillet.AttunableFilterDropdown_Initialize)
    SkilletAttunableFilterDropdown.displayMode = "MENU"  -- changes the pop-up borders to be rounded instead of square
    UIDropDownMenu_SetWidth(SkilletAttunableFilterDropdown, 160)

    Skillet.UpdateSelectedDropdownToActualFilter()
end

