-- #/usr/bin/env lua
-- Module: Install neovim dependent.
-- Author: Zachary Zhang
-- Created Time: 2021-06-29
-- Update Time:  2022-11-08
-- Description: vim/nvim environment auto install, just support like unix system.

local Installer = {
    Info_Icons = {"👌:", "✋Warn:", "👊Error:", "✌ :", "⛽:"},

    Dependent_Softwares = {"python2.7", "python3", "node", "npm", "ranger", "w3m", "fmt", "ffmpegthumbnailer", "screen",
                           "fzf", "the_silver_searcher", "ripgrep", "ctags", "xclip", "figlet"},

    Python_pkgs = {"pynvim", 'jedi', 'black', "debugpy", "ueberzug"},

    Npm_pkgs = {"neovim"}
}

-- Output info msg to terminal.
-- @param msg string info msg
-- @param level? number level of msg
function Installer:info(msg, level)
    -- 1-info 2-warning 3-error 4-greate
    level = level == nil and 1 or level

    print(self.Info_Icons[level] .. msg)
end

-- Get system OS type.
function Installer.get_system()
    return io.popen("uname -s"):read("*l")
end

-- Get the installation command of system.
function Installer:get_package_manager()
    local system = self.get_system()
    print("Detect system os: " .. system .. "\n")

    local installer
    if system == "Darwin" then
        installer = "brew install "
    elseif system == "Ubuntu" then
        installer = "sudo apt install "
    elseif system == "Manjaro" or system == "Arch" then
        installer = "sudo pacman -S "
    end

    return installer
end

-- Checking and install a dependent.
-- @param type: dependent type.
-- @param installer: installation command.
-- @param checker: checking command.
-- @param dep: dependent name.
function Installer:check_and_install(dep_type, install_cmd, check_cmd, dep)
    if not io.popen(check_cmd .. dep):read("*l") then
        os.execute(install_cmd .. dep)
    else
        print("== " .. dep_type .. ": \27[1;42m" .. dep .. "\27[0m already existed.")
    end
end

function Installer:launch()
    -- Get software installer.
    local installer = self.get_package_manager()

    self.info('Try to install software dependency.')
    for _, value in ipairs(self.Dependent_Softwares) do
        self.check_and_install("software", installer, "where ", value)
    end

    self.info('Try to install python package dependency.')
    for _, value in ipairs(self.Python_pkgs) do
        self.check_and_install("python package", "pip3 install -U ", "pip3 freeze | grep ", value)
    end

    self.info('Try to install npm package dependency.')
    for _, value in ipairs(self.Npm_pkgs) do
        self.check_and_install("npm package", "sudo npm i -g ", "npm list -g | grep ", value)
    end
end

------------------------
--  enter  --
------------------------
Installer:launch()

