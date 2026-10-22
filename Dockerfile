# Cборка
FROM ubuntu:24.04 AS builder

RUN apt-get update && apt-get install -y \
    g++ make dpkg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY app.cpp Makefile ./
COPY debian/ debian/
COPY tests/ tests/

# Сборка бинарника и .deb внутри образа
RUN make && make deb

# Финальный образ
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Копирование собранного .deb из builder
COPY --from=builder /src/findmax-1.0-amd64.deb /tmp/

# Устанавка пакета
RUN dpkg -i /tmp/findmax-1.0-amd64.deb \
    && rm /tmp/findmax-1.0-amd64.deb

# Запуск
CMD ["findmax"]
