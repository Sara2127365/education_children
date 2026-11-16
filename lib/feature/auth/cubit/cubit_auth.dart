import 'package:education_children/core/network/api_constants.dart';
import 'package:education_children/core/network/api_service.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/feature/auth/cubit/state_auth.dart';
import 'package:education_children/feature/auth/login/model/login_response.dart';
import 'package:education_children/feature/auth/signup/model/sign_up_request_model.dart';
import 'package:education_children/feature/auth/signup/model/sign_up_response_model.dart';
import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialState());

  /// تسجيل الدخول عبر الـ API (https://akon.fassla.net/api/v1/auth/login)
  Future<void> login({
    required String email,
    String? password,
    String? phone,
    String? childName,
  }) async {
    if (email.trim().isEmpty) {
      emit(ErrorSignInState(message: 'الرجاء إدخال البريد الإلكتروني'));
      return;
    }
    if (!_isValidEmail(email)) {
      emit(ErrorSignInState(message: 'صيغة البريد الإلكتروني غير صالحة'));
      return;
    }

    emit(LoadingSignInState());
    try {
      final body = <String, dynamic>{
        'email': email.trim(),
        if (password != null && password.isNotEmpty) 'password': password,
        if (phone != null && phone.isNotEmpty) 'phone': phone.trim(),
        if (childName != null && childName.isNotEmpty)
          'child_name': childName.trim(),
      };

      final jsonResponse = await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.login}',
        body: body,
      );

      final responseModel = LoginResponseModel.fromJson(jsonResponse);

      final isSuccess = responseModel.status == true ||
          responseModel.success == true ||
          (jsonResponse['statusCode'] != null &&
              jsonResponse['statusCode'] >= 200 &&
              jsonResponse['statusCode'] < 300);

      if (isSuccess) {
        if (childName != null && childName.trim().isNotEmpty) {
          UserProfile.update(newName: childName.trim());
        }
        emit(SuccessSignInState(
          message: responseModel.message ?? 'تم تسجيل الدخول بنجاح',
          response: responseModel,
        ));
      } else {
        emit(ErrorSignInState(
          message: responseModel.message ??
              'فشل تسجيل الدخول، يرجى التحقق من البيانات.',
        ));
      }
    } catch (e) {
      emit(ErrorSignInState(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// تسجيل حساب جديد عبر الـ API (https://akon.fassla.net/api/v1/auth/register)
  Future<void> signUp(SignupRequestModel request) async {
    if (request.childName.trim().isEmpty) {
      emit(ErrorSignUpState(message: 'الرجاء إدخال اسم الطفل'));
      return;
    }
    if (request.parentEmail.trim().isEmpty) {
      emit(ErrorSignUpState(message: 'الرجاء إدخال البريد الإلكتروني'));
      return;
    }
    if (!_isValidEmail(request.parentEmail)) {
      emit(ErrorSignUpState(message: 'صيغة البريد الإلكتروني غير صالحة'));
      return;
    }
    if (request.parentPhone.trim().isEmpty) {
      emit(ErrorSignUpState(message: 'الرجاء إدخال رقم الهاتف'));
      return;
    }

    emit(LoadingSignUpState());
    try {
      final jsonResponse = await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.register}',
        body: request.toJson(),
      );

      final responseModel = SignupResponseModel.fromJson(jsonResponse);

      final isSuccess = responseModel.status == true ||
          responseModel.success == true ||
          (jsonResponse['statusCode'] != null &&
              jsonResponse['statusCode'] >= 200 &&
              jsonResponse['statusCode'] < 300);

      if (isSuccess) {
        UserProfile.update(
          newName: request.childName.trim(),
          newGender: request.gender == 'girl' ? Gender.girl : Gender.boy,
          newGuide: request.mentorGender == 'female'
              ? GuideType.female
              : GuideType.male,
          newAge: request.age,
          newLanguage: request.language,
        );

        emit(SuccessSignUpState(
          message: responseModel.message ?? 'تم إنشاء الحساب بنجاح',
          response: responseModel,
        ));
      } else {
        emit(ErrorSignUpState(
          message: responseModel.message ??
              'فشل إنشاء الحساب، يرجى مراجعة البيانات المدخلة.',
        ));
      }
    } catch (e) {
      emit(ErrorSignUpState(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// تسجيل بديل بالبريد وكلمة المرور
  Future<void> signUpWithCredentials({
    required String email,
    required String password,
    required String name,
  }) async {
    if (name.trim().isEmpty) {
      emit(ErrorSignUpState(message: 'الرجاء إدخال الاسم'));
      return;
    }
    if (email.trim().isEmpty) {
      emit(ErrorSignUpState(message: 'الرجاء إدخال البريد الإلكتروني'));
      return;
    }
    if (!_isValidEmail(email)) {
      emit(ErrorSignUpState(message: 'صيغة البريد الإلكتروني غير صالحة'));
      return;
    }
    if (password.isEmpty) {
      emit(ErrorSignUpState(message: 'الرجاء إدخال كلمة المرور'));
      return;
    }
    if (password.length < 6) {
      emit(ErrorSignUpState(message: 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'));
      return;
    }

    emit(LoadingSignUpState());
    try {
      final jsonResponse = await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.register}',
        body: {
          'email': email.trim(),
          'password': password,
          'name': name.trim(),
        },
      );

      final responseModel = SignupResponseModel.fromJson(jsonResponse);
      final isSuccess = responseModel.status == true ||
          responseModel.success == true ||
          (jsonResponse['statusCode'] != null &&
              jsonResponse['statusCode'] >= 200 &&
              jsonResponse['statusCode'] < 300);

      if (isSuccess) {
        UserProfile.update(newName: name.trim());
        emit(SuccessSignUpState(
          message: responseModel.message ?? 'تم إنشاء الحساب بنجاح',
          response: responseModel,
        ));
      } else {
        emit(ErrorSignUpState(
          message: responseModel.message ?? 'فشل إنشاء الحساب، يرجى المحاولة مرة أخرى',
        ));
      }
    } catch (e) {
      emit(ErrorSignUpState(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.trim());
  }
}
