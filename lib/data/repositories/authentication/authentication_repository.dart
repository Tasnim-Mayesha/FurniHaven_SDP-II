import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp2/common/splash_view.dart';
import 'package:sdp2/common/widgets/bottomnavbar/customer_starting.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';
import 'package:sdp2/common/onboarding/onboarding_view.dart';
import 'package:sdp2/utils/local_storage/storage_utility.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  // Getter method
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get Authenticated user data
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    _showSplashAndRedirect();
  }

  void _showSplashAndRedirect() async {
    // Show the SplashView
    Get.offAll(() => const SplashView());

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Then call screenRedirect to handle the rest of the logic
    screenRedirect();
  }

  void screenRedirect() async {

    final user = _auth.currentUser;
    final isFirstTime = deviceStorage.read('isFirstTime') ?? true;

    print("User: ${user?.uid}, Email Verified: ${user?.emailVerified}, First Time: $isFirstTime");



    if (user != null) {
        await LocalStorage.init(user.uid);
        print("Navigating to CustMainPage");
        Get.offAll(() => CustMainPage()); // Change this to your home screen widget

    } else {
      if (isFirstTime) {
        print("First time user, navigating to OnBoardingScreen");
        Get.offAll(() => const OnBoardingScreen());
      } else {
        print("Navigating to LoginOption");
        Get.offAll(() => const LoginOption());
      }
    }
  }

  /// Email login authentication
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Store additional user information in Firestore
      await _storeUserInfo(userCredential.user);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw Exception('PlatformException: ${e.message}');
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }

  /// Email register authentication
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Store additional user information in Firestore
      await _storeUserInfo(userCredential.user);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw Exception('PlatformException: ${e.message}');
    } catch (e) {
      throw "Something Went Wrong";
    }
  }

  /// Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw Exception('PlatformException: ${e.message}');
    } catch (e) {
      throw "Something Went Wrong";
    }
  }

  /// Forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw Exception('PlatformException: ${e.message}');
    } catch (e) {
      throw "Something Went Wrong";
    }
  }

  /// Re-authenticate user
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
      EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw Exception('PlatformException: ${e.message}');
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }

  /// Google SignIn Authentication
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the UserCredential
      UserCredential userCredential =
      await _auth.signInWithCredential(credentials);

      // Store additional user information in Firestore
      await _storeUserInfo(userCredential.user, userAccount);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw Exception('PlatformException: ${e.message}');
    } catch (e) {
      throw "Something Went Wrong";
    }
  }

  // Store user information in Firestore
  Future<void> _storeUserInfo(User? user,
      [GoogleSignInAccount? userAccount]) async {
    if (user != null) {
      final userDoc = _firestore.collection('Users').doc(user.uid);
      await userDoc.set({
        'email': user.email,
        'profilePicture': userAccount?.photoUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  // Logout User
  Future<void> logout() async {
    try {
      // Sign out from Google
      await GoogleSignIn().signOut();
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      // Clear all user-specific data in GetStorage except isFirstTime
      final storage = GetStorage();
      bool isFirstTime = storage.read('isFirstTime') ?? true;
      await storage.erase(); // Clears all data
      storage.write('isFirstTime', isFirstTime); // Restore isFirstTime
      // Redirect to login option
      Get.offAll(() => const LoginOption());
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }

  /// Delete account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw Exception('PlatformException: ${e.message}');
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }
}
