

import 'package:newnew/model/get_model/get_all_person_model.dart';
import 'package:newnew/model/get_model/get_all_things_model.dart';
import 'package:newnew/model/get_model/old_ten_model.dart';
import 'package:newnew/model/get_model/user_missing_person_case.dart';
import 'package:newnew/model/get_model/user_missing_things_case.dart';
import 'package:newnew/model/get_model/user_search_for_family_case.dart';
import 'package:newnew/model/upload_model/search_for_family_model.dart';
import 'package:newnew/model/upload_model/update_password.dart';
import 'package:newnew/model/upload_model/update_profile.dart';
import 'package:newnew/model/upload_model/upload_missing_things_model.dart';
import 'package:newnew/model/upload_model/upload_person_model.dart';
import 'package:newnew/model/user_model/contact_us_model.dart';
import 'package:newnew/model/user_model/get_profile.dart';

abstract class MainState {}

class MainInitial extends MainState {}
class ChangeCurrentIndexState extends MainState {}

// get image from device State
class ImageLoadingState extends MainState {}
class ImageGetSuccessState extends MainState {}
class ImageGetErrorState extends MainState {}

// delete image state
class ImageDeleteSuccessState extends MainState {}

// logout State
class MissingLogoutLoadingState extends MainState {}
class MissingLogoutSuccessState extends MainState {}
class MissingLogoutErrorState extends MainState {}

// Missing Person State
class UploadMissingPersonLoadingState extends MainState {}
class UploadMissingPersonSuccessState extends MainState {
  late UploadPersonModel uploadPersonModel;
  UploadMissingPersonSuccessState(this.uploadPersonModel);
}
class UploadMissingPersonErrorState extends MainState {}

// Search forFamily State
class UploadSearchForFamilyLoadingState extends MainState {}
class UploadSearchForFamilySuccessState extends MainState {
  late SearchForFamilyModel searchForFamilyModel;
  UploadSearchForFamilySuccessState(this.searchForFamilyModel);
}
class UploadSearchForFamilyErrorState extends MainState {}
// Search forFamily State
class UploadMissingThingsLoadingState extends MainState {}
class UploadMissingThingsSuccessState extends MainState {
  late UploadMissingThings uploadMissingThings;
  UploadMissingThingsSuccessState(this.uploadMissingThings);
}
class UploadMissingThingsErrorState extends MainState {}

// get last Ten State
class GetLastTenPersonLoadingState extends MainState {}
class GetLastTenPersonSuccessState extends MainState {
  late OldTenModel oldTenModel;
  GetLastTenPersonSuccessState(this.oldTenModel);
}
class GetLastTenPersonErrorState extends MainState {}

// get all person State
class GetAllPersonLoadingState extends MainState {}
class GetAllPersonSuccessState extends MainState {
  late GetAllPersonModel getAllPersonModel;
  GetAllPersonSuccessState(this.getAllPersonModel);
}
class GetAllPersonErrorState extends MainState {}

// get all things states
class GetAllThingsLoadingState extends MainState {}
class GetAllThingsSuccessState extends MainState {
  late GetAllThingsModel getAllThingsModel;
  GetAllThingsSuccessState(this.getAllThingsModel);
}
class GetAllThingsErrorState extends MainState {}


// all person filter state
class PersonFilterLoadingState extends MainState {}
class PersonFilterSuccessState extends MainState {
  late GetAllPersonModel getAllPersonModel;
  PersonFilterSuccessState(this.getAllPersonModel);
}
class PersonFilterErrorState extends MainState {}


// things filter state
class ThingsFilterLoadingState extends MainState {}
class ThingsFilterSuccessState extends MainState {
  late GetAllThingsModel getAllThingsModel;
  ThingsFilterSuccessState(this.getAllThingsModel);
}
class ThingsFilterErrorState extends MainState {}

//profile state

class GetProfileLoadingState extends MainState {}
class GetProfileSuccessState extends MainState {
  late GetProfileModel getProfileModel;
  GetProfileSuccessState(this.getProfileModel);
}
class GetProfileErrorState extends MainState {}


//update profile

class UpdateProfileLoadingState extends MainState {}
class UpdateProfileSuccessState extends MainState {
  late UpdateProfileModel updateProfileModel;
  UpdateProfileSuccessState(this.updateProfileModel);
}
class UpdateProfileErrorState extends MainState {}

// home state

class ChangeEditState extends MainState {}

// contact us
class ContactUsLoadingState extends MainState {}
class ContactUsSuccessState extends MainState {
  late ContactUsModel contactUsModel;
  ContactUsSuccessState(this.contactUsModel);
}
class ContactUsErrorState extends MainState {}
//
class UpdatePasswordState extends MainState{}
//

// update password
class UpdatePasswordLoadingState extends MainState {}
class UpdatePasswordSuccessState extends MainState {
  late UpdatePasswordModel updatePasswordModel;
  UpdatePasswordSuccessState(this.updatePasswordModel);
}
class UpdatePasswordErrorState extends MainState {}

//get missing case
class GetMissingCaseLoadingState extends MainState {}
class GetMissingCaseSuccessState extends MainState {
  late UserMissingCaseModel userMissingCaseModel;
  GetMissingCaseSuccessState(this.userMissingCaseModel);
}
class GetMissingCaseErrorState extends MainState {}

//get search for family case
class SearchForFamilyCaseLoadingState extends MainState {}
class SearchForFamilyCaseSuccessState extends MainState {
  late UserSearchForFamilyCaseModel userSearchForFamilyCaseModel;
  SearchForFamilyCaseSuccessState(this.userSearchForFamilyCaseModel);
}
class SearchForFamilyCaseErrorState extends MainState {}

//get things case
class ThingsCaseLoadingState extends MainState {}
class ThingsCaseSuccessState extends MainState {
  late UserThingsCaseModel userThingsCaseModel;
  ThingsCaseSuccessState(this.userThingsCaseModel);
}
class ThingsCaseErrorState extends MainState {}

//delete case

class DeleteCaseLoadingState extends MainState {}
class DeleteCaseSuccessState extends MainState {
  late String message;
  DeleteCaseSuccessState(this.message);
}
class DeleteCaseErrorState extends MainState {}

// update missing case
class UpdateUserCaseLoadingState extends MainState {}
class UpdateUserCaseSuccessState extends MainState {
 // late String message;
 // UpdateCaseSuccessState(this.message);
}
class UpdateUserCaseErrorState extends MainState {}

class AppChangeModeState extends MainState {}

class JustEmitState extends MainState {}
class CheckNetState extends MainState {}

// search image state
class SearchByImageLoadingState extends MainState {}
class SearchByImageSuccessState extends MainState {
  // late String message;
  // UpdateCaseSuccessState(this.message);
}
class SearchByImageErrorState extends MainState {}


// user case found state
class UserCaseFoundLoadingState extends MainState {}
class UserCaseFoundSuccessState extends MainState {
  // late String message;
  // UpdateCaseSuccessState(this.message);
}
class UserCaseFoundErrorState extends MainState {}

// counter case found state
class CounterCaseFoundLoadingState extends MainState {}
class CounterCaseFoundSuccessState extends MainState {
  // late String message;
  // UpdateCaseSuccessState(this.message);
}
class CounterCaseFoundErrorState extends MainState {}