import 'dart:io';

dynamic parseResult(
    {required ProcessResult result,
    required Function onSuccess,
    required Function onFailure}) {
  if (result.exitCode != 0) return onFailure(result);
  return onSuccess(result);
}
