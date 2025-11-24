return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local autopairs = require("nvim-autopairs")
        
        autopairs.setup({
            check_ts = true,  -- Use treesitter for better pair detection
            ts_config = {
                lua = { "string" },  -- Don't add pairs in lua string treesitter nodes
                javascript = { "template_string" },
                java = false,  -- Don't check treesitter on java
            },
        })
        
        -- Integrate with nvim-cmp for better completion experience
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done()
        )
    end,
}