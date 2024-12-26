import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kuwo/changenotifiers/cards.dart';
import 'package:kuwo/changenotifiers/current_card_index.dart';
import 'package:kuwo/models/card_model.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final cardsChangeProvider = await Cards.fromNetwork();
  final currentCardIndexChangeProvider = CurrentCardIndex();
  showCard(id) => currentCardIndexChangeProvider.setCurrentCardIndex(cardsChangeProvider.indexOfCardWithID(id));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => cardsChangeProvider),
      ChangeNotifierProvider(create: (context) => currentCardIndexChangeProvider),
    ],
    child: Consumer<Cards>(
      builder: (context, cards, child) => MainApp(cards: cards),
    ),
  ));

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    showCard(initialMessage.data['article_id']);
  }
  FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) =>  showCard(remoteMessage.data['article_id']));

  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

class MainApp extends StatefulWidget {
  final Cards cards;

  const MainApp({super.key, required this.cards});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> with WidgetsBindingObserver {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int lastCardShown = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "kuwo",
      home: const SafeArea(child: HomePage()),
      navigatorObservers: <NavigatorObserver>[
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      widget.cards.save();
    }
  }
}
