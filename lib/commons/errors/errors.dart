import 'package:porker_front/commons/logger/logger.dart';
import 'package:grpc/grpc_web.dart';

const GRPCErrorsToRetry = <int>[
  StatusCode.deadlineExceeded,
  StatusCode.unavailable,
];

int gRPCErrorCode(Object err) {
  try {
    final grpcErr = err as GrpcError;
    return grpcErr.code;
  } catch (e, stackTrace) {
    gLogger.e("an unexpected exception has occurred", e, stackTrace);
    return 0;
  }
}

bool isGRPCErrorCodeToRetry(Object err) {
  return GRPCErrorsToRetry.contains(gRPCErrorCode(err));
}
