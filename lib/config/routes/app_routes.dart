import 'package:flutter/material.dart';

import '/core/params/car_params.dart';
import '/features/auth/presentation/screen/kind_user_screen.dart';
import '/features/auth/presentation/screen/mobile_screen.dart';
import '/features/auth/presentation/screen/on_boarding_screen.dart';
import '/features/auth/presentation/screen/otp_screen.dart';
import '/features/auth/presentation/screen/register/new_user_register_screen.dart';
import '/features/auth/presentation/screen/register/washer_second_register_screen.dart';
import '/features/auth/presentation/screen/success_change_pass_screen.dart';
import '/features/cars/presentation/screens/car_details_screen.dart';
import '/features/cars/presentation/screens/cars_screen.dart';
import '/features/cars/presentation/screens/map_screen.dart';
import '/features/cars/presentation/screens/new_map_screen.dart';
import '/features/cars/presentation/screens/payment_screen.dart';
import '/features/cars/presentation/screens/sorting_sreen.dart';
import '/features/home/presentation/screens/date_range.dart';
import '/features/more/presentation/screens/contact_us_screen.dart';
import '/features/more/presentation/screens/privacy_policy_screen.dart';
import '/features/more/presentation/screens/terms_and_conditions.dart';
import '/features/profile/presentation/screens/edit_profile_screen.dart';
import '/features/profile/presentation/screens/profile_screen.dart';
import '../../core/utils/app_strings.dart';
import '../../core/widgets/full_photo.dart';
import '../../core/widgets/slider_photo.dart';
import '../../features/auth/presentation/screen/confirm_reset_password_screen.dart';
import '../../features/auth/presentation/screen/failed_otp_screen.dart';
import '../../features/auth/presentation/screen/forget_password_screen.dart';
import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/auth/presentation/screen/register/delivery_register_screen.dart';
import '../../features/auth/presentation/screen/register/washer_register_screen.dart';
import '../../features/auth/presentation/screen/splash_screen.dart';
import '../../features/auth/presentation/screen/success_otp_screen.dart';
import '../../features/auth/presentation/screen/tearms_condations_screen.dart';
import '../../features/auth/presentation/screen/verification_reset_password_screen.dart';
import '../../features/auth/presentation/screen/welcome_screen.dart';
import '../../features/tabbar/presentation/screens/main_page.dart';
import '../../injection_container.dart';

class Routes {
  static const String initialRoute = '/';
  static const String welcomeRoute = '/WelcomeScreen';
  static const String landingPageRoute = '/LandingPage';
  static const String loginScreenRoute = '/LoginScreen';
  static const String mobileScreen = '/MobileScreen';
  static const String emailLoginScreenRoute = '/EmailLoginScreen';
  static const String registerScreenRoute = '/RegisterScreen';
  static const String acceptTermeRegisterRoute = '/AcceptTermeRegisterScreen';
  static const String verificationMobileScreenRoute =
      '/VerificationMobileScreen';
  static const String verificationEmailScreenRoute = '/VerificationEmailScreen';
  static const String verificationResetPasswordScreenRoute =
      '/VerificationResetPasswordScreen';
  static const String confirmResetPasswordScreenRoute =
      '/ConfirmResetPasswordScreen';
  static const String flowScreenRoute = '/FlowScreen';
  static const String reviewMyDataScreenRoute = '/ReviewMyDataScreen';
  static const String editMyDataScreenRoute = '/EditMyDataScreen';
  static const String mainPageRoute = '/MainPage';
  static const String changeLanguageRoute = '/ChangeLanguage';
  static const String saveClinicRoute = '/SaveClinicScreen';
  static const String clinicsRoute = '/ClinicsScreen';
  static const String clinicDetailsRoute = '/ClinicDetailsScreen';
  static const String bioScreenRoute = '/BioScreen';
  static const String editBioScreenRoute = '/EditBioScreen';
  static const String doctorTitleScreenRoute = '/DoctorTitleScreen';
  static const String editDoctorTitleScreenRoute = '/EditDoctorTitleScreen';
  static const String callsRoute = '/CallsScreen';
  static const String saveCallsRoute = '/SaveCallsScreen';

  //Added by Mmoheammed
  static const String qrScannerScreenRoute = '/QRScannerScreen';

  static const String medicalHistoryRoute = '/MyMedicalHistoryScreen';

