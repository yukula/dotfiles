-- ~/.config/nvim/lua/theme.lua

---@param palette PaletteColors
---@return ThemeColors
local function theme(palette)
    return {
        ui = {
            fg         = palette.fujiWhite,
            fg_dim     = palette.oldWhite,
            fg_reverse = palette.waveBlue1,
            bg_dim     = palette.sumiInk1,
            bg_gutter  = 'none',
            bg_m3      = palette.sumiInk0,
            bg_m2      = palette.sumiInk0,
            bg_m1      = palette.sumiInk1,
            bg         = palette.sumiInk1,
            bg_p1      = palette.sumiInk4,
            bg_p2      = palette.sumiInk5,
            special    = palette.springViolet1,
            nontext    = palette.sumiInk6,
            whitespace = palette.sumiInk6,
            bg_search  = palette.waveBlue2,
            bg_visual  = palette.waveBlue1,
            pmenu      = {
                fg       = palette.fujiWhite,
                fg_sel   = "none",
                bg       = palette.waveBlue1,
                bg_sel   = palette.waveBlue2,
                bg_sbar  = palette.waveBlue1,
                bg_thumb = palette.waveBlue2,
            },
            float      = {
                fg        = palette.oldWhite,
                bg        = palette.sumiInk0,
                fg_border = palette.sumiInk6,
                bg_border = palette.sumiInk0,
            },
        },
        syn = {
            string     = palette.lotusBlue3,
            variable   = "none",
            number     = palette.sakuraPink,
            constant   = palette.surimiOrange,
            identifier = palette.carpYellow,
            parameter  = palette.oniViolet2,
            fun        = palette.crystalBlue,
            statement  = palette.oniViolet,
            keyword    = palette.oniViolet,
            operator   = palette.boatYellow2,
            preproc    = palette.katanaGray,
            type       = palette.waveAqua2,
            regex      = palette.boatYellow2,
            deprecated = palette.katanaGray,
            comment    = palette.fujiGray,
            punct      = palette.springViolet2,
            special1   = palette.springBlue,
            special2   = palette.waveRed,
            special3   = palette.peachRed,
        },
        vcs = {
            added   = palette.autumnGreen,
            removed = palette.autumnRed,
            changed = palette.autumnYellow,
        },
        diff = {
            add    = palette.winterGreen,
            delete = palette.winterRed,
            change = palette.winterBlue,
            text   = palette.winterYellow,
        },
        diag = {
            ok      = palette.springGreen,
            error   = palette.samuraiRed,
            warning = palette.roninYellow,
            info    = palette.dragonBlue,
            hint    = palette.waveAqua1,
        },
        term = {
            palette.sumiInk0, palette.autumnRed, palette.autumnGreen,
            palette.boatYellow2, palette.crystalBlue, palette.oniViolet,
            palette.waveAqua1, palette.oldWhite, palette.fujiGray,
            palette.samuraiRed, palette.springGreen, palette.carpYellow,
            palette.springBlue, palette.springViolet1, palette.waveAqua2,
            palette.fujiWhite, palette.surimiOrange, palette.peachRed,
        },
    }
end

return theme
