import gleam/list
import gleam/string
import token

pub fn scan_tokens(source: String) -> List(token.Token) {
  scan_tokens_helper(source, 0, []) |> list.reverse
}

fn scan_tokens_helper(
  source: String,
  current: Int,
  tokens: List(token.Token),
) -> List(token.Token) {
  case current >= source |> string.length {
    True -> [token.Token(token.Eof, "", "", 1), ..tokens]
    False -> todo
  }
}
