return {
    "luukvbaal/statuscol.nvim",
    enabled = false,
    config = function()
        local statuscol = require("statuscol")
        local builtin = require("statuscol.builtin")
        statuscol.setup({
            relculright = true,
            segments = {
                { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                {
                    sign = { namespace = { "diagnostic/signs" }, colwidth = 2, maxwidth = 1, auto = true },
                    click = "v:lua.ScSa",
                },
                {
                    sign = {
                        name = { ".*" },
                        namespace = { ".*" },
                        maxwidth = 1,
                        colwidth = 2,
                        auto = true,
                    },
                    click = "v:lua.ScSa",
                },
                { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
        })
    end,
}
