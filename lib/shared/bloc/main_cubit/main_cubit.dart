import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:newnew/model/admin_model/accept_missing_model.dart';
import 'package:newnew/model/admin_model/get_missing_person.dart';
import 'package:newnew/model/admin_model/get_search_for_family.dart';
import 'package:newnew/model/admin_model/get_things.dart';
import 'package:newnew/model/admin_model/not_accept_missing_model.dart';
import 'package:newnew/model/admin_model/not_accept_search_for_family_model.dart';
import 'package:newnew/model/admin_model/not_accept_tthings_model.dart';
import 'package:newnew/model/get_model/get_all_person_model.dart';
import 'package:newnew/model/get_model/get_all_things_model.dart';
import 'package:newnew/model/get_model/user_missing_person_case.dart';
import 'package:newnew/model/get_model/user_missing_things_case.dart';
import 'package:newnew/model/get_model/user_search_for_family_case.dart';
import 'package:newnew/model/search_by_image_model/search_by_image_model.dart';
import 'package:newnew/model/upload_model/already_missing_found_model.dart';
import 'package:newnew/model/upload_model/update_password.dart';
import 'package:newnew/model/upload_model/update_profile.dart';
import 'package:newnew/model/upload_model/upload_missing_things_model.dart';
import 'package:newnew/model/upload_model/upload_person_model.dart';
import 'package:newnew/model/user_model/contact_us_model.dart';
import 'package:newnew/model/user_model/get_profile.dart';
import 'package:newnew/model/get_model/old_ten_model.dart';
import 'package:newnew/model/upload_model/search_for_family_model.dart';
import 'package:newnew/modules/home_screen/already_found_screen.dart';
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
import 'package:newnew/shared/style/colors.dart';
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
    //  profileImage = await customCompressed(imagePathToCompress: searchByImage!);
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
      final sizeInKbAfter = personImage!.lengthSync()/1924;
      if(sizeInKbAfter > 600){
        personImage = await customCompressed(imagePathToCompress: personImage!);
      }else{
        personImage = personImage;
      }


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


  //////////////////////////////upload missing person//////////////////////////////
  UploadPersonModel? uploadPersonModel;
  AlreadyMissingFoundModel? alreadyMissingFoundModel;
  void uploadMissingPerson(
      {
        String? latitude,
        String? longitude,
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
       required BuildContext context,
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
     'longitude':longitude,
     'latitude':latitude,


    });

    emit(UploadMissingPersonLoadingState());
    try {
      var response = await DioHelper.postData(url: uploadMissingPersonUrl, data:formData,token: token );

      uploadPersonModel=UploadPersonModel.fromJson(response.data);
      deleteImage();
      getUserMissingCase();
      emit(UploadMissingPersonSuccessState(uploadPersonModel!));

    }on DioError catch(e){
      deleteImage();
       if(e.response?.data['data'] != null ){
         alreadyMissingFoundModel = AlreadyMissingFoundModel.fromJson(e.response!.data);
         showDialog(context: context, builder: (context){
           return AlertDialog(
              title:  Text(e.response!.data['message']),
             content:  const Text('you want see it ?'),
             actions: [
               MaterialButton(onPressed: (){
                 Navigator.of(context).pop();
               },child: Text('cancel',style: TextStyle(color: defaultColor),),),
               MaterialButton(onPressed: (){
                 Navigator.of(context).pop();
                 navigateTo(context, AlreadyFoundScreen(model: alreadyMissingFoundModel!.data![0],));
               },child: const Text('ok',style: TextStyle(color: Colors.red),),),
             ],
             elevation: 24,

           );

         },
         );

          emit(AlreadyMissingFoundState());


       }else{
         uploadPersonModel=UploadPersonModel.fromJson(e.response!.data);
         emit(UploadMissingPersonSuccessState(uploadPersonModel!));
       }

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
      final sizeInKbAfter = searchForFamilyImage!.lengthSync()/1924;
      if(sizeInKbAfter > 600){
        searchForFamilyImage = await customCompressed(imagePathToCompress: searchForFamilyImage!);
      }else{
        searchForFamilyImage = searchForFamilyImage;
      }


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
        String? latitude,
        String? longitude,
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
        required BuildContext context,
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
      'latitude':latitude,
      'longitude':longitude,

    });

    emit(UploadSearchForFamilyLoadingState());
    try {
      var response = await DioHelper.postData(url: searchForFamilyUrl, data:formData,token: token);

      searchForFamilyModel=SearchForFamilyModel.fromJson(response.data);
      deleteSearchForFamilyImage();
      getUserSearchForFamilyCase();
      print('11111111111111111111111111111111');
      print(response.data['data']['latitude']);
      print(response.data['data']['longitude']);
      emit(UploadSearchForFamilySuccessState(searchForFamilyModel!));
    }on DioError catch(e){
      deleteSearchForFamilyImage();

      if(e.response?.data['data'] != null ){
        alreadyMissingFoundModel = AlreadyMissingFoundModel.fromJson(e.response!.data);
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title:  Text(e.response!.data['message']),
            content:  const Text('you want see it ?'),
            actions: [
              MaterialButton(onPressed: (){
                Navigator.of(context).pop();
              },child: Text('cancel',style: TextStyle(color: defaultColor),),),
              MaterialButton(onPressed: (){
                Navigator.of(context).pop();
                navigateTo(context, AlreadyFoundScreen(model: alreadyMissingFoundModel!.data![0],));
              },child: const Text('ok',style: TextStyle(color: Colors.red),),),
            ],
            elevation: 24,

          );

        },
        );

        emit(AlreadyMissingFoundState());


      }else{
        searchForFamilyModel=SearchForFamilyModel.fromJson(e.response!.data);
        emit(UploadSearchForFamilySuccessState(searchForFamilyModel!));
      }

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
      final sizeInKbAfter = missingThingsImage!.lengthSync()/1924;
      if(sizeInKbAfter > 600){
         missingThingsImage = await customCompressed(imagePathToCompress: missingThingsImage!);
      }else{
        missingThingsImage = missingThingsImage;
      }



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
        String? longitude,
        String? latitude,
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
      'latitude':latitude,
      'longitude':longitude,



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
    }on DioError catch(_){
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

    }on DioError catch(_){

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
      showToast(text: response.data['message'], state: ToastStates.SUCCESS);

    }on DioError catch(e){

      emit(UpdateUserCaseSuccessState());
      showToast(text: e.response!.data['message'], state: ToastStates.ERROR);


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
      print(response.data['message']);


    }on DioError catch(e){

      emit(UpdateUserCaseSuccessState());
      print(e.response!.data['status']);
      showToast(text: e.response!.data['message'], state: ToastStates.ERROR);


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
       await DioHelper.patchData(url: updateUserThingsCaseUrl+id,
          data:formData,token: token);
      showToast(text: 'update success', state: ToastStates.SUCCESS);
      emit(UpdateUserCaseSuccessState());
      getUserThingsCase();
      deleteMissingThingsImage();


    }on DioError catch(e){
      showToast(text: e.response!.data['message'], state: ToastStates.ERROR);
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
      searchByImageModel=SearchByImageModel.fromJson(response.data);
      emit(SearchByImageSuccessState());

    }on DioError catch(_){
      searchByImageModel != null?searchByImageModel!.data=[]:null;
      showToast(text: 'Not Found try Again 😅', state: ToastStates.ERROR);
      searchByImage = null;
      emit(SearchByImageSuccessState());

    }catch(e){
      emit(SearchByImageErrorState());



    }
  }
