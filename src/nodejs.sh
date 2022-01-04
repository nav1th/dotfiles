#!/bin/bash
install_nodejs(){
	case $distro in 
		fedora | redhat | centos)
		    sh -c "$(curl -fsSL https://rpm.nodesource.com/setup_lts.x)" 2>/dev/null 1>&2
		    ;;
		debian | ubuntu | kali | raspian)
		    sh -c "$(curl -fsSL https://deb.nodesource.com/setup_lts.x)" 2>/dev/null 1>&2
		    ;;
		    *)
	    esac
    if package_install nodejs 2>/dev/null 1>&2; then
        good "nodejs installed"
    else
        warn "nodejs failed to install"
    fi
}
