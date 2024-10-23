import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';

part 'character_rest_client.freezed.dart';
part 'character_rest_client.g.dart';

@RestApi(baseUrl: 'https://rickandmortyapi.com/api/')
abstract class CharacterRestClient {
  factory CharacterRestClient(Dio dio, {String baseUrl}) = _CharacterRestClient;

  @GET('character')
  Future<CharacterResponseModel> getCharacters(@Query('page') int page);

  @GET('character/{id}')
  Future<Character> getCharacterById(@Path('id') int id);
}

@freezed
class CharacterResponseModel with _$CharacterResponseModel {
  const factory CharacterResponseModel({
    required Info info,
    required List<Character> results,
  }) = _CharacterResponseModel;

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) => _$CharacterResponseModelFromJson(json);
}

@freezed
class Info with _$Info {
  const factory Info({
    required int count,
    required int pages,
    required String? next,
    required String? prev,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}
