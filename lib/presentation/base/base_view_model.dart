abstract class BaseViewModel extends BaseViewModelInput with BaseViewModelOutput {

}

abstract class BaseViewModelInput {
  void start(); //called to initialise
  void dispose(); //called to dispose
}

abstract class BaseViewModelOutput {}