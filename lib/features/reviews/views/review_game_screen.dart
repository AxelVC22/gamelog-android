import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/reviews/review_game_request.dart';
import 'package:gamelog/core/data/models/reviews/review_game_response.dart';
import 'package:gamelog/features/reviews/controllers/review_game_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../core/data/providers/photos/reviews/reviews_multimedia_providers.dart';
import '../../../core/domain/entities/game.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/presentation/failure_handler.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_photo.dart';
import '../../../widgets/app_start_rating.dart';
import '../../../widgets/app_text_area.dart';
import 'package:collection/collection.dart';

import '../../multimedia/controllers/review_multimedia_controller.dart';

enum MediaType { image, video }

class SelectedMedia {
  final MediaType type;
  final Uint8List thumbnail;
  final String? path;

  SelectedMedia({required this.type, required this.thumbnail, this.path});
}

final selectedMediaProvider = StateProvider.autoDispose<List<SelectedMedia>>(
  (ref) => [],
);

class ReviewGameScreen extends ConsumerStatefulWidget {
  final Game game;

  const ReviewGameScreen({super.key, required this.game});

  @override
  ConsumerState<ReviewGameScreen> createState() => _ReviewGameScreenState();
}

class _ReviewGameScreenState extends ConsumerState<ReviewGameScreen> {
  double currentRating = 0.0;

  final _opinionController = TextEditingController();

  Future<void> _pickVideo() async {
    final picker = ImagePicker();

    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 5),
    );

    if (video == null) return;

    final notifier = ref.read(selectedMediaProvider.notifier);
    final current = notifier.state;

    final hasVideo = current.any((m) => m.type == MediaType.video);
    if (hasVideo) return;

    final thumbnail = await VideoThumbnail.thumbnailData(
      video: video.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 512,
      quality: 75,
    );

    if (thumbnail == null) return;

    notifier.state = [
      ...current,
      SelectedMedia(
        type: MediaType.video,
        thumbnail: thumbnail,
        path: video.path,
      ),
    ];
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image == null) return;

    final bytes = await image.readAsBytes();

    const maxSize = 3 * 1024 * 1024;
    if (bytes.length > maxSize) return;

    final notifier = ref.read(selectedMediaProvider.notifier);
    final current = notifier.state;

    final imageCount = current.where((m) => m.type == MediaType.image).length;

    if (imageCount >= 3) return;

    notifier.state = [
      ...current,
      SelectedMedia(type: MediaType.image, thumbnail: bytes),
    ];
  }

  void _performReviewGame() async {
    final request = ReviewGameRequest(
      idGame: widget.game.id,
      idPlayer: ref.read(currentUserProvider.notifier).state!.idPlayer,
      rating: currentRating,
      opinion: _opinionController.text,
      name: widget.game.name,
      released: widget.game.released!,
    );

    await ref.read(reviewGameControllerProvider.notifier).reviewGame(request);
  }

  Future<void> _uploadMultimedia(String idReview) async {
    final controller = ref.read(reviewMultimediaControllerProvider.notifier);

    final media = ref.read(selectedMediaProvider);

    int photoIndex = 1;

    for (final item in media.where((m) => m.type == MediaType.image)) {
      final tempFile = await _bytesToTempFile(
        item.thumbnail,
        'photo_$photoIndex.jpg',
      );

      await controller.uploadPhoto(
        idReview: idReview,
        index: photoIndex,
        photo: tempFile,
      );

      photoIndex++;
    }

    final video = media.firstWhereOrNull((m) => m.type == MediaType.video);

    if (video?.path != null) {
      await controller.uploadVideo(
        idReview: idReview,
        video: File(video!.path!),
      );
    }
  }

  Future<File> _bytesToTempFile(Uint8List bytes, String filename) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final uploadState = ref.watch(reviewMultimediaControllerProvider);
    final media = ref.watch(selectedMediaProvider);

    ref.listen<UploadState>(reviewMultimediaControllerProvider, (
      previous,
      next,
    ) {
      if (next.error != null) {
        ref.read(globalLoadingProvider.notifier).state = false;
        handleFailure(context: context, error: next.error!);
        Navigator.pop(context);
      }
    });

    ref.listen<AsyncValue<ReviewGameResponse?>>(reviewGameControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) async {
            if (response == null) return;

            await _uploadMultimedia(response.idReview.toString());

            ref.read(globalLoadingProvider.notifier).state = false;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(response.message)));
              Navigator.pop(context);
            });
          },
          error: (error, stack) {
            ref.read(globalLoadingProvider.notifier).state = false;

            handleFailure(context: context, error: error);
          },
        );
      }

      if (next.isLoading) {
        ref.read(globalLoadingProvider.notifier).state = true;
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.reviewGameTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(14),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppModuleTitle(title: widget.game.name),
                    const SizedBox(height: 8),

                    Text("${l10n.rating}: "),
                    Row(
                      children: [
                        AppStarRating(
                          rating: currentRating,
                          onRatingChanged: (value) {
                            setState(() => currentRating = value!);
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(currentRating.toString()),
                      ],
                    ),

                    const Divider(),

                    AppTextArea(
                      hint: l10n.writeOpinion,
                      maxLength: 250,
                      controller: _opinionController,
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: AppIconButton(
                            icon: Icons.image,
                            onPressed: _pickImage,
                          ),
                        ),
                        Expanded(
                          child: AppIconButton(
                            icon: Icons.video_file,
                            onPressed: _pickVideo,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            if (media.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    final item = media[i];
                    return AppPhoto(
                      imageData: item.thumbnail,
                      isVideo: item.type == MediaType.video,
                      isEditable: true,
                      onRemove: () {
                        ref
                            .read(selectedMediaProvider.notifier)
                            .state = List.from(media)
                          ..removeAt(i);
                      },
                    );
                  }, childCount: media.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                ),
              ),

            SliverPadding(
              padding: const EdgeInsets.all(14),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    if (uploadState.isLoading) ...[
                      LinearProgressIndicator(value: uploadState.progress),
                      const SizedBox(height: 6),
                      Text(
                        '${(uploadState.progress * 100).toStringAsFixed(0)}%',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                    ],

                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: l10n.ok,
                            onPressed: _performReviewGame,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppButton(
                            text: l10n.cancel,
                            type: AppButtonType.cancel,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
