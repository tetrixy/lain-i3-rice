# lain-i3-rice

> *"No matter where you go, everyone's connected."*

Полный, рабочий и идемпотентный репозиторий для i3wm-райса в стиле **Serial Experiments Lain** для Arch Linux.

![lain](https://rare-gallery.com/thumbs/1119968-anime-blue-Serial-Experiments-Lain-Lain-Iwakura-color-darkness-image-snapshot-screenshot.png)

---

## Содержание

- [Быстрый старт](#быстрый-старт)
- [Требования](#требования)
- [Что входит в райс](#что-входит-в-райс)
- [Горячие клавиши](#горячие-клавиши)
- [Креативные скрипты](#креативные-скрипты)
- [Структура репозитория](#структура-репозитория)
- [Идемпотентность](#идемпотентность)
- [Если что-то пошло не так](#если-что-то-пошло-не-так)
- [Чек-лист после установки](#чек-лист-после-установки)
- [Источники](#источники)

---

## Быстрый старт

### 1. Клонировать репозиторий

```bash
git clone https://github.com/tetrixy/lain-i3-rice.git
cd lain-i3-rice
```

### 2. Сделать скрипт исполняемым

```bash
chmod +x install.sh
```

### 3. (Опционально) Проверить что будет сделано без реальных изменений

```bash
./install.sh --dry-run
```

Скрипт напечатает все команды, которые будут выполнены, но не выполнит их. Полезно для первого запуска, чтобы понять масштаб изменений.

### 4. Запустить установку

```bash
./install.sh
```

Скрипт попросит пароль sudo для установки пакетов.

### 5. Перезагрузиться и войти в i3

```bash
reboot
```

После перезагрузки выберите **i3** в вашем display manager (SDDM, LightDM, GDM).

---

## Требования

- **Arch Linux** (чистая установка или существующая система)
- **Пользователь с правами sudo**
- **AUR-помощник**: `yay` или `paru`
  - Если нет — установите перед запуском:
    ```bash
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si
    cd .. && rm -rf yay
    ```
- **Интернет** для загрузки пакетов и обоев
- **X11** (не Wayland)

---

## Что входит в райс

### 🖥️ Оконный менеджер и компоненты

| Компонент | Описание |
|---|---|
| **i3-wm** | Тайловый оконный менеджер с пиксельными бордерами |
| **polybar** | Статус-бар с модулями i3, MPD, CPU, MEM, VOL, NET, BAT |
| **picom** | Композитор с CRT-эффектом (dithering) |
| **rofi** | Лаунчер приложений в стиле Lain |
| **alacritty** | Терминал с цветами Lain |
| **dunst** | Уведомления в стиле Lain |
| **feh** | Установка обоев |

### 🎵 Музыка

| Компонент | Описание |
|---|---|
| **MPD** | Фоновый музыкальный сервер (PipeWire) |
| **ncmpcpp** | TUI клиент для MPD |
| **mpc** | Консольный клиент MPD |
| **Виджет в polybar** | Текущий трек, кнопки play/pause/next/prev |

### 🔊 Звук

| Компонент | Описание |
|---|---|
| **PipeWire** | Современный звуковой сервер |
| **pipewire-pulse** | Совместимость с PulseAudio |
| **pipewire-alsa** | Совместимость с ALSA |
| **wireplumber** | Менеджер сессий |
| **pamixer** | Управление громкостью |
| **playerctl** | Управление медиаплеерами |

### 🌐 Приложения

| Компонент | Описание |
|---|---|
| **Firefox** | Веб-браузер |
| **Thunar** | Графический файловый менеджер |
| **Ranger** | TUI файловый менеджер |
| **imv** | Просмотрщик изображений |
| **zathura** | PDF reader |
| **mpv** | Видеоплеер |
| **Neovim** | Текстовый редактор |
| **File Roller** | Архиватор |

### 🎨 Тема и визуал

| Компонент | Описание |
|---|---|
| **Arc-Dark** | GTK тема |
| **Papirus-Dark** | Иконки |
| **Bibata-Modern-Classic** | Курсор |
| **JetBrains Mono** | Основной шрифт (с кириллицей) |
| **Iosevka** | Альтернативный шрифт (AUR) |
| **Noto Fonts** | Эмодзи + CJK символы |
| **GStreamer** | Мультимедиа кодеки |

### 🛠️ Утилиты

| Компонент | Описание |
|---|---|
| **Clipit** | Менеджер буфера обмена с историей |
| **Bluez + Blueman** | Bluetooth поддержка |
| **TLP** | Управление питанием (ноутбуки) |
| **Htop** | Мониторинг системы |
| **Brightnessctl** | Управление яркостью |
| **Maim + Xclip** | Скриншоты |

---

## Горячие клавиши

> **Mod** = Super (Win) key

### Основные

| Комбинация | Действие |
|---|---|
| `Mod+Return` | Открыть терминал (Alacritty) |
| `Mod+d` | Лаунчер приложений (rofi) |
| `Mod+Shift+q` | Закрыть окно |
| `Mod+h/j/k/l` | Фокус влево/вниз/вверх/вправо |
| `Mod+Shift+h/j/k/l` | Переместить окно |
| `Mod+1–0` | Переключить рабочее пространство |
| `Mod+Shift+1–0` | Переместить окно на воркспейс |
| `Mod+r` | Режим изменения размера |
| `Mod+f` | Полноэкранный режим |
| `Mod+Shift+space` | Плавающее окно |
| `Mod+Space` | Переключить фокус: тайл/плавающее |

### Креативные скрипты (Lain)

| Комбинация | Действие |
|---|---|
| `Mod+Shift+w` | 🎭 Ритуал подключения к Wired |
| `Mod+Shift+g` | 👁️ Глитч-режим (5 секунд) |
| `Mod+Shift+q` | 💬 Случайная цитата из Lain |
| `Mod+Shift+e` | 🚪 Кинематографический выход |

### Музыка

| Комбинация | Действие |
|---|---|
| `Mod+m` | Открыть ncmpcpp |
| `Mod+Shift+m` | Play/Pause MPD |
| `XF86AudioPlay` | Play/Pause |
| `XF86AudioNext` | Следующий трек |
| `XF86AudioPrev` | Предыдущий трек |
| `XF86AudioRaise/Lower` | Громкость ±5% |
| `XF86AudioMute` | Mute |

### Система

| Комбинация | Действие |
|---|---|
| `Mod+Escape` | Заблокировать экран |
| `Mod+Shift+c` | Перезагрузить конфиг i3 |
| `Mod+Shift+r` | Перезапустить i3 |
| `Print` | Скриншот |
| `XF86MonBrightnessUp/Down` | Яркость ±5% |
| `Alt+Shift` | Переключить раскладку US/RU |

### Рабочие пространства

Воркспейсы названы в стиле Serial Experiments Lain:

| Номер | Название |
|---|---|
| 1 | wired |
| 2 | protocol |
| 3 | layer |
| 4 | dial |
| 5 | flux |
| 6 | schema |
| 7 | knight |
| 8 | nexus |
| 9 | ego |
| 10 | lain |

---

## Креативные скрипты

### 🎭 Ритуал подключения (`Mod+Shift+W`)

Анимированная последовательность в терминале:

```
╔══════════════════════════════════════════════════════════╗
║              CONNECTING TO THE WIRED                     ║
╚══════════════════════════════════════════════════════════╝

Layer 01: Initializing protocol...
  > Establishing connection to localhost:6600

Layer 02: Loading consciousness...
  > Memory allocation: OK

Layer 03: Syncing with network...
  > Signal strength: ██████████ 100%

Layer 04: You are now connected.

╔══════════════════════════════════════════════════════════╗
║   "No matter where you go, everyone's connected."        ║
╚══════════════════════════════════════════════════════════╝
```

### 👁️ Глитч-режим (`Mod+Shift+G`)

Временный визуальный глитч на 5 секунд:
- Случайные символы и цвета
- Случайные сообщения: "WHERE AM I?", "DISCONNECTED", "ERROR 404"
- После завершения: "Connection restored."

### 💬 Цитаты (`Mod+Shift+Q`)

Случайная цитата из 25 цитат аниме:
- "No matter where you go, everyone's connected."
- "If you aren't remembered, you don't exist."
- "Let's all love Lain."
- И ещё 22 цитаты...

### 🚪 Кинематографический выход (`Mod+Shift+E`)

Заменяет стандартный выход из i3:

```
╔══════════════════════════════════════════════════════════╗
║        Disconnect from the Wired?                        ║
╚══════════════════════════════════════════════════════════╝

[Y] Yes, I'm done.
[N] No, I'll stay.
```

При подтверждении:
```
Disconnecting...
Closing connections...
Saving memories...

╔══════════════════════════════════════════════════════════╗
║              Goodbye, Lain.                              ║
╚══════════════════════════════════════════════════════════╝

See you in the Wired...
```

---

## Структура репозитория

```
lain-i3-rice/
├── README.md                  # Этот файл
├── install.sh                 # Скрипт установки (идемпотентный)
├── packages.txt               # Список пакетов (~55)
├── Xresources                 # X11 ресурсы (цвета, курсор)
├── i3-config                  # Конфиг i3wm
├── polybar-config             # Конфиг polybar
├── picom.conf                 # Конфиг picom (CRT-эффект)
├── rofi.rasi                  # Тема rofi
├── alacritty.toml             # Конфиг alacritty (TOML формат)
├── dunstrc                    # Конфиг dunst
├── mpd.conf                   # Конфиг MPD
├── ncmpcpp.conf               # Конфиг ncmpcpp
├── gtk-3.0-settings.ini       # Настройки GTK темы
├── wallpaper.sh               # Скрипт установки обоев
├── lock.sh                    # Скрипт блокировки экрана
├── screenshot.sh              # Скрипт скриншотов
├── brightness.sh              # Скрипт управления яркостью
├── mpd-control.sh             # Скрипт управления MPD
├── setup-theme.sh             # Скрипт применения темы
├── connect-to-wired.sh        # Ритуал подключения
├── dissociation.sh            # Глитч-режим
├── quotes.sh                  # Случайные цитаты
├── 404.sh                     # Страница не найдена
└── ending.sh                  # Кинематографический выход
```

---

## Идемпотентность

Скрипт `install.sh` спроектирован идемпотентно:

1. **Пакеты**: перед установкой проверяется `pacman -Q`. Если уже установлен — пропускается.
2. **Конфиги**: если файл совпадает с эталоном (`diff -q`) — не трогается. Если отличается — создаётся бэкап с timestamp.
3. **Ссылки**: `ln -sfn` + проверка текущего target.
4. **Обои**: если файл уже существует — не скачивается повторно.
5. **Root**: скрипт отказывается работать от root (`$EUID -eq 0`).
6. **Конфликты**: автоматически удаляет PulseAudio перед установкой PipeWire, i3lock перед i3lock-color.

**Повторный запуск `./install.sh` безопасен** — ничего не сломается и не продублируется.

---

## Если что-то пошло не так

### Polybar не запускается

```bash
polybar -c ~/.config/polybar/config.ini main 2>&1 | head -20
```

### Picom вызывает артефакты

```bash
# Запустить без конфига для проверки
picom --backend glx
```

### Шрифт не отображает кириллицу

```bash
fc-list | grep "JetBrains Mono"
# Если нет:
sudo pacman -S ttf-jetbrains-mono
```

### Обои не установились

```bash
bash ~/.local/bin/wallpaper.sh --download
```

### i3lock не работает

```bash
i3lock --version
# Для themed version нужен i3lock-color из AUR:
yay -S i3lock-color
```

### Звук не работает

```bash
# Проверить PipeWire
systemctl --user status pipewire
systemctl --user status wireplumber

# Проверить совместимость
pactl info | grep "Server Name"
# Должно показать: PulseAudio (on PipeWire)
```

### Bluetooth не работает

```bash
sudo systemctl enable --now bluetooth
blueman-manager
```

### Polybar: батарея не отображается

Имя батареи и адаптера различается на разных ноутбуках. Проверьте:

```bash
ls /sys/class/power_supply/
```

Отредактируйте `~/.config/polybar/config.ini`:

```ini
[module/battery]
battery = BAT0    # Замените на ваше имя (BAT0, BAT1, BATT, CMB0)
adapter = AC      # Замените на ваше имя (AC, ACAD, ADP0, ADP1)
```

### Polybar: сеть не отображается на desktop

Если у вас desktop (нет Wi-Fi), отредактируйте `~/.config/polybar/config.ini`:

```ini
[module/network]
interface-type = ethernet  # Было: wireless
```

Или закомментируйте модуль network.

---

## Чек-лист после установки

- [ ] Polybar отображается сверху с модулями i3, MPD, date, cpu, memory, volume, network
- [ ] Alt+Shift переключает раскладку US/RU
- [ ] Обои Lain отображаются на рабочем столе
- [ ] Терминал (Mod+Enter) открывается с цветами Lain и шрифтом JetBrains Mono
- [ ] Rofi (Mod+d) открывается с темой Lain
- [ ] MPD запущен, виджет в polybar показывает текущий трек
- [ ] PipeWire работает (`pactl info`)
- [ ] Bluetooth applet в трее (если нужен)
- [ ] CRT-эффект виден (лёгкий шум через picom)

---

## Источники

- [Arch Wiki: i3](https://wiki.archlinux.org/title/I3)
- [i3wm User's Guide](https://i3wm.org/docs/userguide.html)
- [Arch Wiki: Polybar](https://wiki.archlinux.org/title/Polybar)
- [Arch Wiki: Picom](https://wiki.archlinux.org/title/Picom)
- [Arch Wiki: MPD](https://wiki.archlinux.org/title/Music_Player_Daemon)
- [Arch Wiki: PipeWire](https://wiki.archlinux.org/title/PipeWire)
- [Polybar Wiki](https://github.com/polybar/polybar/wiki)
- [Lain Color Guide](https://designbycurio.com) — Serial Experiments Lain visual analysis
- [Alacritty Configuration](https://alacritty.org/config-alacritty.html)
- [Rofi Theme Manual](https://github.com/davatorium/rofi/blob/next/doc/rofi-theme.5.markdown)
- Serial Experiments Lain (1998, Triangle Staff)

---

*Present day, present time... ha ha ha ha*
