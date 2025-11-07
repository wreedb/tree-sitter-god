# SPDX-FileCopyrightText: 2025 Will Reed
#
# SPDX-License-Identifier: LGPL-3.0-or-later

tsjson := "tree-sitter.json"
tsyaml := "tree-sitter.yaml"
tsucl := "tree-sitter.ucl"
uclcpp := "misc/util/ucl.cpp"
cxx := "c++"
cxxflags := "-std=c++23 -fPIC -pipe -march=x86-64 -mtune=generic -O2 -fcf-protection=full -fstack-protector-strong -fstack-clash-protection -fdiagnostics-color -Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -Wl,--as-needed"
nproc := `nproc`

default: build

[group("ts")]
generate:
    tree-sitter generate --abi=latest

[group("ts")]
build: generate
    tree-sitter build --reuse-allocator

[group("ts")]
play: generate
    tree-sitter build --reuse-allocator --wasm
    tree-sitter playground

[group("ts")]
test: generate build
    tree-sitter test

[group("ts")]
fuzz: generate build
    tree-sitter fuzz

[group("ts")]
highlight file="example/simple.god": generate build
    tree-sitter highlight {{file}}

[group("ts")]
parse file="example/simple.god": generate build
    tree-sitter parse --no-ranges {{file}}

[group("ts")]
parse-ranges file="example/simple.god": generate build
    tree-sitter parse {{file}}

[group("util")]
ucl:
    {{cxx}} {{cxxflags}} -lucl {{uclcpp}} -o ucl

[group("install")]
install-node:
    bun install

[group("install")]
install-go:
    go mod tidy -v

[group("install")]
install-swift:
    swift package update

[group("install")]
install-rust:
    cargo fetch --locked

[group("bindings")]
build-rust: generate install-rust
    cargo build --release --locked -j{{nproc}}

[group("bindings")]
build-swift: generate install-swift
    swift build -c release -j{{nproc}}

[group("bindings")]
build-python: generate
    python -m build .

[group("bindings")]
build-zig: generate
    zig build --release=safe --summary new -j{{nproc}}

[group("clean")]
clean-js:
    -rm -fr node_modules *.lock pnpm-lock.yaml pnpm-workspace.yaml package.lock.json

[group("clean")]
clean-go:
    -rm -f go.sum

[group("clean")]
clean-zig:
    -rm -fr zig-out .zig-cache

[group("clean")]
clean-python:
    -rm -fr dist build .venv

[group("clean")]
clean-rust:
    -rm -fr target

[group("clean")]
clean-build:
    -rm -fr .build build .bld bld

[group("clean")]
clean: clean-js clean-go clean-zig clean-python clean-rust clean-build
    -rm -f *.wasm *.so Package.resolved ucl

[group("maint")]
commit:
    @convco commit -i

[group("maint")]
version:
    @cat version

[group("maint")]
log:
    git log

[group("maint")]
reuse action="lint":
    reuse {{action}}
