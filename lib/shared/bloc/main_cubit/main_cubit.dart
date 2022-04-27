import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newnew/model/get_model/get_all_person_model.dart';
import 'package:newnew/model/get_model/get_all_things_model.dart';
import 'package:newnew/model/get_model/user_missing_person_case.dart';
import 'package:newnew/model/get_model/user_missing_things_case.dart';
import 'package:newnew/model/get_model/user_search_for_family_case.dart';
import 'package:newnew/model/search_by_image_model/search_by_image_model.dart';
import 'package:newnew/model/upload_model/update_password.dart';
import 'package:newnew/model/upload_model/update_profile.dart';
import 'package:newnew/model/upload_model/upload_missing_things_model.dart';
import 'package:newnew/model/upload_model/upload_person_model.dart';
import 'package:newnew/model/user_model/contact_us_model.dart';
import 'package:newnew/model/user_model/get_profile.dart';
import 'package:newnew/model/get_model/old_ten_model.dart';
import 'package:newnew/model/upload_model/search_for_family_model.dart';
import 'package:newnew/modules/home_screen/paper_screen.dart';
import 'package:newnew/modules/home_screen/personal_screen.dart';
import 'package:newnew/modules/home_screen/upload_data/upload_screen.dart';
import 'package:newnew/modules/user_authentication/login_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/constant.dart';
import 'package:newnew/shared/local/share_pereference.dart';
import 'package:newnew/shared/network/dio.dart';
import 'package:newnew/shared/network/end_point.dart';
import 'package:newnew/shared/style/icon_broken.dart';


class MainCubit extends Cubit<MainState>{
  MainCubit() : super(MainInitial());
  static MainCubit get(context)=>BlocProvider.of(context);

  bool isEdit = false;

  void changeEdit(){
    isEdit = !isEdit ;
    emit(ChangeEditState());
  }
  void changeEditFalse(){
    isEdit = false ;
    emit(ChangeEditState());
  }

  bool  currentIsPassword=true,newIsPassword=true, confirmIsPassword=true;
  IconData visibilityOff = IconBroken.Hide ,visibility= IconBroken.Show;
  changePassword(){
    currentIsPassword = !currentIsPassword;
    emit(UpdatePasswordState());
  }
  changeNewPassword(){
    newIsPassword = !newIsPassword;
    emit(UpdatePasswordState());
  }
  changeConfirmRegisterPassword(){
    confirmIsPassword = !confirmIsPassword;
    emit(UpdatePasswordState());
  }
  var profileImagePicker = ImagePicker();
  File? profileImage;
  Future getProfileImage({required BuildContext context}) async{
    emit(ImageLoadingState());
    var pickerImage  = await profileImagePicker.pickImage(source: ImageSource.gallery);
    if(pickerImage != null){
      profileImage = File(pickerImage.path);
      emit(ImageGetSuccessState());
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(backgroundColor: Colors.red,
            content: Text('no image selected ',style: TextStyle(fontFamily: 'Jannah'),)),
      );

    }

  }
  void deleteProfileImage(){

    profileImage=null;
    emit(ImageDeleteSuccessState());
  }
  justEmitState(){
    emit(JustEmitState());

  }
  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      result = state;
      if(state==true){
        getAllPerson();
          getAllThings();
          getOldTenPerson();
          getUserMissingCase();
          getUserSearchForFamilyCase();
          getUserThingsCase();
          getProfile();
      }
      print(result);
      emit(CheckNetState());
    });
  }




  List<Widget> screen=[
    const PersonalScreen(),
    const PaperScreen(),
    const UploadScreen(),

  ];
  int currentIndex=0;
  int indicatorIndex=0;
  void changeIndex(index){
    currentIndex=index;
    emit(ChangeCurrentIndexState());
  }

  int x = 0;
  void tap(int y){

    x=y;
    emit(ChangeCurrentIndexState());
  }



  // logOut/////////////////////////////////////
  void missingLogout(context)async{
    emit(MissingLogoutLoadingState());
    DioHelper.postData(url: logout,
      token: token,
      data: {}
    ).
    then((value) {
      Fluttertoast.showToast(
        msg:'logout success',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,

      ).then((value) {
        CacheHelper.remove(key: 'token');
        Navigator.of(context).pop();

        navigateToAndRemove(context,  LoginScreen());
      });
      emit(MissingLogoutSuccessState());
    }).catchError((error){
      Fluttertoast.showToast(
        msg:'logout failed',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,

      );
      emit(MissingLogoutErrorState());
    });
  }


