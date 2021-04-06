#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

rm -rf package/feeds/routing/olsrd/patches/012-gpsd.patch
rm -rf feeds/packages/net/smartdns
rm -rf package/lean/luci-theme-argon



svn co https://github.com/Lienol/openwrt-packages/trunk/net/smartdns                                     package/smartdns
git clone https://github.com/pymumu/luci-app-smartdns.git -b lede                                        package/luci-app-smartdns
git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06                                     package/luci-theme-argon-jerrykuku

svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome                          package/adg
git clone https://github.com/hyird/Openwrt-AdguardHome.git                                               package/AdGuardHome
git clone https://github.com/yangsongli/luci-theme-atmaterial.git                                        package/luci-theme-atmaterial


git clone https://github.com/tindy2013/openwrt-subconverter.git                                          package/openwrt-subconverter
git clone https://github.com/jerrykuku/luci-app-argon-config.git                                         package/luci-app-argon-config
git clone https://github.com/jerrykuku/lua-maxminddb.git                                                 package/lua-maxminddb
git clone https://github.com/CCnut/feed-netkeeper.git -b LUCI-LUA-UCITRACK                               package/feed-netkeeper


sed -i 's/DEPENDS.*/& \+kmod-tun +libcap-bin/g'  package/luci-app-openclash/luci-app-openclash/Makefile
sed -i 's/DEPENDS.*/& \+luci-i18n-mwan3-zh-cn/g'  package/lean/luci-app-syncdial/Makefile
sed -i 's/DEPENDS.*/& \+kmod-usb-core +kmod-usb-ohci +kmod-usb-uhci +kmod-usb-storage +kmod-usb-storage-extras +kmod-usb2 +kmod-scsi-core/g'  package/lean/automount/Makefile

find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
