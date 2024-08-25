// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataModelImpl _$$DataModelImplFromJson(Map<String, dynamic> json) =>
    _$DataModelImpl(
      uuid: json['uuid'] as String?,
      content: json['content'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      serverUpdatedAt: json['server_updated_at'] == null
          ? null
          : DateTime.parse(json['server_updated_at'] as String),
      isDeleted: json['is_deleted'] as bool?,
      isSynced: json['is_synced'] as bool?,
    );

Map<String, dynamic> _$$DataModelImplToJson(_$DataModelImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'content': instance.content,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'server_updated_at': instance.serverUpdatedAt?.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'is_synced': instance.isSynced,
    };
