GPP = g++
GCC = gcc
OUTPUT = "bin/hash.so"
COMPILER_FLAGS = -c -m32 -fPIC -O3 -DLINUX -w -I./include/ -I./include/SDK/amx/ -I/opt/boost_1_67_0
LIBRARIES = -lrt ./lib/libcryptopp.a /opt/boost_1_67_0/stage/lib/libboost_system.a /opt/boost_1_67_0/stage/lib/libboost_thread.a /opt/boost_1_67_0/stage/lib/libboost_atomic.a /opt/boost_1_67_0/stage/lib/libboost_chrono.a
CRYPTOPP_SRC_DIR = ./src/cryptopp

all: cryptolib hash clean

hash:
	$(GCC) $(COMPILER_FLAGS) ./include/SDK/amx/*.c
	$(GPP) $(COMPILER_FLAGS) ./include/SDK/*.cpp
	$(GPP) $(COMPILER_FLAGS) ./src/*.cpp
	mkdir -p bin
	$(GPP) -m32 -O2 -fshort-wchar -shared -o $(OUTPUT) *.o $(LIBRARIES)
	
cryptolib:
	$(MAKE) -C $(CRYPTOPP_SRC_DIR) static
	mkdir -p lib
	cp $(CRYPTOPP_SRC_DIR)/libcryptopp.a ./lib
	
clean:
	rm -f *.o
