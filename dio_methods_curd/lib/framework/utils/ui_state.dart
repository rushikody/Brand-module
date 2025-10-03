

class UiState<T>{

  bool isLoading;
  T? success;
  bool isSearch;
  String? error;
  bool hasMoreData;
  bool isUpdate;
  bool isLogOut;

  UiState({this.isLoading=false, this.isLogOut=false,this.isUpdate=false,this.hasMoreData=true,this.success,this.error,this.isSearch=false});

}