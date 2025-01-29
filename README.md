# Fork
для личного пользования, с использованием одного VPS и списков от itDog
- inside russia
- subnets (Meta/Discord/Twitter)
автообновляемые списки:
https://raw.githubusercontent.com/Nocturnal-ru/itdog-inside-russia-list-to-json/main/inside-russia.json
https://raw.githubusercontent.com/Nocturnal-ru/itdog-inside-russia-list-to-json/main/subnets.json

# Singbox as service

Проект для управления [sing-box](https://github.com/SagerNet/sing-box) как службой Windows с возможностью маршрутизации трафика по настраиваемым правилам.

## Особенности

- Управление sing-box как службой Windows (установка, запуск, остановка, удаление)
- Поддержка двух режимов работы: TUN и Proxy
- Поддержка DNS-over-HTTPS через Google DNS
- Маршрутизация трафика на основе правил для различных сервисов (Discord, YouTube, TikTok)
- Автоматическое обновление правил антиблокировки [Антизапрет](https://github.com/savely-krasovsky/antizapret-sing-box) через remote ruleset
- Поддержка VLESS + Reality для безопасного соединения
- TUN интерфейс для системной маршрутизации трафика

## Структура проекта

```
VPN-Service-Sample/
├── sing-box/                       # Основная директория
│   ├── rules/                      # Правила маршрутизации
│   │   ├── custom-rules.json       # Пользовательские правила
|   │   ├── no-russia-hosts.json    # [Правила](https://github.com/dartraiden/no-russia-hosts) для хостов, ограничивающих/цензурирующих российский трафик (c моими правками)
│   │   ├── geosite-*.srs           # Бинарные файлы правил для сайтов
│   │   └── geoip-*.srs             # Бинарные файлы правил для IP
│   ├── config-tun.json             # Конфиг для режима TUN
│   ├── config-proxy.json           # Конфиг для режима Proxy
│   ├── sing-box.exe                # Исполняемый файл sing-box
│   |── singbox-service.xml         # Конфигурация WinSw службы
|   |── singbox-service.exe         # Исполняемый файл WinSw для работы службы
├── install-service.bat             # Установка службы
├── uninstall-service.bat           # Удаление службы
├── start-service.bat               # Запуск службы
├── stop-service.bat                # Остановка службы
├── restart-service.bat             # Перезапуск службы
├── status-service.bat              # Проверка статуса службы
├── change-mode.bat                 # Переключение между режимами TUN и Proxy
├── show-mode.bat                   # Отображение текущего режима
└── start-once-without-service.bat  # Запуск без установки службы
```

## Установка

1. Клонируйте репозиторий в удобное место на вашем компьютере. **ВАЖНО:** путь к папке проекта не должен содержать пробелов
2. Выберите нужный режим работы с помощью `change-mode.bat`
3. Настройте параметры подключения в `config-tun.json` и `config-proxy.json`. Для этого есть два способа:
   - Переименуйте `config-tun.json.example` в `config-tun.json`
   - Переименуйте `config-proxy.json.example` в `config-proxy.json`
   - Удалите комментарии в конфигах
   - Экспортируйте конфигурацию из NekoBox, либо воспользуйтесь генератором конфигурации: [XKeen Config Generator](https://corvus-malus.github.io/XKeen-Config-Generator/) и скопируйте конфигурацию вашего outbound в конфиги
   - Обязательно сохраните теги "proxy" и "proxy-youtube" в конфигах как в примерах (они используются в правилах маршрутизации)
4. Бесплатный VLESS можно получить тут: [Aeza VLESS Generator](https://github.com/vernette/aeza-vless-generator)
5. Запустите `install-service.bat` от имени администратора для установки службы

## Управление службой и режимами

### Управление службой

- `install-service.bat` - установка службы Windows
- `uninstall-service.bat` - удаление службы
- `start-service.bat` - запуск службы
- `stop-service.bat` - остановка службы
- `restart-service.bat` - перезапуск службы
- `status-service.bat` - проверка статуса службы
- `start-once-without-service.bat` - запуск sing-box без установки службы

### Управление режимами

- `change-mode.bat` - переключение между режимами TUN и Proxy и перезапуск службы
- `show-mode.bat` - отображение текущего активного режима

### Режим прокси

Локальный прокси слушает на адресе: "127.0.0.1", порт: 2080,
Пример строки подключения: `socks://127.0.0.1:2080`

## Конфигурация

### Основные компоненты конфигурационных файлов:

- DNS настройки с поддержкой DNS-over-HTTPS
- TUN интерфейс для системной маршрутизации (только в режиме TUN)
- Несколько исходящих соединений (outbounds) для разных сервисов
- Правила маршрутизации на основе геолокации и пользовательских списков
- Автоматическое обновление правил антиблокировки

### Служба Windows

Служба настроена со следующими параметрами:

- Автоматический перезапуск при сбоях (через 10 секунд)
- Сброс счетчика сбоев каждый час
- Нормальный приоритет процесса
- Тайм-аут остановки службы: 15 секунд
- Ротация логов по размеру (10 МБ, хранение 8 файлов)

## Требования

- Windows 7/8/10/11
- Права администратора для управления службой
- Поддержка TUN-интерфейса в системе (для режима TUN)

## Безопасность

- Используется VLESS + Reality для безопасного соединения
- Строгая маршрутизация через TUN-интерфейс (в режиме TUN)
- Блокировка UDP на порту 443
- Защита от DNS-утечек через DNS-over-HTTPS

## Логирование

- Основной лог: `box.log`
- Логи службы: `singbox-service.err.log`, `singbox-service.out.log`, `singbox-service.wrapper.log`
- Уровень логирования: warning (можно изменить в конфигурационных файлах)
