// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TvSeriesHiveModelAdapter extends TypeAdapter<TvSeriesHiveModel> {
  @override
  final int typeId = 2;

  @override
  TvSeriesHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TvSeriesHiveModel(
      id: fields[0] as int,
      name: fields[1] as String,
      backdropPath: fields[2] as String?,
      genreIds: (fields[3] as List).cast<int>(),
      overview: fields[4] as String,
      voteAverage: fields[5] as double,
      firstAirDate: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TvSeriesHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.backdropPath)
      ..writeByte(3)
      ..write(obj.genreIds)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.voteAverage)
      ..writeByte(6)
      ..write(obj.firstAirDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvSeriesHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
