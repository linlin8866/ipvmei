# --------------------------
# 一键安装mita 终极完整版 双栈TFO
# --------------------------
# 开启 IPv4 + IPv6 双栈TCP快速打开TFO
echo 3 > /proc/sys/net/ipv4/tcp_fastopen
echo 3 > /proc/sys/net/ipv6/conf/all/tcp_fastopen
echo "net.ipv4.tcp_fastopen=3" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.tcp_fastopen=3" >> /etc/sysctl.conf
sysctl -p

# 自动校验TFO是否开启成功
echo -e "\n========== TFO双栈状态检测 =========="
sysctl net.ipv4.tcp_fastopen net.ipv6.conf.all.tcp_fastopen

# 安装mita程序
dpkg -i /root/mita.deb

# 固定最优配置 MTU1460 端口账号永久不变
cat > /etc/mita/server.json <<'EOF'
{
  "portBindings": [
    {"port": 48451, "protocol": "TCP"},
    {"port": 48451, "protocol": "UDP"}
  ],
  "users": [
    {"name": "user123", "password": "pass123456"}
  ],
  "mtu": 1460
}
EOF

# 加载配置启动服务
mita apply config /etc/mita/server.json
mita start

# 开机自启
systemctl enable mita

# 放行端口 自动兼容IPV4+IPV6
ufw allow 48451/tcp
ufw allow 48451/udp
ufw reload

# 最终状态汇总
echo -e "\n========== 服务运行状态 =========="
mita status
systemctl is-enabled mita
