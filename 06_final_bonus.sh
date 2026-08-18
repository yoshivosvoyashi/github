#!/bin/bash

# --- ИНИЦИАЛИЗАЦИЯ ФУНКЦИЙ ---
log_info() { echo "[$(date +%T)] INFO: $1"; }
log_error() { echo "[$(date +%T)] ERROR: $1" >&2; }

# --- ПРОВЕРКА АРГУМЕНТОВ ---
TARGET_DIR=$1
if [[ -z "$TARGET_DIR" || ! -d "$TARGET_DIR" ]]; then
    log_error "Укажите корректный путь к директории логов."
    exit 1
fi

# --- ЦИКЛЫ И ЗАВЕРШЕНИЕ ---

# Создаем папку для бэкапов
DEST_DIR="./backups_$(date +%F)"
mkdir -p "$DEST_DIR"

log_info "Архивация файлов из $TARGET_DIR в $DEST_DIR..."

# Цикл for для поиска всех .log файлов
for file in "$TARGET_DIR"/*.log; do
    if [[ -f "$file" ]]; then
        FILE_NAME=$(basename "$file")
        log_info "Упаковываю: $FILE_NAME"
        
        # Архивируем файл не выводя ничего на экран
        tar -czf "$DEST_DIR/$FILE_NAME.tar.gz" "$file" 2>/dev/null
    fi
done

# Финальный отчет с использованием Pipe и awk
DISK_FREE=$(df -h / | tail -1 | awk '{print $5}')

log_info "Бэкап завершен успешно!"
log_info "Текущая загрузка диска: $DISK_FREE"

exit 0
