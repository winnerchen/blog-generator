---
title: 搬瓦工+SS+FS搭建自己的翻墙神器
date: 2017-08-09 16:49:17
copyright: true
tags:
---
# 前言
作为一个经常上谷歌，YouTube的程序狗，不能自由的访问网络实在是让我很心烦，以前我都是买网上的vpn服务，但是由于不知名的原因，那个网站被封掉了...

购买vpn服务其实也有很多的弊端，例如数据有泄漏的隐患、网络高峰期速度会比较慢，还有就是vpn的费用比起整年购买的vps服务也是贵了不少。


前两天有一个哥们推荐了这么一个翻墙的神技，根据相应的关键字我百度了一番教程之后，终于被我摸索出一套可行的方案。下面是很详细的教程，希望新手们在走完教程后能享受到自由无限制的网络:)
<!--more-->
# 1.搬瓦工

## 1.1注册·
传送门：https://bwh1.net/register.php

需要提一句的是，在注册的时候，如果是国内的网络会显示不出验证码。不过相信这种问题一定难不倒机智的你。

![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_1.png) 

## 1.2 购买服务
作为个人用户，我推荐大家还是买第一个服务即可，不做为商业服务器部署项目的话，每个月的500个G的流量是非常够用的。一年下来大概36美金。

![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_2.png) 

## 1.3 服务管理
根据下图即可跳转到管理界面
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_3.png) 

主管理界面：
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_4.png) 
注意这里记录了你的ip地址和端口号，之后FS和SS的客户端会需要这些数据。

# 2. ShadowSocks
## 2.1 配置服务器端
SS服务器端的配置非常简单，因为搬瓦工已经帮我们一键集成了，我们需要做的就是开启这个服务。具体流程参考下图。

![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_5.png) 
在屏幕的左边点击Shadowsocks Server，第一次进入会提示你未开启该服务，是否需要现在开启。直接点激活即可。

激活完毕之后就会跳转到这个界面，SS服务器端口号和密码需要记录下来，客户端需要使用。

## 2.2 配置客户端
推荐使用版本：2.5.8
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_6.png) 
根据上图配置SS客户端的ip地址，端口号。密码从搬瓦工网上复制下来。
端口号2000是本地端口，用于加速使用，可以随意填写。

# 3. FinalSpeed
## 3.1 配置服务器端
打开搬瓦工的linux命令行，点击右边导航栏的Root-shell basic进入。
在命令行中依次输入：
```
yum -y install wget
```
```
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/finalspeed/master/install_fs.sh && bash install_fs.sh
```
顺利安装好FS的服务端之后即可输入启动命令来启动FS服务
```
/etc/init.d/finalspeed start
```
FS相关命令
停止FS服务端：
```
/etc/init.d/finalspeed stop
```
查看FS运行状态
```
/etc/init.d/finalspeed status
```

## 3.2 配置客户端
推荐版本：FinalSpeed1.2
详细配置参见下图
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_7.png) 
如果连接成功会提示已成功连接
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/vps_8.png) 

如果一切顺利，至此一切配置都已配完，是时候享受自由无限制的网络了！
***
