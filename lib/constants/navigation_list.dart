import 'package:flutter/material.dart';
import 'package:instagram/views/instagramViews/insta_add_post_view.dart';
import 'package:instagram/views/instagramViews/insta_home_view.dart';
import 'package:instagram/views/instagramViews/insta_profile_view.dart';
import 'package:instagram/views/instagramViews/insta_reel_view.dart';
import 'package:instagram/views/instagramViews/insta_search_view.dart';

const List<Widget> navPages = [
  InstagramHomeView(),
  InstagramSearchView(),
  InstagramAddPostView(),
  InstagramReelsView(),
  InstagramProfileView(),
];
