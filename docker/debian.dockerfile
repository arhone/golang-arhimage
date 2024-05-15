ARG RELEASE=bullseye
FROM debian:${RELEASE}-slim

ARG TIME_ZONE

# Подготовка системы
RUN set -x \
    && apt-get -y update  \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y upgrade \
    && apt-get -y install bash tzdata wget htop nano locales \
    && sed -i '/ru_RU.UTF-8/s/^# //g' /etc/locale.gen && locale-gen \
    && cp /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
    && echo ${TIME_ZONE} > /etc/timezone

ENV LANGUAGE ru_RU.UTF-8
ENV LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

# Создание пользователя и группы
ARG USER_NAME
ARG USER_ID
ARG GROUP_ID
RUN groupadd --gid ${GROUP_ID} ${USER_NAME} 2> /dev/null || true \
    && useradd --uid ${USER_ID} --gid ${GROUP_ID} --create-home ${USER_NAME} 2> /dev/null || true

# Установка golang
COPY ./docker/import/go ./go
RUN tar -C /usr/local -xzf ./go/go1.22.3.linux-amd64.tar.gz && export PATH=$PATH:/usr/local/go/bin && rm -rf ./go

WORKDIR /srv/aimger

# Копирование кода и настроек приложения
COPY ./.env .
COPY ./go.mod .
COPY ./go.sum .
COPY ./main.go .

# Сборка проекта
RUN /usr/local/go/bin/go mod download && /usr/local/go/bin/go build main.go

# Запуск через CMD
CMD /srv/aimger/main
# Тестовый запуск
#CMD ["sleep", "infinity"]