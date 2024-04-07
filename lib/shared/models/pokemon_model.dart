import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
@CopyWith()
class PokemonModel extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'base_experience')
  final int? baseExperience;
  final int? height;
  @JsonKey(name: 'is_default')
  final bool? isDefault;
  final bool? isCaptured;
  final int? order;
  final int? weight;

  final List<PokemonAbility>? abilities;
  final List<NamedAPIResourceModel>? forms;
  @JsonKey(name: 'game_indices')
  final List<VersionGameIndex>? gameIndices;
  @JsonKey(name: 'location_area_encounters')
  final String? locationAreaEncounters;
  final List<PokemonMove>? moves;
  @JsonKey(name: 'past_types')
  final List<PokemonTypePast>? pastTypes;
  final PokemonSprites? sprites;
  final PokemonCriesModel? cries;
  final NamedAPIResourceModel? species;
  final List<PokemonStat>? stats;
  final List<PokemonTypeModel>? types;

  const PokemonModel(
    this.name,
    this.id,
    this.height,
    this.weight,
    this.types,
    this.baseExperience,
    this.order,
    this.forms,
    this.gameIndices,
    //this.heldItems,
    this.locationAreaEncounters,
    this.moves,
    this.pastTypes,
    this.sprites,
    this.cries,
    this.stats,
    this.abilities,
    this.isDefault,
    this.species,
    this.isCaptured,
  );

  @override
  List<Object?> get props => [
        name,
        id,
        baseExperience,
        height,
        isDefault,
        order,
        weight,
        abilities,
        forms,
        gameIndices,
        locationAreaEncounters,
        moves,
        pastTypes,
        sprites,
        cries,
        stats,
        species,
        isCaptured,
      ];

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
}

@JsonSerializable()
@CopyWith()
class PokemonCriesModel extends Equatable {
  final String latest;
  final String legacy;

  const PokemonCriesModel({required this.latest, required this.legacy});

  factory PokemonCriesModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonCriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonCriesModelToJson(this);

  @override
  List<Object?> get props => [latest, legacy];
}

@JsonSerializable()
@CopyWith()
class NamedAPIResourceModel extends Equatable {
  final String? name;
  final String? url;

  const NamedAPIResourceModel({required this.name, required this.url});

  factory NamedAPIResourceModel.fromJson(Map<String, dynamic> json) =>
      _$NamedAPIResourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$NamedAPIResourceModelToJson(this);

  @override
  List<Object?> get props => [name, url];
}

@JsonSerializable()
@CopyWith()
class PokemonTypeModel extends Equatable {
  final int? slot;
  final NamedAPIResourceModel? type;

  const PokemonTypeModel({required this.slot, required this.type});

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeModelToJson(this);

  @override
  List<Object?> get props => [slot, type];
}

@JsonSerializable()
@CopyWith()
class VersionGameIndex extends Equatable {
  @JsonKey(name: 'game_index')
  final int? gameIndex;
  final NamedAPIResourceModel? version;

  const VersionGameIndex({this.gameIndex, this.version});

  factory VersionGameIndex.fromJson(Map<String, dynamic> json) =>
      _$VersionGameIndexFromJson(json);

  Map<String, dynamic> toJson() => _$VersionGameIndexToJson(this);

  @override
  List<Object?> get props => [gameIndex, version];
}

@JsonSerializable()
@CopyWith()
class PokemonHeldItem extends Equatable {
  final NamedAPIResourceModel? item;
  @JsonKey(name: 'version_details')
  final PokemonHeldItemVersion? versionDetails;

  const PokemonHeldItem({this.item, this.versionDetails});

  factory PokemonHeldItem.fromJson(Map<String, dynamic> json) =>
      _$PokemonHeldItemFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonHeldItemToJson(this);

  @override
  List<Object?> get props => [versionDetails, item];
}

@JsonSerializable()
@CopyWith()
class PokemonHeldItemVersion extends Equatable {
  final NamedAPIResourceModel? version;
  final int? rarity;

  const PokemonHeldItemVersion({required this.version, required this.rarity});

  factory PokemonHeldItemVersion.fromJson(Map<String, dynamic> json) =>
      _$PokemonHeldItemVersionFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonHeldItemVersionToJson(this);

  @override
  List<Object?> get props => [version, rarity];
}

@JsonSerializable()
@CopyWith()
class PokemonMove extends Equatable {
  final NamedAPIResourceModel? move;
  @JsonKey(name: 'version_group_details')
  final List<PokemonMoveVersion>? versionGroupDetails;

  const PokemonMove({required this.move, required this.versionGroupDetails});
  factory PokemonMove.fromJson(Map<String, dynamic> json) =>
      _$PokemonMoveFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonMoveToJson(this);

  @override
  List<Object?> get props => [versionGroupDetails, move];
}

@JsonSerializable()
@CopyWith()
class PokemonMoveVersion extends Equatable {
  @JsonKey(name: 'move_learn_method')
  final NamedAPIResourceModel? moveLearnMethod;
  @JsonKey(name: 'version_group')
  final NamedAPIResourceModel? versionGroup;
  @JsonKey(name: 'level_learned_at')
  final int? levelLearnedAt;

  const PokemonMoveVersion(
      {required this.moveLearnMethod,
      required this.versionGroup,
      required this.levelLearnedAt});

  factory PokemonMoveVersion.fromJson(Map<String, dynamic> json) =>
      _$PokemonMoveVersionFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonMoveVersionToJson(this);

  @override
  List<Object?> get props => [moveLearnMethod, versionGroup, levelLearnedAt];
}

