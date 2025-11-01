<!--
SPDX-FileCopyrightText: 2025 Will Reed <wreed@disroot.org>

SPDX-License-Identifier: LGPL-3.0-or-later
-->
# Tree-sitter grammar for **God**

This grammar is for the [GOD](https://github.com/wreedb/god) data serialization language, which is 
heavily derived from the Nix language, albeit without any programatic features. See the repo for 
more information.

---
## Building/Testing
You can build, test, parse, and highlight like so:
```sh
tree-sitter build
tree-sitter test
tree-sitter parse example/types.god
tree-sitter highlight example/package.god
```

---
If you would like to introspect the grammar interactively, you can use 
the following commands:
```sh
tree-sitter build --wasm
tree-sitter playground
```
Which will open a local web server at port 8001 with an interface to use.

---
And if you'd like to install the grammar, you can use make or CMake:
```sh
# make
make
make test
make install # as root if needed

# cmake
cmake -B .build -DCMAKE_BUILD_TYPE=Release # add '-G Ninja' to use ninja
cmake --build .build
cmake --build .build --target ts-test # to test the grammar
cmake --install .build # as root if needed
```

---
## Installing
In addition the the manual method above, you may find prebuilt packages on the 
[releases](https://github.com/wreedb/tree-sitter-god/releases) page, along with source-only archives as well.

---
## Licensing
This project is licensed under the GNU Lesser General Public License, version 3.0 or later.
