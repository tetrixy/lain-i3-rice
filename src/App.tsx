import { useState } from 'react';
import { repoFiles, repoTree, hotkeys, lainColors, RepoFile } from './data/repoData';

// Section types
type Section = 'overview' | 'files' | 'hotkeys' | 'install' | 'palette';

function App() {
  const [activeSection, setActiveSection] = useState<Section>('overview');
  const [selectedFile, setSelectedFile] = useState<RepoFile>(repoFiles[0]);
  const [copiedFile, setCopiedFile] = useState<string | null>(null);

  const copyToClipboard = (text: string, fileName: string) => {
    navigator.clipboard.writeText(text).then(() => {
      setCopiedFile(fileName);
      setTimeout(() => setCopiedFile(null), 2000);
    });
  };

  return (
    <div className="min-h-screen bg-lain-bg noise-bg">
      {/* CRT scanline overlay */}
      <div className="crt-overlay" />

      {/* Header */}
      <header className="border-b border-lain-border bg-lain-bg-alt/80 backdrop-blur-sm sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-3 h-3 rounded-full bg-lain-green pulse-green" />
            <h1 className="text-lg font-medium text-lain-text flicker">
              <span className="text-lain-green">lain</span>-i3-rice
            </h1>
            <span className="text-xs text-lain-text-dim hidden sm:inline">
              Serial Experiments Lain
            </span>
          </div>
          <div className="flex items-center gap-1 text-xs">
            <span className="text-lain-text-dim">status:</span>
            <span className="text-lain-green ml-1">connected</span>
          </div>
        </div>
      </header>

      {/* Navigation */}
      <nav className="border-b border-lain-border bg-lain-bg-alt/40">
        <div className="max-w-7xl mx-auto px-4 flex gap-0 overflow-x-auto">
          {([
            ['overview', 'Обзор'],
            ['files', 'Файлы'],
            ['hotkeys', 'Горячие клавиши'],
            ['install', 'Установка'],
            ['palette', 'Палитра'],
          ] as [Section, string][]).map(([key, label]) => (
            <button
              key={key}
              onClick={() => setActiveSection(key)}
              className={`px-4 py-3 text-sm nav-link whitespace-nowrap transition-colors ${
                activeSection === key
                  ? 'tab-active'
                  : 'text-lain-text-dim hover:text-lain-text'
              }`}
            >
              {label}
            </button>
          ))}
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 py-8">
        {activeSection === 'overview' && <OverviewSection />}
        {activeSection === 'files' && (
          <FilesSection
            selectedFile={selectedFile}
            setSelectedFile={setSelectedFile}
            copiedFile={copiedFile}
            copyToClipboard={copyToClipboard}
          />
        )}
        {activeSection === 'hotkeys' && <HotkeysSection />}
        {activeSection === 'install' && <InstallSection />}
        {activeSection === 'palette' && <PaletteSection />}
      </main>

      {/* Footer */}
      <footer className="border-t border-lain-border mt-16 py-6">
        <div className="max-w-7xl mx-auto px-4 text-center text-xs text-lain-text-dim">
          <p className="mb-2">
            <span className="text-lain-blood-bright">Present day, present time...</span>
            <span className="ml-2">ha ha ha ha</span>
          </p>
          <p>
            Sources: Arch Wiki • i3wm.org • designbycurio.com • Serial Experiments Lain (1998)
          </p>
        </div>
      </footer>
    </div>
  );
}

// ============================================================================
// Section Components
// ============================================================================

