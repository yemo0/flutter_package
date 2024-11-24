// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataModelImpl _$$DataModelImplFromJson(Map<String, dynamic> json) =>
    _$DataModelImpl(
      content: json['content'] as String?,
      uuid: json['uuid'] as String?,
      updatedAt:
          json['u_at'] == null ? null : DateTime.parse(json['u_at'] as String),
      createdAt:
          json['c_at'] == null ? null : DateTime.parse(json['c_at'] as String),
      isDeleted: json['is_deleted'] as bool?,
      isSynced: json['is_synced'] as bool?,
    );

Map<String, dynamic> _$$DataModelImplToJson(_$DataModelImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'uuid': instance.uuid,
      'u_at': instance.updatedAt?.toIso8601String(),
      'c_at': instance.createdAt?.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'is_synced': instance.isSynced,
    };
