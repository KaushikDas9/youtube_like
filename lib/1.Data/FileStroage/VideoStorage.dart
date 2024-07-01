// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:video_compress/video_compress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_clone/3.Presentation/ManageAllScreen/Manage_All_Screen.dart';
import 'package:uuid/uuid.dart';

class VideoStorage {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> getUserUIDFromSupabase() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final uid = user.id;
      debugPrint('User UID: $uid');
      return uid;
    } else {
      debugPrint('No user is signed in.');
    }
  }

  Future<String?> CreateBucketAtSupabase() async {
    String? uid = await getUserUIDFromSupabase();
    final String bucketId =
        await supabase.storage.createBucket(uid ?? "No name ");
    debugPrint("This is bucketId:$bucketId");

    return bucketId;
  }

  Future uploadFileAtSupabase(
      {required String path, required File file,  String title = ""}) async {
    try {
      await compressVideo(file: file, path: path).then((value) async {
        var uniqueVideoId = Uuid().v1();
        var userId = await getUserUIDFromSupabase();

        //For Video upload
        if (value != null) {
          final String fullPath = await supabase.storage.from("Video").upload(
                "$title",
                value[0]!,
                fileOptions:
                    const FileOptions(cacheControl: '3600', upsert: false),
              );

          //For ThumbNail upload
          // final String fullPath1 = await supabase.storage.from("Video").upload(
          //       "thumbnail/$title",
          //       value[1]!,
          //       fileOptions:
          //           const FileOptions(cacheControl: '3600', upsert: false),
          //     );

          if (fullPath.isNotEmpty ) {
            Get.off(const Manage_All_Screen());
            Get.snackbar("Uploaded", "Upload Successfully");
          }
        }
      });
    } on StorageException catch (e) {
      Get.snackbar(e.error ?? "Error", e.message);
    }
  }

  Future<List<dynamic>?> compressVideo(
      {required String path, required File file}) async {
    List<dynamic>? list=[];
    try {
      await VideoCompress.compressVideo(path,
              quality: VideoQuality.LowQuality, includeAudio: true)
          .then((value) {
        list.add(value!.file);
      });

      await VideoCompress.getFileThumbnail(path).then((value) {
        list.add(value);
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", e.toString());
    }

    // debugPrint("This is CompressVideo info :$list");
    return list;
  }
}
