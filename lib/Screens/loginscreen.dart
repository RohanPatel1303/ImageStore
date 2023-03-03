import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagestore/Constants/imageconstants.dart';
import 'package:imagestore/CustomWidgets/dropdownwidget.dart';
import 'package:imagestore/Screens/detailviewerscreen.dart';
const List<String> dd1_list=<String>["A","B","C","D"];
const List<String> dd2_list=<String>["1","2","3","4"];
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? pwd;
  String? dd1_value;
  String? dd2_value;


  @override
  Widget build(BuildContext context) {
    void toggle_dd1_value(value){
      dd1_value=value;
      setState(() {
      });
    };
    void toggle_dd2_value(value){
      dd2_value=value;
      setState(() {
      });
    };
    var screen_size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Login Screen"),),
      body: Column(
        children: [
          Container(
            height:screen_size.height*0.20 ,
            decoration:const BoxDecoration(
              image:DecorationImage(image: AssetImage(bg_img),fit: BoxFit.fill)
            )

          ),
          Container(
            child: const Text("Login",style: TextStyle(fontSize: 32),),
          ),
           Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 20),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter Your Email Address"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value){
                        email=value;
                        setState(() {

                        });
                      },

                      decoration: const InputDecoration(border: OutlineInputBorder(),hintText: "Email",label:Text("Email")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Enter Your Password"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value){
                        pwd=value;
                        setState(() {

                        });
                      },
                      decoration: const InputDecoration(border: OutlineInputBorder(),hintText: "Password",label:Text("Password")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   Dropdownwidget(itemList: dd1_list, onselect:toggle_dd1_value ),
                    const SizedBox(
                      height: 20,
                    ),
                    Dropdownwidget(itemList: dd2_list, onselect:toggle_dd2_value ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => {
                              print(email),
                              Get.to(const DetailsScreen(), arguments: [email,pwd,dd1_value,dd2_value])
                            },
                            child: const Text("Submit")),
                      ],
                    )

                  ],
                ),

            ),
          )


        ],
      ),
    );
  }
}
