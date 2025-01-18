import 'package:app_show_images/src/features/cubit/images_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowImagesPage extends StatelessWidget {
  const ShowImagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagesCubit = BlocProvider.of<ImagesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagenes del Api Pública'),
      ),
      body: BlocBuilder<ImagesCubit, ImagesState>(
        builder: (context, state) {
          if (state is ImagesInitial) {
            imagesCubit.fetchImages('priime');
            return const Center(child: CircularProgressIndicator());
          } else if (state is ImagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ImagesLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(item.media.m),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.tags ?? 'No tags available',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ImagesError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
