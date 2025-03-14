local map = vim.keymap.set
local vscode = require('vscode')

map(
    "n", "H",
    function()
        vscode.action('workbench.action.previousEditor')
    end,
    { desc = "previousEditor", noremap = true }
)
map(
    "n", "L",
    function()
        vscode.action('workbench.action.nextEditor')
    end,
    { desc = "nextEditor", noremap = true }
)
map(
    "n", "]e",
    function()
        vscode.action('editor.action.marker.next')
    end,
    { desc = "goTo next marker" }
)
map(
    "n", "[e",
    function()
        vscode.action('editor.action.marker.prev')
    end,
    { desc = "goTo prev marker" }
)

map(
    "n", "<leader>aa",
    function()
        vscode.action('workbench.panel.chat')
    end,
    { desc = "ai chat panel" }
)
map(
    "n", "<leader>bo",
    function()
        vscode.action('workbench.action.closeOtherEditors')
    end,
    { desc = "closeOtherEditors" }
)
map(
    "n", "<leader>bd",
    function()
        vscode.action('workbench.action.files.save')
        vscode.action('workbench.action.closeActiveEditor')
    end,
    { desc = "save files and close editor" }
)

map(
    "i", "<C-a>",
    function()
        vscode.action('editor.action.selectAll')
    end,
    { desc = "selectAll in insert mode", noremap = true }
)

map(
    { "n", "v" }, "<leader>ca",
    function()
        vscode.action('editor.action.sourceAction')
    end,
    { desc = "sourceAction" }
)
map(
    { "n", "v" }, "<leader>cr",
    function()
        vscode.action('editor.action.rename')
    end,
    { desc = "rename" }
)

map(
    { "n", "v" }, "<leader>cr",
    function()
        vscode.action('editor.action.rename')
    end,
    { desc = "rename" }
)
map(
    "n", "<leader>cf",
    function()
        vscode.action('editor.action.formatDocument')
        vscode.action('workbench.action.files.save')
    end,
    { desc = "format Document and Save files" }
)

map(
    "n", "<leader>fr",
    function()
        vscode.action('workbench.action.quickOpen')
    end,
    { desc = "openRecent files" }
)

map(
    "n", "<leader>fs",
    function()
        vscode.action('editor.showCallHierarchy')
    end,
    { desc = "file struct" }
)
map(
    "n", "<leader>lz",
    function()
        vscode.action('workbench.action.toggleZenMode')
    end,
    { desc = "toggleZenMode" }
)
map(
    "n", "<leader>lf",
    function()
        vscode.action('workbench.action.toggleFullScreen')
    end,
    { desc = "toggleFullScreen" }
)

map(
    "n", "<leader>gi",
    function()
        vscode.action('editor.action.goToImplementation')
    end,
    { desc = "goToImplementation" }
)

map(
    "n", "<leader>gy",
    function()
        vscode.action('editor.action.goToTypeDefinition')
    end,
    { desc = "goToImplementation" }
)

map(
    "n", "<leader>wm",
    function()
        vscode.action('workbench.action.minimizeOtherEditors')
    end,
    { desc = "minimizeOtherEditors" }
)
