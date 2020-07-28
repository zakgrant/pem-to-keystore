# Pem-To-KeyStore

Easily add PEM certificates to a new or existing java key store.

This container is based on the `openjdk:jre-alpine` container.

## Configuration

The following parameters can be configured via environmental variables;

| Environmental Variable | Default Value      | Description                                                | Required           |
| :--------------------- | :----------------- | :--------------------------------------------------------- | :----------------: |
| `CRT_PATH`             | `/src/tls.crt`     | Path to the certificate of the keypair that is to be added |                    |
| `KEY_PATH`             | `/src/tls.key`     | Path to the private key of the keypair that is to be added |                    |
| `KEYSTORE_NAME`        | `keystore`         | Keystore filename                                          |                    |
| `KEYSTORE_PASSWORD`    | `changeit`         | Password to set for new keystore                           | :white_check_mark: |
| `KEYSTORE_ALIAS`       | `key`              | Alias under which the key should be added to the keystore  |                    |

## Building

```
docker build --tag pem-to-keystore:1.0 .
```

## Running

Using the example cert and key provided under [examples](./examples)

> :warning: SECURITY WARNING - DO NOT USE THE PROVIDED PRIVATE KEY + PASSWORDS FOR ANYTHING OTHER THAN THIS EXAMPLE AS THEY ARE IN PLAIN SIGHT

```
$ docker run \
    -e KEYSTORE_PASSWORD='P4ssw0rd' \
    -e KEYSTORE_ALIAS='example' \
    -v $PWD/example/example.crt:/src/tls.crt \
    -v $PWD/example/example.key:/src/tls.key \
    -v $PWD:/target \
    --name pem-to-keystore \
    pem-to-keystore:1.0
```
