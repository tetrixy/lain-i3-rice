# lain-i3-rice — Web Presentation

> *"No matter where you go, everyone's connected."*

Веб-приложение, представляющее полный репозиторий i3wm-райса в стиле **Serial Experiments Lain** для Arch Linux.

## О проекте

Это интерактивная документация и презентация dotfiles-репозитория, включающая:

- **Обзор** — структура репозитория, возможности, требования
- **Файлы** — полное содержимое всех конфигов с возможностью копирования
- **Горячие клавиши** — все биндинги i3wm с русскими описаниями
- **Установка** — пошаговая инструкция + чек-лист + траблшутинг
- **Палитра** — цветовая схема Lain с HEX-кодами и предпросмотром рабочего стола

## Стиль

Визуальный стиль приложения повторяет эстетику райса:
- Тёмный сине-серый фон (#0d0f14)
- Акценты «оксидной крови» (#4d353c, #6b2d3c)
- Неоновый зелёный (#39ff14) для «живого сигнала»
- Моноширинный шрифт JetBrains Mono
- CRT-эффект (scanlines overlay)
- Glitch-анимация заголовка

## Технологии

- React 18 + TypeScript
- Vite
- Tailwind CSS v4
- Vite `?raw` imports для конфигов

## Сборка

```bash
npm install
npm run build
```

## Источники

- [Arch Wiki: i3](https://wiki.archlinux.org/title/I3)
- [i3wm User's Guide](https://i3wm.org/docs/userguide.html)
- [Arch Wiki: Polybar](https://wiki.archlinux.org/title/Polybar)
- [Arch Wiki: Picom](https://wiki.archlinux.org/title/Picom)
- [Lain Color Guide](https://designbycurio.com)
- Serial Experiments Lain (1998, Triangle Staff)

---

*Present day, present time... ha ha ha ha*
