local QBCore = exports['qb-core']:GetCoreObject()

local TintMappings = {
    ['weapontint_black'] = 0,   -- Normal/Default
    ['weapontint_green'] = 1,   -- Green
    ['weapontint_gold'] = 2,    -- Gold
    ['weapontint_pink'] = 3,    -- Pink
    ['weapontint_army'] = 4,    -- Army
    ['weapontint_lspd'] = 5,    -- LSPD
    ['weapontint_orange'] = 6,  -- Orange
    ['weapontint_plat'] = 7,    -- Platinum
}

for itemName, tintId in pairs(TintMappings) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end

        TriggerClientEvent('qb-weapontints:client:ApplyTint', source, tintId, itemName)
    end)
end

RegisterNetEvent('qb-weapontints:server:UpdateWeaponTint', function(weaponSlot, tintId)
    local src = source

    local weaponItem = exports.ox_inventory:GetSlot(src, weaponSlot)

    if weaponItem then
        local metadata = weaponItem.metadata or {}
        metadata.tint = tintId

        exports.ox_inventory:SetMetadata(src, weaponSlot, metadata)
    end
end)

RegisterNetEvent('qb-weapontints:server:RemoveTintItem', function(itemName)
    local src = source
    exports.ox_inventory:RemoveItem(src, itemName, 1)
end)