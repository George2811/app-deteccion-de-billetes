class AppData {
  static final _appData = new AppData._internal();

  bool showNavBar = false;

  factory AppData(){
    return _appData;
  }
  
  AppData._internal();
  
}

final appData = AppData();