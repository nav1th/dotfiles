#!/bin/bash
install_nodejs(){
	case $distro in 
		fedora | redhat | centos)
		    sh -c "$(curl -fsSL https://rpm.nodesource.com/setup_lts.x)" 2>/dev/null 1>&2
		    ;;
		debian | ubuntu | kali | raspian | zorin)
		    sh -c "$(curl -fsSL https://deb.nodesource.com/setup_lts.x)" 2>/dev/null 1>&2
		    ;;
		    *)
	    esac
    if package_install nodejs; then
        return 0
    else
        return 1
    fi
}
