import 'package:equatable/equatable.dart';

class Llm extends Equatable {
  final bool? enabled;
  final int? topK;
  final double? scoreThreshold;
  final String? model;
  final String? embeddings;
  final double? temperature;
  final String? prompt;
  //
  final String? apiKey;
  final String? apiSecret;
  final String? apiUrl;

  const Llm({
    this.enabled,
    this.topK,
    this.scoreThreshold,
    this.model,
    this.embeddings,
    this.temperature,
    this.prompt,
    this.apiKey,
    this.apiSecret,
    this.apiUrl,
  }) : super();

  //
  static Llm fromJson(dynamic json) {
    return Llm(
      enabled: json['enabled'],
      topK: json['topK'],
      scoreThreshold: json['scoreThreshold'],
      model: json['model'],
      embeddings: json['embeddings'],
      temperature: json['temperature'],
      prompt: json['prompt'],
      apiKey: json['apiKey'],
      apiSecret: json['apiSecret'],
    );
  }

  //
  Map<String, dynamic> toJson() => <String, dynamic>{
        'enabled': enabled,
        'topK': topK,
        'scoreThreshold': scoreThreshold,
        'model': model,
        'embeddings': embeddings,
        'temperature': temperature,
        'prompt': prompt,
        'apiKey': apiKey,
        'apiSecret': apiSecret,
        'apiUrl': apiUrl,
      };

  //
  static Llm init() {
    return const Llm(
      enabled: false,
      topK: 1,
      scoreThreshold: 0.9,
      model: 'gpt-3.5',
      embeddings: 'gpt-3.5',
      temperature: 0,
      prompt: '',
      apiKey: '',
      apiSecret: '',
      apiUrl: '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
