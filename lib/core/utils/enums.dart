enum RequestType {
  post,
  get,
  put,
  delete,
}

enum ApiResult{
  success,
  failure
}

extension EnumApiResult on ApiResult {
  String? get type {
    switch (this) {
      case ApiResult.success:
        return "001";
      case ApiResult.failure:
        return "002";

    }   return null;
  }
}

enum SequenceCalls{
  call1,
  call2,
  call3
}

extension EnumSequenceCalls on SequenceCalls {
  String? get text {
    switch (this) {
      case SequenceCalls.call1:
        return "failed at call 1";
      case SequenceCalls.call2:
        return "failed at call 1";
      case SequenceCalls.call3:
        return "failed at call 1";

    }   return null;
  }
}