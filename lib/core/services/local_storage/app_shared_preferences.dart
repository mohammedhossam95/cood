import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/features/auth/data/models/login_model.dart';
import '/features/auth/domain/entities/login_response.dart';
import '../../utils/enums.dart';
import '../../utils/extension.dart';

abstract class _AppSharedPreferencesKeys {
  static const countryId = 'countryId';
  static const userId = 'userId';
  static const user = 'user';
  static const appTheme = 'appTheme';
  static const languageCode = 'languageCode';
  static const userType = 'userType';
  static const userCycle = 'userCycle';
  static const cartProviderId = 'cartProviderId';
  static const serviceTypeId = 'service_type_Id';
}

abstract class AppSharedPreferences {
  final SharedPreferences instance;

  const AppSharedPreferences({required this.instance});

  //region:: Country Id
  int? getCountryId();
  Future<bool> saveCountryId(int countryId);
  Future<bool> removeCountryId();

  //region:: Provider Id
  String? getCartProviderId();
  Future<bool> saveCartProviderId(String providerId);
  Future<bool> removeCartProviderId();

  //region:: getServiceType Id
  String? getServiceTypeId();
  Future<bool> saveServiceTypeId(String typeId);
  Future<bool> removeServiceTypeId();

  //region:: user Id
  int? getUserId();
  Future<bool> saveUserId(int id);
  Future<bool> removeUserId();

  //region:: user
  User? getUser();
  Future<bool> saveUser(User user);
  Future<bool> removeUser();

  //endregion

  //region:: Language Code
  LanguageCode getLanguageCode();
  Future<bool> saveLanguageCode(String value);
  Future<bool> removeLanguageCode();

  //endregion

  //region:: App Theme
  Themes getAppTheme();

  Future<bool> saveAppTheme(Themes theme);

  Future<bool> removeAppTheme();

  //endregion

  //region:: User Type
  UserType getUserType();

  Future<bool> saveUserType(UserType value);

  Future<bool> removeUserType();
  // User Cycle
  Future<bool> saveUserCycle(UserCycle value);
  UserCycle getUserCycle();
  Future<bool> removeUserCycle();

  //cart

  //endregion

  Future<bool> clearAll();
}

class AppSharedPreferencesImpl extends AppSharedPreferences {
  AppSharedPreferencesImpl({required super.instance});

  //region:: Country Id
  @override
  int? getCountryId() => instance.getInt(_AppSharedPreferencesKeys.countryId);

  @override
  Future<bool> saveCountryId(int countryId) =>
      instance.setInt(_AppSharedPreferencesKeys.countryId, countryId);

  @override
  Future<bool> removeCountryId() =>
      instance.remove(_AppSharedPreferencesKeys.countryId);

//region:: CartProvider Id
  @override
  String? getCartProviderId() =>
      instance.getString(_AppSharedPreferencesKeys.cartProviderId);

  @override
  Future<bool> saveCartProviderId(String providerId) =>
      instance.setString(_AppSharedPreferencesKeys.cartProviderId, providerId);

  @override
  Future<bool> removeCartProviderId() =>
      instance.remove(_AppSharedPreferencesKeys.cartProviderId);

  //region:: Service Type Id
  @override
  String? getServiceTypeId() =>
      instance.getString(_AppSharedPreferencesKeys.serviceTypeId);

  @override
  Future<bool> saveServiceTypeId(String typeId) =>
      instance.setString(_AppSharedPreferencesKeys.serviceTypeId, typeId);

  @override
  Future<bool> removeServiceTypeId() =>
      instance.remove(_AppSharedPreferencesKeys.serviceTypeId);

  //region:: User Id
  @override
  int? getUserId() => instance.getInt(_AppSharedPreferencesKeys.userId);

  @override
  Future<bool> saveUserId(int id) =>
      instance.setInt(_AppSharedPreferencesKeys.userId, id);

  @override
  Future<bool> removeUserId() =>
      instance.remove(_AppSharedPreferencesKeys.userId);

  //endregion

  //region:: Language Code
  @override
  LanguageCode getLanguageCode() {
    String value =
        instance.getString(_AppSharedPreferencesKeys.languageCode) ?? "ar";
    // Intl.systemLocale.split('_').first;
    final lang = LanguageCodeExtension.fromString(value);
    log('getLanguageCode Intl.systemLocale: ${Intl.systemLocale}');
    log('getLanguageCode lang: $lang');
    return lang;
  }

  @override
  Future<bool> saveLanguageCode(String value) {
    final languageCode = LanguageCodeExtension.fromString(value);
    return instance.setString(
        _AppSharedPreferencesKeys.languageCode, languageCode.name);
  }

  @override
  Future<bool> removeLanguageCode() =>
      instance.remove(_AppSharedPreferencesKeys.languageCode);

  //endregion

  //region:: App Theme
  @override
  Themes getAppTheme() {
    String value = instance.getString(_AppSharedPreferencesKeys.appTheme) ?? '';
    return ThemesExtension.fromString(value);
  }

  @override
  Future<bool> saveAppTheme(Themes theme) =>
      instance.setString(_AppSharedPreferencesKeys.appTheme, theme.name);

  @override
  Future<bool> removeAppTheme() =>
      instance.remove(_AppSharedPreferencesKeys.appTheme);

  //endregion

  //region:: User Type
  @override
  UserType getUserType() => UserTypeExtension.fromString(
      instance.getString(_AppSharedPreferencesKeys.userType) ?? '');

  @override
  Future<bool> saveUserType(UserType value) =>
      instance.setString(_AppSharedPreferencesKeys.userType, value.name);

  @override
  Future<bool> removeUserType() =>
      instance.remove(_AppSharedPreferencesKeys.userType);

  @override
  UserCycle getUserCycle() => UserCycleExtension.fromString(
      instance.getString(_AppSharedPreferencesKeys.userCycle) ?? '');

  @override
  Future<bool> saveUserCycle(UserCycle value) =>
      instance.setString(_AppSharedPreferencesKeys.userCycle, value.name);

  @override
  Future<bool> removeUserCycle() =>
      instance.remove(_AppSharedPreferencesKeys.userCycle);

//User

  @override
  User getUser() {
    String? userStr = instance.getString(_AppSharedPreferencesKeys.user);
    return UserModel.fromJson(jsonDecode(userStr ?? ''));
  }

  @override
  Future<bool> saveUser(User user) =>
      instance.setString(_AppSharedPreferencesKeys.user, jsonEncode(user));

  @override
  Future<bool> removeUser() => instance.remove(_AppSharedPreferencesKeys.user);

  //endregion

  @override
  Future<bool> clearAll() => instance.clear();
}
