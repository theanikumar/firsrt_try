class AppStrings {
  // Language selection
  static String _currentLanguage = 'en';

  // v1 ships a full UI only in these three languages. The other choices are
  // saved on the devotee profile, but the interface falls back to English.
  static const _uiReadyLanguages = {'en', 'hi', 'mr'};

  static void setLanguage(String languageCode) {
    _currentLanguage =
        _uiReadyLanguages.contains(languageCode) ? languageCode : 'en';
  }

  static String get currentLanguage => _currentLanguage;

  // Onboarding - Shradha Saburi (Always in Hindi)
  static String get shradha {
    return 'श्रद्धा';
  }

  static String get saburi {
    return 'सबुरी';
  }

  // Sai Jaikar (Always in Hindi)
  static String get saiJaikar {
    return 'अनंत कोटि ब्रह्मांड नायक राजाधिराज योगीराज परब्रह्म श्री सच्चिदानन्द सद्गुरु साईंनाथ महाराज की जय';
  }

  // Sai Vani
  static String get saiVani {
    return _strings[_currentLanguage]?['saiVani'] ?? _strings['en']!['saiVani']!;
  }

  // Sai Vani Tag
  static String get saiVaniTag {
    return _strings[_currentLanguage]?['saiVaniTag'] ?? _strings['en']!['saiVaniTag']!;
  }

  // Language Selector Heading
  static String get chooseSacredLanguage {
    return _strings[_currentLanguage]?['chooseSacredLanguage'] ?? _strings['en']!['chooseSacredLanguage']!;
  }

  // Language Badge (Always in Hindi)
  static String get languageBadge {
    return 'भाषा चुने';
  }

  // Select Language Button
  static String get selectLanguageButton {
    return _strings[_currentLanguage]?['selectLanguageButton'] ?? _strings['en']!['selectLanguageButton']!;
  }

  // Blessed Devotees Text
  static String get blessedDevotees {
    return _strings[_currentLanguage]?['blessedDevotees'] ?? _strings['en']!['blessedDevotees']!;
  }

  // Parayan Sankalp Setup
  static String get parayanSankalpSetup {
    return _strings[_currentLanguage]?['parayanSankalpSetup'] ?? _strings['en']!['parayanSankalpSetup']!;
  }

  // Select Sacred Reading Vow
  static String get selectSacredReadingVow {
    return _strings[_currentLanguage]?['selectSacredReadingVow'] ?? _strings['en']!['selectSacredReadingVow']!;
  }

  // Saptah Sankalp (Always in Hindi)
  static String get saptahSankalp {
    return 'सप्ताह संकल्प';
  }

  // Duration Selector
  static String get sevenDaySaptah {
    return _strings[_currentLanguage]?['sevenDaySaptah'] ?? _strings['en']!['sevenDaySaptah']!;
  }

  static String get currentDayStart {
    return _strings[_currentLanguage]?['currentDayStart'] ?? _strings['en']!['currentDayStart']!;
  }

  static String get oneAdhyayDaily {
    return _strings[_currentLanguage]?['oneAdhyayDaily'] ?? _strings['en']!['oneAdhyayDaily']!;
  }

  static String get flexiblePace {
    return _strings[_currentLanguage]?['flexiblePace'] ?? _strings['en']!['flexiblePace']!;
  }

  // Pledge Cycle
  static String get pledgeCycle {
    return _strings[_currentLanguage]?['pledgeCycle'] ?? _strings['en']!['pledgeCycle']!;
  }

  static String get pledgeCycleDates {
    return _strings[_currentLanguage]?['pledgeCycleDates'] ?? _strings['en']!['pledgeCycleDates']!;
  }

  static String get pledgeCycleDescription {
    return _strings[_currentLanguage]?['pledgeCycleDescription'] ?? _strings['en']!['pledgeCycleDescription']!;
  }

  // Daily Audio Parayan Time
  static String get dailyAudioParayanTime {
    return _strings[_currentLanguage]?['dailyAudioParayanTime'] ?? _strings['en']!['dailyAudioParayanTime']!;
  }

  // Aarti & Parayan Reminder
  static String get aartiParayanReminder {
    return _strings[_currentLanguage]?['aartiParayanReminder'] ?? _strings['en']!['aartiParayanReminder']!;
  }

  // Take Sacred Sankalp Button
  static String get takeSacredSankalp {
    return _strings[_currentLanguage]?['takeSacredSankalp'] ?? _strings['en']!['takeSacredSankalp']!;
  }

  // Daily Saptah Schedule - Adhyay Cards
  static String get day1 {
    return _strings[_currentLanguage]?['day1'] ?? _strings['en']!['day1']!;
  }

  static String get day1Duration {
    return _strings[_currentLanguage]?['day1Duration'] ?? _strings['en']!['day1Duration']!;
  }

  static String get day1Adhyays {
    return _strings[_currentLanguage]?['day1Adhyays'] ?? _strings['en']!['day1Adhyays']!;
  }

  static String get day1Summary {
    return _strings[_currentLanguage]?['day1Summary'] ?? _strings['en']!['day1Summary']!;
  }

  static String get day2 {
    return _strings[_currentLanguage]?['day2'] ?? _strings['en']!['day2']!;
  }

  static String get day2Duration {
    return _strings[_currentLanguage]?['day2Duration'] ?? _strings['en']!['day2Duration']!;
  }

  static String get day2Adhyays {
    return _strings[_currentLanguage]?['day2Adhyays'] ?? _strings['en']!['day2Adhyays']!;
  }

  static String get day2Summary {
    return _strings[_currentLanguage]?['day2Summary'] ?? _strings['en']!['day2Summary']!;
  }

  static String get day3 {
    return _strings[_currentLanguage]?['day3'] ?? _strings['en']!['day3']!;
  }

  static String get day3Duration {
    return _strings[_currentLanguage]?['day3Duration'] ?? _strings['en']!['day3Duration']!;
  }

  static String get day3Adhyays {
    return _strings[_currentLanguage]?['day3Adhyays'] ?? _strings['en']!['day3Adhyays']!;
  }

  static String get day3Summary {
    return _strings[_currentLanguage]?['day3Summary'] ?? _strings['en']!['day3Summary']!;
  }

  static String get today {
    return _strings[_currentLanguage]?['today'] ?? _strings['en']!['today']!;
  }

  static String get playingNow {
    return _strings[_currentLanguage]?['playingNow'] ?? _strings['en']!['playingNow']!;
  }

  static String get elapsed {
    return _strings[_currentLanguage]?['elapsed'] ?? _strings['en']!['elapsed']!;
  }

  static String get remaining {
    return _strings[_currentLanguage]?['remaining'] ?? _strings['en']!['remaining']!;
  }

  static String get offline {
    return _strings[_currentLanguage]?['offline'] ?? _strings['en']!['offline']!;
  }

  // Days 4-7
  static String get day4 {
    return _strings[_currentLanguage]?['day4'] ?? _strings['en']!['day4']!;
  }

  static String get day4Duration {
    return _strings[_currentLanguage]?['day4Duration'] ?? _strings['en']!['day4Duration']!;
  }

  static String get day4Adhyays {
    return _strings[_currentLanguage]?['day4Adhyays'] ?? _strings['en']!['day4Adhyays']!;
  }

  static String get day4Summary {
    return _strings[_currentLanguage]?['day4Summary'] ?? _strings['en']!['day4Summary']!;
  }

  static String get day5 {
    return _strings[_currentLanguage]?['day5'] ?? _strings['en']!['day5']!;
  }

  static String get day5Duration {
    return _strings[_currentLanguage]?['day5Duration'] ?? _strings['en']!['day5Duration']!;
  }

  static String get day5Adhyays {
    return _strings[_currentLanguage]?['day5Adhyays'] ?? _strings['en']!['day5Adhyays']!;
  }

  static String get day5Summary {
    return _strings[_currentLanguage]?['day5Summary'] ?? _strings['en']!['day5Summary']!;
  }

  static String get day6 {
    return _strings[_currentLanguage]?['day6'] ?? _strings['en']!['day6']!;
  }

  static String get day6Duration {
    return _strings[_currentLanguage]?['day6Duration'] ?? _strings['en']!['day6Duration']!;
  }

  static String get day6Adhyays {
    return _strings[_currentLanguage]?['day6Adhyays'] ?? _strings['en']!['day6Adhyays']!;
  }

  static String get day6Summary {
    return _strings[_currentLanguage]?['day6Summary'] ?? _strings['en']!['day6Summary']!;
  }

  static String get day7 {
    return _strings[_currentLanguage]?['day7'] ?? _strings['en']!['day7']!;
  }

  static String get day7Duration {
    return _strings[_currentLanguage]?['day7Duration'] ?? _strings['en']!['day7Duration']!;
  }

  static String get day7Adhyays {
    return _strings[_currentLanguage]?['day7Adhyays'] ?? _strings['en']!['day7Adhyays']!;
  }

  static String get day7Summary {
    return _strings[_currentLanguage]?['day7Summary'] ?? _strings['en']!['day7Summary']!;
  }

  // All Adhyays Info Card
  static String get sacredProcess {
    return _strings[_currentLanguage]?['sacredProcess'] ?? _strings['en']!['sacredProcess']!;
  }

  static String get currentTrack {
    return _strings[_currentLanguage]?['currentTrack'] ?? _strings['en']!['currentTrack']!;
  }

  static String get finished {
    return _strings[_currentLanguage]?['finished'] ?? _strings['en']!['finished']!;
  }

  static String get overall {
    return _strings[_currentLanguage]?['overall'] ?? _strings['en']!['overall']!;
  }

  static String get resumingAt {
    return _strings[_currentLanguage]?['resumingAt'] ?? _strings['en']!['resumingAt']!;
  }

  static String get verse {
    return _strings[_currentLanguage]?['verse'] ?? _strings['en']!['verse']!;
  }

  // Search and Categories
  static String get searchHint {
    return _strings[_currentLanguage]?['searchHint'] ?? _strings['en']!['searchHint']!;
  }

  static String get all {
    return _strings[_currentLanguage]?['all'] ?? _strings['en']!['all']!;
  }

  static String get completed {
    return _strings[_currentLanguage]?['completed'] ?? _strings['en']!['completed']!;
  }

  static String get inProgress {
    return _strings[_currentLanguage]?['inProgress'] ?? _strings['en']!['inProgress']!;
  }

  static String get unread {
    return _strings[_currentLanguage]?['unread'] ?? _strings['en']!['unread']!;
  }

  static String get famousLeelas {
    return _strings[_currentLanguage]?['famousLeelas'] ?? _strings['en']!['famousLeelas']!;
  }

  static String get teachings {
    return _strings[_currentLanguage]?['teachings'] ?? _strings['en']!['teachings']!;
  }

  static String get mahasamadhi {
    return _strings[_currentLanguage]?['mahasamadhi'] ?? _strings['en']!['mahasamadhi']!;
  }

  // Adhyay List
  static String get satcharitaIndex {
    return _strings[_currentLanguage]?['satcharitaIndex'] ?? _strings['en']!['satcharitaIndex']!;
  }

  static String get adhyaysCount {
    return _strings[_currentLanguage]?['adhyaysCount'] ?? _strings['en']!['adhyaysCount']!;
  }

  static String get order {
    return _strings[_currentLanguage]?['order'] ?? _strings['en']!['order']!;
  }

  static String get adhyay {
    return _strings[_currentLanguage]?['adhyay'] ?? _strings['en']!['adhyay']!;
  }

  static String get completedStatus {
    return _strings[_currentLanguage]?['completedStatus'] ?? _strings['en']!['completedStatus']!;
  }

  static String get readingNow {
    return _strings[_currentLanguage]?['readingNow'] ?? _strings['en']!['readingNow']!;
  }

  static String get upNext {
    return _strings[_currentLanguage]?['upNext'] ?? _strings['en']!['upNext']!;
  }

  static String get unreadStatus {
    return _strings[_currentLanguage]?['unreadStatus'] ?? _strings['en']!['unreadStatus']!;
  }

  static String get readAgain {
    return _strings[_currentLanguage]?['readAgain'] ?? _strings['en']!['readAgain']!;
  }

  static String get resumeReading {
    return _strings[_currentLanguage]?['resumeReading'] ?? _strings['en']!['resumeReading']!;
  }

  static String get read {
    return _strings[_currentLanguage]?['read'] ?? _strings['en']!['read']!;
  }

  static String get listen {
    return _strings[_currentLanguage]?['listen'] ?? _strings['en']!['listen']!;
  }

  static String get recorded {
    return _strings[_currentLanguage]?['recorded'] ?? _strings['en']!['recorded']!;
  }

  static String get notRecorded {
    return _strings[_currentLanguage]?['notRecorded'] ??
        _strings['en']!['notRecorded']!;
  }

  // Localized strings database
  // Add other app strings here with language support
  static const Map<String, Map<String, String>> _strings = {
    // English
    'en': {
      'saiVani': 'Sai Vani',
      'saiVaniTag': 'Your spiritual companion for sacred Shri Sai Satcharitra audio parayan & tranquil daily prayers',
      'chooseSacredLanguage': 'Choose Sacred Language',
      'selectLanguageButton': 'Select Language (भाषा चुनें)',
      'blessedDevotees': 'Blessed for devotees worldwide • ॐ साईं राम',
      'parayanSankalpSetup': 'Parayan Sankalp Setup',
      'selectSacredReadingVow': 'Select your sacred reading vow',
      'sevenDaySaptah': '7-Day Saptah',
      'currentDayStart': 'Monday Start',
      'oneAdhyayDaily': '1 Adhyay Daily',
      'flexiblePace': 'Flexible Pace',
      'pledgeCycle': 'PLEDGE CYCLE',
      'pledgeCycleDates': 'Monday to Sunday',
      'pledgeCycleDescription': 'Covers all 51 sacred chapters in 7 consecutive days',
      'dailyAudioParayanTime': 'Daily Audio Parayan Time',
      'aartiParayanReminder': 'Aarti & Parayan Reminder',
      'takeSacredSankalp': 'Take Sacred Sankalp (संकल्प करें)',
      'day1': 'DAY 1',
      'day1Duration': '54 min',
      'day1Adhyays': 'Adhyays 1 to 7',
      'day1Summary': 'Wheat Grinding Leela & Sai Baba\'s Divine',
      'day2': 'DAY 2',
      'day2Duration': '58 min',
      'day2Adhyays': 'Adhyays 8 to 14',
      'day2Summary': 'Baba\'s Sacred Routine & Human Manifestation',
      'day3': 'DAY 3',
      'day3Duration': '52m total',
      'day3Adhyays': 'Adhyays 15 to 21',
      'day3Summary': 'Cholera Epidemic, Kakasheb Dixit &..',
      'today': 'TODAY',
      'playingNow': 'Playing Now',
      'elapsed': 'elapsed',
      'remaining': 'remaining',
      'offline': 'Offline unavailable',
      'day4': 'DAY 4',
      'day4Duration': '56 min',
      'day4Adhyays': 'Adhyays 22 to 28',
      'day4Summary': 'Plague, Udi Powers & Baba\'s Handi',
      'day5': 'DAY 5',
      'day5Duration': '54 min',
      'day5Adhyays': 'Adhyays 29 to 35',
      'day5Summary': 'Shama\'s Vision & Abdul Baba\'s Story',
      'day6': 'DAY 6',
      'day6Duration': '58 min',
      'day6Adhyays': 'Adhyays 36 to 42',
      'day6Summary': 'Das Ganu, Gopal Rao & Bal Gangadhar',
      'day7': 'DAY 7',
      'day7Duration': '62 min',
      'day7Adhyays': 'Adhyays 43 to 51',
      'day7Summary': 'Final Teachings & Baba\'s Maha Samadhi',
      'sacredProcess': 'SACRED PROCESS',
      'currentTrack': 'Current Track',
      'finished': 'Finished',
      'overall': 'overall',
      'resumingAt': 'Resuming at',
      'verse': 'verse',
      'searchHint': 'Search chapter story or leela',
      'all': 'All',
      'completed': 'Completed',
      'inProgress': 'InProgress',
      'unread': 'Unread',
      'famousLeelas': 'Famous Leelas',
      'teachings': 'Teachings',
      'mahasamadhi': 'Mahasamadhi',
      'satcharitaIndex': 'Sri Sai Satcharitra Index',
      'adhyaysCount': '51 Adhyays',
      'order': 'Order (1-51)',
      'adhyay': 'ADHYAY',
      'completedStatus': 'Completed',
      'readingNow': 'Reading Now',
      'upNext': 'Up Next',
      'unreadStatus': 'Unread',
      'readAgain': 'Read Again',
      'resumeReading': 'Resume Reading',
      'read': 'Read',
      'listen': 'Listen',
      'recorded': 'Recorded',
      'notRecorded': 'Not yet recorded',
    },
    // Hindi
    'hi': {
      'saiVani': 'साई वाणी',
      'saiVaniTag': 'पवित्र श्री साई सत्चरित्र ऑडियो पारायण और शांत दैनिक प्रार्थनाओं के लिए आपका आध्यात्मिक साथी',
      'chooseSacredLanguage': 'पवित्र भाषा चुनें',
      'selectLanguageButton': 'भाषा चुनें (Select Language)',
      'blessedDevotees': 'दुनिया भर के भक्तों के लिए आशीर्वादित • ॐ साईं राम',
      'parayanSankalpSetup': 'पारायण संकल्प सेटअप',
      'selectSacredReadingVow': 'अपना पवित्र पाठ संकल्प चुनें',
      'sevenDaySaptah': '७-दिवसीय सप्ताह',
      'currentDayStart': 'सोमवार प्रारंभ',
      'oneAdhyayDaily': '१ अध्याय दैनिक',
      'flexiblePace': 'लचीली गति',
      'pledgeCycle': 'संकल्प चक्र',
      'pledgeCycleDates': 'सोमवार से रविवार',
      'pledgeCycleDescription': '७ लगातार दिनों में सभी ५१ पवित्र अध्यायों को शामिल करता है',
      'dailyAudioParayanTime': 'दैनिक ऑडियो पारायण समय',
      'aartiParayanReminder': 'आरती और पारायण अनुस्मारक',
      'takeSacredSankalp': 'पवित्र संकल्प लें (Take Sacred Sankalp)',
      'day1': 'दिवस 1',
      'day1Duration': '54 मिनट',
      'day1Adhyays': 'अध्याय 1 से 7',
      'day1Summary': 'गेहूं पीसने की लीला और साईं बाबा का दिव्य',
      'day2': 'दिवस 2',
      'day2Duration': '58 मिनट',
      'day2Adhyays': 'अध्याय 8 से 14',
      'day2Summary': 'बाबा की पवित्र दिनचर्या और मानव अवतार',
      'day3': 'दिवस 3',
      'day3Duration': '52 मिनट कुल',
      'day3Adhyays': 'अध्याय 15 से 21',
      'day3Summary': 'हैजा की महामारी, काकासाहेब दीक्षित और..',
      'today': 'आज',
      'playingNow': 'अभी चल रहा है',
      'elapsed': 'बीत गया',
      'remaining': 'शेष',
      'offline': 'ऑफ़लाइन उपलब्ध नहीं',
      'day4': 'दिवस 4',
      'day4Duration': '56 मिनट',
      'day4Adhyays': 'अध्याय 22 से 28',
      'day4Summary': 'प्लेग, उदी शक्तियां और बाबा की हंडी',
      'day5': 'दिवस 5',
      'day5Duration': '54 मिनट',
      'day5Adhyays': 'अध्याय 29 से 35',
      'day5Summary': 'शामा का दर्शन और अब्दुल बाबा की कहानी',
      'day6': 'दिवस 6',
      'day6Duration': '58 मिनट',
      'day6Adhyays': 'अध्याय 36 से 42',
      'day6Summary': 'दास गणु, गोपाल राव और बाल गंगाधर',
      'day7': 'दिवस 7',
      'day7Duration': '62 मिनट',
      'day7Adhyays': 'अध्याय 43 से 51',
      'day7Summary': 'अंतिम शिक्षाएं और बाबा की महासमाधि',
      'sacredProcess': 'पवित्र प्रक्रिया',
      'currentTrack': 'वर्तमान ट्रैक',
      'finished': 'समाप्त',
      'overall': 'कुल मिलाकर',
      'resumingAt': 'फिर से शुरू',
      'verse': 'छंद',
      'searchHint': 'अध्याय कहानी या लीला खोजें',
      'all': 'सभी',
      'completed': 'पूर्ण',
      'inProgress': 'प्रगति में',
      'unread': 'अपठित',
      'famousLeelas': 'प्रसिद्ध लीलाएं',
      'teachings': 'शिक्षाएं',
      'mahasamadhi': 'महासमाधि',
      'satcharitaIndex': 'श्री साईं सत्चरित्र सूची',
      'adhyaysCount': '51 अध्याय',
      'order': 'क्रम (1-51)',
      'adhyay': 'अध्याय',
      'completedStatus': 'पूर्ण',
      'readingNow': 'अभी पढ़ रहे हैं',
      'upNext': 'अगला',
      'unreadStatus': 'अपठित',
      'readAgain': 'फिर से पढ़ें',
      'resumeReading': 'पढ़ना जारी रखें',
      'read': 'पढ़ें',
      'listen': 'सुनें',
      'recorded': 'उपलब्ध',
      'notRecorded': 'अभी रिकॉर्ड नहीं',
    },
    // Marathi
    'mr': {
      'saiVani': 'साई वाणी',
      'saiVaniTag': 'पवित्र श्री साई सत्चरित्र ऑडिओ पारायण आणि शांत दैनिक प्रार्थनांसाठी तुमचा आध्यात्मिक साथी',
      'chooseSacredLanguage': 'पवित्र भाषा निवडा',
      'selectLanguageButton': 'भाषा निवडा (Select Language)',
      'blessedDevotees': 'जगभरातील भक्तांसाठी आशीर्वादित • ॐ साईं राम',
      'parayanSankalpSetup': 'पारायण संकल्प सेटअप',
      'selectSacredReadingVow': 'तुमचा पवित्र वाचन व्रत निवडा',
      'sevenDaySaptah': '७-दिवसीय सप्ताह',
      'currentDayStart': 'सोमवार सुरुवात',
      'oneAdhyayDaily': '१ अध्याय दररोज',
      'flexiblePace': 'लवचिक गती',
      'pledgeCycle': 'प्रतिज्ञा चक्र',
      'pledgeCycleDates': 'सोमवार ते रविवार',
      'pledgeCycleDescription': '७ सलग दिवसांमध्ये सर्व ५१ पवित्र अध्यायांचा समावेश',
      'dailyAudioParayanTime': 'दैनिक ऑडिओ पारायण वेळ',
      'aartiParayanReminder': 'आरती आणि पारायण स्मरणपत्र',
      'takeSacredSankalp': 'पवित्र संकल्प घ्या (Take Sacred Sankalp)',
      'day1': 'दिवस 1',
      'day1Duration': '54 मिनिटे',
      'day1Adhyays': 'अध्याय 1 ते 7',
      'day1Summary': 'गव्हाच्या गोंधळाचा लीला आणि साईं बाबांचे दिव्य',
      'day2': 'दिवस 2',
      'day2Duration': '58 मिनिटे',
      'day2Adhyays': 'अध्याय 8 ते 14',
      'day2Summary': 'बाबांची पवित्र दिनचर्या आणि मानवी अवतार',
      'day3': 'दिवस 3',
      'day3Duration': '52 मिनिटे एकूण',
      'day3Adhyays': 'अध्याय 15 ते 21',
      'day3Summary': 'कॉलरा साथीचा रोग, काकासाहेब दीक्षित आणि..',
      'today': 'आज',
      'playingNow': 'आता चालू आहे',
      'elapsed': 'गेले',
      'remaining': 'उरलेले',
      'offline': 'ऑफलाइन उपलब्ध नाही',
      'day4': 'दिवस 4',
      'day4Duration': '56 मिनिटे',
      'day4Adhyays': 'अध्याय 22 ते 28',
      'day4Summary': 'प्लेग, उदी शक्ती आणि बाबांची हंडी',
      'day5': 'दिवस 5',
      'day5Duration': '54 मिनिटे',
      'day5Adhyays': 'अध्याय 29 ते 35',
      'day5Summary': 'शामाचे दर्शन आणि अब्दुल बाबांची कथा',
      'day6': 'दिवस 6',
      'day6Duration': '58 मिनिटे',
      'day6Adhyays': 'अध्याय 36 ते 42',
      'day6Summary': 'दास गणू, गोपाळ राव आणि बाळ गंगाधर',
      'day7': 'दिवस 7',
      'day7Duration': '62 मिनिटे',
      'day7Adhyays': 'अध्याय 43 ते 51',
      'day7Summary': 'अंतिम शिकवणी आणि बाबांची महासमाधी',
      'sacredProcess': 'पवित्र प्रक्रिया',
      'currentTrack': 'वर्तमान ट्रॅक',
      'finished': 'पूर्ण',
      'overall': 'एकूण',
      'resumingAt': 'पुन्हा सुरू',
      'verse': 'श्लोक',
      'searchHint': 'अध्याय कथा किंवा लीला शोधा',
      'all': 'सर्व',
      'completed': 'पूर्ण',
      'inProgress': 'प्रगतीत',
      'unread': 'न वाचलेले',
      'famousLeelas': 'प्रसिद्ध लीला',
      'teachings': 'शिकवण',
      'mahasamadhi': 'महासमाधी',
      'satcharitaIndex': 'श्री साई सत्चरित्र सूची',
      'adhyaysCount': '51 अध्याय',
      'order': 'क्रम (1-51)',
      'adhyay': 'अध्याय',
      'completedStatus': 'पूर्ण',
      'readingNow': 'आत्ता वाचत आहे',
      'upNext': 'पुढील',
      'unreadStatus': 'न वाचलेले',
      'readAgain': 'पुन्हा वाचा',
      'resumeReading': 'वाचणे सुरू ठेवा',
      'read': 'वाचा',
      'listen': 'ऐका',
      'recorded': 'उपलब्ध',
      'notRecorded': 'अजून रेकॉर्ड नाही',
    },
  };
}
