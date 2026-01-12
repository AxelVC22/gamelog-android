import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../core/data/providers/photos/reviews/reviews_multimedia_providers.dart';
import '../core/data/repositories/photos/reviews/review_multimedia_repository.dart';
import '../core/domain/entities/review.dart';
import 'app_icon_button.dart';
import 'app_like_button.dart';
import 'app_photo.dart';
import 'app_profile_picture.dart';
import 'app_start_rating.dart';

class AppReviewCard extends StatelessWidget {
  final Review review;
  final String username;
  final String imageUrl;
  final VoidCallback? onTap;
  final DateTime date;
  final double rating;
  final String opinion;
  final VoidCallback? onDelete;
  final bool isLiked;
  final String userType;
  final int likes;
  final VoidCallback? onLiked;
  final Uint8List? imageData;
  final bool isLoading;

  const AppReviewCard({
    super.key,
    required this.review,
    required this.username,
    required this.imageUrl,
    this.onTap,
    required this.date,
    required this.rating,
    required this.opinion,
    required this.onDelete,
    required this.isLiked,
    required this.userType,
    required this.likes,
    this.onLiked,
    required this.imageData,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      AppProfilePhoto(
                        imageData: imageData,
                        isLoading: isLoading,
                        radius: 20,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (userType == 'Administrador')
                        AppIconButton(
                          icon: Icons.highlight_remove_rounded,
                          onPressed: onDelete,
                        ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      const SizedBox(height: 36),

                      AppStarRating(rating: rating, onRatingChanged: (_) {}),
                      const SizedBox(width: 8),

                      Text(
                        DateFormat('dd/MM/yyyy').format(date),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    opinion,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ReviewItem(review: review),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppLikeButton(
                    initialValue: isLiked,
                    onChanged: (value) {
                      onLiked!();
                    },
                  ),
                  if (likes > 0)
                    Text(
                      likes.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewItem extends ConsumerWidget {
  final Review review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metaAsync = ref.watch(
      reviewMetadataProvider(review.idReview.toString()),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        metaAsync.when(
          loading: () => const SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          ),

          error: (error, _) {
            return IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.invalidate(
                  reviewMetadataProvider(review.idReview.toString()),
                );
              },
            );
          },

          data: (meta) {
            if (meta.numFotos == 0 && meta.numVideos == 0) {
              return const SizedBox();
            }

            return ReviewMultimedia(
              reviewId: review.idReview.toString(),
              metadata: meta,
            );
          },
        ),
      ],
    );
  }
}

class ReviewMultimedia extends ConsumerWidget {
  final String reviewId;
  final MultimediaMetadata metadata;

  const ReviewMultimedia({
    super.key,
    required this.reviewId,
    required this.metadata,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        if (metadata.numFotos > 0)
          ref
              .watch(reviewPhotosProvider(reviewId))
              .when(
                loading: () => const CircularProgressIndicator(),
                error: (error, _) {
                  return IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      ref.invalidate(reviewPhotosProvider(reviewId));
                    },
                  );
                },
                data: (photos) {
                  if (photos.isEmpty) return const SizedBox();

                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: photos.take(3).map((photo) {
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: AppPhoto(
                          imageData: photo,
                          isEditable: false,
                          onRemove: null,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

        if (metadata.numVideos > 0) ...[
          const SizedBox(height: 8),
          ref
              .watch(reviewVideoProvider(reviewId))
              .when(
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const SizedBox(),
                data: (videoBytes) {
                  if (videoBytes == null) return const SizedBox();

                  return SizedBox(
                    width: 210,
                    height: 210,
                    child: AppReviewVideo(videoBytes: videoBytes),
                  );
                },
              ),
        ],
      ],
    );
  }
}

class AppReviewVideo extends StatefulWidget {
  final Uint8List videoBytes;

  const AppReviewVideo({super.key, required this.videoBytes});

  @override
  State<AppReviewVideo> createState() => _AppReviewVideoState();
}

class _AppReviewVideoState extends State<AppReviewVideo> {
  Uint8List? _thumbnail;
  bool _isLoading = true;
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
    _initializeVideo();
  }

  Future<void> _generateThumbnail() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempVideoPath =
          '${tempDir.path}/temp_video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final tempFile = File(tempVideoPath);
      await tempFile.writeAsBytes(widget.videoBytes);

      final thumbnailData = await VideoThumbnail.thumbnailData(
        video: tempVideoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 512,
        quality: 75,
      );

      await tempFile.delete();

      if (mounted) {
        setState(() {
          _thumbnail = thumbnailData;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _initializeVideo() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final videoPath =
          '${tempDir.path}/review_video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final videoFile = File(videoPath);
      await videoFile.writeAsBytes(widget.videoBytes);

      _controller = VideoPlayerController.file(videoFile);
      await _controller!.initialize();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error inicializando video: $e');
    }
  }

  void _togglePlayPause() {
    if (_controller == null) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _isPlaying = false;
      } else {
        _controller!.play();
        _isPlaying = true;
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        width: 100,
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_thumbnail == null || _controller == null) {
      return const SizedBox(
        width: 150,
        height: 100,
        child: Center(child: Icon(Icons.error)),
      );
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: SizedBox(
        width: 120,
        height: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!_isPlaying)
                Image.memory(
                  _thumbnail!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              else
                AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),

              if (!_isPlaying)
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
