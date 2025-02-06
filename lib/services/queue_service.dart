import 'package:dart_amqp/dart_amqp.dart';

class QueueService {
  final Client client = Client();

  Future<void> publishMessage(String message) async {
    final channel = await client.channel(); 
    final exchange = await channel.exchange('person_exchange', ExchangeType.DIRECT);
    exchange.publish(message, 'person_queue');
  }
}
