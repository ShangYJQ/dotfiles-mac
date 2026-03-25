### 安装 `homwbrew`：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 导出 `brew` 包：

```bash
brew bundle dump --global --force --describe
```

### 直接恢复 `brew` 包：

```bash
brew bundle --global
```
