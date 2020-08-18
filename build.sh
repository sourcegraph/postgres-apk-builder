docker rm -f postgres-apk-builder
docker run --detach --name=postgres-apk-builder -it alpine:3.12 
docker cp build-postgres.sh postgres-apk-builder:/build-postgres.sh
docker exec -it postgres-apk-builder sh -c 'chmod +x /build-postgres.sh && /build-postgres.sh'
docker cp postgres-apk-builder:/target .

name="postgres-11-5-for-alpine-3-12-$(git rev-parse --short HEAD).tar.gz"
tar cvfz $name target/
gsutil cp $name gs://apktmp/$name
