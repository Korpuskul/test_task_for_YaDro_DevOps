# Используем официальный образ Ubuntu 22.04
FROM ubuntu:22.04

# Установим curl и bash (и обновим пакеты)
RUN apt-get update && \
    apt-get install -y curl bash && \
    apt-get clean

# Копируем bash-скрипт в контейнер
COPY check_http.sh /usr/local/bin/check_http.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/local/bin/check_http.sh

# Указываем скрипт как команду по умолчанию
CMD ["/usr/local/bin/check_http.sh"]
