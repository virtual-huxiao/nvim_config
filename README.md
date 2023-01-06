# 安装说明:

## 1. 下载此代码仓库

​	首先可以Git clone 本项目到配置文件路径: (默认你就有git了)

* Windows: `C:/Users/AppData/Local/nvim/`下;
* Linux: `~/.config/nvim/`下;



## 2. 需要安装的内容

​	以下内容, 更希望**安装最新版本**;

[`Neovim(>= 0.7)`](https://neovim.io/), [`Nodejs(>=14.0)`](https://nodejs.org/en/), [`clangd(>=14.0)`](https://github.com/llvm/llvm-project/releases)和 [`ripgrep`](https://github.com/BurntSushi/ripgrep/releases);

## 2.1 Windows

Windows下安装这些, 非常简单; 主要就是把他们加载到`Path`环境变量中(*能在任何位置, 被命令行访问到*)就好了;或者使用Windows下的包管理工具[scoop](https://github.com/ScoopInstaller/Scoop/releases);

或者直接访问其官网下载即可:	[`Neovim(>= 0.7)`](https://neovim.io/), [`Nodejs(>=14.0)`](https://nodejs.org/en/), [`clangd(>=14.0)`](https://github.com/llvm/llvm-project/releases)和 [`ripgrep`](https://github.com/BurntSushi/ripgrep/releases);

## 2.2 Linux 和 Mac

Linux下, 例如Ubuntu有内部包管理工具, 但是apt安装的版本都太旧了, 所以推荐使用[Homebrew](https://brew.sh/index_zh-cn)(服务于Linux和Mac)安装;

安装Homebrew, 用官方的方法, 可能网络就是一个大问题, 

1. 这里有清华源的安装说明:https://mirror.tuna.tsinghua.edu.cn/help/homebrew/
   然后就可以通过https://formulae.brew.sh/formula/查找你要安装的软件, 都是最新的!!!
2. 路径下有`HomebrewInstall.sh`, 你可以在Ubuntu中使用`sh./HomebrewInstall.sh`进行安装; 如果结束的话, 那么你将可以通过`sudo brew install gcc llvm node ripgrep neovim`(过程略长)进行安装了;(终端不同, 系统不同, 可以仿照修改其中的逻辑); 如果安装之后发现无法识别`brew`, 那么应该使用`source ~/.bashrc`更新配置再做尝试;


注: 目前不知道Linuxbrew出什么问题, 下载的node一直是有问题的; 当然, 我们有其他的方式可以下载node补偿;(见下方内容)

### 2.2.1 Ubuntu安装的方式(使用Apt修改源安装)

	1. 使用https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/中给定的换源手段

```bash
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

2. 增加个软件源:

参考: https://apt.llvm.org/, 

```bash
# 管理员打开/etc/apt/sources.list 行尾添加下面命令, 然后apt update & apt install llvm就可以了
deb http://apt.llvm.org/unstable/ llvm-toolchain-15 main
deb-src http://apt.llvm.org/unstable/ llvm-toolchain-15 main
```

参考https://github.com/nodesource/distributions

```bash
# 安装nodejs
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs
```

但是没有neovim最新的安装说明, ripgrep是直接可以使用apt安装的;


