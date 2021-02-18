import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


showImagePickerDialog(
    BuildContext context,
    {
      String imageURL,
      File imageFile,
      Function(File) onChange
    }
    ){
  List<Widget> tiles = [];
  if(imageFile!=null)
    tiles.add(
        ListTile(
          title: Text('Edit Selected Image'),
          leading: Icon(Icons.edit),
          onTap: () async{
            File file = await getImageCropped(imageFile);
            onChange(file);
          },
        )
    );
  tiles.add(
      ListTile(
        title: Text('Capture image'),
        leading: Icon(Icons.camera_alt),
        onTap: () async{
          File file = await getImageFromSource(ImageSource.camera);
          onChange(file);
        },
      )
  );
  tiles.add(
      ListTile(
        title: Text('Select from Gallery'),
        leading: Icon(Icons.photo_library),
        onTap: () async{
          File file = await getImageFromSource(ImageSource.gallery);
          onChange(file);
          // Navigator.pop(context);
        },
      )
  );
  showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: false,
      builder: (context){
        return SimpleDialog(
          children: tiles,
        );
      }
  );
}

Future<File> getImageFromSource(ImageSource source) async{
  PickedFile pickedFile = await ImagePicker().getImage(source: source, maxHeight: 800, maxWidth: 1200);
  File file = await getImageFromPicked(pickedFile);
  // return file;
  File finalFile = await getImageCropped(file);
  return finalFile;
}

Future<File> getImageFromPicked(PickedFile file) async{
  return File(file.path);
}

Future<File> getImageCropped(File image) async{
  return await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
  );
}