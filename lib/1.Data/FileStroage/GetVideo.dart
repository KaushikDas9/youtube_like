import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetVideo {
  final SupabaseClient supabase = Supabase.instance.client;

  Future GetAllVideo() async {
    final id = supabase.auth.currentUser!.id;
    final allVideoId = await supabase.storage.from('Video').list();

    List allVideo = [];

    for (var i = 0; i < allVideoId.length; i++) {
      final publicUrl = await supabase.storage
          .from('Video')
          .createSignedUrl(allVideoId[i].name, 60 * 60 * 24);
      allVideo.add(publicUrl);
    }

    return allVideo;
  }

  Future GetAllVideoTitle() async {
    final id = supabase.auth.currentUser!.id;
    final allVideoId = await supabase.storage.from('Video').list();

    List allVideo = allVideoId.map((e) => e.name).toList();


    return allVideo;
  }
}
