class LoginRequest {
  final String phone;
  final String code;

  const LoginRequest({required this.phone, required this.code});

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'code': code,
      };
}

class LoginResponse {
  final String token;
  final Map<String, dynamic> user;

  const LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final token = (json['token'] as String?) ?? '';
    final user = <String, dynamic>{
      'avatar_url': json['avatar_url'],
      'mobile': json['mobile'],
      'nickname': json['nickname'],
      'uid': json['uid'],
      'uuid': json['uuid'],
      'vip_start_date': json['vip_start_date'],
      'vip_end_date': json['vip_end_date'],
      'vip_grade': json['vip_grade'],
      'user_type': json['user_type'],
      'vip_member_type': json['vip_member_type'],
      'vip_name': json['vip_name'],
      'weixin_nickname': json['weixin_nickname'],
      'expire': json['expire'],
      'refresh_token': json['refresh_token'],
      'created_at': json['created_at'],
      'limit_vip_end_date': json['limit_vip_end_date'],
      'limit_vip_start_date': json['limit_vip_start_date'],
      'is_tag': json['is_tag'],
    };
    return LoginResponse(token: token, user: user);
  }
}