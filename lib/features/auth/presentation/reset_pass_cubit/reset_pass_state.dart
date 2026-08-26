sealed class ResetPassState {
  const ResetPassState();
}

class ResetPassInitial extends ResetPassState {
  const ResetPassInitial();
}
class ResetPassLoading extends ResetPassState {
  const ResetPassLoading();
}
class ResetPassSuccess extends ResetPassState {
  const ResetPassSuccess();
}


class ResetPassFailure extends ResetPassState {
  final String message;
  const ResetPassFailure({required this.message});
}
