return {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function ()
        require("copilot_cmp").setup({
            method = "getCompletionsCycling",
            formatters = {
                label = require("copilot_cmp.format").format_label_text,
                insert_text = require("copilot_cmp.format").remove_existing,
                preview = require("copilot_cmp.format").deindent,
            },
        })
    end
}





