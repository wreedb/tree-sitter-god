<!--
SPDX-FileCopyrightText: 2025 Will Reed <wreed@disroot.org>

SPDX-License-Identifier: LGPL-3.0-or-later
-->
# Tree-sitter grammar for **GOD**

This grammar is for the [GOD](https://github.com/wreedb/god) data serialization language, which is 
heavily derived from the Nix language, albeit without any programatic features. See the repo for 
more information.

## Building/Testing
You can build, test, parse, and highlight like so:
```sh
tree-sitter build
tree-sitter test
tree-sitter parse example/types.god
tree-sitter highlight example/package.god
```

And if you'd like to install the grammar, you can use make or CMake:
```sh
# make
make
make test
make install # as root if needed

# cmake
cmake -B bld -DCMAKE_BUILD_TYPE=Release # add '-G Ninja' to use ninja
cmake --build bld
make -C bld ts-test # or 'ninja -C bld ts-test' if using ninja
cmake --install bld # as root if needed
```
