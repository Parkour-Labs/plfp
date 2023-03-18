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

## TODOs

- [ ] add tests 
- [ ] add docs

## Features

- `Either<L, R>`: a value that can be either left or right;
- `Lazy<T>`: a lazily evaluated value;
- `Optional<T>`: an optional value;
- `Result<V, E>`: the result value, similar to `Either<L, R>`, but has left
  being assigned to value and right assigned to error. This is similar to the
  `Result` in rust, but diffferent from the convention in `dartz`;
- `ServiceStore`: a service locator similar to the one `GetIt` or `Get`;

## Getting started

Just add this to the pubspec and then use the things.

## Usage


```dart
const like = 'sample';
```

## Additional information

