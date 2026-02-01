# openpresso-toolchain

This repository contains a Dockerfile for a openpresso cross-compilation toolchain.
It provides gcc build toolchain, cmake, python3 with pip and venv, and conan package
manager installed globally with pip.
Conan has two preconfigured profiles:

1. `default`, relates to the builder machine
2. `target`, relates to the host where built app will run

They are alredy set in the global conan config as default build and host profiles respectively,
so there is no need to specify them when calling conan cli commands.

## Typical usage

```bash
docker run -it -v .:/workspace ghcr.io/openpresso/openpresso-toolchain-armv8 bash
cd /workspace
conan install . 
cmake . --preset conan-release
cmake --build . --preset conan-release
```

Note that actual preset names depend on conanfile layout settings.
