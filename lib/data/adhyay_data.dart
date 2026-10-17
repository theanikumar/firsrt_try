class AdhyayData {
  final int number;
  final String title;
  final String summary;
  final String? imageUrl;
  final int durationMinutes;

  const AdhyayData({
    required this.number,
    required this.title,
    required this.summary,
    this.imageUrl,
    required this.durationMinutes,
  });

  static final List<AdhyayData> allAdhyays = [
    const AdhyayData(
      number: 1,
      title: 'The Divine Wheat Grinding Leela',
      summary: 'Baba\'s miraculous wheat grinding and distribution to devotees, showing His divine compassion for all.',
      durationMinutes: 14,
    ),
    const AdhyayData(
      number: 2,
      title: 'Baba\'s Sacred Routine & Human Manifestation',
      summary: 'Description of Sai Baba\'s daily life, habits, and His human-like appearance while being divine.',
      durationMinutes: 16,
    ),
    const AdhyayData(
      number: 3,
      title: 'Cholera Epidemic & Kakasheb Dixit',
      summary: 'How Baba protected Shirdi from cholera and the story of Kakasheb Dixit\'s first visit.',
      durationMinutes: 15,
    ),
    const AdhyayData(
      number: 4,
      title: 'Plague Miracles & Udi Powers',
      summary: 'Baba\'s protection during plague epidemic and the miraculous healing powers of His sacred Udi.',
      durationMinutes: 17,
    ),
    const AdhyayData(
      number: 5,
      title: 'Shama\'s Vision & Abdul Baba',
      summary: 'Madhav Adkar (Shama)\'s divine vision and Abdul Baba\'s devotion and service to Sai.',
      durationMinutes: 13,
    ),
    const AdhyayData(
      number: 6,
      title: 'Das Ganu & Gopal Rao Gund',
      summary: 'The stories of devotee Das Ganu\'s Bhakti and Gopal Rao Gund\'s experiences with Baba.',
      durationMinutes: 18,
    ),
    const AdhyayData(
      number: 7,
      title: 'Final Teachings & Preparation',
      summary: 'Baba\'s last teachings to devotees and the signs preceding His Maha Samadhi.',
      durationMinutes: 16,
    ),
    // Add more chapters - template for chapters 8-51
    ...List.generate(44, (index) {
      final number = index + 8;
      return AdhyayData(
        number: number,
        title: 'Adhyay $number - Divine Leela & Teachings',
        summary: 'Sacred stories and teachings from Sai Baba\'s life, showing His divine grace and compassion.',
        durationMinutes: 12 + (number % 7),
      );
    }),
  ];

  static AdhyayData getAdhyay(int number) {
    return allAdhyays.firstWhere(
      (adhyay) => adhyay.number == number,
      orElse: () => allAdhyays[0],
    );
  }
}
