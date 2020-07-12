import 'package:authmabform/account.dart';
import 'package:authmabform/home/home_page.dart';
import 'package:bloc/bloc.dart';



enum NavigationEvents {
  HomePageClickedEvent,
  AccountClickedEvent,
  OrdersClickedEvent,
}

abstract class NavigationStates {

}


class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{


  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.AccountClickedEvent:
        yield Account();
        break;
    }
  }


}