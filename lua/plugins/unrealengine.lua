return {
    "mbwilding/UnrealEngine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>ug",
            function()
                require("unrealengine.commands").generate_lsp()
            end,
            desc = "UnrealEngine: Generate LSP"
        },
        {
            "<leader>ub",
            function()
                require("unrealengine.commands").build()
            end,
            desc = "UnrealEngine: Build"
        },
        {
            "<leader>ur",
            function()
                require("unrealengine.commands").rebuild()
            end,
            desc = "UnrealEngine: Rebuild"
        },
        {
            "<leader>uo",
            function()
                require("unrealengine.commands").open()
            end,
            desc = "UnrealEngine: Open Editor"
        },
        {
            "<leader>uc",
            function()
                require("unrealengine.commands").clean()
            end,
            desc = "UnrealEngine: Clean"
        },
        {
            "<leader>ue",
            function()
                require("unrealengine.commands").build_engine()
            end,
            desc = "UnrealEngine: Link Plugin - Build Engine"
        },
        {
            "<leader>up",
            function()
                require("unrealengine.commands").build_plugin()
            end,
            desc = "UnrealEngine: Build Plugin"
        },
    },
    build = function()
        require("unrealengine.commands").build_engine()
    end,
    opts = {
        engine_path = "/Users/Shared/Epic Games/UE_5.8",
        auto_generate = true,
    },
}
