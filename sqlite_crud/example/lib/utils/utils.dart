isEmpty<T>(T param, Function(T) predicate, onTure, onFalse) {
  if (predicate(param)) {
    return onTure;
  }
  return onFalse;
}