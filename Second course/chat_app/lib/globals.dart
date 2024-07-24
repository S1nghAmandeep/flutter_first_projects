import 'package:event_bus/event_bus.dart';
import 'package:pubnub/pubnub.dart';

late PubNub pubNub;

const String channelValue = "8";
late String username;

EventBus eventBus = EventBus();