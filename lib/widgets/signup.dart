

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app1/imagePicker.dart';
import 'package:flutter_app1/providers/passwordProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app1/providers/imageProvider.dart';
import '../main.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.ac_unit_outlined,
                    color: Colors.green,
                  ),
                  Text(
                    'ecommStreet SignUp',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            body: ChangeNotifierProvider<MyProvider>(
              create: (context) => MyProvider(),
              child: Consumer<MyProvider>(builder: (context, provider, child) {
                return ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.all(35),
                      padding: EdgeInsets.all(30),
                      child: Column(children: [
                        Text(
                          'Welcome To ecommStreet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        MyImage(),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Workspace',
                            prefixText: 'https://www.',
                            suffixText: '.ecommstreet.in',
                            prefixIcon: Icon(
                              Icons.add_business,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: AutofillHints.email,
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        //          MyPasswordState(),
                        //         MyPasswordState(
                        //           confirmPassword: confirmPassword,
                        //       ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Phone No.',
                              hintText: 'phone number',
                              prefixIcon: Icon(
                                Icons.phone,
                              )),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          //   inputFormatters: <TextInputFormatter>[
                          //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          //   ],
                          validator: (value) {
                            if (value.isEmpty || value.length != 10) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: provider.hidePwd,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: AutofillHints.password,
                            prefixIcon: Icon(
                              Icons.vpn_key,
                            ),
                            suffixIcon: IconButton(
                              icon: Builder(
                                builder: (context) {
                                  if (provider.hidePwd) {
                                    return Icon(
                                      Icons.visibility_off,
                                    );
                                  }
                                  return Icon(
                                    Icons.visibility,
                                  );
                                },
                              ),
                              onPressed: () {
                                provider.setPassword();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MaterialButton(
                            child: Text('login'),
                            color: Colors.green,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            onPressed: () {
                              //    Navigator.pop(context);
                              if (_formKey.currentState.validate()) {
                                Navigator.pop(context);
                              }
                            }),
                      ]),
                    ),
                  ],
                );
              }),
            ),
          )),
    );
  }
}

class MyImage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return ChangeNotifierProvider<ImageProvider>(
    create: (context) => ImageProvider(),
    child: Consumer<ImageProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            if (provider.image == null)
              Icon(
                Icons.camera,
                size: 50,
              ),
            if (provider.image != null)
              Image.file(
                provider.image,
                height: 50,
                width: 50,
              ),
            FlatButton(
              onPressed: () async {
                showImagePickerDialog(
                    context,
                    imageFile: provider.image,
                    onChange: (file){
                      provider.setImage(file);
                    }
                );
              },
              child: Text('camera'),
            ),
            FlatButton(
              onPressed: () async {
                var imageFile =
                await ImagePicker().getImage(source: ImageSource.gallery);
                File file = File(imageFile.path);
                provider.setImage(file);
              },
              child: Text('gallery'),
            ),
          ],
        );
      },
    ),
  );
}
}


