import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_design_assingment_app/network/api_service.dart';

final providerOfApiService = Provider<ApiService>((ref) => ApiService());
