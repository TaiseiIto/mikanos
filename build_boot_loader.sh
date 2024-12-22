#!/bin/bash

source edksetup.sh
cd Conf
sed -i "s/^ACTIVE_PLATFORM[\t ]*=[\t ]*.*$/ACTIVE_PLATFORM = MikanLoaderPkg\/MikanLoaderPkg.dsc/" target.txt
sed -i "s/^TARGET[\t ]*=[\t ]*.*$/TARGET = DEBUG/" target.txt
sed -i "s/^TARGET_ARCH[\t ]*=[\t ]*.*$/TARGET_ARCH = X64/" target.txt
sed -i "s/^TOOL_CHAIN_TAG[\t ]*=[\t ]*.*$/TOOL_CHAIN_TAG = CLANG38/" target.txt
build

