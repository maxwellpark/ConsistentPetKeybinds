local PET_CHANGE_EVENT = "UNIT_SPELLCAST_SUCCEEDED"
local PET_SUMMON_IDs = { 712, 713, 688, 697, 691, 30146 }
local PET_ATTACK_BINDING = "MIDDLEMOUSE"

function IsPetSpellId(id)
    for i = 1, #PET_SUMMON_IDs do
        if PET_SUMMON_IDs[i] == id then
            return true
        end
    end
    return false
end

function PetChangeHandler(self, event, arg1, arg2, arg3)
    print("Event fired: " .. event)
    print(format("Event args: 1. %s, 2. %s, 3. %s", tostring(arg1), tostring(arg2), tostring(arg3)))
    local spellId = arg3
    if IsPetSpellId(spellId) then
        print("Spell ID matches a pet spell")
        local spellName = GetSpellName(spellId, BOOKTYPE_SPELL("spell"))
        print("Spell name: " .. spellName)
        -- Reset the keybinding
        SetBinding(PET_ATTACK_BINDING)
        -- Set the keybinding by binding name and spell name
        SetBinding(PET_ATTACK_BINDING, spellName)

    end
end

function CreateCoreFrame()
    -- Create frame for subscribing to events
    local coreFrame = CreateFrame("FRAME", "CPK_CoreFrame")
    coreFrame:RegisterEvent(PET_CHANGE_EVENT)
    coreFrame:SetScript("OnEvent", PetChangeHandler)
    return coreFrame
end

CoreFrame = CreateCoreFrame()
