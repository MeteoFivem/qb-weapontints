-- https://github.com/MeteoFivem/qb-weapontints

local TintMappings = {
    [0] = 'weapontint_black',   -- Normal/Default
    [1] = 'weapontint_green',   -- Green
    [2] = 'weapontint_gold',    -- Gold
    [3] = 'weapontint_pink',    -- Pink
    [4] = 'weapontint_army',    -- Army
    [5] = 'weapontint_lspd',    -- LSPD
    [6] = 'weapontint_orange',  -- Orange
    [7] = 'weapontint_plat',    -- Platinum
}

RegisterNetEvent('qb-weapontints:client:ApplyTintVisual', function(tintId)
    local tintItemName = TintMappings[tintId]
    if not tintItemName then return end

    local hasTintItem = exports.ox_inventory:Search('count', tintItemName) > 0
    if not hasTintItem then return end

    local weaponData = exports.ox_inventory:getCurrentWeapon()
    if not weaponData then return end

    local ped = PlayerPedId()
    local weaponHash = GetHashKey(weaponData.name)

    -- add compatibility and live update
    if weaponHash and weaponHash ~= `WEAPON_UNARMED` then
        SetPedWeaponTintIndex(ped, weaponHash, tintId)
    end
end)