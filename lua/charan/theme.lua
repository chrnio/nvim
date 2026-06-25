local M = {}

M.themes = {
    "catppuccin-mocha",
    "moonfly",
    "kola-dark",
    "gruvbox-material",
    "onedark",
    "cyberdream",
    "eldritch",
    "nordic",
    "solarized-osaka",
    "tokyonight",
}

-- persists chosen theme across sessions
local state_file = vim.fn.stdpath("data") .. "/charan_theme.txt"

function M.save(name)
    local f = io.open(state_file, "w")
    if f then f:write(name); f:close() end
end

function M.load_saved()
    local f = io.open(state_file, "r")
    if f then
        local name = f:read("*l"); f:close()
        return name
    end
end

function M.apply(name)
    local ok, err = pcall(vim.cmd.colorscheme, name)
    if not ok then
        vim.notify("Theme '" .. name .. "' failed: " .. err, vim.log.levels.WARN)
        return false
    end
    M.save(name)
    return true
end

function M.pick()
    vim.ui.select(M.themes, { prompt = "Select theme" }, function(choice)
        if choice then M.apply(choice) end
    end)
end

function M.setup()
    M.apply(M.load_saved() or "catppuccin-mocha")
end

return M
