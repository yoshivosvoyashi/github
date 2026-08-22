#!/bin/bash

# Переменные (ИМЯ=ЗНАЧЕНИЕ, без пробелов!)
# Подстановка команд через $(command)
# Можно вводить
read -rp 'Your Login: ' login_name
echo $1$login_name
# Добавляем флаг s для скрытого ввода (не зеркалирует ввод на экран)
# && echo добавили для красивого вывода 
read -rsp 'Your password: ' password && echo
echo $password

