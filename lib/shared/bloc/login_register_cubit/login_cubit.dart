import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/model/user_auth_model/forget_password_model.dart';
import 'package:newnew/model/user_auth_model/register_model.dart';
import 'package:newnew/model/user_auth_model/reset_password_model.dart';
import 'package:newnew/model/user_auth_model/user_model.dart';
import 'package:newnew/model/user_auth_model/verify_code_model.dart';
import 'package:newnew/modules/user_authentication/login_screen.dart';
import 'package:newnew/shared/bloc/login_register_cubit/login_state.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/constant.dart';
import 'package:newnew/shared/local/share_pereference.dart';
import 'package:newnew/shared/network/dio.dart';
import 'package:newnew/shared/network/end_point.dart';
import '../../../shared/style/icon_broken.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool isPassword = true,registerIsPassword=true,confirmIsPassword=true;
   IconData visibilityOff = IconBroken.Hide ,visibility= IconBroken.Show;
 changePassword(){
   isPassword = !isPassword;
   emit(ChangePasswordState());
  }
  changeRegisterPassword(){
    registerIsPassword = !registerIsPassword;
    emit(ChangePasswordState());
  }
  changeConfirmRegisterPassword(){
    confirmIsPassword = !confirmIsPassword;
    emit(ChangePasswordState());
  }

late UserDataModel userDataModel;
 void loginPostData(
      {
        required email,
        required password,
        required context
      }
      )async{
    emit(LoginLoadingState());
    try {
      var response = await DioHelper.postData(url: login, data: {
        "email": email,
        "password": password
      });
      userDataModel=UserDataModel.fromJson(response.data);
      token=userDataModel.token!;
      CacheHelper.saveData(key: 'token', value: userDataModel.token!);
      emit(LoginSuccessState(userDataModel));
      MainCubit.get(context).currentIndex=0;
      MainCubit.get(context).getProfile();
      MainCubit.get(context).getUserMissingCase();
      MainCubit.get(context).getUserSearchForFamilyCase();
      MainCubit.get(context).getUserThingsCase();



    }on DioError catch(e){
      userDataModel=UserDataModel.fromJson(e.response!.data);
      emit(LoginSuccessState(userDataModel));


    }catch(e){
      emit(LoginErrorState());
    }
  }


  late RegisterDataModel registerDataModel;
  void signUpPostData(
      {
        required name,
        required email,
        required password,
        required passwordConfirm,
        required context,
      }
      )async{
        emit(SignupLoadingState());
    try {
      var response = await DioHelper.postData(url:signup , data: {
        "name":name,
        "email":email,
        "password":password,
        "passwordConfirm":passwordConfirm,
      });
      registerDataModel=RegisterDataModel.fromJson(response.data);
      //await Future.delayed(const Duration(seconds: 1));
      navigateToAndRemove(context, LoginScreen());
      emit(SignupSuccessState(registerDataModel));




    }on DioError catch(e){

      registerDataModel=RegisterDataModel.fromJson(e.response!.data);
      emit(SignupSuccessState(registerDataModel));


    }catch(e){
      emit(SignupErrorState());
    }
  }


  late ForgetPasswordDataModel forgetPasswordDataModel;
  void forgetPasswordPostData(
      {
        required email,

      }
      )async{
    emit(ForgetPasswordLoadingState());
    try {
      var response = await  DioHelper.postData(url: forgetPassword, data: {
        "email":email
      });
      forgetPasswordDataModel= ForgetPasswordDataModel.fromJson(response.data);
      emit(ForgetPasswordSuccessState(forgetPasswordDataModel));


    }on DioError catch(e){

      forgetPasswordDataModel= ForgetPasswordDataModel.fromJson(e.response!.data);
      emit(ForgetPasswordSuccessState(forgetPasswordDataModel));


    }catch(e){
      emit(ForgetPasswordErrorState());
    }
  }



  late VerifyCodeDataModel verifyCodeDataModel;
  void verifyCodePostData(
      {
        required code,

      }
      )async{
    emit(VerifyCodeLoadingState());
    try {
      var response = await DioHelper.postData(url: verifyCode, data: {
        'code':code
      });
      verifyCodeDataModel= VerifyCodeDataModel.fromJson(response.data);
      emit(VerifyCodeSuccessState(verifyCodeDataModel));


    }on DioError catch(e){

      verifyCodeDataModel= VerifyCodeDataModel.fromJson(e.response!.data);
      emit(VerifyCodeSuccessState(verifyCodeDataModel));

    }catch(e){
      emit(VerifyCodeErrorState());    }
  }





  late ResetPasswordDataModel resetPasswordDataModel;
  void resetPasswordPatchData(
      {
        required code,
        required newPassword,
        required passwordConfirm,

      }
      )async{
    emit(ResetPasswordLoadingState());
    try {
      var response = await DioHelper.patchData(url: resetPassword, data: {
        'code':code,
        'newPassword':newPassword,
        'passwordConfirm':passwordConfirm,
      });
      resetPasswordDataModel= ResetPasswordDataModel.fromJson(response.data);
      emit(ResetPasswordSuccessState(resetPasswordDataModel));


    }on DioError catch(e){

      resetPasswordDataModel= ResetPasswordDataModel.fromJson(e.response!.data);
      emit(ResetPasswordSuccessState(resetPasswordDataModel));

    }catch(e){

      emit(ResetPasswordErrorState());

    }
  }







  }


