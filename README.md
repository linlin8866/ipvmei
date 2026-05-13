bash <(curl -Ls https://raw.githubusercontent.com/linlin8866/ipvmei/main/ip.sh)

bash <(curl -Ls https://raw.githubusercontent.com/linlin8866/ipvmei/main/ip.sh)

sysctl net.ipv4.tcp_fastopen net.ipv6.conf.all.tcp_fastopen

卸载

# 停止服务
mita stop
# 卸载程序
dpkg -r mita
# 删除配置文件+服务文件
rm -rf /etc/mita /usr/lib/systemd/system/mita.service
# 删除安装包
rm -rf /root/mita.deb
# 重载系统服务
systemctl daemon-reload
# 删除放行端口规则（ipv4+ipv6）
ufw delete allow 48451/tcp
ufw delete allow 48451/udp
ufw reload
echo "✅ 已完整卸载干净 无残留"

