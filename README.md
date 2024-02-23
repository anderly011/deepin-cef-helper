# 安装loongarch64构建依赖软件包

构建loongarch64 deb包前, 须要安装构建依赖软件包libffi7

```bash
sudo apt-get  install ./build-depends/libffi7_3.3-5.lnd.4_loongarch64.deb
```



# deb包构建

获取该项目数据后，执行如下命令开始构建deb包

```bash
debuild -b -us -uc -tc
```



# 构建支持架构

- amd64
- arm64
- loongarch64



# 更新二进制包

## 已编译源码包获取方式

1. amd64 & arm64架构
   - 浏览器打开地址 https://cef-builds.spotifycdn.com/index.html
   - 找到对应架构分类菜单。amd64为Linux 64-bit，arm64为Linux ARM64
   - 选择"Standard Distribution"压缩包下载
2. loongarch64架构
   - 浏览器打开地址 http://www.loongnix.cn/zh/api/CEF/
   - 下载最新版本压缩包



## 放置已下载二进制包

- 将已下载的二进制包放置在项目家目录里(即与debian\src同目录层级)
- 下载的二进制包名不要修改文件名称