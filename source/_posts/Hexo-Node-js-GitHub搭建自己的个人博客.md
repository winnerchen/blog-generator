---
title: Hexo+Node.js+GitHub搭建自己的个人博客
date: 2017-08-11 16:18:17
copyright: true
tags:
- Hexo
- 个人博客
- Node.js
- GitHub
categories:
- 搭建博客
---
# 1. 前言
作为一名技术人员，很早之前就想搭建一个自己的个人博客了，但是由于种种原因一直搁置着，最近终于闲了下来，有时间去慢慢折腾了。拥有自己的个人博客是有很多好处的，包括：
* 总结自己的学习和成长
* 记录自己对于各种技术的收获
* 共享知识，方便其他人学习
* 包装自己，展示自我
* 练习文笔
* ...

还有很多的好处就不一一描述了，相信大家都有各种各样的动力去做一个博客。相对于早期的博客开发来说，现在搭建自己的个人博客是一件相对容易的事情，很多的框架和技术都已经把复杂的流程和操作封装起来，准备好环境之后只需要几条命令行即可完成本地博客的搭建。新博文的发布和编辑也是很好上手的。
<!--more-->

选择一个自己喜欢的主题风格即可让自己的博客看起来有模有样的了，以下是搭建博客的准备工作。

# 2. 搭建环境准备
- Node.js的安装和准备
- Git的安装和准备
- GitHub账号的配置和仓库的新建
## 2.1 下载Node.js的安装文件
Node.js下载链接：
* [Windows Installer 32-bit](https://nodejs.org/dist/v4.2.3/node-v4.2.3-x86.msi "Node.js 32-bit") 
* [Windows Installer 64-bit](https://nodejs.org/dist/v4.2.3/node-v4.2.3-x64.msi "Node.js 32-bit") 

大家可以根据自己的windows版本下载安装相应的文件。

![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_4.png)
下载完毕之后，一路按next即可完成安装。

然后我们检查一下组件是否安装完毕，按下Win+R输入CMD打开命令行窗口。
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_1.png) 
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_2.png) 
在打开的命令行窗口中输入

```
node -v
npm -v
```
如果显示如下图，则表示安装正确，可以进行下一步安装。
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_3.png) 

## 2.2 配置Git环境
下载[Git安装文件](https://git-scm.com/downloads "Git下载")

下载完成之后直接安装即可，安装过程无需解释了，next到结束即可。

安装完毕之后用命令来检查Git是否已经正确安装:
```
git --version
```
如果结果如下图所示，则说明安装正确，进入下一步安装。
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_5.png) 

## 2.3 GitHub账号的注册和配置
### 2.3.1 GitHub账号的注册
前往[GitHub注册页面](https://github.com/)注册自己的个人账户
### 2.3.2 GitHub仓库的创建
如下图所示，点击Your Profile - Repositories - New来创建新仓库
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_7.png)
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_6.png)

在repository内填写yourname.github.io,如下图所示
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_8.png)

### 2.3.3 仓库配置

如果仓库正确创建之后，你会看到如下界面：
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_9.png)
然后点击setting选项卡，进入设置页面，往下拖至GitHub Pages项，此时可以看到Source下的选项不可用，因为此时尚未有分支创建和代码提交。如下图所示。
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_10.png)
在完成了hexo的安装、测试以及代码推送之后，可以选择master分支将自己的博客代码部署到GitHub服务器上。下面介绍Hexo的安装和配置。

## 2.4 安装Hexo
首先新建一个文件夹，作为你的本地博客网站的路径。我的路径是F:/hexo。在该文件夹下按住Shift键+右键，选择‘在此处打开命令窗口’，进入cmd命令行。
在命令行中输入
```
npm install hexo -g  #-g表示全局安装, npm默认为当前项目安装
hexo version
```
如果遇到报错，则用下面命令安装
```
npm install hexo --no-optional
```
使用
```
hexo v
```
来查看hexo是否已经正确安装，如果显示下图，则表明安装成功。