  static const String saveMedicalHistoryRoute = '/SaveMyMedicalHistoryScreen';
  static const String addFollowUpScreenRoute = '/AddFollowUpScreen';
  static const String medHistoryFilterScreenRoute = '/MedHistoryFiltersScreen';
  static const String fullPhotoRoute = '/FullPhoto';
  static const String photoListRoute = '/PhotoList';
  static const String walletScreenRoute = '/walletScreenRoute';
  static const String walletRequestScreenRoute = '/WalletRequestScreenRoute';
  static const String walletDetailsScreenRoute = '/WalletDetailsScreenRoute';
  static const String walletHistoryScreenRoute = '/walletHistoryScreenRoute';
  static const String bankAccountsScreenRoute = '/BankAccountsScreen';
  static const String addBankAccountScreenRoute = '/AddBankAccountScreen';

  static const String settingsRoute = '/SettingsScreen';
  static const String hospitalInvitationsRoute = '/HospitalInvitationsScreen';
  static const String hospitalInvitationDetailsRoute =
      '/HospitalInvitationDetailsScreen';
  static const String kindUserRoute = '/KindUserScreen';
  static const String otpAuthRoute = '/OtpAuthScreen';
  static const String successChangePassRoute = '/SuccessChangePassScreen';
  static const String onBoardingRoute = '/OnBoardingScreen';
  static const String notificationsScreenRoute = '/NotificationsScreen';
  static const String cartScreenRoute = '/CartScreen';
  static const String laundryDetailsScreenRoute = '/LaundryDetailsScreen';
  static const String orderingProcessRoute = '/OrderingProcessScreen';
  static const String orderAddressScreenRoute = '/OrderAddressScreen';

  static const String paymentScreenRoute = '/PaymentScreen';
  static const String orderCompletedScreenRoute = '/OrderCompletedScreen';
  static const String onlinePaymentRoute = '/OnlinePaymentScreen';

  static const String messagesRoute = '/MessagesScreen';

//laundry

  static const String laundryAddServiceScreenRoute =
      '/LaundryAddServiceScreenRoute';
  static const String laundrySelectCatRoute = '/laundrySelectCategoryScreen';
  static const String laundrySelectSubCatRoute =
      '/laundrySelectSubCategoryScreen';
  static const String publucQuationRoute = '/PublucQuationScreen';
  static const String callCenterRoute = '/CallCenterScreen';
  static const String privacyPolicyRoute = '/PrivacyPolicyScreen';
  static const String aboutUsRoute = '/AboutUsScreen';

  static const String newUserRegisterRoute = '/NewUserRegisterScreen';

  static const String newDelivryRegisterRoute = '/NewDelivryRegisterScreen';
  static const String delivryRegisterSecondRoute =
      '/DelivryRegisterSecondScreen';

  static const String newWasherRegisterRoute = '/NewWasherRegisterScreen';
  static const String newWasherRegisterSecondStepRoute =
      '/NewWasherRegisterSecondStepScreen';
  static const String newWasherRegisterTheardStepRoute =
      '/NewWasherRegisterTheardStepScreen';
  static const String myOrederDetailsRoute = '/MyOrederDetailsScreen';
  static const String orderMapRoute = '/OrderMapScreen';
  static const String newOrderMapRoute = '/NewOrderMapScreen';
  static const String laundryOrderDetailsRoute = '/LaundryOrderDetailsScreen';

  //delivery routes
  static const String deleviryOrderDetails = '/orderDetails';
  static const String viewAllWashersRoutes = '/ViewAllWashersScreen';
  static const String newAddAddressRoute = '/NewAddAddressScreen';
  static const String contactUsRoute = '/ContactUsScreen';
  static const String termsAndConditionsRoute = '/TermsAndConditionsScreen';
  static const String newDelegateOrderDetailsRoute =
      '/NewDelegateOrderDetailsScreen';

