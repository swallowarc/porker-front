# porker-frontend

This is a web application implemented in Flutter.  
It works by communicating with backend applications implemented in the Go language.

## Related repositories

- https://github.com/swallowarc/porker-proto
- https://github.com/swallowarc/porker-rpc

## Getting Started

Follow the steps below to get started.
(Run on localhost)

### 1. Start backend application

Launch the backend application in advance. See
the [backend application repository](https://github.com/swallowarc/porker-backend) for instructions.

### 2. Install Chrome

Use Chrome for debugging. Please install in advance.

### 3. Setup Flutter

Set up Flutter. Please refer to the [official website](https://flutter.dev/docs/get-started/install) for the detailed
procedure.

### 4. Download reference library

Clone this repository and run the following command in the root directory.

``` shell
flutter pub get
```

### 5. Frontend application launch

Use the following command.

```shell
flutter run -d chrome --dart-define=BACKEND_URI="http://localhost:8080"
```

Or use an IDE (Intellij IDEA, Visual Studio Code, etc.) to start debugging.  
We strongly recommend using the IDE from the perspective of development efficiency.

## Other steps

### Fix view controller's state

Freezed is used to implement the state of the view controller.  
If you change the state of the Controller, you need to generate the source code by the generator.

```shell
flutter pub run build_runner build --delete-conflicting-outputs
```

or

```shell
make generate
```
