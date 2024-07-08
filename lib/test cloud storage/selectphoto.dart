import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/test%20cloud%20storage/storage_service.dart';

class SelectPhoto extends StatefulWidget{
  const SelectPhoto({super.key});

  @override
  State<SelectPhoto> createState() => _SelectPhotoState();
}

class _SelectPhotoState extends State<SelectPhoto> {

  final Storage storage = Storage();
  selectFile()async{

    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png','jpg'],
    );

    if(results == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No file selected')));
      return null;
    }

    final path = results.files.single.path;
    final name = results.files.single.name;

    storage.uploadFile(path!, name).then((value) => print('Done'));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Storage"),

      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: selectFile, child: const Text("upload file"),
            ),
          ),
        ],
      ),
    );
  }
}