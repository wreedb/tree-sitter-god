# SPDX-FileCopyrightText: 2025 Will Reed
#
# SPDX-License-Identifier: LGPL-3.0-or-later

tsjson := "tree-sitter.json"
tsyaml := "tree-sitter.yaml"
tsucl := "tree-sitter.ucl"
uclcpp := "misc/util/ucl.cpp"
cxx := "cxx -std=c++23 -fPIC -pipe -march=x86-64 -mtune=generic -O2 -fcf-protection=full -fstack-protector-strong -fstack-clash-protection -fdiagnostics-color -Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -Wl,--as-needed"

[group("util")]
@ucl:
    @{{cxx}} -lucl {{uclcpp}} -o ucl

[group("maintainence")]
@json-yaml:
    yj -jy < {{tsjson}}

[group("maintainence")]
@yaml-json:
    @yj -yj < {{tsyaml}}

[group("maintainence")]
@npmi:
    @bun install

[group("maintainence")]
@gomodi:
    @go mod tidy -v

[group("maintainence")]
@swifti:
    @swift package update

[group("clean")]
@clean-js:
    @-rm -fr node_modules *.lock pnpm-lock.yaml pnpm-workspace.yaml package.lock.json

[group("clean")]
@clean-go:
    @-rm -f go.sum

[group("clean")]
@clean-zig:
    @-rm -fr zig-out .zig-cache

[group("clean")]
@clean-python:
    @-rm -fr dist build .venv

[group("clean")]
@clean-rust:
    @-rm -fr target

[group("clean")]
@clean-build:
    @-rm -fr .build build .bld bld

[group("clean")]
@distclean: clean-js clean-go clean-zig clean-python clean-rust clean-build
    @-rm -f *.wasm *.so Package.resolved ucl

[group("git")]
@commit:
    @convco commit -i
