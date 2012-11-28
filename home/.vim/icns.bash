#!/usr/bin/env bash
mvi=`readlink ~/Applications/MacVim.app`
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "${script_dir}/MacVim.icns" "${mvi}/Contents/Resources/MacVim.icns"
