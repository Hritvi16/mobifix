import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobifix/api/Environment.dart';
import 'package:mobifix/models/CityResponse.dart';
import 'package:mobifix/models/CompanyResponse.dart';
import 'package:mobifix/models/CountryResponse.dart';
import 'package:mobifix/models/LoginResponse.dart';
import 'package:mobifix/models/ModelResponse.dart';
import 'package:mobifix/models/PackageResponse.dart';
import 'package:mobifix/models/PartResponse.dart';
import 'package:mobifix/models/Response.dart';
import 'package:mobifix/models/StateResponse.dart';
import 'package:mobifix/models/SubscriptionResponse.dart';
import 'APIConstant.dart';

class APIService {
  // getHeader() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map<String, String> headers = {
  //     APIConstant.authorization : APIConstant.token+(sharedPreferences.getString("token")??"")+"."+base64Encode(utf8.encode(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))),
  //     "Accept": "application/json",
  //   };
  //   return headers;
  // }

  // getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String token = sharedPreferences.getString("token")??"";
  //   return token;
  // }


  // Future<Response> insertUserFCM(Map<String, dynamic> data) async {
  //   var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.insertUserFCM);
  //   var result = await http.post(url, body: data);
  //
  //   Response response = Response.fromJson(json.decode(result.body));
  //   return response;
  // }

  Future<CountryResponse> getCountries(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCountries, queryParameters);
    print(url);
    var result = await http.get(url);
    CountryResponse countryResponse = CountryResponse.fromJson(json.decode(result.body));
    return countryResponse;
  }

  Future<StateResponse> getStates(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageStates, queryParameters);
    var result = await http.get(url);
    StateResponse stateResponse = StateResponse.fromJson(json.decode(result.body));
    return stateResponse;
  }

  Future<CityResponse> getCities(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCities, queryParameters);
    var result = await http.get(url);
    CityResponse cityResponse = CityResponse.fromJson(json.decode(result.body));
    return cityResponse;
  }

  Future<Response> register(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageStudents);
    var result = await http.post(url, body: data);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageStudents);
    var result = await http.post(url, body: data);
    LoginResponse loginResponse = LoginResponse.fromJson(json.decode(result.body));
    return loginResponse;
  }

  Future<SubscriptionResponse> checkSubscription(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageSubscriptions);
    var result = await http.post(url, body: data);
    SubscriptionResponse subscriptionResponse = SubscriptionResponse.fromJson(json.decode(result.body));
    return subscriptionResponse;
  }

  Future<PackageResponse> getPackages(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePackages, queryParameters);
    print(url);
    var result = await http.get(url);
    PackageResponse packageResponse = PackageResponse.fromJson(json.decode(result.body));
    return packageResponse;
  }

  Future<SubscriptionResponse> addSubscription(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageSubscriptions);
    var result = await http.post(url, body: data);
    SubscriptionResponse subscriptionResponse = SubscriptionResponse.fromJson(json.decode(result.body));
    return subscriptionResponse;
  }

  Future<Response> verifyCode(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageSubscriptions);
    var result = await http.post(url, body: data);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<CompanyResponse> getCompanies(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCompanies, queryParameters);
    print(url);
    var result = await http.get(url);
    CompanyResponse companyResponse = CompanyResponse.fromJson(json.decode(result.body));
    return companyResponse;
  }

  Future<ModelResponse> getModels(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageModels, queryParameters);
    print(url);
    var result = await http.get(url);
    ModelResponse modelResponse = ModelResponse.fromJson(json.decode(result.body));
    return modelResponse;
  }

  Future<PartResponse> getParts(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageParts, queryParameters);
    print(url);
    var result = await http.get(url);
    PartResponse partResponse = PartResponse.fromJson(json.decode(result.body));
    return partResponse;
  }
}
