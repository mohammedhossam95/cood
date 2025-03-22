import 'package:cood/core/params/auth_params.dart';
import 'package:cood/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:cood/features/auth/presentation/cubit/user_register_cubit/user_register_cubit.dart';
import 'package:cood/features/auth/presentation/cubit/verify_otp/verify_otp_cubit.dart';
import 'package:cood/features/categories/presentation/widgets/communication_details_item_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/params/car_params.dart';
import '/features/auth/presentation/screen/otp_screen.dart';
import '/features/auth/presentation/screen/success_change_pass_screen.dart';
import '/features/cars/presentation/screens/car_details_screen.dart';
import '/features/cars/presentation/screens/cars_screen.dart';
import '/features/cars/presentation/screens/map_screen.dart';
import '/features/cars/presentation/screens/new_map_screen.dart';
import '/features/cars/presentation/screens/payment_screen.dart';
import '/features/cars/presentation/screens/sorting_sreen.dart';
import '/features/home/presentation/screens/date_range.dart';
import '/features/profile/presentation/screens/edit_profile_screen.dart';
import '/features/profile/presentation/screens/profile_screen.dart';
import '../../core/utils/app_strings.dart';
import '../../core/widgets/full_photo.dart';
import '../../core/widgets/slider_photo.dart';
import '../../features/auth/presentation/screen/confirm_reset_password_screen.dart';
import '../../features/auth/presentation/screen/failed_otp_screen.dart';
import '../../features/auth/presentation/screen/forget_password_screen.dart';
import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/auth/presentation/screen/register_screen.dart';
import '../../features/auth/presentation/screen/splash_screen.dart';
import '../../features/auth/presentation/screen/success_otp_screen.dart';
import '../../features/auth/presentation/screen/tearms_condations_screen.dart';
import '../../features/auth/presentation/screen/verification_reset_password_screen.dart';
import '../../features/notification/presentation/screen/notification_screen.dart';
import '../../features/profile/presentation/screens/about_app_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/contact_us_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../../features/tabbar/presentation/screens/main_page.dart';
import '../../injection_container.dart';

class Routes {
  static const String initialRoute = '/';
  static const String landingPageRoute = '/LandingPage';
  static const String loginScreenRoute = '/LoginScreen';
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
  static const String hospitalInvitationsRoute = '/HospitalInvitationsScreen';
  static const String hospitalInvitationDetailsRoute =
      '/HospitalInvitationDetailsScreen';
  static const String otpAuthRoute = '/OtpAuthScreen';
  static const String successChangePassRoute = '/SuccessChangePassScreen';
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

  static const String registerRoute = '/RegisterScreen';

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
  static const String aboutAppRoute = '/AboutAppScreen';
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
  static const String changePasswordRoute = '/changePasswordScreen';
//---------------------added by ali
  static const String communicationItemSliver = '/CommunicationItemDetails';
}

final _sl = ServiceLocator.instance;

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

      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => _sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
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

      case Routes.changePasswordRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const ChangePasswordScreen(),
        );
      case Routes.notificationsScreenRoute:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (BuildContext context) => NotificationScreen());
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

      case Routes.aboutAppRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const AboutAppScreen(),
        );
      case Routes.privacyPolicyRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => const PrivacyPolicyScreen(),
        );

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

      case Routes.otpAuthRoute:
        AuthParams authParams = routeSettings.arguments as AuthParams;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => ServiceLocator.instance<VerifyOtpCubit>(),
            child: OtpAuthScreen(
              authParams: authParams,
            ),
          ),
        );
      case Routes.successChangePassRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) =>
              const SuccessChangePasswordScreen(),
        );

      case Routes.registerRoute:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => _sl<UserRegisterCubit>(),
            child: RegisterScreen(),
          ),
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
      case Routes.communicationItemSliver:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) => CommunicationItemDetails(),
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
