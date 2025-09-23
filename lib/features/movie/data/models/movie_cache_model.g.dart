// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_cache_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieCacheModelAdapter extends TypeAdapter<MovieCacheModel> {
  @override
  final int typeId = 1;

  @override
  MovieCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieCacheModel(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      poster: fields[3] as String?,
      rate: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieCacheModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.poster)
      ..writeByte(4)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