![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_11.png)
# 3. 部署本地博客
然后依次输入hexo命令：
```
hexo init #执行init命令初始化到你指定的hexo目录
npm install    #install before start blogging
hexo generate       #自动根据当前目录下文件,生成静态网页
hexo server         #运行本地服务
```
显示下图则表示项目已经成功初始化并且部署到本地4000端口。
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_13.png)
在浏览器中输入http://localhost:4000/即可访问本地博客。
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_14.png)
# 4. 把本地博客部署到GitHub Pages
## 4.1 在Git中配置个人信息
如果你之前已经配置好Git的个人信息，可以跳过这一步。
查看Git是否关联GitHub：在该文件夹下右击打开GIT bash窗口，然后输入
```
ssh -T git@github.com
```
如果显示如下图，则表示已经关联成功
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_15.png)
如果是初次使用git要首先设置git的username和email：
```
git config --global user.name "your_username"
git config --global user.email "your_email@xxx.com"
```
然后生成秘钥
```
ssh-keygen -t rsa -C "your_email@xxx.com"
```
连续按三次回车之后，会生成两个文件id_rsa 和 id_rsa.pub，id_rsa 是密钥，id_rsa.pub 就是公钥。这两文件默认分别在如下目录里生成：

Linux/Mac 系统 在 ~/.ssh 下，win系统在 /c/Documents and Settings/username/.ssh 下，都是隐藏文件，相信你们有办法查看的。

接下来要做的是把 id_rsa.pub 的内容添加到 GitHub 上，这样你本地的 id_rsa 密钥跟 GitHub上的 id_rsa.pub 公钥进行配对，授权成功才可以提交代码。

## 4.2 GitHub上添加SSH key
第一步先在 GitHub 上的设置页面，点击最左侧 SSH and GPG keys ：
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_16.png)
然后点击右上角的 New SSH key 按钮， 然后将id_rsa.pub公钥文件里的内容复制粘贴进去就可以了。Title那一栏可以不用填写。点击Add SSH key 按钮就ok了。
SSH key 添加成功之后，输入 ssh -T git@github.com 进行测试，如果出现以下提示证明添加成功了。
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_17.png)
## 4.3 配置_config.yml文件
在根目录下找到_config.yml文件，找到deployment，然后按照如下修改：
```
deploy:
  type: git
  repo: git@github.com:yourname/yourname.github.io.git
  branch: master
```
比如我的仓库的地址是git@github.com:winnerchen/chen.github.io.git，所以配置如下
```
deploy:
  type: git
  repo: git@github.com:winnerchen/chen.github.io.git
  branch: master
```
同时还可在site栏下修改标题已经作者：
```
# Site
title: Your Blog Name
subtitle: Your Subtitle
description:
author: Your Name
language:
timezone:
```
配置url和root（非常重要！如果没有配置成功会显示不出样式和主题！）：
```
# URL
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
url: http://yoursite.com
root: /
permalink: :year/:month/:day/:title/
permalink_defaults:
```
以我的配置为例：
```
url:  https://winnerchen.github.io #博客的域名
root: /chen.github.io #git仓库的名称
permalink: :year/:month/:day/:title/
permalink_defaults:
```
## 4.4部署到GitHub Pages
安装git扩展：
```
npm install hexo-deployer-git --save
```
如果没有执行者行命令，将会提醒
```
deloyer not found:git
```

运行生成和部署的命令：
```
hexo g   # 生成
hexo d   # 部署
```
显示下图表明项目已经成功推送到github远程仓库
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_18.png)
此时到github仓库中查看，会发现代码已经成功上传
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_19.png)
然后进入setting中，找到github pages，把source选为master branch
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_20.png)
稍等一分钟左右，等到刷出如下图所示的页面即可访问自己部署在github上的个人博客了！
![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_21.png)

![](https://raw.githubusercontent.com/winnerchen/hexo/master/source/images/blog_22.png)
至此，在github上部署个人博客的教程已经结束，希望大家都不出bug顺利走完！

# 5.发布日志
To be continued...
# 6.自定义主题
To be continued...
# 7.插件安装
To be continued...

***

