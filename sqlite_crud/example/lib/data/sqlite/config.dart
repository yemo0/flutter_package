class DBConfig {
  static const sqliteFile = './data.db';
  static const int version = 1;

  // db table name
  static const data = 'data';
  // db crate table
  static const createTableSqlData = '''CREATE TABLE $data (
uuid TEXT PRIMARY KEY,
content TEXT,
updated_at TEXT,
created_at TEXT,
server_updated_at TEXT,
is_deleted INTEGER DEFAULT 0,
is_synced INTEGER DEFAULT 0
);
''';

  // db table name
  static const kvStore = 'kv_store';
  // create kv_store table
  static const createTableKVStore = '''CREATE TABLE $kvStore (
key TEXT PRIMARY KEY,
value TEXT
);
''';
}
