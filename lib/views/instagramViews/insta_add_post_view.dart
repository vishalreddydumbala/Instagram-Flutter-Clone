import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_bloc.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_event.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_state.dart';
import 'package:instagram/nav/bloc/nav_bloc.dart';
import 'package:instagram/nav/bloc/nav_event.dart';
import 'package:instagram/utilities/colors.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class InstagramAddPostView extends StatefulWidget {
  const InstagramAddPostView({super.key});

  @override
  State<InstagramAddPostView> createState() => _InstagramAddPostViewState();
}

class _InstagramAddPostViewState extends State<InstagramAddPostView> {
  late final TextEditingController _captionController;
  List<AssetEntity>? _imageEntities;
  Uint8List? _selectedImage;
  int? _selectedIndex = 0;

  @override
  void initState() {
    _captionController = TextEditingController();
    context.read<AddPostSubBloc>().add(const AddPostSubInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostSubBloc, AddPostSubState>(
      listener: (context, state) {
        if (state is AddPostLoadedState) {
          _imageEntities = state.imageEntities;
          _selectedImage = state.selectedImage;
          _selectedIndex = state.index;
        }
      },
      child: BlocBuilder<AddPostSubBloc, AddPostSubState>(
        builder: (context, state) {
          if (state is AddPostInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddPostLoadedState) {
            _imageEntities = state.imageEntities;
            _selectedImage = state.selectedImage;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: mobileBackgroundColor,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      context.read<NavBloc>().add(const NavigateEvent(0));
                    },
                  ),
                  title: const Text('Post'),
                  centerTitle: false,
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.read<AddPostSubBloc>().add(
                              AddPostSubImageSelectedEvent(
                                  selectedImage: _selectedImage));
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                          ),
                        ))
                  ],
                ),
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 400.0,
                      floating: false,
                      stretch: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: _selectedImage != null
                            ? Image.memory(
                                _selectedImage!,
                                height: 400,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : const Placeholder(
                                fallbackHeight: 400,
                                fallbackWidth: double.infinity,
                              ),
                      ),
                    ),
                    SliverAppBar(
                      floating: false,
                      pinned: true,
                      stretch: true,
                      backgroundColor: Colors.grey[200],
                      title: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Recent',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ),
                      centerTitle: false,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<AddPostSubBloc>()
                                  .add(const AddPostGetCameraImageEvent());
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<AddPostSubBloc>()
                                  .add(AddPostSubGetImageEvent(index));
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image(
                                  image: AssetEntityImageProvider(
                                      _imageEntities![index]),
                                  fit: BoxFit.cover,
                                ),
                                if (_selectedIndex == index)
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                              ],
                            ),
                          );
                        },
                        childCount: _imageEntities!.length,
                      ),
                    )
                  ],
                ));
          } else if (state is AddPostSubmitState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    context
                        .read<AddPostSubBloc>()
                        .add(const AddPostSubInitialEvent());
                  },
                ),
                title: const Text('Post'),
                centerTitle: false,
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.memory(
                              _selectedImage!,
                              height: 400,
                              width: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 53, 51, 51),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                                controller: _captionController,
                                decoration: const InputDecoration(
                                  hintText: 'Write your caption...',
                                  hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                  border: InputBorder.none,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AddPostSubBloc>().add(AddPostPostEvent(
                          state.selectedImage, _captionController.text));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Post',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
