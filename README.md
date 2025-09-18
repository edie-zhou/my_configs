# My Configuration Files

This repository contains my personal configuration files (dotfiles) for various tools and shell environments. These configurations help maintain a consistent development environment across different machines.

## 📁 What's Included

| File | Purpose |
|------|---------|
| `.bashrc` | Bash shell configuration and customizations |
| `.zshrc` | Zsh shell configuration and customizations |
| `.profile` | Shell-agnostic environment setup |
| `.inputrc` | Readline library configuration for command-line editing |
| `.vimrc` | Vim editor configuration and plugins |
| `.tmux.conf` | Tmux terminal multiplexer configuration |

## 🚀 Installation

### Quick Setup
```bash
# Clone the repository
git clone https://github.com/edie-zhou/my_configs.git
cd my_configs

# Create symbolic links to your home directory
ln -sf $(pwd)/.bashrc ~/.bashrc
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.profile ~/.profile
ln -sf $(pwd)/.inputrc ~/.inputrc
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf

# Reload your shell configuration
source ~/.bashrc  # or source ~/.zshrc if using zsh
```

### Manual Installation
Alternatively, you can copy individual configuration files to your home directory:
```bash
cp .bashrc ~/.bashrc
cp .vimrc ~/.vimrc
# ... etc for other files
```

## ⚙️ Key Features

### Shell Configuration
- **Bash/Zsh**: Custom prompt, aliases, and productivity enhancements
- **Profile**: Environment variables and path configurations
- **Inputrc**: Enhanced command-line editing experience

### Editor Setup
- **Vim**: Comprehensive vim configuration with useful settings and mappings

### Terminal Management
- **Tmux**: Terminal multiplexer setup for managing multiple terminal sessions

## 🔧 Customization

Feel free to fork this repository and modify the configurations to suit your preferences. Each configuration file is well-commented to help you understand what each setting does.

### Before Making Changes
It's recommended to backup your existing configuration files:
```bash
cp ~/.bashrc ~/.bashrc.backup
cp ~/.vimrc ~/.vimrc.backup
# ... etc for other files you want to backup
```

## 📋 Requirements

- **Bash** or **Zsh** shell
- **Vim** editor
- **Tmux** terminal multiplexer (optional, for `.tmux.conf`)

## 🤝 Contributing

If you have suggestions for improvements or find any issues, feel free to open an issue or submit a pull request.

## 📄 License

These configuration files are provided as-is. Feel free to use, modify, and distribute them as needed.

---

*Last updated: September 2025*