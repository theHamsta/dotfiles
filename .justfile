# Just file: https://github.com/casey/just
build:
    mkdir -p debug
    cd debug && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -G Ninja  -DCMAKE_CXX_FLAGS=-fcolor-diagnostics -DCMAKE_C_FLAGS=-fcolor-diagnostics ..
    rm -f compile_commands.json
    ln -s debug/compile_commands.json
    cd debug && cmake --build . -- -j8

run: build
    debug/pystencils_gui
    
release:
    mkdir -p release
    cd release && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DCMAKE_BUILD_TYPE=Release -G Ninja -DCMAKE_CXX_FLAGS=-fcolor-diagnostics -DCMAKE_C_FLAGS=-fcolor-diagnostics ..
    cd release && cmake --build . -- -j8

release-run: release
    release/pystencils_gui

clean:
	rm -rf debug
	rm -rf release

clean-build: clean build

install: release
    cd release && sudo ninja install
