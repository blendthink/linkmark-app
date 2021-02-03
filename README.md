# Linkmark

![Flutter CI](https://github.com/blendthink/linkmark-app/workflows/Flutter%20CI/badge.svg)
![codecov](https://codecov.io/gh/blendthink/linkmark-app/branch/main/graph/badge.svg?token=FHHCLMU8NN)](https://codecov.io/gh/blendthink/linkmark-app)

This project is the code of an application that stores links.

## Documentation

- [Project Authors](docs/AUTHORS.md)
- [Contributor Guidelines](docs/CONTRIBUTING.md)
- [Contributor Covenant Code of Conduct](docs/CODE_OF_CONDUCT.md)

## Requirements

- [Flutter 1.22.0+ (beta channel)](https://flutter.dev/docs/get-started/install)
- [Dart 2.10.0+](https://github.com/dart-lang/sdk/wiki/Installing-beta-and-dev-releases-with-brew,-choco,-and-apt-get#installing)

## Environment

### iOS
- iOS 13+

### Android
- Android 5.1+
    - minSdkVersion 22
- targetSdkVersion 30

## App architecture
- Base on [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) + [Repository](https://docs.microsoft.com/ja-jp/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design)

## Code Style
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## Assets, Fonts

**If added some assets or fonts**

- Use [FlutterGen](https://github.com/FlutterGen/flutter_gen/)

## Models

**If added some models for api results**

- Use [Freezed](https://pub.dev/packages/freezed)

## Localizations

**If added some localizations (i.g. edited [*.arb](https://github.com/wasabeef/flutter-architecture-blueprints/tree/main/lib/l10n))**

- Use [Official Flutter localization package](https://docs.google.com/document/d/10e0saTfAv32OZLRmONy866vnaw0I2jwL8zukykpgWBc)

## Git Commit message style

- [Semantic Commit Messages](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)

### Setup

```shell script
$ make setup
$ make build-runner
```

### Make .apk and .ipa file

Android
```shell script
$ make build-android-dev
$ make build-android-prd
```

iOS
```shell script
$ make build-ios-dev
$ make build-ios-prd
```

### Run app
```shell script
$ make run-dev
$ make run-prd
```

<br>

### How to add assets(images..)
1. Add assets
2. Run [FlutterGen](https://github.com/fluttergen)

### How to add localizations
1. Edit [*.arb](https://github.com/wasabeef/flutter-architecture-blueprints/tree/main/lib/l10n) files.
2. Run generate the `flutter pub get`
