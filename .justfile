# Just file: https://github.com/casey/just

alias debug := build

build:
	mkdir -p debug
	cmake -B debug \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_CUDA_HOST_COMPILER=g++-11 \
		-DCMAKE_BUILD_TYPE=Debug -GNinja \
		-DCMAKE_CUDA_COMPILER_LAUNCHER=ccache \
		-GNinja \
		-DCMAKE_C_FLAGS_INIT="-fsanitize=undefined -fsanitize=address" \
		-DCMAKE_CXX_FLAGS_INIT="-fsanitize=undefined -fsanitize=address" \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_C_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_C_CLANG_TIDY="clang-tidy-17" \
		-DCMAKE_CXX_CLANG_TIDY="clang-tidy-17" \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo"
	rm -f compile_commands.json
	ln -s debug/compile_commands.json .
	cd debug && cmake --build . --parallel

run: build
	debug/pystencils_gui
meson-release:
	meson setup --reconfigure --buildtype=release -Dc_flags=-fdiagnostics-absolute-paths -Dcpp_flags=-fdiagnostics-absolute-paths release
	rm -f compile_commands.json
	ln -s release/compile_commands.json .
	meson compile -C release

meson-debug:
	meson setup --reconfigure --buildtype=debug -Dc_flags=-fdiagnostics-absolute-paths -Dcpp_flags=-fdiagnostics-absolute-paths debug
	rm -f compile_commands.json
	ln -s debug/compile_commands.json .
	meson compile -C debug

meson-install: meson-release
	meson install -C release

release:
	mkdir -p release
	cmake -Brelease \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_CUDA_HOST_COMPILER=g++-11 \
		-DCMAKE_CUDA_COMPILER_LAUNCHER=ccache \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_CXX_FLAGS_RELEASE="-march=native -O3 -DNDEBUG" \
		-DCMAKE_C_FLAGS=-fdiagnostics-color \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo"
	rm -f compile_commands.json
	ln -s release/compile_commands.json .
	cd release && cmake --build . --parallel

gcc-release:
	mkdir -p gcc-release
	export CXX=g++-13 && export CC=gcc-13 && cd gcc-release && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES  \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-color -O3" \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo" \
		-DCMAKE_C_FLAGS="-fdiagnostics-color" ..
	cd gcc-release && cmake --build . --parallel

gcc11-release:
	mkdir -p gcc11-release
	export CXX=g++-11 && export CC=gcc-11 && cd gcc11-release && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES  \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo -G Ninja \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-color -O3" \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo" \
		-DCMAKE_C_FLAGS="-fdiagnostics-color" ..
	cd gcc11-release && cmake --build . --parallel

gcc-9-release:
	mkdir -p gcc-release
	export CXX=g++-9 && export CC=gcc-9 && cd gcc-release && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CXX_FLAGS=-fdiagnostics-color \
		-DCMAKE_C_FLAGS=-fdiagnostics-color ..
	cd gcc-release && cmake --build . --parallel

gcc-debug:
	mkdir -p gcc-debug
	export CXX=g++-11 && export CC=gcc-11 && cd gcc-debug && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_BUILD_TYPE=Debug -G Ninja \
		-DCMAKE_CXX_FLAGS=-fdiagnostics-color \
		-DCMAKE_C_FLAGS=-fdiagnostics-color ..
	rm -f compile_commands.json
	ln -s gcc-debug/compile_commands.json .
	cd gcc-debug && cmake --build . --parallel

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
