# Just file: https://github.com/casey/just

alias debug := build

build:
	mkdir -p debug
	cd debug && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_CUDA_HOST_COMPILER=g++-11 \
		-DCMAKE_BUILD_TYPE=Debug -GNinja \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_C_FLAGS="-fdiagnostics-color" \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo" ..
	#cd debug && cmake \
		#-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		#-DCMAKE_CUDA_HOST_COMPILER=g++-11 \
		#-DCMAKE_BUILD_TYPE=Debug -GNinja \
		#-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		#-DCMAKE_C_FLAGS="-fdiagnostics-color" \
		#-DCMAKE_CUDA_ARCHITECTURES=OFF \
		#-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo" ..
	rm -f compile_commands.json
	ln -s debug/compile_commands.json
	cd debug && cmake --build . -- -j$(nproc)

run: build
	debug/pystencils_gui

release:
	mkdir -p release
	cd release && cmake \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_CUDA_HOST_COMPILER=g++-11 \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color -march=native" \
		-DCMAKE_C_FLAGS=-fdiagnostics-color \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo" \
		..
	rm -f compile_commands.json
	ln -s release/compile_commands.json
	cd release && cmake --build . -- -j$(nproc)

gcc-release:
	mkdir -p gcc-release
	export CXX=g++-11 && export CC=gcc-11 && cd gcc-release && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES  \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CXX_FLAGS=-fdiagnostics-color \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo" \
		-DCMAKE_C_FLAGS="-fdiagnostics-color" ..
	cd gcc-release && cmake --build . -- -j$(nproc)

gcc-9-release:
	mkdir -p gcc-release
	export CXX=g++-9 && export CC=gcc-9 && cd gcc-release && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CXX_FLAGS=-fdiagnostics-color \
		-DCMAKE_C_FLAGS=-fdiagnostics-color ..
	cd gcc-release && cmake --build . -- -j$(nproc)

gcc-debug:
	mkdir -p gcc-debug
	export CXX=g++-11 && export CC=gcc-11 && cd gcc-debug && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_BUILD_TYPE=Debug -G Ninja \
		-DCMAKE_CXX_FLAGS=-fdiagnostics-color \
		-DCMAKE_C_FLAGS=-fdiagnostics-color ..
	rm -f compile_commands.json
	ln -s debug/compile_commands.json
	cd gcc-debug && cmake --build . -- -j$(nproc)

release-run: release
	release/pystencils_gui

clean:
	rm -rf debug
	rm -rf release

clean-build: clean build

install: release
	cd release && sudo ninja install

gcc-install: gcc-release
	cd gcc-release && sudo ninja install

meson-release:
	meson build --buildtype=release
	cd build && meson compile
	ln -s build/compile_commands.json .

meson-debug:
	meson debug --buildtype=debug
	cd debug && meson compile
	ln -s debug/compile_commands.json .