// get image for missing person
  var personImagePicker = ImagePicker();
  File? personImage;
  Future getPersonImage({required BuildContext context}) async{
    emit(ImageLoadingState());
    var pickerImage  = await personImagePicker.pickImage(source: ImageSource.gallery);
    if(pickerImage != null){
      personImage = File(pickerImage.path);
      emit(ImageGetSuccessState());
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(backgroundColor: Colors.red,
            content: Text('no image selected ',style: TextStyle(fontFamily: 'Jannah'),)),
      );

    }

  }
  void deleteImage(){

    personImage=null;
    emit(ImageDeleteSuccessState());
  }


  //upload missing person
  UploadPersonModel? uploadPersonModel;
  void uploadMissingPerson(
      {
        String? name,
        String? fatherName,
        String? motherName,
        String? yearOfBirth,
        String? gender,
        String? nationality,
        String? skinColor,
        String? eyeColor,
        String? headColor,
        String? height,
        String? weight,
        String? characteristics,
        String? date,
        String? country,
        String? state,
        String? city,
        String? circumstances,
        String? phone,
        String? whatApp,
        String? messengerUserName,
        File? photo,
      }
      )async{

      FormData formData = FormData.fromMap({
    "photo":photo != null? await MultipartFile.fromFile(
      photo.path,
    ):null,
     'Name':name,
     'fatherName':fatherName,
     'motherName':motherName,
     'yearOfBirth':yearOfBirth,
     'gender':gender,
     'nationality':nationality,
     'skinColor':skinColor,
     'eyeColor':eyeColor,
     'height':height,
     'weight':weight,
     'characteristics':characteristics,
     'date':date,
     'country':country,
     'state':state,
     'city':city,
     'circumstances':circumstances,
     'phone':phone,
     'whatApp':whatApp,
     'messengerUserName':messengerUserName,


    });

    emit(UploadMissingPersonLoadingState());
    try {
      var response = await DioHelper.postData(url: uploadMissingPersonUrl, data:formData,token: token );

      uploadPersonModel=UploadPersonModel.fromJson(response.data);
      deleteImage();
      getUserMissingCase();
      emit(UploadMissingPersonSuccessState(uploadPersonModel!));

    }on DioError catch(e){
     uploadPersonModel=UploadPersonModel.fromJson(e.response?.data);
     emit(UploadMissingPersonSuccessState(uploadPersonModel!));

    }catch(e){
      emit(UploadMissingPersonErrorState());
    }

  }
    ///////////////////////end///////////////////////////////


  /////////////// get image for search for family////////////////////////

  var searchForFamilyPicker = ImagePicker();
  File? searchForFamilyImage;
  Future getSearchForFamilyImage({required BuildContext context}) async{
    emit(ImageLoadingState());
    var pickerImage  = await searchForFamilyPicker.pickImage(source: ImageSource.gallery);
    if(pickerImage != null){
      searchForFamilyImage = File(pickerImage.path);
      emit(ImageGetSuccessState());
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(backgroundColor: Colors.red,

            content: Text('no image selected ',style: TextStyle(fontFamily: 'Jannah'),)),
      );
    }

  }

  void deleteSearchForFamilyImage(){
    searchForFamilyImage=null;
    emit(ImageDeleteSuccessState());
  }

   SearchForFamilyModel? searchForFamilyModel;
  void postSearchForFamily(
      {
        String? name,
        String? fatherName,
        String? motherName,
        String? yearOfBirth,
        String? gender,
        String? nationality,
        String? skinColor,
        String? eyeColor,
        String? headColor,
        String? height,
        String? weight,
        String? characteristics,
        String? date,
        String? country,
        String? state,
        String? city,
        String? circumstances,
        String? phone,
        String? whatApp,
        String? messangerUserName,
        File? photo,
      }
      )async{

    FormData formData = FormData.fromMap({
      "photo":photo != null? await MultipartFile.fromFile(
        photo.path,
      ):null,
      'Name':name,
      'fatherName':fatherName,
      'motherName':motherName,
      'yearOfBirth':yearOfBirth,
      'gender':gender,
      'nationality':nationality,
      'skinColor':skinColor,
      'eyeColor':eyeColor,
      'height':height,
      'weight':weight,
      'characteristics':characteristics,
      'date':date,
      'country':country,
      'state':state,
      'city':city,
      'circumstances':circumstances,
      'phone':phone,
      'whatApp':whatApp,
      'messangerUserName':messangerUserName,


    });

    emit(UploadSearchForFamilyLoadingState());
    try {
      var response = await DioHelper.postData(url: searchForFamilyUrl, data:formData,token: token);

      searchForFamilyModel=SearchForFamilyModel.fromJson(response.data);
      deleteSearchForFamilyImage();
      getUserSearchForFamilyCase();

      emit(UploadSearchForFamilySuccessState(searchForFamilyModel!));
    }on DioError catch(e){
      searchForFamilyModel=SearchForFamilyModel.fromJson(e.response!.data);
      emit(UploadSearchForFamilySuccessState(searchForFamilyModel!));
    }catch(e){
      emit(UploadMissingPersonErrorState());
    }
  }

  ///////////////////end///////////////////////////////////////////


  /////////////// get image for missing things////////////////////////

  var missingThings = ImagePicker();
  File? missingThingsImage;
  Future getMissingThingsImage({required BuildContext context}) async{
    emit(ImageLoadingState());
    var pickerImage  = await missingThings.pickImage(source: ImageSource.gallery);
    if(pickerImage != null){
      missingThingsImage = File(pickerImage.path);
      emit(ImageGetSuccessState());
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(backgroundColor: Colors.red,
            content: Text('no image selected ',style: TextStyle(fontFamily: 'Jannah'),)),
      );
    }

  }

  void deleteMissingThingsImage(){
    missingThingsImage=null;
    emit(ImageDeleteSuccessState());
  }

  UploadMissingThings? uploadMissingThings;
  void postMissingThings(
      {
        String? name,
        String? type,
        String? state,
        String? model,
        String? color,
        String? carNumber,
        String? description,
        File? photo,
        String? date,
        String? location,
        String? phone,
        String? whatApp,
        String? messengerUserName,

      }
      )async{

    FormData formData = FormData.fromMap({
      "photo":photo != null? await MultipartFile.fromFile(
        photo.path,
      ):null,
      'name':name,
      'type':type,
      'state':state,
      'model':model,
      'color':color,
      'carNumber':carNumber,
      'description':description,
      'date':date,
      'location':location,
      'phone':phone,
      'whatApp':whatApp,
      'messengerUserName':messengerUserName,



    });

    emit(UploadMissingThingsLoadingState());
    try {
      var response = await DioHelper.postData(url: uploadThingsUrl, data:formData,token: token);
      uploadMissingThings=UploadMissingThings.fromJson(response.data);
      deleteMissingThingsImage();
      getUserThingsCase();
      emit(UploadMissingThingsSuccessState(uploadMissingThings!));



    }on DioError catch(e){
      uploadMissingThings=UploadMissingThings.fromJson(e.response!.data);
      emit(UploadMissingThingsSuccessState(uploadMissingThings!));

    }catch(e){

      emit(UploadMissingThingsErrorState());

    }

  }