  static const String carsScreenRoute = '/HomeScreen';
  static const String mapScreenRoute = '/MapScreen';
  static const String sortingSreenRoute = '/SortingSreen';
  static const String carDetailsScreenRoute = '/CarDetailsScreen';
  static const String profileScreenRoute = '/ProfileScreen';
  static const String editProfileScreenRoute = '/EditProfileScreen';
  static const String calnederScreemRoute = '/CalnederScreem';
  static const String newMapScreenRoute = '/NewMapScreen';
  static const String forgetPasswordScreenRoute = '/ForgetPasswordScreen';
  static const String tearmsAndCondationsAuthScreenRoute =
      '/TearmsAndCondationsAuthScreenScreen';
  static const String successOtpScreenRoute = '/SuccessOtpScreenScreen';
  static const String failedOtpScreenRoute = '/FailedOtpScreenScreen';

}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const SplashScreen();
          },
        );

      case Routes.welcomeRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const WelcomeScreen(),
        );

      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const LoginScreen(),
        );
      case Routes.forgetPasswordScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const ForgetPasswordScreen(),
        );
      case Routes.successOtpScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const SuccessOtpScreen(),
        );
        case Routes.failedOtpScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const FailedOtpScreen(),
        );
      case Routes.mobileScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const MobileScreen(),
        );
      case Routes.contactUsRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const ContactUsScreen(),
        );
      case Routes.tearmsAndCondationsAuthScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const TearmsCondationsScreen(),
        );

      case Routes.termsAndConditionsRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const TermsAndConditions(),
        );
      case Routes.privacyPolicyRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const PrivacyPolicyScreen(),
        );

      // case Routes.verificationMobileScreenRoute:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (BuildContext context) => const VerificationMobileScreen(),
      //   );

      // case Routes.verificationEmailScreenRoute:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (BuildContext context) => const VerificationEmailScreen(),
      //   );

      // case Routes.emailLoginScreenRoute:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (BuildContext context) => const EmailLoginScreen(),
      //   );

      // case Routes.registerScreenRoute:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (BuildContext context) => const RegisterScreen(),
      //   );

      // case Routes.flowScreenRoute:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (BuildContext context) => const FlowScreen(),
      //   );

      // case Routes.reviewMyDataScreenRoute:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (BuildContext context) => const ReviewMyDataScreen(),
      //   );

      // case Routes.editMyDataScreenRoute:
      //   return MaterialPageRoute(
      //     settings: routeSettings,
      //     builder: (BuildContext context) => const UpdateRegisterScreen(),
      //   );

      case Routes.verificationResetPasswordScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) =>
              const VerificationResetPasswordScreen(),
        );

      case Routes.confirmResetPasswordScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const ConfirmResetPasswordScreen(),
        );
      case Routes.mainPageRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => const MainPage(),
        );

      case Routes.fullPhotoRoute:
        String item = routeSettings.arguments as String;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => FullPhotoScreen(image: item),
        );
      case Routes.photoListRoute:
        Map<String, dynamic> map =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => SliderPhotoScreen(
            imagesFiles: map['imagesFiles'],
            images: map['images'],
            path: map['path'],
            imageIndex: map['imageIndex'],
          ),
        );

      case Routes.kindUserRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const KindUserScreen(),
        );
      case Routes.otpAuthRoute:
        // AuthParam authParam = routeSettings.arguments as AuthParam;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => OtpAuthScreen(
              // authParam: authParam,
              ),
        );
      case Routes.successChangePassRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) =>
              const SuccessChangePasswordScreen(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const OnBoardingScreen(),
        );

      case Routes.newUserRegisterRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => NewUserRegisterScreen(),
        );

      case Routes.newDelivryRegisterRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const NewDeliveryRegisterScreen(),
        );

      case Routes.newWasherRegisterRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const NewWasherRegisterScreen(),
        );
      case Routes.newWasherRegisterSecondStepRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const WasherRegisterSecondScreen(),
        );
      case Routes.carsScreenRoute:
        CarParams car = routeSettings.arguments as CarParams;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => CarsScreen(params: car),
        );
      case Routes.mapScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const MapScreen(),
        );
      case Routes.sortingSreenRoute:
        CarParams params = routeSettings.arguments as CarParams;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => SortingScreen(params: params),
        );
      case Routes.carDetailsScreenRoute:
        final args = routeSettings.arguments as CarDetailsArgs;

        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => CarDetailsScreen(
            car: args.car,
            params: args.params,
          ),
        );
      case Routes.profileScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const ProfileScreen(),
        );
      case Routes.editProfileScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const EditProfileScreen(),
        );
      case Routes.calnederScreemRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const DateRange(),
        );

      case Routes.paymentScreenRoute:
        final args = routeSettings.arguments as PaymentScreenArgs;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => PaymentScreen(
            car: args.car,
            attributes: args.attributes,
            params: args.params,
          ),
        );

      case Routes.newMapScreenRoute:
        CarParams params = routeSettings.arguments as CarParams;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => NewMapScreen(
            params: params,
          ),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }

  static String get currentRoute => routesStack.last;

  static void pushRouteToRoutesStack(String route) {
    routesStack.add(route);
    ServiceLocator.injectRoutesStackSingleton(routesStack);
  }

  static void popRouteFromRoutesStack() {
    routesStack.removeLast();
    ServiceLocator.injectRoutesStackSingleton(routesStack);
  }
}