function OverviewSection() {
  return (
    <div className="space-y-8">
      {/* Hero */}
      <div className="text-center py-16 border border-lain-border rounded-sm relative overflow-hidden">
        <div 
          className="absolute inset-0 opacity-40"
          style={{
            backgroundImage: 'url(https://image.qwenlm.ai/generated-images/fbd29529-9653-4ab4-be62-fea1e2cf368a/_result.png)',
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        />
        <div className="absolute inset-0 bg-gradient-to-b from-lain-bg/60 via-lain-bg/80 to-lain-bg" />
        <div className="relative">
          <h2 className="text-4xl font-bold mb-3 glitch-text">
            <span className="text-lain-green">lain</span>-i3-rice
          </h2>
          <p className="text-lain-text-dim text-sm mb-4">
            i3wm rice в стиле Serial Experiments Lain для Arch Linux
          </p>
          <p className="text-lain-text text-sm max-w-xl mx-auto leading-relaxed">
            Полный, рабочий и идемпотентный репозиторий для «райса» в стиле Lain.
            После клонирования и запуска <code className="text-lain-green bg-lain-bg px-1 rounded">./install.sh</code> на
            чистом Arch Linux система превращается в готовый i3wm-райс.
          </p>
          <div className="mt-6 flex justify-center gap-3">
            <span className="px-3 py-1 text-xs border border-lain-green/50 text-lain-green rounded-sm">i3-wm</span>
            <span className="px-3 py-1 text-xs border border-lain-border text-lain-text-dim rounded-sm">polybar</span>
            <span className="px-3 py-1 text-xs border border-lain-border text-lain-text-dim rounded-sm">picom</span>
            <span className="px-3 py-1 text-xs border border-lain-border text-lain-text-dim rounded-sm">rofi</span>
            <span className="px-3 py-1 text-xs border border-lain-border text-lain-text-dim rounded-sm">alacritty</span>
          </div>
        </div>
      </div>

      {/* Features Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <FeatureCard
          icon="⌨"
          title="i3-wm"
          description="Тайловый оконный менеджер с пиксельными бордерами, gaps и workspace-именами из аниме"
        />
        <FeatureCard
          icon="◈"
          title="CRT-эффект"
          description="Picom с dithered-present для лёгкого film grain. Читаемость важнее эффектов"
        />
        <FeatureCard
          icon="▣"
          title="Идемпотентность"
          description="Повторный запуск install.sh не ломает систему. Бэкапы, проверки, --dry-run"
        />
      </div>

      {/* Repo Tree */}
      <div className="border border-lain-border rounded-sm">
        <div className="px-4 py-2 border-b border-lain-border bg-lain-bg-alt/50 flex items-center gap-2">
          <span className="text-lain-green text-xs">▸</span>
          <span className="text-sm text-lain-text">Структура репозитория</span>
        </div>
        <pre className="p-4 text-xs text-lain-text-dim leading-relaxed overflow-x-auto">
          {repoTree}
        </pre>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <StatCard label="Файлов" value="9" />
        <StatCard label="Пакетов" value="~20" />
        <StatCard label="Горячих клавиш" value={hotkeys.length.toString()} />
        <StatCard label="AUR-пакетов" value="2" />
      </div>

      {/* Requirements */}
      <div className="border border-lain-border rounded-sm p-4">
        <h3 className="text-sm font-medium text-lain-text mb-3">Требования</h3>
        <ul className="space-y-2 text-sm text-lain-text-dim">
          <li className="flex items-start gap-2">
            <span className="text-lain-green mt-0.5">›</span>
            Arch Linux (чистая установка или существующая система)
          </li>
          <li className="flex items-start gap-2">
            <span className="text-lain-green mt-0.5">›</span>
            Пользователь с правами sudo
          </li>
          <li className="flex items-start gap-2">
            <span className="text-lain-green mt-0.5">›</span>
            AUR-помощник: <code className="text-lain-text bg-lain-bg px-1 rounded">yay</code> или <code className="text-lain-text bg-lain-bg px-1 rounded">paru</code>
          </li>
          <li className="flex items-start gap-2">
            <span className="text-lain-green mt-0.5">›</span>
            Интернет для загрузки пакетов и обоев
          </li>
        </ul>
      </div>
    </div>
  );
}

function FilesSection({
  selectedFile,
  setSelectedFile,
  copiedFile,
  copyToClipboard,
}: {
  selectedFile: RepoFile;
  setSelectedFile: (f: RepoFile) => void;
  copiedFile: string | null;
  copyToClipboard: (text: string, name: string) => void;
}) {
  const categories = [
    { key: 'root', label: 'Корень' },
    { key: 'config', label: 'Конфигурации' },
    { key: 'scripts', label: 'Скрипты' },
  ];

  return (
    <div className="grid grid-cols-1 lg:grid-cols-4 gap-4">
      {/* File list */}
      <div className="lg:col-span-1 border border-lain-border rounded-sm">
        <div className="px-3 py-2 border-b border-lain-border bg-lain-bg-alt/50">
          <span className="text-xs text-lain-text-dim">Файлы</span>
        </div>
        {categories.map((cat) => (
          <div key={cat.key}>
            <div className="px-3 py-1.5 text-xs text-lain-text-dim bg-lain-bg/50 border-b border-lain-border/50">
              {cat.label}
            </div>
            {repoFiles
              .filter((f) => f.category === cat.key)
              .map((file) => (
                <button
                  key={file.path}
                  onClick={() => setSelectedFile(file)}
                  className={`w-full text-left px-3 py-2 text-xs border-b border-lain-border/30 transition-colors ${
                    selectedFile.path === file.path
                      ? 'bg-lain-bg-alt text-lain-green border-l-2 border-l-lain-green'
                      : 'text-lain-text-dim hover:text-lain-text hover:bg-lain-bg-alt/50'
                  }`}
                >
                  <span className="block truncate">{file.path}</span>
                </button>
              ))}
          </div>
        ))}
      </div>

      {/* File content */}
      <div className="lg:col-span-3 border border-lain-border rounded-sm">
        <div className="px-4 py-2 border-b border-lain-border bg-lain-bg-alt/50 flex items-center justify-between">
          <div>
            <span className="text-sm text-lain-text font-medium">{selectedFile.path}</span>
            <span className="text-xs text-lain-text-dim ml-3">{selectedFile.description}</span>
          </div>
          <button
            onClick={() => copyToClipboard(selectedFile.content, selectedFile.path)}
            className="text-xs px-2 py-1 border border-lain-border rounded-sm text-lain-text-dim hover:text-lain-green hover:border-lain-green transition-colors"
          >
            {copiedFile === selectedFile.path ? '✓ Скопировано' : 'Копировать'}
          </button>
        </div>
        <div className="code-block border-0 rounded-none">
          <pre className="text-xs leading-relaxed max-h-[70vh] overflow-auto">
            <code>{selectedFile.content}</code>
          </pre>
        </div>
      </div>
    </div>
  );
}

function HotkeysSection() {
  return (
    <div className="space-y-6">
      <div className="border border-lain-border rounded-sm">
        <div className="px-4 py-3 border-b border-lain-border bg-lain-bg-alt/50">
          <h3 className="text-sm font-medium text-lain-text">Горячие клавиши i3</h3>
          <p className="text-xs text-lain-text-dim mt-1">Mod = Super (Win) key</p>
        </div>
        <div className="divide-y divide-lain-border/50">
          {hotkeys.map((hk) => (
            <div key={hk.keys} className="px-4 py-3 flex items-center justify-between gap-4">
              <div className="flex items-center gap-3">
                <kbd className="px-2 py-0.5 text-xs bg-lain-bg border border-lain-border rounded-sm text-lain-green font-mono">
                  {hk.keys}
                </kbd>
                <span className="text-sm text-lain-text hidden sm:inline">{hk.action}</span>
              </div>
              <span className="text-xs text-lain-text-dim">{hk.actionRu}</span>
            </div>
          ))}
        </div>
      </div>

      <div className="border border-lain-border rounded-sm p-4">
        <h3 className="text-sm font-medium text-lain-text mb-2">Рабочие пространства</h3>
        <p className="text-xs text-lain-text-dim mb-3">
          Названия воркспейсов взяты из терминологии Serial Experiments Lain:
        </p>
        <div className="flex flex-wrap gap-2">
          {['wired', 'protocol', 'layer', 'dial', 'flux', 'schema', 'knight', 'nexus', 'ego', 'lain'].map(
            (name, i) => (
              <span
                key={name}
                className="px-2 py-1 text-xs bg-lain-bg border border-lain-border rounded-sm"
              >
                <span className="text-lain-green">{i + 1}:</span>{' '}
                <span className="text-lain-text">{name}</span>
              </span>
            )
          )}
        </div>
      </div>
    </div>
  );
}

function InstallSection() {
  return (
    <div className="space-y-6">
      {/* Installation Steps */}
      <div className="border border-lain-border rounded-sm">
        <div className="px-4 py-3 border-b border-lain-border bg-lain-bg-alt/50">
          <h3 className="text-sm font-medium text-lain-text">Установка</h3>
        </div>
        <div className="p-4 space-y-4">
          <InstallStep
            step={1}
            title="Клонировать репозиторий"
            command="git clone https://github.com/YOUR_USERNAME/lain-i3-rice.git && cd lain-i3-rice"
          />
          <InstallStep
            step={2}
            title="(Опционально) Dry-run — проверить что будет сделано"
            command="./install.sh --dry-run"
          />
          <InstallStep
            step={3}
            title="Запустить установку"
            command="./install.sh"
          />
          <InstallStep
            step={4}
            title="Выйти и войти в i3"
            command="Выйти из текущей сессии → выбрать i3 в DM → войти"
          />
        </div>
      </div>

      {/* AUR helper */}
      <div className="border border-lain-border rounded-sm p-4">
        <h3 className="text-sm font-medium text-lain-text mb-2">
          Если нет AUR-помощника
        </h3>
        <div className="code-block mt-2">
          <pre className="text-xs">
{`# Установка yay
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && rm -rf yay`}
          </pre>
        </div>
      </div>

      {/* Idempotency */}
      <div className="border border-lain-border rounded-sm p-4">
        <h3 className="text-sm font-medium text-lain-text mb-3">Идемпотентность</h3>
        <ul className="space-y-2 text-sm text-lain-text-dim">
          <li className="flex items-start gap-2">
            <span className="text-lain-green">1.</span>
            <span><strong className="text-lain-text">Пакеты:</strong> перед установкой проверяется <code className="text-lain-green bg-lain-bg px-1 rounded">pacman -Q</code>. Если уже установлен — пропускается.</span>
          </li>
          <li className="flex items-start gap-2">
            <span className="text-lain-green">2.</span>
            <span><strong className="text-lain-text">Конфиги:</strong> если файл совпадает с эталоном (<code className="text-lain-green bg-lain-bg px-1 rounded">diff -q</code>) — не трогается. Если отличается — создаётся бэкап с timestamp.</span>
          </li>
          <li className="flex items-start gap-2">
            <span className="text-lain-green">3.</span>
            <span><strong className="text-lain-text">Ссылки:</strong> <code className="text-lain-green bg-lain-bg px-1 rounded">ln -sfn</code> + проверка текущего target.</span>
          </li>
          <li className="flex items-start gap-2">
            <span className="text-lain-green">4.</span>
            <span><strong className="text-lain-text">Обои:</strong> если файл уже существует — не скачивается повторно.</span>
          </li>
          <li className="flex items-start gap-2">
            <span className="text-lain-green">5.</span>
            <span><strong className="text-lain-text">Root:</strong> скрипт отказывается работать от root (<code className="text-lain-green bg-lain-bg px-1 rounded">$EUID -eq 0</code>).</span>
          </li>
        </ul>
      </div>

      {/* Troubleshooting */}
      <div className="border border-lain-border rounded-sm">
        <div className="px-4 py-3 border-b border-lain-border bg-lain-bg-alt/50">
          <h3 className="text-sm font-medium text-lain-blood-bright">Если что-то пошло не так</h3>
        </div>
        <div className="p-4 space-y-4">
          <TroubleshootItem
            problem="Polybar не запускается"
            solution="polybar -c ~/.config/polybar/config.ini main 2>&1 | head -20"
          />
          <TroubleshootItem
            problem="Picom вызывает артефакты"
            solution="picom --backend glx  # проверить без конфига"
          />
          <TroubleshootItem
            problem="Шрифт не отображает кириллицу"
            solution="fc-list | grep 'JetBrains Mono'  # если нет: sudo pacman -S ttf-jetbrains-mono"
          />
          <TroubleshootItem
            problem="Обои не установились"
            solution="bash ~/.local/bin/wallpaper.sh --download"
          />
          <TroubleshootItem
            problem="i3lock не работает"
            solution="i3lock --version  # для themed: yay -S i3lock-color"
          />
        </div>
      </div>

      {/* Post-install checklist */}
      <div className="border border-lain-border rounded-sm p-4">
        <h3 className="text-sm font-medium text-lain-text mb-3">
          ✓ Чек-лист после установки
        </h3>
        <ul className="space-y-2 text-sm text-lain-text-dim">
          <li className="flex items-start gap-2">
            <input type="checkbox" className="mt-0.5 accent-lain-green" readOnly />
            <span>Проверить, что polybar отображается сверху экрана с модулями i3, date, cpu, memory</span>
          </li>
          <li className="flex items-start gap-2">
            <input type="checkbox" className="mt-0.5 accent-lain-green" readOnly />
            <span>Убедиться, что Alt+Shift переключает раскладку US/RU</span>
          </li>
          <li className="flex items-start gap-2">
            <input type="checkbox" className="mt-0.5 accent-lain-green" readOnly />
            <span>Проверить, что обои Lain отображаются на рабочем столе</span>
          </li>
          <li className="flex items-start gap-2">
            <input type="checkbox" className="mt-0.5 accent-lain-green" readOnly />
            <span>Открыть терминал (Mod+Enter) — проверить цвета и шрифт</span>
          </li>
          <li className="flex items-start gap-2">
            <input type="checkbox" className="mt-0.5 accent-lain-green" readOnly />
            <span>Запустить rofi (Mod+d) — проверить, что открывается с темой Lain</span>
          </li>
        </ul>
      </div>
    </div>
  );
}

function PaletteSection() {
  return (
    <div className="space-y-6">
      <div className="border border-lain-border rounded-sm">
        <div className="px-4 py-3 border-b border-lain-border bg-lain-bg-alt/50">
          <h3 className="text-sm font-medium text-lain-text">Цветовая палитра Lain</h3>
          <p className="text-xs text-lain-text-dim mt-1">
            Источники: designbycurio.com, кадры Serial Experiments Lain
          </p>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-px bg-lain-border">
          {lainColors.map((color) => (
            <div
              key={color.hex}
              className="flex items-center gap-3 p-4 bg-lain-bg"
            >
              <div
                className="w-10 h-10 rounded-sm border border-lain-border flex-shrink-0"
                style={{ backgroundColor: color.hex }}
              />
              <div className="min-w-0">
                <div className="text-sm text-lain-text truncate">{color.name}</div>
                <div className="text-xs text-lain-green font-mono">{color.hex}</div>
                <div className="text-xs text-lain-text-dim truncate">{color.usage}</div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Visual Preview */}
      <div className="border border-lain-border rounded-sm">
        <div className="px-4 py-3 border-b border-lain-border bg-lain-bg-alt/50">
          <h3 className="text-sm font-medium text-lain-text">Предпросмотр: как выглядит рабочий стол</h3>
        </div>
        <div className="p-4">
          <DesktopPreview />
        </div>
      </div>

      {/* Typography */}
      <div className="border border-lain-border rounded-sm p-4">
        <h3 className="text-sm font-medium text-lain-text mb-3">Типографика</h3>
        <div className="space-y-3">
          <div>
            <span className="text-xs text-lain-text-dim">Основной шрифт:</span>
            <p className="text-lain-text font-mono text-lg">JetBrains Mono — Aa Бб Вв Гг 0123456789</p>
          </div>
          <div>
            <span className="text-xs text-lain-text-dim">Поддержка кириллицы:</span>
            <p className="text-lain-text font-mono">Привет, Lain. СегодняPresent day, present time.</p>
          </div>
          <div>
            <span className="text-xs text-lain-text-dim">Альтернатива:</span>
            <p className="text-lain-text font-mono text-sm">Iosevka (ttf-iosevka) — также включён в packages.txt</p>
          </div>
        </div>
      </div>
    </div>
  );
}

// ============================================================================
// Helper Components
// ============================================================================

function FeatureCard({ icon, title, description }: { icon: string; title: string; description: string }) {
  return (
    <div className="border border-lain-border rounded-sm p-4 bg-lain-bg-alt/20 hover:border-lain-green/30 transition-colors">
      <div className="text-2xl mb-2">{icon}</div>
      <h3 className="text-sm font-medium text-lain-text mb-1">{title}</h3>
      <p className="text-xs text-lain-text-dim leading-relaxed">{description}</p>
    </div>
  );
}

function StatCard({ label, value }: { label: string; value: string }) {
  return (
    <div className="border border-lain-border rounded-sm p-3 text-center">
      <div className="text-xl font-bold text-lain-green">{value}</div>
      <div className="text-xs text-lain-text-dim mt-1">{label}</div>
    </div>
  );
}

function InstallStep({ step, title, command }: { step: number; title: string; command: string }) {
  return (
    <div className="flex items-start gap-3">
      <div className="w-6 h-6 rounded-full border border-lain-green flex items-center justify-center text-xs text-lain-green flex-shrink-0">
        {step}
      </div>
      <div className="flex-1 min-w-0">
        <p className="text-sm text-lain-text mb-1">{title}</p>
        <code className="text-xs text-lain-green bg-lain-bg px-2 py-1 rounded-sm block overflow-x-auto">
          $ {command}
        </code>
      </div>
    </div>
  );
}

function TroubleshootItem({ problem, solution }: { problem: string; solution: string }) {
  return (
    <div>
      <p className="text-sm text-lain-text mb-1">⚠ {problem}</p>
      <code className="text-xs text-lain-text-dim bg-lain-bg px-2 py-1 rounded-sm block overflow-x-auto">
        $ {solution}
      </code>
    </div>
  );
}

function DesktopPreview() {
  return (
    <div className="border border-lain-border rounded-sm overflow-hidden" style={{ backgroundColor: '#0d0f14' }}>
      {/* Fake polybar */}
      <div className="h-7 flex items-center px-3 text-xs border-b" style={{ backgroundColor: '#0d0f14', borderColor: '#2a2f3a' }}>
        <div className="flex items-center gap-3">
          <span style={{ color: '#39ff14' }}>1: wired</span>
          <span style={{ color: '#6b7280' }}>2: protocol</span>
          <span style={{ color: '#6b7280' }}>3: layer</span>
          <span style={{ color: '#6b7280' }}>4: dial</span>
        </div>
        <div className="flex-1 text-center" style={{ color: '#b8c0cc' }}>
          Mon 15.01.2024  23:42
        </div>
        <div className="flex items-center gap-3">
          <span style={{ color: '#6b7280' }}>MEM 34%</span>
          <span style={{ color: '#6b7280' }}>CPU 12%</span>
          <span style={{ color: '#6b7280' }}>VOL 65%</span>
          <span style={{ color: '#39ff14' }}>NET lain-net</span>
        </div>
      </div>

      {/* Fake desktop */}
      <div className="h-64 flex items-center justify-center relative" style={{ backgroundColor: '#0d0f14' }}>
        {/* Fake terminal window */}
        <div className="border border-lain-border rounded-sm w-80 shadow-lg" style={{ borderColor: '#4a7c59' }}>
          <div className="h-5 flex items-center px-2 text-xs" style={{ backgroundColor: '#131927', borderBottom: '1px solid #2a2f3a' }}>
            <span style={{ color: '#6b7280' }}>alacritty</span>
          </div>
          <div className="p-2 text-xs font-mono" style={{ backgroundColor: '#0d0f14' }}>
            <div><span style={{ color: '#4a7c59' }}>lain@arch</span><span style={{ color: '#b8c0cc' }}>:</span><span style={{ color: '#3d5a80' }}>~</span><span style={{ color: '#b8c0cc' }}>$ neofetch</span></div>
            <div style={{ color: '#6b7280' }} className="mt-1">
              <div>OS: Arch Linux x86_64</div>
              <div>WM: i3</div>
              <div>Terminal: alacritty</div>
            </div>
            <div className="flex gap-1 mt-1">
              {['#0d0f14', '#6b2d3c', '#4a7c59', '#8b7355', '#3d5a80', '#4d353c', '#b8c0cc'].map(c => (
                <div key={c} className="w-3 h-3 rounded-sm" style={{ backgroundColor: c }} />
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
