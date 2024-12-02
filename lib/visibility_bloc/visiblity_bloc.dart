import 'package:blocseries/visibility_bloc/visiblity_event.dart';
import 'package:blocseries/visibility_bloc/visiblity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisiblityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisiblityBloc() : super(VisibilityState(show: true)) {
    on<VisiblityShowEvent>((event, emit) => emit(VisibilityState(show: true)));
    on<VisiblityHideEvent>((event, emit) => emit(VisibilityState(show: false)));
  }
}