///////////////////end///////////////////////////////////////////

//////////////////get old 10 person/////////////////////////////
  OldTenModel? oldTenModel;
void getOldTenPerson()async{

  emit(GetLastTenPersonLoadingState());
  try {
    var response = await DioHelper.getData(url: getOldTenUrl,token: token);

    oldTenModel=OldTenModel.fromJson(response.data);
    emit(GetLastTenPersonSuccessState(oldTenModel!));


  }on DioError catch(e){

    oldTenModel=OldTenModel.fromJson(e.response!.data);
    emit(GetLastTenPersonSuccessState(oldTenModel!));
  }catch(e){

    emit(GetLastTenPersonErrorState());

  }

}
///////////////////end///////////////////////////////////////////

//////////////////get all person/////////////////////////////
  GetAllPersonModel? getAllPersonModel;
  void getAllPerson()async{

    emit(GetAllPersonLoadingState());
    try {
      var response = await DioHelper.getData(url: getAllPersonUrl,token: token);

      getAllPersonModel=GetAllPersonModel.fromJson(response.data);
      emit(GetAllPersonSuccessState(getAllPersonModel!));

    }on DioError catch(e){

      getAllPersonModel=GetAllPersonModel.fromJson(e.response!.data);
      emit(GetAllPersonSuccessState(getAllPersonModel!));

    }catch(e){
      emit(GetAllPersonErrorState());

    }

  }
