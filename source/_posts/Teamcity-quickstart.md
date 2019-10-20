---
title: Teamcity quickstart
date: 2018-01-20 10:01:30
tags:
---
# 前言
Teamcity是由JetBrain公司开发的一个强大的持续集成工具，支持多个平台、环境和语言。在深入了解Teamcity之前，需要先了解持续集成（Continuous Integration）这个概念。
不熟悉的同学们请移步：

- 百科定义：http://baike.baidu.com/view/5253255.htm
- 网络文章：http://www.ruanyifeng.com/blog/2015/09/continuous-integration.html

<!--more-->

# TeamCity入门
## TeamCity安装部署
略

## TeamCity相关配置
### 添加项目
 在主页点击右上角的Administration进当如下图所示的项目管理界面，然后点击Create Project。
 ![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/teamcity_2.png)
如下所示，进入添加项目界面后有多个添加项目的方式。本人所有项目都是从github上添加进来的。
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/teamcity_3.png)
项目添加完毕之后可以对项目进行管理，配置构建程序。
### 配置构建步骤
进入项目管理界面之后，在Build Configurations这一栏里找到Build Step。这里就是需要你配置自定义构建程序的地方了。由于teamcity支持maven，意味着可以直接在teamcity中运行所有maven的指令，这包括了clean,complie,deploy,install等等。还支持maven插件下的tomcat项目部署。
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/teamcity_4.png)

点击edit进入下图，这个是构建步骤页面，在这里可以进行相关的配置
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/teamcity_5.png)
Build Step页面如下图所示（核心配置）
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/teamcity_6.png)

点击edit进入具体的每个构建步骤的详细配置，如下图所示。
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/teamcity_7.png)

上面提到了Teamcity支持所有的maven指令，还包括maven的插件。这意味着我们可以通过maven来部署我们的项目。
上面那个构建步骤是编译和打包整个项目，下面则是如何部署项目相关的配置。详细配置如下图所示
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/teamcity_8.png)

