# 安装说明:

## 1. 下载此代码仓库

​	首先可以Git clone 本项目到配置文件路径: (默认你就有git了)

* Windows: `C:/Users/AppData/Local/nvim/`下;
* Linux: `~/.config/nvim/`下;



## 2. 需要安装的内容

​	以下内容, 更希望**安装最新版本**;

[`Neovim(>= 0.7)`](https://neovim.io/), [`Nodejs(>=14.0)`](https://nodejs.org/en/), [`clangd(>=14.0)`](https://github.com/llvm/llvm-project/releases)和 [`ripgrep`](https://github.com/BurntSushi/ripgrep/releases);

Windows下安装这些, 非常简单; 主要就是把他们加载到`Path`环境变量中(*能在任何位置, 被命令行访问到*)就好了;或者使用Windows下的包管理工具[scoop](https://github.com/ScoopInstaller/Scoop/releases);

Linux下, 例如Ubuntu有内部包管理工具, 但是apt安装的版本都太旧了, 所以推荐使用[Homebrew](https://brew.sh/index_zh-cn)(服务于Linux和Mac)安装;

安装Homebrew, 用官方的方法, 可能网络就是一个大问题, 

1. 这里有清华源的安装说明:https://mirror.tuna.tsinghua.edu.cn/help/homebrew/
   然后就可以通过https://formulae.brew.sh/formula/查找你要安装的软件, 都是最新的!!!




