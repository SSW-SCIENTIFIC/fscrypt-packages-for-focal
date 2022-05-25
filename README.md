fscrypt and libpam-fscrypt v0.3.3 for Ubuntu 20.04
==================================================

This project contains files to build **fscrypt** and **libpam-fscrypt** packages from [v0.3.3 source][google/fscrypt@v0.3.3] of [google/fscrypt][].
Package sources are based on the [package source for Ubuntu 22.04][jammy package source], and built on Ubuntu 20.04 after applying a (very small) patch.

How to build
------------

1. Open project root with Visual Studio Code, and **reopen in containers**.
2. Run following command on shell inside the container.

    ```sh
    scripts/build-packages.sh
    ```

And then two `.deb` packages (`fscrypt_0.3.3-1_amd64.deb` and `libpam-fscrypt_0.3.3-1_amd64.deb`) for Ubuntu 20.04 are generated.
Now you can install them on Ubuntu 20.04 by `sudo dpkg -i <.deb package>`.

[google/fscrypt@v0.3.3]: https://github.com/google/fscrypt/releases/tag/v0.3.3
[google/fscrypt]: https://github.com/google/fscrypt
[jammy package source]: https://packages.ubuntu.com/jammy/fscrypt
