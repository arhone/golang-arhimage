# Aimger

Сервис для обработки изображений.

# Установка проекта

Получить проект
```shell
sudo mkdir -p /srv/arhone/aimger && chown $USER:$USER /srv/arhone/aimger
git clone https://github.com/arhone/aimger.git && cd /srv/arhone/aimger
```

Настроить проект
````shell
cp .example.env .env
nano .env
````

Запустить проект в докере
```shell
docker compose -f docker-compose.yml up -d --build --remove-orphans
# docker compose -f docker-compose.local.yml up -d --build --remove-orphans
```

Войти в контейнер
```shell
docker exec -it arhone-aimger /bin/bash
```