// Import raw config files using Vite's ?raw import
import installSh from '../configs/install.sh?raw';
import packagesTxt from '../configs/packages.txt?raw';
import i3Config from '../configs/i3-config?raw';
import polybarConfig from '../configs/polybar-config?raw';
import picomConf from '../configs/picom.conf?raw';
import rofiRasi from '../configs/rofi.rasi?raw';
import alacrittyYml from '../configs/alacritty.yml?raw';
import wallpaperSh from '../configs/wallpaper.sh?raw';
import lockSh from '../configs/lock.sh?raw';

export interface RepoFile {
  path: string;
  description: string;
  content: string;
  language: string;
  category: string;
}

export const repoFiles: RepoFile[] = [
  {
    path: "install.sh",
    description: "Main installation script — idempotent, refuses root, supports --dry-run",
    content: installSh,
    language: "bash",
    category: "root"
  },
  {
    path: "packages.txt",
    description: "List of required packages from official Arch repos",
    content: packagesTxt,
    language: "text",
    category: "root"
  },
  {
    path: "config/i3/config",
    description: "i3 window manager — Lain colors, Cyrillic layout, workspace names from the anime",
    content: i3Config,
    language: "ini",
    category: "config"
  },
  {
    path: "config/polybar/config.ini",
    description: "Polybar status bar — minimal modules, signal-green for network status",
    content: polybarConfig,
    language: "ini",
    category: "config"
  },
  {
    path: "config/picom/picom.conf",
    description: "Picom compositor — CRT dithering effect, no blur, subtle fading",
    content: picomConf,
    language: "ini",
    category: "config"
  },
  {
    path: "config/rofi/lain.rasi",
    description: "Rofi launcher theme — dark Lain palette, angular borders",
    content: rofiRasi,
    language: "css",
    category: "config"
  },
  {
    path: "config/alacritty/alacritty.yml",
    description: "Alacritty terminal — Lain color scheme, JetBrains Mono with Cyrillic",
    content: alacrittyYml,
    language: "yaml",
    category: "config"
  },
  {
    path: "scripts/wallpaper.sh",
    description: "Downloads Lain wallpaper and sets it via feh",
    content: wallpaperSh,
    language: "bash",
    category: "scripts"
  },
  {
    path: "scripts/lock.sh",
    description: "Screen locker with Lain-themed i3lock colors",
    content: lockSh,
    language: "bash",
    category: "scripts"
  },
];

export const repoTree = `lain-i3-rice/
├── README.md
├── install.sh
├── .gitignore
├── packages.txt
├── config/
│   ├── i3/
│   │   └── config
│   ├── polybar/
│   │   └── config.ini
│   ├── picom/
│   │   └── picom.conf
│   ├── rofi/
│   │   └── lain.rasi
│   └── alacritty/
│       └── alacritty.yml
├── scripts/
│   ├── wallpaper.sh
│   └── lock.sh
└── wallpapers/
    └── (lain.png — downloaded at install time)`;

export const hotkeys = [
  { keys: "Mod+Return", action: "Open terminal (Alacritty)", actionRu: "Открыть терминал" },
  { keys: "Mod+d", action: "Application launcher (rofi)", actionRu: "Запустить приложения" },
  { keys: "Mod+Shift+q", action: "Kill focused window", actionRu: "Закрыть окно" },
  { keys: "Mod+h/j/k/l", action: "Focus left/down/up/right", actionRu: "Навигация" },
  { keys: "Mod+Shift+h/j/k/l", action: "Move window", actionRu: "Переместить окно" },
  { keys: "Mod+1–0", action: "Switch workspace", actionRu: "Рабочее пространство" },
  { keys: "Mod+Shift+1–0", action: "Move to workspace", actionRu: "Переместить на воркспейс" },
  { keys: "Mod+r", action: "Resize mode", actionRu: "Режим изменения размера" },
  { keys: "Mod+Escape", action: "Lock screen", actionRu: "Заблокировать экран" },
  { keys: "Mod+Shift+c", action: "Reload i3 config", actionRu: "Перезагрузить конфиг" },
  { keys: "Mod+Shift+r", action: "Restart i3", actionRu: "Перезапустить i3" },
  { keys: "Mod+Shift+e", action: "Exit i3", actionRu: "Выйти из i3" },
  { keys: "Print", action: "Screenshot", actionRu: "Скриншот" },
  { keys: "Alt+Shift", action: "Toggle US/RU layout", actionRu: "Переключить раскладку" },
];

export const lainColors = [
  { name: "Background", hex: "#0d0f14", usage: "Main background, terminal bg" },
  { name: "Background Alt", hex: "#131927", usage: "Cards, focused workspace bg" },
  { name: "Dark Surface", hex: "#191919", usage: "Secondary surfaces" },
  { name: "Blood (dim)", hex: "#4d353c", usage: "Urgent states, magenta" },
  { name: "Blood (bright)", hex: "#6b2d3c", usage: "Errors, alerts, urgent" },
  { name: "Signal Green", hex: "#39ff14", usage: "Network connected, cursor, highlights" },
  { name: "Green (dim)", hex: "#4a7c59", usage: "Accents, focused borders, primary" },
  { name: "Foreground", hex: "#b8c0cc", usage: "Main text" },
  { name: "Foreground Dim", hex: "#6b7280", usage: "Secondary text, unfocused" },
  { name: "Border", hex: "#2a2f3a", usage: "Borders, separators" },
];
