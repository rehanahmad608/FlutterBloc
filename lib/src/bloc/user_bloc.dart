import 'package:bloc/bloc.dart';
import 'package:demoapp/src/models/User.dart';
import 'package:demoapp/src/resources/UserRespository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  final _repository = UserRepository();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is Signin) {
      bool shouldpush;
      yield UserLoading();
      try {
         bool isSignup = false;
        String? userId = await _repository.register(event.phoneNum);
        if (userId == null) {
          isSignup = true;
          userId = event.phoneNum;
          }
           yield UserVerify(
            userId: userId,
            isSignup: isSignup,
            phoneNum: event.phoneNum,
            shouldPush: true);
       
      } catch (e) {
        yield LogInError(error: e.toString());
      }
    } else if (event is Signup) {
      yield UserLoading();
      try {
        final user =
            await _repository.signup(event.fName, event.lName, event.phoneNum);
        if (user != null) {
          
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user', user.userId);
      
          yield UserLoggedIn(user: user);
        }
      } catch (e) {
        print('error in Signup');
        yield UserSignupError(error: e.toString());
      }
    }
     else if (event is Verify) {
       bool verified;
      yield UserLoading();

      try {
       
         if (event.code.length != 4) {
          throw 'Please Insert Valid OTP';
        }
        if (event.isSignup) {
          await _repository.verifyNewUser(event.userId, event.code);
          // yield UserUploadPicture(
          //     phoneNum: event.phoneNum, shouldNavigate: true);
          yield UserVerified(phoneNum: event.phoneNum);
        } else {
          final user = await _repository.verify(event.userId, event.code);

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('user', event.userId);

          yield UserLoggedIn(user: user!);
          }
      
      } catch (e) {
        print('Error in Verification');
        yield VerificationError(
            error: e.toString(),
            userId: event.userId,
            // isSignup: event.isSignup,
            phoneNum: event.phoneNum);
      }
      //resend otp
    } 
    // else if (event is ResendOTP) {
    //   yield UserResndingOTP();
    //   try {
    //     await _repository.resendOtp(event.phoneNum);

    //     yield UserVerify(
    //         userId: event.userId,
    //         isSignup: event.isSignup,
    //         phoneNum: event.phoneNum,
    //         shouldPush: false);
    //   } catch (e) {
    //     print('error in resend Otp');
    //     yield VerificationError(
    //         error: e.toString(),
    //         isSignup: event.isSignup,
    //         phoneNum: event.phoneNum,
    //         userId: event.userId);
    //   }

    // }
  }
}
