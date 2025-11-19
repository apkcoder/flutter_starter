import '../../../core/network/network_manager.dart';
import 'models/login_models.dart';

class LoginRepository {
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final res = await NetworkManager.post<Map<String, dynamic>>(
        '/api/ticiqi/v1/sms_login',
        data: request.toJson(),
      );
      final data = res.data ?? <String, dynamic>{};
      return LoginResponse.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }
}