.PHONY: all clean run

all: app_fibo fibo.wasm

app_fibo: app_fibo.zig
	zig build-exe app_fibo.zig

fibo.wasm: fibo.zig
	zig build-exe \
		-target wasm32-freestanding \
		-fno-entry --export=fibo \
		-O ReleaseFast \
		fibo.zig

run: app_fibo
	./app_fibo
	node ./web_fibo.js

clean:
	rm -f *.o app_fibo fibo.wasm
