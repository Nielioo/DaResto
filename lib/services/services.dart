import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:daresto/main.dart';
import 'package:daresto/models/models.dart';
import 'package:daresto/shared/shared.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

part 'background_service.dart';
part 'network/restaurant_api_service.dart';
part 'local/hive_helper.dart';
