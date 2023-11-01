import 'package:bloc/bloc.dart';
import 'package:currency_price/data/api/currency_api.dart';
import 'package:currency_price/data/model/currency_model.dart';

import 'package:meta/meta.dart';



part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final CurrencyApi _api;

  MainBloc(this._api) : super(const MainState()) {
    on<MainGetLastEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        emit(state.copyWith(
          status: Status.success,
          currencies: await _api.currencies(),
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.fail, message: "$e"));
      }
    });
    on<MainGetDateEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        emit(state.copyWith(
          status: Status.success,
          currencies: await _api.currencies(date: event.date),
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.fail, message: "$e"));
      }
    });
    on<MainGetLanguage>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        emit(state.copyWith(
          status: Status.success,
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.fail, message: "$e"));
      }
    });
  }
}
