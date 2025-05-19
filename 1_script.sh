#!/bin/bash

# Массив с нужными кодами ответа
status_codes=(100 200 302 404 500)

# Функция для выполнения запроса и обработки результата
make_request() {
    local code=$1
    local url="https://httpstat.us/$code"
    
    # Выполняем запрос, сохраняем статус-код и тело ответа
    response=$(curl -s -w "\n%{http_code}" "$url")
    body=$(echo "$response" | sed '$d')         # Всё кроме последней строки
    status=$(echo "$response" | tail -n1)       # Последняя строка — это статус

    # Обработка ответа
    if [[ $status =~ ^1[0-9]{2}$ || $status =~ ^2[0-9]{2}$ || $status =~ ^3[0-9]{2}$ ]]; then
        echo "[INFO] Status: $status"
        echo "[INFO] Body: $body"
        echo "--------------------------"
    elif [[ $status =~ ^4[0-9]{2}$ || $status =~ ^5[0-9]{2}$ ]]; then
        echo "[ERROR] Status: $status"
        echo "[ERROR] Body: $body"
        echo "[EXCEPTION] HTTP error occurred with status code $status"
        echo "--------------------------"
    else
        echo "[WARNING] Unknown status code: $status"
        echo "--------------------------"
    fi
}

# Основной цикл по кодам
for code in "${status_codes[@]}"; do
    make_request "$code"
done
