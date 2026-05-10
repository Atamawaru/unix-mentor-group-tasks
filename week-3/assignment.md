1. Your task is to compile the "curl" command-line tool from source code, with HTTPS support enabled (pvz OpenSSL).

2. OpenSSL must be compiled and installed first into a custom prefix directory (e.g. ~/opt/openssl), (keep inmind that curl's configure script needs to locate its headers and static libs before it can build).

3. When you're done with OpenSSL, configure and compile curl, pointing it at your local OpenSSL installation using a flag (--with-openssl).

4. After a successful build, verify that your binary is dynamically linked against your custom OpenSSL (ldd), and confirm that HTTPS requests work by fetching https://mif.vu.lt/lt3/ (pasirodo mif.vu.lt turi 302 ) with your compiled curl.
