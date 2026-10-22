# maxfinder-distribution

Проект демонстрирует полный цикл доставки ПО от исходного кода до релиза на чистой системе: Makefile, deb-пакет, CI/CD на GitHub Actions, Docker. 

## Что внутри

- **`src/app.cpp`**: программа C++ поиска максимума в массиве;
- **`Makefile`**: сборка, тесты (`make test`), ручной `.deb` (`make deb`), стандартный Debian-пакет (`make deb-full`);
- **`tests/test.sh`**: 4 теста (норма, одно число, отрицательные, пустой массив);
- **`debian/`**: стандартная структура Debian-пакета: `control`, `rules`, `changelog`, `install`, `source/format`;
- **`Dockerfile`**: multi-stage сборка: `builder` (с `g++`, `make`, `dpkg`) собирает `.deb`, финальный образ ставит пакет и запускает `findmax`;
- **`.github/workflows/ci.yml`**: CI/CD на GitHub Actions: `build` → `test` → `package` → `docker` → `release`.

## Три варианта сборки

```bash
make            # сборка findmax
make test       # тесты
make deb        # ручной .deb → findmax-1.0-amd64.deb
make deb-full   # стандартный Debian-пакет → maxfinder_1.0_amd64.deb
```

**Установка и запуск:**

```bash
sudo dpkg -i maxfinder_1.0_amd64.deb
findmax
# Enter number of elements: 5
# Enter numbers: 1 5 3 9 2
# Max value: 9
```

**Docker:**

```bash
docker build -t maxfinder .
echo -e "5\n1 5 3 9 2" | docker run -i --rm maxfinder
# Max value: 9
```

## Стек

- **C++17**;
- **Make**;
- **Debian packaging**;
- **Docker**;
- **GitHub Actions**;
- **Bash**.

Ubuntu/Debian:

```bash
sudo apt install build-essential dpkg-dev debhelper docker.io
```

## Структура проекта

```
maxfinder-distribution/
├── README.md
├── Makefile
├── Dockerfile
├── .gitignore
├── .dockerignore
├── src/
│   └── app.cpp
├── tests/
│   └── test.sh
├── debian/
│   ├── control
│   ├── rules
│   ├── changelog
│   ├── install
│   └── source/
│       └── format
└── .github/
    └── workflows/
        └── ci.yml
```