///////////////////end///////////////////////////////////////////


//////////////////get all things////////////////////////////////

  GetAllThingsModel? getAllThingsModel;
  void getAllThings()async{

    emit(GetAllThingsLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getAllThingsUrl,
          token: token
      );
      getAllThingsModel=GetAllThingsModel.fromJson(response.data);
      emit(GetAllThingsSuccessState(getAllThingsModel!));

    }on DioError catch(e){

      getAllThingsModel=GetAllThingsModel.fromJson(e.response!.data);
      emit(GetAllThingsSuccessState(getAllThingsModel!));

    }catch(e){
      emit(GetAllThingsErrorState());
    }

  }
///////////////////end///////////////////////////////////////////


//////////////////get all person filter/////////////////////////////
  void getAllPersonFilter({
   String? gender,
   String? adult,
   String? child,
   String? minAge,
   String? maxAge,
   String? minHeight,
   String? maxHeight,
   String? minWeight,
   String? maxWeight,
   String? name,
   String? yearOfBirth,
   required BuildContext context,
   required personType,

})async{
    emit(PersonFilterLoadingState());
    try {
      var response = await DioHelper.getData(url: getAllPersonFilterUrl+personType,token: token,
         query: {
        'gender':gender,
        'Adult':adult,
        'Child':child,
        'minAge':minAge,
        'maxAge':maxAge,
        'minheight':minHeight,
        'maxheight':maxHeight,
        'minweight':minWeight,
        'maxweight':maxWeight,
        'Name':name,
        'yearOfBirth':yearOfBirth,
      });

      getAllPersonModel=GetAllPersonModel.fromJson(response.data);
      emit(PersonFilterSuccessState(getAllPersonModel!));
      Navigator.of(context).pop();
    }on DioError catch(e){
      emit(PersonFilterSuccessState(getAllPersonModel!));
      getAllPerson();
      Fluttertoast.showToast(
        msg:'Not Found 😅 !',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.of(context).pop();
    }catch(e){
      emit(PersonFilterErrorState());

    }

  }
///////////////////end///////////////////////////////////////////


///////////////////get things filter ///////////////////////////////////////////
  void getAllThingsFilter({
    String? name,
    String? type,
    String? model,
    String? state,
    String? color,
    String? carNumber,
    String? location,

    required BuildContext context

  })async{
    getAllThingsModel=null;
    emit(ThingsFilterLoadingState());
    try {
      var response = await DioHelper.getData(url: getAllThingsFilterUrl,token: token,
          query: {
            'name':name,
            'type':type,
            'model':model,
            'state':state,
            'color':color,
            'location':location,
            'car_number':carNumber
          });
      print('++++++++++++++++++++++++++++++++++++++');
      print(response.data);
      getAllThingsModel=GetAllThingsModel.fromJson(response.data);
       if(getAllThingsModel!.data!.isEmpty ){
         getAllThings();
         Fluttertoast.showToast(
           msg:'Not Found 😅 !',
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 2,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0,
         );
       }

      Navigator.of(context).pop();

      emit(ThingsFilterSuccessState(getAllThingsModel!));

    }on DioError catch(e){

      getAllThings();
      Fluttertoast.showToast(
        msg:'Not Found 😅 !',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(ThingsFilterSuccessState(getAllThingsModel!));


    }catch(e){

      emit(ThingsFilterErrorState());

    }
  }
///////////////////end///////////////////////////////////////////


//////////////////get profile////////////////////////////////

  GetProfileModel? getProfileModel;
  void getProfile()async{

    emit(GetProfileLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getProfileUrl,
          token: token
      );
      getProfileModel=GetProfileModel.fromJson(response.data);
      emit(GetProfileSuccessState(getProfileModel!));

    }on DioError catch(e){

      getProfileModel=GetProfileModel.fromJson(e.response!.data);
      emit(GetProfileSuccessState(getProfileModel!));

    }catch(e){
      emit(GetProfileErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

/////////////// contact us////////////////////////
  ContactUsModel? contactUsModel;

  void contactUs(
      {
        String? name,
        String? email,
        String? message,
        String? subject,
        String? phone,
      }
      )async{

    emit(ContactUsLoadingState());
    try {
      var response = await DioHelper.postData(url: contactUsUrl, data:{
        'name':name,
        'email':email,
        'message':message,
        'subject':subject,
        'phone':phone,
      },);
      contactUsModel=ContactUsModel.fromJson(response.data);
      emit(ContactUsSuccessState(contactUsModel!));
    }on DioError catch(e){
      contactUsModel=ContactUsModel.fromJson(e.response!.data);
      emit(ContactUsSuccessState(contactUsModel!));
    }catch(e){
      emit(ContactUsErrorState());

    }

  }

///////////////////end///////////////////////////////////////////

///////////////////update profile///////////////////////////////////////////
 UpdateProfileModel? updateProfileModel;
  void updateProfile({
    String? name,
    String? email,
    File? photo,

  })async{
    FormData formData = FormData.fromMap({
      "photo":photo != null? await MultipartFile.fromFile(
        photo.path,
      ):null,
      'name':name,
      'email':email,


    });
    emit(UpdateProfileLoadingState());
    try{
      var response = await DioHelper.patchData(url: updateProfileUrl,
          data:formData,token: token);
      updateProfileModel=UpdateProfileModel.fromJson(response.data);
      emit(UpdateProfileSuccessState(updateProfileModel!));
      getProfile();
      deleteProfileImage();

    }on DioError catch(e){

      updateProfileModel=UpdateProfileModel.fromJson(e.response!.data);
      emit(UpdateProfileSuccessState(updateProfileModel!));
    }catch(e){
      emit(UpdateProfileErrorState());
    }
  }
///////////////////end///////////////////////////////////////////

///////////////////update password///////////////////////////////////////////
  UpdatePasswordModel? updatePasswordModel;
  void updatePassword({
    String? passwordCurrent,
    String? newPassword,
    String? passwordConfirm,

  })async{
    emit(UpdatePasswordLoadingState());
    try{
      var response = await DioHelper.patchData(url: updatePasswordUrl, data:{
       'passwordCurrent':passwordCurrent,
       'newPassword':newPassword,
       'passwordConfirm':passwordConfirm,
      },token: token);
      print(response.data['token']);
      updatePasswordModel=UpdatePasswordModel.fromJson(response.data);
      emit(UpdatePasswordSuccessState(updatePasswordModel!));
      CacheHelper.putData(key: 'token', value: response.data['token'] );
      token=response.data['token'];
      getProfile();


    }on DioError catch(e){

      updatePasswordModel=UpdatePasswordModel.fromJson(e.response!.data);
      emit(UpdatePasswordSuccessState(updatePasswordModel!));

    }catch(e){

      emit(UpdatePasswordErrorState());

    }
  }
///////////////////end///////////////////////////////////////////

//////////////////get missing case////////////////////////////////

  UserMissingCaseModel? userMissingCaseModel;
  List<Map>  missingCaseList=[];
  void getUserMissingCase()async{

    emit(GetMissingCaseLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getUserMissingCaseUrl,
          token: token
      );

      userMissingCaseModel=UserMissingCaseModel.fromJson(response.data);

      emit(GetMissingCaseSuccessState(userMissingCaseModel!));

    }on DioError catch(e){

      userMissingCaseModel=UserMissingCaseModel.fromJson(e.response!.data);
      emit(GetMissingCaseSuccessState(userMissingCaseModel!));

    }catch(e){
      emit(GetMissingCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////get search for family case////////////////////////////////

  UserSearchForFamilyCaseModel? userSearchForFamilyCaseModel;
  void getUserSearchForFamilyCase()async{

    emit(SearchForFamilyCaseLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getUserSearchForFamilyCaseUrl,
          token: token
      );
      userSearchForFamilyCaseModel=UserSearchForFamilyCaseModel.fromJson(response.data);
      emit(SearchForFamilyCaseSuccessState(userSearchForFamilyCaseModel!));

    }on DioError catch(e){

      userSearchForFamilyCaseModel=UserSearchForFamilyCaseModel.fromJson(e.response!.data);
      emit(SearchForFamilyCaseSuccessState(userSearchForFamilyCaseModel!));

    }catch(e){
      emit(SearchForFamilyCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////get Things case////////////////////////////////

  UserThingsCaseModel? userThingsCaseModel;
  void getUserThingsCase()async{

    emit(ThingsCaseLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getUserThingsCaseUrl,
          token: token
      );
      userThingsCaseModel=UserThingsCaseModel.fromJson(response.data);
      emit(ThingsCaseSuccessState(userThingsCaseModel!));

    }on DioError catch(e){

      userThingsCaseModel=UserThingsCaseModel.fromJson(e.response!.data);
      emit(ThingsCaseSuccessState(userThingsCaseModel!));

    }catch(e){
      emit(ThingsCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////delete missing case////////////////////////////////


  void deleteMissingCase({
    required String id,
})async{

    emit(DeleteCaseLoadingState());
    try {
      var response = await DioHelper.deleteData(
          url: deleteUserMissingCaseUrl+id,
          token: token
      );
      emit(DeleteCaseSuccessState(response.data['message']));
      getUserMissingCase();
      getAllPerson();

    }on DioError catch(e){
      emit(DeleteCaseSuccessState(e.response!.data['message']));

    }catch(e){
      emit(DeleteCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////delete search for family case////////////////////////////////

  void deleteSearchForFamilyCase({
    required String id,
  })async{

    emit(DeleteCaseLoadingState());
    try {
      var response = await DioHelper.deleteData(
          url: deleteSearchForFamilyCaseUrl+id,
          token: token
      );
      emit(DeleteCaseSuccessState(response.data['message']));
      getUserSearchForFamilyCase();
      getAllPerson();

    }on DioError catch(e){

      emit(DeleteCaseSuccessState(e.response!.data['message']));

    }catch(e){
      emit(DeleteCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////delete things case////////////////////////////////

  void deleteThingsCase({
    required String id,
  })async{

    emit(DeleteCaseLoadingState());
    try {
      var response = await DioHelper.deleteData(
          url: deleteUserThingsCaseUrl+id,
          token: token
      );
      getUserThingsCase();
      getAllThings();
      emit(DeleteCaseSuccessState(response.data['message']));


    }on DioError catch(e){

      emit(DeleteCaseSuccessState(e.response!.data['message']));

    }catch(e){
      emit(DeleteCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

///////////////////update missing case///////////////////////////////////////////
  void updateMissingCase({
  String? name,
  String? fatherName,
  String? motherName,
  String? yearOfBirth,
  String? gender,
  String? nationality,
  String? skinColor,
  String? eyeColor,
    String? headColor,
    String? height,
    String? weight,
    String? characteristics,
    String? date,
    String? country,
    String? state,
    String? city,
    String? circumstances,
    String? phone,
    String? whatApp,
    String? messengerUserName,
    required String id,
    File? photo,
  })async{
    FormData formData = FormData.fromMap({
      "photo":photo != null? await MultipartFile.fromFile(
        photo.path,
      ):null,
      'Name':name,
      'fatherName':fatherName,
      'motherName':motherName,
      'yearOfBirth':yearOfBirth,
      'gender':gender,
      'nationality':nationality,
      'skinColor':skinColor,
      'eyeColor':eyeColor,
      'height':height,
      'weight':weight,
      'characteristics':characteristics,
      'date':date,
      'country':country,
      'state':state,
      'city':city,
      'circumstances':circumstances,
      'phone':phone,
      'whatApp':whatApp,
      'messangerUserName':messengerUserName,
    });
    emit(UpdateUserCaseLoadingState());
    try{
      var response = await DioHelper.patchData(url: updateUserMissingCaseUrl+id,
          data:formData,token: token);
      getAllPerson();
      getUserMissingCase();
      getOldTenPerson();
      deleteImage();
      showToast(text: 'update success', state: ToastStates.SUCCESS);
      emit(UpdateUserCaseSuccessState());
    }on DioError catch(e){

      emit(UpdateUserCaseSuccessState());
      print(e.response!.data);

    }catch(e){
      emit(UpdateUserCaseErrorState());

    }
  }
///////////////////end///////////////////////////////////////////

///////////////////update searchFamilyCase///////////////////////////////////////////
  void updateSearchFamilyCase({
    String? name,
    String? fatherName,
    String? motherName,
    String? yearOfBirth,
    String? gender,
    String? nationality,
    String? skinColor,
    String? eyeColor,
    String? headColor,
    String? height,
    String? weight,
    String? characteristics,
    String? date,
    String? country,
    String? state,
    String? city,
    String? circumstances,
    String? phone,
    String? whatApp,
    String? messengerUserName,
    required String id,
    File? photo,

  })async{
    FormData formData = FormData.fromMap({
      "photo":photo != null? await MultipartFile.fromFile(
        photo.path,
      ):null,
      'Name':name,
      'fatherName':fatherName,
      'motherName':motherName,
      'yearOfBirth':yearOfBirth,
      'gender':gender,
      'nationality':nationality,
      'skinColor':skinColor,
      'eyeColor':eyeColor,
      'height':height,
      'weight':weight,
      'characteristics':characteristics,
      'date':date,
      'country':country,
      'state':state,
      'city':city,
      'circumstances':circumstances,
      'phone':phone,
      'whatApp':whatApp,
      'messangerUserName':messengerUserName,


    });
    emit(UpdateUserCaseLoadingState());
    try{
      var response = await DioHelper.patchData(url: updateUserSearchFamilyCaseUrl+id,
          data:formData,token: token);
      getAllPerson();
      getUserSearchForFamilyCase();
      getOldTenPerson();
      deleteSearchForFamilyImage();
      showToast(text: 'update success', state: ToastStates.SUCCESS);
      emit(UpdateUserCaseSuccessState());


    }on DioError catch(e){

      emit(UpdateUserCaseSuccessState());

    }catch(e){

      emit(UpdateUserCaseErrorState());

    }
  }
///////////////////end///////////////////////////////////////////


///////////////////update Things Case///////////////////////////////////////////
  void updateThingsCase({
    String? name,
    String? type,
    String? state,
    String? model,
    String? color,
    String? carNumber,
    String? description,
    File? photo,
    String? date,
    String? location,
    String? phone,
    String? whatApp,
    String? messengerUserName,
    required String id,

  })async{
    FormData formData = FormData.fromMap({
      "photo":photo != null? await MultipartFile.fromFile(
        photo.path,
      ):null,
      'name':name,
      'type':type,
      'state':state,
      'model':model,
      'color':color,
      'carNumber':carNumber,
      'description':description,
      'date':date,
      'location':location,
      'phone':phone,
      'whatApp':whatApp,
      'messengerUserName':messengerUserName,
    });

    emit(UpdateUserCaseLoadingState());
    try{
      var response = await DioHelper.patchData(url: updateUserThingsCaseUrl+id,
          data:formData,token: token);
      getUserThingsCase();
      deleteMissingThingsImage();
      showToast(text: 'update success', state: ToastStates.SUCCESS);
      emit(UpdateUserCaseSuccessState());


    }on DioError catch(e){

      emit(UpdateUserCaseSuccessState());

    }catch(e){

      emit(UpdateUserCaseErrorState());

    }
  }
///////////////////end///////////////////////////////////////////

  bool isDark =false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null){
      isDark = fromShared;
      emit(AppChangeModeState());
    }

    else{
      isDark = !isDark;
      CacheHelper.putData(key:'isDark', value: isDark).then((value){
        emit(AppChangeModeState());
      } );
    }


  }
  /////////////////////////////////////end////////////////////

  ///////////////////////////////////// search by image ///////////////////////
  SearchByImageModel? searchByImageModel;
  void searchByImagePost({
    File? photo,
  })async{
    FormData formData = FormData.fromMap({"photo":photo != null? await MultipartFile.fromFile(photo.path,):null,});

    emit(SearchByImageLoadingState());
    try{
      var response = await DioHelper.postData(url:searchByImageUrl,
          data:formData,token: token);
      print(response.data);
      searchByImageModel=SearchByImageModel.fromJson(response.data);
      emit(SearchByImageSuccessState());

    }on DioError catch(e){
      searchByImageModel!.data=[];
      showToast(text: 'Not Found try Again 😅', state: ToastStates.ERROR);
      searchByImage = null;
      emit(SearchByImageSuccessState());

    }catch(e){
      emit(SearchByImageErrorState());

    }
  }
////////////////////////////////////// end ////////////////////////////////


  //////////////////////////////////////////////////////
  var searchByImagePicker = ImagePicker();
  File? searchByImage;
  Future getSearchByImageGallery({required BuildContext context}) async{
    Navigator.of(context).pop();
    emit(ImageLoadingState());
    var pickerImage  = await searchByImagePicker.pickImage(source: ImageSource.gallery);
    if(pickerImage != null){
      searchByImage = File(pickerImage.path);
      emit(ImageGetSuccessState());
      searchByImagePost(photo:searchByImage );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(backgroundColor: Colors.red,

            content: Text('no image selected ',style: TextStyle(fontFamily: 'Jannah'),)),
      );
    }

  }
  Future getSearchByImageCamera({required BuildContext context}) async{
    Navigator.of(context).pop();
    emit(ImageLoadingState());
    var pickerImage  = await searchByImagePicker.pickImage(source: ImageSource.camera);
    if(pickerImage != null){
      searchByImage = File(pickerImage.path);
      emit(ImageGetSuccessState());
      searchByImagePost(photo:searchByImage);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(backgroundColor: Colors.red,

            content: Text('no image selected ',style: TextStyle(fontFamily: 'Jannah'),)),
      );
    }

  }
  void deleteSearchByImage(){
    searchByImage=null;
    emit(ImageDeleteSuccessState());
  }
  ////////////////////////////////////////////////////////////////////////
///////////////////////////// missing case found//////
  void userMissingCaseFound({
    required String id,
  })async{

    emit(UserCaseFoundLoadingState());
    try {
      var response = await DioHelper.postData(
          url: missingFoundUrl+id,
          token: token, data: null,
      );
      print(response.data);
      showToast(text:response.data['message'], state: ToastStates.SUCCESS);


      emit(UserCaseFoundSuccessState());
      getUserMissingCase();
      getAllPerson();

    }on DioError catch(e){
      print(e.response!.data);
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);



      emit(UserCaseFoundSuccessState());

    }catch(e){
      emit(UserCaseFoundErrorState());
    }

  }
///////////////////////////////////////////////////////////////////////////

/////////////////////////////  searchFamily case found//////
  void userSearchFamilyCaseFound({
    required String id,
  })async{

    emit(UserCaseFoundLoadingState());
    try {
      var response = await DioHelper.postData(
        url: searchFamilyFoundUrl+id,
        token: token, data: null,
      );
      print(response.data);
      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      emit(UserCaseFoundSuccessState());
      getUserSearchForFamilyCase();
      getAllPerson();

    }on DioError catch(e){

      emit(UserCaseFoundSuccessState());
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);


    }catch(e){
      emit(UserCaseFoundErrorState());
    }

  }
///////////////////////////////////////////////////////////////////////////

///////////////////////////// things case found//////////////////////
  void userThingsCaseFound({
    required String id,
  })async{

    emit(UserCaseFoundLoadingState());
    try {
      var response = await DioHelper.postData(
        url: thingsFoundUrl+id,
        token: token, data: null,
      );
      print(response.data);
      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      emit(UserCaseFoundSuccessState());
      getUserThingsCase();
      getAllPerson();

    }on DioError catch(e){
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);

      emit(UserCaseFoundSuccessState());

    }catch(e){
      emit(UserCaseFoundErrorState());
    }

  }
///////////////////////////////////////////////////////////////////////////
///////////////////////////////counterFoundUrl////////////////////////////////////
void counterFound()async{

  emit(CounterCaseFoundLoadingState());
  try {
    var response = await DioHelper.getData(
      url: counterFoundUrl,
    );
    emit(CounterCaseFoundSuccessState());
    print(response.data);

  }catch(e){
    emit(CounterCaseFoundErrorState());
  }

}
////////////////////////////////////////////////////////////////////////////




}









