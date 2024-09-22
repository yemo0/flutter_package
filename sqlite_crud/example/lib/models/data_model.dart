import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqlite_crud/sqlite_crud.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class DataModel with _$DataModel implements SqliteSyncModel<DataModel> {
  const DataModel._();
  const factory DataModel({
    @JsonKey(includeIfNull: false) String? uuid,
    @JsonKey(includeIfNull: false) String? content,
    @JsonKey(includeIfNull: false, name: 'updated_at') DateTime? updatedAt,
    @JsonKey(includeIfNull: false, name: 'created_at') DateTime? createdAt,
    @JsonKey(includeIfNull: false, name: 'server_updated_at') DateTime? serverUpdatedAt,
    @JsonKey(includeIfNull: false, name: 'is_deleted') bool? isDeleted,
    @JsonKey(includeIfNull: false, name: 'is_synced') bool? isSynced,
  }) = _DataModel;

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);

  @override
  DataModel fromJson(Map<String, dynamic> json) {
    return DataModel.fromJson(json);
  }
}
