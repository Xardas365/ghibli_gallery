class Film {
  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseYear,
    required this.runningTimeMinutes,
    required this.rtScore,
    this.image,
    this.movieBanner,
  });

  final String id;
  final String title;
  final String description;
  final String director;
  final String producer;
  final int? releaseYear;
  final int? runningTimeMinutes;
  final int? rtScore;
  final String? image;
  final String? movieBanner;
}
