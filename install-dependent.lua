-- #/usr/bin/env lua
-- Module: Neovim dependent utils.
-- Author: Zachary Zhang
-- Created Time: 2021-06-29
-- Update Time:  2023-06-28
-- Description: vim/nvim environment auto install, just support like unix system.
local Installer = {}

NOTIFY = "notify"
WARN = "warning"
ERROR = "error"
GREAT = "great"

Installer.info_prefixs = {
    notify = "[\x1b[38;5;74mnotify\x1b[0m] ",
    warning = "[\x1b[38;5;184mwarn\x1b[0m] ",
    error = "[\x1b[38;5;167merror\x1b[0m] ",
    great = "[\x1b[38;5;77mok\x1b[0m] ",
}

Installer.softwares = {
    "python2.7",
    "python3.9",
    "node",
    "npm",
    "w3m",
    "fmt",
    "ffmpegthumbnailer",
    "screen",
    "fzf",
    "the_silver_searcher",
    "ripgrep",
    "ctags",
    "xclip",
    "figlet",
}

Installer.py_deps = {
    "pynvim",
    "jedi",
    "black",
    "debugpy",
}

Installer.npm_deps = {
    "neovim",
}

--- Output info msg to terminal.
---@param msg string info msg
---@param level? string level of msg
function Installer:info(msg, level)
    if level == nil then
        level = NOTIFY
    end

    print(self.info_prefixs[level] .. msg)
end

--- Get system OS type.
---@return string
function Installer:get_system()
    return io.popen("uname -s"):read("*l")
end

--- Get the installation command of system.
---@param os string
---@return string
function Installer:fetch_pkg_manager(os)
    local installer
    if os == "Darwin" then
        installer = "brew install "
    elseif os == "Ubuntu" then
        installer = "sudo apt install "
    elseif os == "Manjaro" or os == "Arch" then
        installer = "sudo pacman -S "
    end

    return installer
end

--- Checking and install a dependent.
---@param dep_type string @dependent type.
---@param install_cmd string installation command.
---@param check_cmd string checking command.
---@param dep string  dependent name.
function Installer:do_install(dep_type, install_cmd, check_cmd, dep)
    local exist_str = "== %s: \27[1;42m%s\27[0m already existed."

    if not io.popen(check_cmd .. dep):read("*l") then
        local ok_exit, signal = os.execute(install_cmd .. dep)

        if ok_exit then
            self:info("Install " .. dep .. " over.", GREAT)
        else
            self:info("Install " .. dep .. " exit with othe.", WARN)
        end

        return 1
    else
        self:info(exist_str:format(dep_type, dep), WARN)
        return 2
    end
end

function Installer:launch()
    local os = self:get_system()
    local pkg_install_cmd = self:fetch_pkg_manager(os)

    self:info("Try to install software dependency.")
    for _, value in pairs(self.softwares) do
        self:check_and_install("software", pkg_install_cmd, "where ", value)
    end

    self:info("Try to install python package dependency.")
    for _, value in pairs(self.py_deps) do
        self:do_install("python package", "pip3 install -U ", "pip3 freeze | grep ", value)
    end

    self:info("Try to install npm package dependency.")
    for _, value in pairs(self.npm_deps) do
        self:do_install("npm package", "sudo npm i -g ", "npm list -g | grep ", value)
    end
end

------------------------
--  enter  --
------------------------
Installer:launch()