////////////////////////////////////// end ////////////////////////////////


  //////////////////////////////////////////////////////
  Future<File> customCompressed({
  required File imagePathToCompress,
})async{
    var path = FlutterNativeImage.compressImage(
      imagePathToCompress.absolute.path,
      quality: 100,
      percentage: 10,

    );
  return path;
  }

  var searchByImagePicker = ImagePicker();
  File? searchByImage;
  Future getSearchByImageGallery({required BuildContext context}) async{
    Navigator.of(context).pop();
    emit(ImageLoadingState());
    var pickerImage  = await searchByImagePicker.pickImage(source: ImageSource.gallery);
    if(pickerImage != null){
      searchByImage = File(pickerImage.path);
      final sizeInKbAfter = searchByImage!.lengthSync()/1924;
      if(sizeInKbAfter > 600){
        searchByImage = await customCompressed(imagePathToCompress: searchByImage!);
      }else{
        searchByImage = searchByImage;
      }
      searchByImagePost(photo:searchByImage );
      emit(ImageGetSuccessState());

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
      File compressedImage = await customCompressed(imagePathToCompress: searchByImage!);
      //final sizeInKbAfter = compressedImage.lengthSync()/1924;
      searchByImagePost(photo:compressedImage);
      emit(ImageGetSuccessState());
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
      showToast(text:response.data['message'], state: ToastStates.SUCCESS);


      emit(UserCaseFoundSuccessState());
      getUserMissingCase();
      getAllPerson();

    }on DioError catch(e){
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
     await DioHelper.getData(
      url: counterFoundUrl,
    );
    emit(CounterCaseFoundSuccessState());

  }catch(e){
    emit(CounterCaseFoundErrorState());
  }

}
////////////////////////////////////////////////////////////////////////////

