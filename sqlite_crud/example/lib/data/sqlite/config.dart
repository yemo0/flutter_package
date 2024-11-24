class DBConfig {
  static const sqliteFile = './data.db';
  static const int version = 1;

  // db table name
  static const data = 'data';
  // db crate table
  static const createTableSqlData = '''CREATE TABLE IF NOT EXISTS $data (
uuid TEXT PRIMARY KEY,
content TEXT,
u_at TEXT,
c_at TEXT,
is_deleted INTEGER DEFAULT 0,
is_synced INTEGER DEFAULT 0
);
''';

  // db table name
  static const kvStore = 'kv_store';
  // create kv_store table
  static const createTableKVStore = '''CREATE TABLE IF NOT EXISTS $kvStore (
key TEXT PRIMARY KEY,
value TEXT
);
''';
}
