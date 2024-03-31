import os

from packages.package import Package, packages


CURRENT_USER = os.environ["USER"]


PACKAGE_LIST: set[Package] = set()

# core
PACKAGE_LIST |= packages(
    {
        "base",
        "base-devel",
        # system
        "amd-ucode",
        "btrfs-progs",
        "efibootmgr",
        "linux-firmware",
        "linux-lts",
        "man-db",
        "man-pages",
        "nfs-utils",
        "openssh",
        "pacman-contrib",
        "sshfs",
        Package("reflector", services={"reflector.timer"}),
        Package("xdg-user-dirs", scripts=['cd "$HOME" && xdg-user-dirs-update']),
        # shell
        "starship",
        Package(
            "zsh",
            scripts=[
                f"""
                    if [[ "$SHELL" != "/bin/zsh" ]]; then
                        chsh -s "/bin/zsh" "{CURRENT_USER}"
                    fi
                """,
            ],
        ),
        "zsh-autosuggestions",
        "zsh-completions",
        "zsh-history-substring-search",
        "zsh-syntax-highlighting",
        # cli
        Package(
            "bat",
            scripts=["bat cache --source ~/.dotfiles/modules/catppuccin/bat --build"],
        ),
        "bc",
        "bottom",
        "btop",
        "downgrade",
        "duf",
        "dust",
        "eza",
        "fd",
        "ffmpeg",
        "fzf",
        "gallery-dl-bin",
        "gping",
        "gptfdisk",
        "htop",
        "ipcalc",
        "jq",
        "p7zip",
        "paru-bin",
        "procs",
        "ranger",
        "renameutils",
        "ripgrep",
        "rsync",
        "sd",
        "tealdeer",
        "tmux",
        "tmuxinator",
        "ventoy-bin",
        "wget",
        # fonts
        "ttf-fira-code",
        "ttf-firacode-nerd",
        "ttf-font-awesome",
        "ttf-jetbrains-mono",
        "ttf-jetbrains-mono-nerd",
        # misc
        "packwiz-git",
    }
)

# wayland
PACKAGE_LIST |= packages(
    {
        "glfw-wayland",
        "qt5-wayland",
        "qt6-wayland",
        # hyprland
        Package(
            "hyprland",
            dependencies={"hyprpaper"},
        ),
        # sway
        Package(
            "sway",
            dependencies={
                "noto-fonts",
                "polkit",  # polkit is required by other PACKAGE_LIST anyway
                "swaybg",
                "swaylock",
                "xorg-xwayland",
            },
        ),
        "wofi",  # application launcher
        "waybar",  # status bar
        # terminal emulator
        "foot",
        "wezterm",
        # audio
        Package(
            "pipewire",
            dependencies={
                "pipewire-alsa",
                "pipewire-audio",
                "pipewire-jack",
                "pipewire-pulse",
            },
        ),
        "pipewire-docs",
        "wireplumber",
        # gui
        "feh",
        "firefox",
        "nemo",
        "nemo-share",
        "thunderbird",
        "udiskie",
        "vlc",
        Package("okular", dependencies={"phonon-qt5-gstreamer"}),
        # cli
        "clipman",  # clipboard manager
        "grim",  # screenshot utility
        "slurp",  # region selection
        "wf-recorder",
        "wl-clipboard",  # clipboard integration
    }
)

# development
PACKAGE_LIST |= packages(
    {
        # git
        "git",
        "git-cliff",
        "git-delta",
        "git-lfs",
        # neovim
        Package("neovim", dependencies={"python-pynvim"}),
        # cli
        "aws-cli-v2",
        "ctags",  # indexes language objects in source files
        "direnv",
        "entr",
        "hyperfine",  # benchmarking tool
        "lldb",  # LLVM debugger
        "mitmproxy",  # man-in-the-middle HTTP(S) proxy
        "mold",  # modern linker
        "sccache",  # compilation cache
        "tailspin",  # log file viewer
        "valgrind",  # memory checker
        Package(
            "nix",
            groups={"nix-users"},
            services={"nix-daemon.service"},
            scripts=[
                "nix-channel --add 'https://nixos.org/channels/nixpkgs-unstable' && nix-channel --update",
            ],
        ),
        # gui
        "lunacy-bin",  # free UI/UX design software
        "insomnia-bin",  # API client and design platform for Graphql and REST
        # docker
        "dive",
        "docker-compose",
        Package(
            "docker",
            dependencies={"docker-buildx"},
            services={"docker.service"},
            groups={"docker"},
        ),
        # kubernetes
        "helm",
        "k9s",
        "kubectl",
    }
)


# development/languages
PACKAGE_LIST |= packages(
    {
        "codelldb-bin",
        "pulumi",
        # ansible
        "ansible",
        "ansible-language-server",
        "ansible-lint",
        # c/c++
        "checkmake",
        "cmake",
        "cmake-format",
        "cppcheck",
        "include-what-you-use",
        "ninja",
        "python-cpplint",
        # css
        "vscode-css-languageserver",
        # go
        "gopls",
        # html
        "vscode-html-languageserver",
        # java
        "gradle",
        "gradle-doc",
        "gradle-src",
        "jdk-openjdk",
        "jdk8-openjdk",
        "jdk11-openjdk",
        "jdk17-openjdk",
        "jdtls",
        "maven",
        "openjdk-doc",
        "openjdk-src",
        "openjdk8-doc",
        "openjdk8-src",
        "openjdk11-doc",
        "openjdk11-src",
        "openjdk17-doc",
        "openjdk17-src",
        # javascript/typescript
        "eslint",
        "nvm",
        "pnpm",
        "nodejs",
        "prettier",
        "typescript-language-server",
        # json
        "vscode-json-languageserver",
        # lua
        "lua-language-server",
        # openscad
        "openscad-git",
        # python
        "pyenv",
        "pyright",
        "python",
        "python-poetry",
        # powershell
        "powershell-bin",
        # rust
        "cargo-edit",
        "cargo-expand",
        "cargo-feature",
        "cargo-generate",
        "cargo-msrv",
        "cargo-outdated",
        "cargo-release",
        "cargo-tauri",
        "cargo-udeps",
        "cargo-update",
        "cargo-watch",
        "cross",
        "rust-analyzer",
        "rustup",
        "wasm-bindgen",
        "wasm-pack",
        # shell
        "bash-language-server",
        "shellcheck",
        # sql
        "sqlfluff",
        # svelte
        "svelte-language-server",
        # terraform
        "opentofu-bin",
        "terraform",
        "terraform-ls",
        "terragrunt",
        "tflint-bin",
        "tfsec-bin",
        # tex/latex
        "tectonic",
        "texinfo",
        "texlab",
        # yaml
        "yamllint",
        # zig
        "zig",
    }
)

# vmware
with open("/proc/scsi/scsi", "r") as scsi:
    for line in scsi.readlines():
        if "vmware" in line.lower():
            PACKAGE_LIST |= packages(
                {
                    "xf86-input-vmmouse",
                    Package(
                        name="open-vm-tools",
                        dependencies={"fuse2"},
                        services={"vmtoolsd.service", "vmware-vmblock-fuse.service"},
                    ),
                }
            )
