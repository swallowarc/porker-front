import 'dart:async';

import 'package:porker_front/commons/errors/errors.dart';
import 'package:porker_front/commons/logger/logger.dart';
import 'package:retry/retry.dart';

const GRPCRetryOpt = RetryOptions(
  maxAttempts: 8,
  maxDelay: Duration(seconds: 5),
);

Future<T> gRPCRetry<T>(FutureOr<T> Function() fn) {
  return GRPCRetryOpt.retry(
    () => fn(),
    retryIf: (e) => isGRPCErrorCodeToRetry(e),
    onRetry: (e) => grpcLoggingInfo(e),
  );
}
