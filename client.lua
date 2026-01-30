-- https://github.com/MeteoFivem/qb-weapontints
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-weapontints:client:ApplyTint', function(tintId, itemName)
    local ped = PlayerPedId()
    local currentWeapon = GetSelectedPedWeapon(ped)

    if currentWeapon == nil or currentWeapon == `WEAPON_UNARMED` then
        QBCore.Functions.Notify('You need to have a weapon equipped!', 'error')
        return
    end

    local weaponData = exports.ox_inventory:getCurrentWeapon()

    if not weaponData then
        QBCore.Functions.Notify('No weapon equipped!', 'error')
        return
    end

    SetPedWeaponTintIndex(ped, currentWeapon, tintId)

    local weaponSlot = weaponData.slot
    if weaponSlot then
        local metadata = weaponData.metadata or {}
        metadata.tint = tintId

        TriggerServerEvent('qb-weapontints:server:UpdateWeaponTint', weaponSlot, tintId)
    end

    TriggerServerEvent('qb-weapontints:server:RemoveTintItem', itemName)

    QBCore.Functions.Notify('Weapon tint applied!', 'success')
end)