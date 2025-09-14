# Just file: https://github.com/casey/just

alias debug := build

build:
	mkdir -p debug
	cmake -B debug \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_CUDA_HOST_COMPILER=g++-13 \
		-DCMAKE_BUILD_TYPE=Debug -GNinja \
		-DCMAKE_CUDA_COMPILER_LAUNCHER=ccache \
		-GNinja \
		-DCMAKE_C_FLAGS_INIT="-fsanitize=undefined -fsanitize=address -fsanitize=memory" \
		-DCMAKE_CXX_FLAGS_INIT="-fsanitize=undefined -fsanitize=address -fsanitize=memory" \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_C_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_CUDA_ARCHITECTURES=native \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -G --source-in-ptx"
	rm -f compile_commands.json
	ln -s debug/compile_commands.json .
	cd debug && cmake --build . --parallel
#-DCMAKE_C_CLANG_TIDY="clang-tidy-20" \
#-DCMAKE_CXX_CLANG_TIDY="clang-tidy-20" \

run: build
	debug/pystencils_gui
meson-release:
	meson setup --reconfigure --buildtype=release -Dc_args="-fdiagnostics-absolute-paths -march=native -fdiagnostics-color" -Dcpp_args="-fdiagnostics-absolute-paths -march=native" -Dcuda_args="-arch=native -lineinfo" release
	rm -f compile_commands.json
	ln -s release/compile_commands.json .
	meson compile -C release

meson-debugoptimized:
	meson setup --reconfigure --buildtype=debugoptimized -Dc_args="-fdiagnostics-absolute-paths -march=native -fdiagnostics-color" -Dcpp_args="-fdiagnostics-absolute-paths -march=native" release
	rm -f compile_commands.json
	ln -s release/compile_commands.json .
	meson compile -C release

meson-debug:
	meson setup --reconfigure --buildtype=debug -Dc_args="-fdiagnostics-absolute-paths  -fdiagnostics-color" -Dcpp_args="-fdiagnostics-absolute-paths -fdiagnostics-color" debug
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
		-DCMAKE_CUDA_HOST_COMPILER=g++-13 \
		-DCMAKE_CUDA_COMPILER_LAUNCHER=ccache \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_CXX_FLAGS_RELEASE="-march=native -O3 -DNDEBUG" \
		-DCMAKE_C_FLAGS=-fdiagnostics-color \
		-DCMAKE_C_FLAGS_RELEASE="-march=native -O3 -DNDEBUG" \
		-DCMAKE_CUDA_ARCHITECTURES=89 \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo --use_fast_math -O3"
	rm -f compile_commands.json
	ln -s release/compile_commands.json .
	cd release && cmake --build . --parallel

release-deb:
	mkdir -p release
	cmake -Brelease \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_CUDA_HOST_COMPILER=g++-11 \
		-DCMAKE_CUDA_COMPILER_LAUNCHER=ccache \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo -G Ninja \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-absolute-paths -fdiagnostics-color" \
		-DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-march=native -O3 -DNDEBUG" \
		-DCMAKE_C_FLAGS=-fdiagnostics-color \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo --use_fast_math -O3"
	rm -f compile_commands.json
	ln -s release/compile_commands.json .
	cd release && cmake --build . --parallel

gcc-release:
	mkdir -p gcc-release
	export CXX=g++-15 && export CC=gcc-15 && cd gcc-release && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES  \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_CUDA_HOST_COMPILER=g++-13 \
		-DCMAKE_BUILD_TYPE=Release -G Ninja \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CXX_FLAGS_RELEASE="-fdiagnostics-color -O3" \
		-DCMAKE_C_FLAGS_RELEASE="-march=native -O3 -DNDEBUG" \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo" \
		-DCMAKE_C_FLAGS="-fdiagnostics-color" ..
	rm -f compile_commands.json
	ln -s gcc-release/compile_commands.json .
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
	mkdir -p debug
	CXX=g++-13 CC=gcc-13 cmake -Bgcc-debug \
		-DCMAKE_VERBOSE_MAKEFILE=OFF  \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
		-DCMAKE_CUDA_HOST_COMPILER=g++-11 \
		-DCMAKE_CUDA_COMPILER_LAUNCHER=ccache \
		-DCMAKE_BUILD_TYPE=debug -G Ninja \
		-DCMAKE_CXX_FLAGS="-fdiagnostics-color" \
		-DCMAKE_C_FLAGS=-fdiagnostics-color \
		-DCMAKE_CUDA_ARCHITECTURES=OFF \
		-DCMAKE_CUDA_FLAGS="-Wno-deprecated-gpu-targets -allow-unsupported-compiler -arch=native -lineinfo"
	rm -f compile_commands.json
	ln -s gcc-debug/compile_commands.json .
	cd gcc-debug && cmake --build . --parallel

release-run: release
	release/pystencils_gui

clean:
	rm -rf debug
	rm -rf release
	rm -rf gcc-debug
	rm -rf gcc-release

clean-build: clean build

install: release
	sudo ninja -C release install

gcc-install: gcc-release
	sudo ninja -C gcc-release install
