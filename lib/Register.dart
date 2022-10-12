import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/colors/MyColors.dart';
import 'package:mobifix/models/CityResponse.dart';
import 'package:mobifix/models/CountryResponse.dart';
import 'package:mobifix/models/Response.dart';
import 'package:mobifix/models/StateResponse.dart';
import 'package:mobifix/size/MySize.dart';
import 'package:mobifix/toast/Toast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();

  List<Country> countries = [];
  Country? country;
  List<States> states = [];
  States? state;
  List<City> cities = [];
  City? city;

  bool add = true;

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  height: 250,
                  width: MySize.size100(context),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 35,
                      foreground: Paint()..shader = LinearGradient(
                        colors: <Color>[
                          MyColors.colorDarkPrimary,
                          MyColors.colorPrimary,
                          MyColors.colorLightPrimary,
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width, 100.0))
                    )
                  ),
                ),
                TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }  else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }  else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  validator: (value) {
                    if(value!.isNotEmpty) {
                      if (!EmailValidator.validate(email.text)) {
                        return "Enter valid email address";
                      } else {
                        return null;
                      }
                    }
                    else {
                      return "* Required";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mobile,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Mobile No.",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }
                    else if(value.length!=10) {
                      return "* Invalid Mobile No.";
                    }
                    else if((value.startsWith("+91") || value.startsWith("91")) && value.length!=10) {
                      return "* Invalid Mobile No.";
                    }
                    else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: address,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }  else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField(
                        value: country,
                        items: countries.map((Country items) {
                          return DropdownMenuItem(
                            value: items,
                            child: SizedBox(
                              width: MySize.size35(context),
                              child: Text(items.name??"",
                                style: const TextStyle(
                                    fontSize: 15
                                ),
                              ),),
                          );
                        }).toList(),
                        onChanged: (value) {
                          country = value as Country;
                          setState(() {

                          });
                          getStates();
                        },
                        decoration: const InputDecoration(
                          labelText: "Country",
                        ),
                        validator: (value) {
                          if (value==null) {
                            return "* Required";
                          }  else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField(
                        value: state,
                        items: states.map((States items) {
                          return DropdownMenuItem(
                            value: items,
                            child: SizedBox(
                                width: MySize.size35(context),
                                child: Text(items.name??"",
                                  style: const TextStyle(
                                      fontSize: 15
                                  ),)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          state = value as States;
                          setState(() {

                          });
                          getCities();
                        },
                        decoration: const InputDecoration(
                          labelText: "State",
                        ),
                        validator: (value) {
                          if (value==null) {
                            return "* Required";
                          }  else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  value: city,
                  items: cities.map((City items) {
                    return DropdownMenuItem(
                      value: items,
                      child: SizedBox(
                        width: MySize.size35(context),
                        child: Text(items.name??"",
                          style: const TextStyle(
                              fontSize: 15
                          ),
                        ),),
                    );
                  }).toList(),
                  onChanged: (value) {
                    city = value as City;
                    setState(() {

                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "City",
                  ),
                  validator: (value) {
                    if (value==null) {
                      return "* Required";
                    }  else {
                      return null;
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if(add) {
                      if (formkey.currentState!.validate()) {
                        register();
                      }
                    }
                  },
                  child: Container(
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 25, left: 30, right: 30, top: 45),
                    width: MySize.size100(context),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                            MyColors.colorDarkPrimary,
                            MyColors.colorPrimary,
                            MyColors.colorLightPrimary
                          ]
                      ),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: add ? Text(
                      "REGISTER",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 16
                      ),
                    )
                    : CircularProgressIndicator(
                      color: MyColors.white,
                    )
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Already have an account?\t",
                    style: TextStyle(
                      color: MyColors.colorDarkPrimary
                    ),
                    children: [
                      TextSpan(
                        text: "Login.",
                        style: TextStyle(
                          color: MyColors.colorPrimary
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pop(context);
                        },
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  getCountries() async {
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.getAll,
    };

    CountryResponse countryResponse = await APIService().getCountries(data);

    countries = countryResponse.country ?? [];

    setState(() {

    });
  }

  getStates() async {
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.getAll,
      "id" : country?.id
    };

    StateResponse stateResponse = await APIService().getStates(data);

    states = stateResponse.state ?? [];

    setState(() {

    });
  }

  getCities() async {
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.getAll,
      "id" : state?.id
    };

    CityResponse cityResponse = await APIService().getCities(data);

    cities = cityResponse.city ?? [];

    setState(() {

    });
  }

  register() async {
    add = false;
    setState(() {

    });

    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.add,
      "name" : name.text,
      "username" : username.text,
      "email" : email.text,
      "mobile" : "${country?.code??""} ${mobile.text}",
      "address" : address.text,
      "c_id" : city?.id,
    };

    print(data);

    Response response = await APIService().register(data);

    if(response.status=="Success") {
      Navigator.pop(context);
    }

    add = true;
    setState(() {

    });

    Toast.sendToast(context, response.message??"");
  }
}
