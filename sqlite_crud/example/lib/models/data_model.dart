// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqlite_crud/sqlite_crud.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class DataModel with _$DataModel implements SqliteSyncModel<DataModel> {
  const DataModel._();
  const factory DataModel({
    String? content,
    String? uuid,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'server_updated_at') DateTime? serverUpdatedAt,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
    @JsonKey(name: 'is_synced') bool? isSynced,
  }) = _DataModel;

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);

  @override
  DataModel fromJson(Map<String, dynamic> json) {
    return DataModel.fromJson(json);
  }
}