@JsonSerializable()
@CopyWith()
class PokemonSprites extends Equatable {
  @JsonKey(name: 'front_default')
  final String? frontDefault;
  @JsonKey(name: 'front_shiny')
  final String? frontShiny;
  @JsonKey(name: 'front_female')
  final String? frontFemale;
  @JsonKey(name: 'front_shiny_female')
  final String? frontShinyFemale;
  @JsonKey(name: 'back_default')
  final String? backDefault;
  @JsonKey(name: 'back_shiny')
  final String? backShiny;
  @JsonKey(name: 'back_female')
  final String? backFemale;
  @JsonKey(name: 'back_shiny_female')
  final String? backShinyFemale;
  final OtherSprites? other;

  const PokemonSprites(
      {required this.frontDefault,
      required this.frontShiny,
      required this.frontFemale,
      required this.frontShinyFemale,
      required this.backDefault,
      required this.backShiny,
      required this.backFemale,
      required this.backShinyFemale,
      required this.other});

  factory PokemonSprites.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpritesToJson(this);

  @override
  List<Object?> get props => [frontDefault, frontShiny, frontFemale, other];
}

@JsonSerializable()
@CopyWith()
class PokemonStat extends Equatable {
  final NamedAPIResourceModel? stat;
  final int? effort;
  @JsonKey(name: 'base_stat')
  final int? baseStat;

  const PokemonStat(
      {required this.stat, required this.effort, required this.baseStat});

  factory PokemonStat.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonStatToJson(this);

  @override
  List<Object?> get props => [stat, effort, baseStat];
}

@JsonSerializable()
@CopyWith()
class PokemonAbility extends Equatable {
  @JsonKey(name: 'is_hidden')
  final bool? isHidden;
  final int? slot;
  final NamedAPIResourceModel? ability;

  const PokemonAbility(
      {required this.isHidden, required this.slot, required this.ability});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonAbilityToJson(this);

  @override
  List<Object?> get props => [isHidden, slot, ability];
}

@JsonSerializable()
@CopyWith()
class PokemonTypePast extends Equatable {
  final NamedAPIResourceModel? generation;
  final List<PokemonTypeModel>? types;

  const PokemonTypePast({required this.generation, required this.types});

  factory PokemonTypePast.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypePastFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypePastToJson(this);

  @override
  List<Object?> get props => [generation, types];
}

@JsonSerializable()
@CopyWith()
class OtherSprites extends Equatable {
  @JsonKey(name: 'dream_world')
  final DreamWorldSprites? dreamWorld;
  final HomeSprites? home;
  final DreamWorldSprites? showdown;

  const OtherSprites(
      {required this.dreamWorld, required this.home, required this.showdown});

  Map<String, dynamic> toJson() => _$OtherSpritesToJson(this);
  factory OtherSprites.fromJson(Map<String, dynamic> json) =>
      _$OtherSpritesFromJson(json);

  @override
  List<Object?> get props => [dreamWorld, home, showdown];
}

@JsonSerializable()
@CopyWith()
class DreamWorldSprites extends Equatable {
  @JsonKey(name: 'front_default')
  final String? frontDefault;

  const DreamWorldSprites({required this.frontDefault});

  factory DreamWorldSprites.fromJson(Map<String, dynamic> json) =>
      _$DreamWorldSpritesFromJson(json);

  Map<String, dynamic> toJson() => _$DreamWorldSpritesToJson(this);

  @override
  List<Object?> get props => [frontDefault];
}

@JsonSerializable()
@CopyWith()
class HomeSprites extends Equatable {
  @JsonKey(name: 'front_default')
  final String? frontDefault;
  @JsonKey(name: 'front_shiny')
  final String? frontShiny;

  const HomeSprites({required this.frontDefault, required this.frontShiny});

  factory HomeSprites.fromJson(Map<String, dynamic> json) =>
      _$HomeSpritesFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSpritesToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
@CopyWith()
class FlavorTextEntry extends Equatable {
  @JsonKey(name: 'flavor_text')
  final String? flavorText;
  final Language? language;

  const FlavorTextEntry({
    this.flavorText,
    this.language,
  });

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) =>
      _$FlavorTextEntryFromJson(json);

  Map<String, dynamic> toJson() => _$FlavorTextEntryToJson(this);

  @override
  List<Object?> get props => [flavorText, language];
}

@JsonSerializable()
class Language extends Equatable {
  final String? name;
  final String? url;

  const Language({
    this.name,
    this.url,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  List<Object?> get props => [name, url];
}

@JsonSerializable()
@CopyWith()
class PokemonSpecieModel extends Equatable {
  final int id;
  final NamedAPIResourceModel? color;
  @JsonKey(name: 'egg_groups')
  final List<NamedAPIResourceModel>? eggGroups;
  @JsonKey(name: 'flavor_text_entries')
  final List<FlavorTextEntry>? flavorTextEntries;
  @JsonKey(name: 'gender_rate')
  final double? genderRate;

  const PokemonSpecieModel({
    required this.id,
    this.color,
    this.eggGroups,
    this.flavorTextEntries,
    this.genderRate,
  });

  @override
  List<Object?> get props =>
      [id, color, eggGroups, flavorTextEntries, genderRate];

  factory PokemonSpecieModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpecieModelFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonSpecieModelToJson(this);

  String? getFlavorTextInSpanish() {
    return flavorTextEntries
        ?.firstWhere(
          (entry) => entry.language!.name == 'es',
          orElse: () => const FlavorTextEntry(),
        )
        .flavorText;
  }
}
