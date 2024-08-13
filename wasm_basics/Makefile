.PHONY: all clean

all: app fibo.wasm

app: app.zig
	zig build-exe app.zig

fibo.wasm: fibo.zig
	zig build-exe \
		-target wasm32-freestanding \
		-O ReleaseSmall \
		-fno-entry \
		-rdynamic \
		fibo.zig

clean:
	rm -f app fibo.wasm *.o
