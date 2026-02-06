local MemeMeta = {
    Auras = {
        {Name = "Skibidi Gray", Multiplier = 0.5, Rarity = 90},
        {Name = "Mewing Streak", Multiplier = 2.0, Rarity = 7},
        {Name = "Fanum Gold", Multiplier = 10.0, Rarity = 2.5},
        {Name = "STRAWBERRY ELEPHANT", Multiplier = 50.0, Rarity = 0.4},
        {Name = "GIGA CHAD TRANSCENDENCE", Multiplier = 100.0, Rarity = 0.1}
    },
    
    SigmaRanks = {
        {Name = "Lvl 1 Crook", Requirement = 0},
        {Name = "Rizzler", Requirement = 1000},
        {Name = "Mewing Master", Requirement = 10000},
        {Name = "ULTRA SIGMA", Requirement = 100000},
        {Name = "GIGA CHAD", Requirement = 1000000}
    },

    Zones = {
        FanumTaxZone = {
            Multiplier = 5,
            TaxRate = 0.2, -- 20% loss if caught
            Position = Vector3.new(-100, 0, -100),
            Size = Vector3.new(100, 1, 100)
        }
    }
}

return MemeMeta