//////////////////get admin missing case////////////////////////////////

  AdminMissingPersonModel? adminMissingPersonModel;
  List<Map>  missingAdminCaseList=[];
  void getAdminMissingCase()async{

    emit(GetAdminMissingCaseLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getAminMissingCaseUrl,
          token: token
      );

      adminMissingPersonModel=AdminMissingPersonModel.fromJson(response.data);

      emit(GetAdminMissingCaseSuccessState(adminMissingPersonModel!));

    }on DioError catch(e){

      adminMissingPersonModel=AdminMissingPersonModel.fromJson(e.response!.data);
      emit(GetAdminMissingCaseSuccessState(adminMissingPersonModel!));

    }catch(e){
      emit(GetAdminMissingCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////get admin search for family case////////////////////////////////

  AdminSearchForFamilyModel? adminSearchForFamilyModel;
  List<Map>  searchForFamilyAdminCaseList=[];
  void getAdminSearchForFamilyCase()async{

    emit(GetAdminSearchForFamilyCaseLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getAminSearchForFamilyCaseUrl,
          token: token
      );

      adminSearchForFamilyModel=AdminSearchForFamilyModel.fromJson(response.data);

      emit(GetAdminSearchForFamilyCaseSuccessState(adminSearchForFamilyModel!));

    }on DioError catch(e){

      adminSearchForFamilyModel=AdminSearchForFamilyModel.fromJson(e.response!.data);
      emit(GetAdminSearchForFamilyCaseSuccessState(adminSearchForFamilyModel!));


    }catch(e){
      emit(GetAdminSearchForFamilyCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////get admin things case////////////////////////////////

  AdminThingsModel? adminThingsModel;
  List<Map>  thingsAdminCaseList=[];
  void getAdminThingsCase()async{

    emit(GetAdminThingsCaseLoadingState());
    try {
      var response = await DioHelper.getData(
          url: getAminThingsCaseUrl,
          token: token
      );

      adminThingsModel=AdminThingsModel.fromJson(response.data);

      emit(GetAdminThingsCaseSuccessState(adminThingsModel!));


    }on DioError catch(e){

      adminThingsModel=AdminThingsModel.fromJson(e.response!.data);

      emit(GetAdminThingsCaseSuccessState(adminThingsModel!));



    }catch(e){
      emit(GetAdminThingsCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////delete admin missing case////////////////////////////////

  void deleteAdminMissingCase({
    required String id,
  })async{

    emit(DeleteAdminCaseLoadingState());
    try {
      var response = await DioHelper.deleteData(
          url: deleteAdminMissingCaseUrl+id,
          token: token
      );

      emit(DeleteAdminCaseSuccessState(response.data['message']));
        getAdminMissingCase();

    }on DioError catch(e){

      emit(DeleteAdminCaseSuccessState(e.response!.data['message']));

    }catch(e){
      emit(DeleteAdminCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////delete admin Search For Family case////////////////////////////////

  void deleteAdminSearchForFamilyCase({
    required String id,
  })async{

    emit(DeleteAdminCaseLoadingState());
    try {
      var response = await DioHelper.deleteData(
          url: deleteAdminSearchForFamilyCaseUrl+id,
          token: token
      );

      emit(DeleteAdminCaseSuccessState(response.data['message']));
       getAdminSearchForFamilyCase();

    }on DioError catch(e){

      emit(DeleteAdminCaseSuccessState(e.response!.data['message']));

    }catch(e){
      emit(DeleteAdminCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

//////////////////delete admin Things case////////////////////////////////

  void deleteAdminThingsCase({
    required String id,
  })async{

    emit(DeleteAdminCaseLoadingState());
    try {
      var response = await DioHelper.deleteData(
          url: deleteAdminThingsCaseUrl+id,
          token: token
      );
      getAdminThingsCase();
      emit(DeleteAdminCaseSuccessState(response.data['message']));

    }on DioError catch(e){

      emit(DeleteAdminCaseSuccessState(e.response!.data['message']));

    }catch(e){
      emit(DeleteAdminCaseErrorState());
    }

  }
///////////////////end///////////////////////////////////////////

/////////////////////////////admin missing case accept//////
  AcceptMissingAdmin? acceptMissingAdmin;
  void adminMissingCaseAccept({
    required String id,
  })async{
    emit(AdminCaseAcceptLoadingState());
    try {
      var response = await DioHelper.postData(
        url: acceptAdminMissingCaseUrl+id,
        token: token,
         data: []
      );

      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      getAdminMissingCase();
      emit(AdminCaseAcceptSuccessState());


    }on DioError catch(e){
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);
      emit(AdminCaseAcceptSuccessState());

    }catch(e){
      emit(AdminCaseAcceptErrorState());
    }
  }
///////////////////////////////////////////////////////////////////////////

/////////////////////////////admin Things case accept//////

  void adminThingsCaseAccept({
    required String id,
  })async{
    emit(AdminThingsAcceptLoadingState());
    try {
      var response = await DioHelper.postData(
          url: acceptAdminThingsCaseUrl+id,
          token: token,
          data: []
      );

      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      getAdminThingsCase();
      emit(AdminThingsAcceptSuccessState());

    }on DioError catch(e){
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);
      emit(AdminThingsAcceptSuccessState());

    }catch(e){
      emit(AdminThingsAcceptErrorState());
    }
  }
///////////////////////////////////////////////////////////////////////////

/////////////////////////////admin Search For Family case accept//////

  void adminSearchForFamilyCaseAccept({
    required String id,
  })async{
    emit(AdminSearchForFamilyAcceptLoadingState());
    try {
      var response = await DioHelper.postData(
          url: acceptAdminSearchForFamilyCaseUrl+id,
          token: token,
          data: []
      );

      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      getAdminSearchForFamilyCase();
      emit(AdminSearchForFamilyAcceptSuccessState());


    }on DioError catch(e){
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);
      emit(AdminSearchForFamilyAcceptSuccessState());

    }catch(e){
      emit(AdminSearchForFamilyAcceptErrorState());
    }
  }
///////////////////////////////////////////////////////////////////////////

  //////////////////////////// not accept missing admin /////////////////
  MissingRejectAdmin? missingRejectAdmin;
  void reasonForRefusedMissing(
      {
        String? message,
        required String id,
      }
      )async{

    FormData formData = FormData.fromMap({
      'message' : message,
    });


    emit(RejectedMissingLoadingState());
    try {
      var response = await DioHelper.postData(url: rejectedAdminMissingCaseUrl+id, data:formData,token: token);
      missingRejectAdmin=MissingRejectAdmin.fromJson(response.data);
      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      emit(RejectedMissingSuccessState(missingRejectAdmin!));

    }on DioError catch(e){
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);
      missingRejectAdmin=MissingRejectAdmin.fromJson(e.response!.data);
      emit(RejectedMissingSuccessState(missingRejectAdmin!));

    }catch(e) {
      emit(RejectedMissingErrorState());

    }
  }

///////////////////end///////////////////////////////////////////

//////////////////////////// not accept search for family admin /////////////////
  SearchFamilyRejectAdmin? searchFamilyRejectAdmin;
  void reasonForRefusedSearchFamily(
      {
        String? message,
        required String id,
      }
      )async{

    FormData formData = FormData.fromMap({
      'message' : message,
    });

    emit(RejectedSearchForFamilyLoadingState());
    try {
      var response = await DioHelper.postData(url: rejectedAdminSearchForFamilyCaseUrl+id, data:formData,token: token);
      searchFamilyRejectAdmin=SearchFamilyRejectAdmin.fromJson(response.data);
      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      emit(RejectedSearchForFamilySuccessState(searchFamilyRejectAdmin!));

    }on DioError catch(e){
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);
      searchFamilyRejectAdmin=SearchFamilyRejectAdmin.fromJson(e.response!.data);
      emit(RejectedSearchForFamilySuccessState(searchFamilyRejectAdmin!));

    }catch(e) {
      emit(RejectedSearchForFamilyErrorState());

    }
  }

///////////////////end///////////////////////////////////////////

//////////////////////////// not accept Things admin /////////////////
  ThingsRejectAdmin? thingsRejectAdmin;
  void reasonForRefusedThings(
      {
        String? message,
        required String id,
      }
      )async{

    FormData formData = FormData.fromMap({
      'message' : message,
    });

    emit(RejectedThingsLoadingState());
    try {
      var response = await DioHelper.postData(url: rejectedAdminThingsCaseUrl+id, data:formData,token: token);
      thingsRejectAdmin=ThingsRejectAdmin.fromJson(response.data);
      showToast(text:response.data['message'], state: ToastStates.SUCCESS);
      emit(RejectedThingsSuccessState(thingsRejectAdmin!));

    }on DioError catch(e){
      showToast(text:e.response!.data['message'], state: ToastStates.ERROR);
      thingsRejectAdmin=ThingsRejectAdmin.fromJson(e.response!.data);
      emit(RejectedThingsSuccessState(thingsRejectAdmin!));

    }catch(e) {
      emit(RejectedThingsErrorState());

    }
  }

  void getAllAdmin(){
    if(CacheHelper.getData(key: 'role')=='admin'){
     getAdminMissingCase();
      getAdminSearchForFamilyCase();
     getAdminThingsCase();

    }

  }

///////////////////end///////////////////////////////////////////

  Future loadHomeScreenData()async {

    await Future.delayed(const Duration(microseconds: 4000));
    getAllPerson();
    getOldTenPerson();
    getAllThings();

  }

  LocationData? currentLocation;
  LatLng? latLng ;
  selectLocation() async {

    var location = Location();


    location.onLocationChanged.listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);

      latLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      print("getLocation:$latLng");


    }

    );
     CacheHelper.saveData(key:'longitude', value: latLng!.longitude.toString());
    CacheHelper.saveData(key:'latitude', value: latLng!.latitude.toString());

justEmitState();


  }


}









