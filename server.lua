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

        local weaponSlot = nil
        local inventory = exports.ox_inventory:GetInventory(source)

        if inventory and inventory.items then
            for slot, invItem in pairs(inventory.items) do
                if invItem and invItem.name and invItem.name:find("WEAPON_") then
                    weaponSlot = slot
                    break
                end
            end
        end

        if not weaponSlot then
            TriggerClientEvent('QBCore:Notify', source, 'You need to have a weapon equipped!', 'error')
            return
        end

        local hasTintItem = exports.ox_inventory:Search(source, 'count', itemName)
        if not hasTintItem or hasTintItem < 1 then
            return
        end

        local weaponItem = exports.ox_inventory:GetSlot(source, weaponSlot)
        if weaponItem then
            local metadata = weaponItem.metadata or {}
            metadata.tint = tintId

            exports.ox_inventory:SetMetadata(source, weaponSlot, metadata)
            exports.ox_inventory:RemoveItem(source, itemName, 1)

            TriggerClientEvent('qb-weapontints:client:ApplyTintVisual', source, tintId)
            TriggerClientEvent('QBCore:Notify', source, 'Weapon tint applied!', 'success')
        end
    end)
end