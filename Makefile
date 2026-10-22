# Компилятор и флаги
CXX      = g++
CXXFLAGS = -Wall -Wextra -O2 -std=c++17

# Имя бинарника и исходник
TARGET = findmax
SRC    = app.cpp

# Переменные для deb-пакета
PACKAGE_NAME ?= findmax
VERSION      ?= 1.0
ARCH         ?= amd64
MAINTAINER   ?= Alen
DESCRIPTION  ?= Program to find the maximum value in an array

.PHONY: all clean deb test

# Сборка бинарника
all: $(TARGET)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)

# Тесты
test: $(TARGET)
	./tests/test.sh

# Очистка
clean:
	rm -f $(TARGET) *.deb
	rm -rf package

# Создание deb-пакета
deb: $(TARGET)
	rm -rf package
	mkdir -p package/usr/local/bin
	cp $(TARGET) package/usr/local/bin/
	mkdir -p package/DEBIAN
	echo "Package: $(PACKAGE_NAME)" > package/DEBIAN/control
	echo "Version: $(VERSION)" >> package/DEBIAN/control
	echo "Section: utils" >> package/DEBIAN/control
	echo "Priority: optional" >> package/DEBIAN/control
	echo "Architecture: $(ARCH)" >> package/DEBIAN/control
	echo "Depends: libc6, libstdc++6" >> package/DEBIAN/control
	echo "Maintainer: $(MAINTAINER)" >> package/DEBIAN/control
	echo "Description: $(DESCRIPTION)" >> package/DEBIAN/control
	dpkg-deb --build --root-owner-group package $(PACKAGE_NAME)-$(VERSION)-$(ARCH).deb
