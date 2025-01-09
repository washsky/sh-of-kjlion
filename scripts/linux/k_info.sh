

k_info() {
send_stats "k命令参考用例"
echo "-------------------"
echo "视频介绍: https://www.bilibili.com/video/BV1ib421E7it?t=0.1"
echo "以下是k命令参考用例："
echo "启动脚本            k"
echo "安装软件包          k install nano wget | k add nano wget | k 安装 nano wget"
echo "卸载软件包          k remove nano wget | k del nano wget | k uninstall nano wget | k 卸载 nano wget"
echo "更新系统            k update | k 更新"
echo "清理系统垃圾        k clean | k 清理"
echo "打开重装系统面板    k dd | k 重装"
echo "打开bbr3控制面板    k bbr3 | k bbrv3"
echo "打开内核调优面板    k nhyh | k 内核优化"
echo "设置虚拟内存        k swap 2048"
echo "设置虚拟时区        k time Asia/Shanghai | k 时区 Asia/Shanghai"
echo "打开系统回收站      k trash | k hsz | k 回收站"
echo "软件启动            k start sshd | k 启动 sshd "
echo "软件停止            k stop sshd | k 停止 sshd "
echo "软件重启            k restart sshd | k 重启 sshd "
echo "软件状态查看        k status sshd | k 状态 sshd "
echo "软件开机启动        k enable docker | k autostart docke | k 开机启动 docker "
echo "域名证书申请        k ssl"
echo "域名证书到期查询    k ssl ps"
echo "docker环境安装      k docker install |k docker 安装"
echo "docker容器管理      k docker ps |k docker 容器"
echo "docker镜像管理      k docker img |k docker 镜像"
echo "LDNMP站点管理       k web"
echo "LDNMP缓存清理       k web cache"
echo "安装WordPress       k wp |k wordpress |k wp xxx.com"
echo "安装反向代理        k fd |k rp |k 反代 |k fd xxx.com"

}



if [ "$#" -eq 0 ]; then
	# 如果没有参数，运行交互式逻辑
	kejilion_sh
else
	# 如果有参数，执行相应函数
	case $1 in
		install|add|安装)
			shift
			send_stats "安装软件"
			install "$@"
			;;
		remove|del|uninstall|卸载)
			shift
			send_stats "卸载软件"
			remove "$@"
			;;
		update|更新)
			linux_update
			;;
		clean|清理)
			linux_clean
			;;
		dd|重装)
			dd_xitong
			;;
		bbr3|bbrv3)
			bbrv3
			;;
		nhyh|内核优化)
			Kernel_optimize
			;;
		trash|hsz|回收站)
			linux_trash
			;;
		wp|wordpress)
			shift
			ldnmp_wp "$@"

			;;
		fd|rp|反代)
			shift
			ldnmp_Proxy "$@"
			;;

		swap)
			shift
			send_stats "快速设置虚拟内存"
			add_swap "$@"
			;;

		time|时区)
			shift
			send_stats "快速设置时区"
			set_timedate "$@"
			;;


		iptables_open)
			iptables_open
			;;

		status|状态)
			shift
			send_stats "软件状态查看"
			status "$@"
			;;
		start|启动)
			shift
			send_stats "软件启动"
			start "$@"
			;;
		stop|停止)
			shift
			send_stats "软件暂停"
			stop "$@"
			;;
		restart|重启)
			shift
			send_stats "软件重启"
			restart "$@"
			;;

		enable|autostart|开机启动)
			shift
			send_stats "软件开机自启"
			enable "$@"
			;;

		ssl)
			shift
			if [ "$1" = "ps" ]; then
				send_stats "查看证书状态"
				ssl_ps
			elif [ -z "$1" ]; then
				add_ssl
				send_stats "快速申请证书"
			elif [ -n "$1" ]; then
				add_ssl "$1"
				send_stats "快速申请证书"
			else
				k_info
			fi
			;;

		docker)
			shift
			case $1 in
				install|安装)
					send_stats "快捷安装docker"
					install_docker
					;;
				ps|容器)
					send_stats "快捷容器管理"
					docker_ps
					;;
				img|镜像)
					send_stats "快捷镜像管理"
					docker_image
					;;
				*)
					k_info
					;;
			esac
			;;

		web)
		   shift
			if [ "$1" = "cache" ]; then
				web_cache
			elif [ -z "$1" ]; then
				ldnmp_web_status
			else
				k_info
			fi
			;;
		*)
			k_info
			;;
	esac
fi



#
########

