# openpresso-toolchain

This repository contains a Dockerfile for a openpresso cross-compilation toolchain.
It provides gcc build toolchain, cmake, python3 with pip and venv, and conan package
manager installed globally with pip.
Conan has two preconfigured profiles:

1. `default`, relates to host machine
2. `target`, configured for cross-compiling for the target architecture,
    for convience can be accessed with `TARGET_PROFILE` environment variable

## Typical usage

```bash
docker run -it -v .:/workspace -w /workspace ghcr.io/openpresso/openpresso-toolchain-armv8 bash
conan install . -pr:h=target -pr:b=default
cmake . --preset conan-release
cmake --build . --preset conan-release
```

Note that actual preset names depends on conanfile layout settings.
