/// Utility class to wrap result data
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Success(): {
///     print(result.value);
///   }
///   case Failure(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.success(T value) = Success._;

  /// Creates an failed [Result], completed with the specified [error].
  const factory Result.failure(Exception error) = Failure._;

  /// Safely casts the result to [Success] if it is a success, otherwise returns null.
  Success<T>? get asSuccess => this is Success<T> ? this as Success<T> : null;

  /// Safely casts the result to [Failure] if it is a failure, otherwise returns null.
  Failure<T>? get asError => this is Failure<T> ? this as Failure<T> : null;
}

/// Subclass of Result for values
final class Success<T> extends Result<T> {
  /// Returned value in result
  final T value;

  const Success._(this.value);

  @override
  String toString() => 'Result<$T>.success($value)';
}

/// Subclass of Result for errors
final class Failure<T> extends Result<T> {
  /// Returned error in result
  final Exception error;

  const Failure._(this.error);

  @override
  String toString() => 'Result<$T>.failure($error)';
}
