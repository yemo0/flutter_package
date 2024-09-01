# sqlite_crud
A fast sqlite CRUD package, based on sqflite

## Getting Started 
import `sqlite_crud`

### Initialize the database
```dart
  await SqliteDBConn().init("demo.db", [DBConfig.createTableSqlData]);
  // demo.db -> String dbPathName,
  // DBConfig.createTableSqlData -> List<String> createTableSql
```

### CRUD
model `user_model.dart` using `freezed`
**Must implement the SqliteCRUDModel class**
```dart
@freezed
class UserModel with _$UserModel implements SqliteCRUDModel {
  const UserModel._();
  const factory UserModel({ String? name, int? age}) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  @override
  SqliteCRUDModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
```

```dart
// insert 
SqliteCRUD.insert("users",  UserModel(name: name.text, age: int.parse(age.text)));
// update
SqliteCRUD.updateByID("users",  UserModel(age: int.parse(age.text)), int.parse(id.text));
// delete
SqliteCRUD.deleteByID("users", 1);
// query
SqliteCRUD.query("users", const UserModel(), where: "id = 1", limit: 1, ....);
```

## Sync
model `user_model.dart` using `freezed`
**Must implement the SqliteSyncModel class**
```dart
SqliteSyncData<UserModel>.syncLastTime()
SqliteSyncData<UserModel>.syncUpdate()
```