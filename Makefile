# Компилятор и флаги
CXX      = g++
CXXFLAGS = -Wall -Wextra -O2 -std=c++17

# Имя бинарника и исходник
TARGET = findmax
SRC    = app.cpp

# Переменные для deb-пакета (только для make deb)
PACKAGE_NAME ?= findmax
VERSION      ?= 1.0
ARCH         ?= amd64
MAINTAINER   ?= Soft <sonya.kosmos69@mail.ru>
DESCRIPTION  ?= Program to find the maximum value in an array

.PHONY: all clean deb deb-full test

# Cборка бинарника
all: $(TARGET)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)

# Тесты
test: $(TARGET)
	./tests/test.sh

# Очистка
clean:
	rm -f $(TARGET) *.deb *.buildinfo *.changes
	rm -rf package
	rm -rf debian/tmp debian/.debhelper debian/files debian/maxfinder

# deb-пакет
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

deb-full: clean
	dpkg-buildpackage -us -uc -b
	mv ../maxfinder_*.deb . 2>/dev/null || true
