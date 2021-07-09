--[[ Install neovim dependent.
 Author: Zachary Zhang
 Created Time: 2021-06-29
 Description: vim/nvim environment auto install, just support like unix system.
]]

Dependent_softwares = {
    "python2.7",
    "python3",
    "node",
    "npm",
    "ranger",
    "w3m",
    "fmt",
    "ffmpegthumbnailer",
    "screen",
    "fzf" ,
    "the_silver_searcher",
    "ripgrep",
    "ctags",
    "xclip" ,
    "figlet"
}

Python_pkg = {"pynvim", "debugpy", "ueberzug"}

Npm_pkg = {"neovim"}

-- Get system OS type.
local function get_system()
    return io.popen("uname -s"):read("*l")
end

-- Get the installation command of system.
local function get_installer()
    local system = get_system()
    print("Detect system os: "..system.."\n")
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
local function check_and_install(type, installer, checker, dep)
    if not io.popen(checker..dep):read("*l") then
        os.execute(installer..dep)
    else
        print("== "..type..": \27[1;42m"..dep.."\27[0m already existed.")
    end
end

function Main()
    local installer = get_installer()
    print('⛽ Try to install software dependency.')
    for _, value in ipairs(Dependent_softwares) do
        check_and_install("software", installer, "where ", value)
    end
    print('⛽️ Try to install python package dependency.')
    for _, value in ipairs(Python_pkg) do
        check_and_install("python package", "pip3 install -U ", "pip3 freeze | grep ", value)
    end
    print('⛽ Try to install npm package dependency.')
    for _, value in ipairs(Npm_pkg) do
        check_and_install("npm package", "sudo npm i -g ", "npm list -g | grep ", value)
    end
end

Main()


