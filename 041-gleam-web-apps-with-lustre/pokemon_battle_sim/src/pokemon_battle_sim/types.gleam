pub type CanLoad(value, error) {
  Loading
  Loaded(value)
  LoadError(error)
}
