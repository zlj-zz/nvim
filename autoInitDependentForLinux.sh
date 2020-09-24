
# vim/nvim environment auto install
# author: Zachary Zhang

dependent_softwares=("python2.7" \
    "python3" \
    "nodejs" \
    "npm" \
    "fzf" \
    "xclip" \
    "figlet" \
    "the_silver_searcher")
dependent_python_package=("pynvim" \
    "debugpy")
dependent_npm_package=("neovim")

# different package manager install function
#------------------------------------------------
#------------------------------------------------
apt_install(){
    if ! type $i >/dev/null 2>&1; then
        echo -e "\e[1;41;93m$i\e[0m\e[1m ==> \e[0m not found, start to download:"
        sudo DEBIAN_FRONTEND=noninteractive apt -y install $1
    else
        echo -e "\e[1;42;93m$i\e[0m\e[1m ==> \e[0m is installed."
    fi
}

pacman_install(){
    if ! type $i >/dev/null 2>&1; then
        echo -e "\e[1;41;93m$i\e[0m\e[1m ==> \e[0m not found, start to download:"
        sudo  pacman -S $1
    else
        echo -e "\e[1;42;93m$i\e[0m\e[1m ==> \e[0m is installed."
    fi
    #TODO: need to finish
}

#------------------------------------------------
#------------------------------------------------
#------------------------------------------------

pip_install(){
    if [[ $(pip3 list | grep ${i}) ]]; then
        echo -e "\e[1;42;93mPython\e[0m[\e[0;92m$i\e[0m]: is installed."
    else
        echo -e "\e[1;41;93mPython\e[0m[\e[0;91m$i\e[0m] not found, start to download:"
        pip   install $1
        pip3  install $1
    fi
}

npm_install(){
    if [[ $(npm list -g --depth 0 | grep ${i}) ]]; then
        echo -e "\e[1;42;93mnpm\e[0m[\e[0;92m$i\e[0m]: is installed."
    else
        echo -e "\e[1;42;93mnpm\e[0m[\e[0;91m$i\e[0m] not found, start to download:"
        sudo npm -g install $1
    fi
}

# start program ---------------------------------
#------------------------------------------------
#------------------------------------------------

# get system's package manager
echo -e "\e[1;96mStart Install Evironment.\e[0m"
software_intall_func=1
get_package_manager(){
    if [[ $(ls /usr/bin/apt) ]]; then
        software_intall_func=apt_install
        echo 1
    elif [[ $(ls /usr/bin/pacman) ]]; then
        software_intall_func=pacman_install
        echo 2
    fi
}

get_package_manager

for i in ${dependent_softwares[@]}; do
    $software_intall_func $i
done

for i in ${dependent_npm_package[@]}; do
    npm_install $i
done

for i in ${dependent_python_package[@]}; do
    pip_install $i
done

echo -e "\e[1;96mInstall Evironment Over.\e[0m"
