# postgres-apk-builder

This lets you install older Postgres versions into newer Alpine linux versions.

For example, Postgres v11.5 into Alpine v3.12 - which currently only has Postgres v12 packages.

These scripts build Postgres v11.5 in an Alpine v3.12 container in the same way the official Alpine
packaging process does (from the same source, using the same patches and tests.) It then uploads a
tarball of them to a GCP bucket.

To build and upload to our `apktmp` GCP bucket:

```sh
./build.sh
```

They can then be installed into an Alpine v3.12 Docker container (`docker run -it alpine:3.12`) using:

```sh
wget https://storage.googleapis.com/apktmp/postgres-11-5-for-alpine-3-12-4cc8106a5e.tar.gz
tar -xzf postgres-11-5-for-alpine-3-12-4cc8106a5e.tar.gz
cd target/main/x86_64/
apk add --allow-untrusted *.apk
cd ../../../
rm -rf target/
```
