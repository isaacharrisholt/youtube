import gleam/float
import gleam/int
import gleam/io
import gleam/list

@external(erlang, "deploy_ffi", "wait")
@external(javascript, "./deploy_ffi.mjs", "wait")
fn wait(ms: Int) -> Nil

fn is_prime(n: Int) -> Bool {
  case n {
    1 -> False
    2 | 3 -> True
    _ -> {
      let assert Ok(limit_float) = int.power(n, 0.5)
      let limit = float.truncate(limit_float)
      list.range(2, limit)
      |> list.all(fn(i) {
        // conditions are reversed because we want to know
        // when the number is NOT divisible by the current number
        case int.modulo(n, i) {
          Ok(0) -> False
          _ -> True
        }
      })
    }
  }
}

fn find_primes(n: Int) {
  case is_prime(n) {
    True -> {
      io.println(int.to_string(n))
      wait(1000)
    }
    _ -> Nil
  }
  find_primes(n + 1)
}

pub fn main() {
  find_primes(1)
}
