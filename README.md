<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A utils package containing some functional programming utils.

## Features

- `Either<L, R>`: a value that can be either left or right;
- `Lazy<T>`: a lazily evaluated value;
- `Optional<T>`: an optional value;
- `Result<V, E>`: the result value, similar to `Either<L, R>`, but has left
  being assigned to value and right assigned to error. This is similar to the
  `Result` in rust, but diffferent from the convention in `dartz`;
- `ServiceStore`: a service locator similar to the one `GetIt` or `Get`;

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
