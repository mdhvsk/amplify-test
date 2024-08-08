import 'dart:io';
import 'package:amplify_test/core/services/post_service.dart';
import 'package:amplify_test/core/services/supabase_client.dart';
import 'package:amplify_test/ui/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class StoryFormScreen extends StatefulWidget {
  const StoryFormScreen({super.key});

  @override
  State<StoryFormScreen> createState() => _StoryFormScreenState();
}

class _StoryFormScreenState extends State<StoryFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  late SupabaseClient _client;
  static String get supabaseBucketName =>
      dotenv.env['SUPABASE_BUCKET_NAME'] ?? "";
  PostService postService = PostService();
  String? submitError;
  String? imageId;

  _StoryFormScreenState() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    final instance = await SupabaseClientSingleton.instance;
    _client = instance.client;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_image == null) return null;

    setState(() {
      _isUploading = true;
    });

    try {
      final String fileName = path.basename(_image!.path);
      final fileExtension = path.extension(fileName);
      final String filePath =
          'uploads/${DateTime.now().toIso8601String()}$fileExtension';

      String response = await _client.storage
          .from(supabaseBucketName)
          .upload(filePath, _image!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Story uploaded successfully!')),
      );
      setState(() {
        imageId = response;
      });
      return response;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $error')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _navigateHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const FeedScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> handleFormSubmit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      int? userId = prefs.getInt('user_id');
      if (userId == null) {
        setState(() {
          submitError = "Not signed in";
        });
        return;
      }
      String? uploaded_image_id = await _uploadImage();
      debugPrint("Image ID: $uploaded_image_id");
      postService.insertPost(userId, _titleController.text,
          _storyController.text, uploaded_image_id);
      _navigateHome(context);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add News Story"),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              Text(
                'Submit Story',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                  controller: _titleController,
                  label: 'News Story Title',
                  maxLines: 1),
              SizedBox(height: 16),
              _buildInputField(
                  controller: _storyController,
                  label: 'Story Text',
                  maxLines: 5),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                    foregroundColor: Colors.blue[700],
                    backgroundColor: Colors.white,
                  ),
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => handleFormSubmit(),
                child: Text('Upload Story'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 20),
              if (_image != null) ...[
                Image.file(_image!, height: 200, alignment: Alignment.center),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                // foregroundColor: Colors.white,
                // backgroundColor: Colors.blue[700],
                //   ),
                //   onPressed: _isUploading ? null : _uploadImage,
                //   child: _isUploading
                //       ? const CircularProgressIndicator()
                //       : const Text('Upload to Supabase'),
                // ),
              ],
            ])));
  }
}

Widget _buildInputField(
    {required TextEditingController controller,
    required String label,
    required int maxLines}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      // border: InputBorder.none,
      // prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: label,
      alignLabelWithHint: false,
      floatingLabelBehavior: FloatingLabelBehavior.always,

      // prefixIcon: Icon(icon),
    ),
    textAlignVertical: TextAlignVertical.top,
    maxLines: maxLines,
  );
}
