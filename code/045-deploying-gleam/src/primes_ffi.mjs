export function wait(ms) {
  const start = Date.now();
  while (Date.now() - start < ms) {
    // Do nothing
  }
}
