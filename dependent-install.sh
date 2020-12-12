
# Author: Zachary Zhang
# Description: vim/nvim environment auto install
# Created Time: 2020-08-28 02:23:05
# Last Modified: 2020-10-02 10:48

#------------------------------------------------
# dependent softwares
#------------------------------------------------
DEPENDENT_SOFTWARES=("python2.7" \
    "python3" \
    "nodejs" \
    "npm" \
    "ranger "\
    "w3m"
    "fmt"\
    "ffmpegthumbnailer"\
    "screen"
    "fzf" \
    "the_silver_searcher"\
    "ripgrep"\
    "ctags"\
    "xclip" \
    "figlet")
DEPENDENT_PYTHON_PACKAGES=("pynvim" \
    "debugpy"\
    "ueberzug")
DEPENDENT_NPM_PACKAGES=("neovim")

#------------------------------------------------
# different package manager install function
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
        sudo pacman -S $1
    else
        echo -e "\e[1;42;93m$i\e[0m\e[1m ==> \e[0m is installed."
    fi
}

brew_install(){
    if ! type $i >/dev/null 2>&1; then
        echo -e "\e[1;41;93m$i\e[0m\e[1m ==> \e[0m not found, start to download:"
        brew install -s $1
    else
        echo -e "\e[1;42;93m$i\e[0m\e[1m ==> \e[0m is installed."
    fi
}

#------------------------------------------------
# other installer
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

#------------------------------------------------
# get what package manager in this system
#------------------------------------------------
software_intaller=1
get_package_manager(){
    if [[ $(ls /usr/bin/apt) ]]; then
        software_intaller=apt_install
        echo "Found package manager: apt"
    elif [[ $(ls /usr/bin/pacman) ]]; then
        software_intaller=pacman_install
        echo "Found package manager: pacman"
    elif [[ $(whereis brew) ]]; then
        software_intaller=brew_install
        echo "Found package manager: HomeBrew"
    else
        echo "Found package manager error!"
        exit(0)
    fi
}

#------------------------------------------------
# start program 
#------------------------------------------------
run(){
    # get system's package manager
    echo -e "\e[1;96mStart install Evironment for Neovim.\e[0m"
    get_package_manager

    for i in ${DEPENDENT_SOFTWARES[@]}; do
        $software_intaller $i
    done

    for i in ${DEPENDENT_NPM_PACKAGES[@]}; do
        npm_install $i
    done

    for i in ${DEPENDENT_PYTHON_PACKAGES[@]}; do
        pip_install $i
    done

    echo -e "\e[1;96mInstall Evironment Over.\e[0m"
}

# start
run
