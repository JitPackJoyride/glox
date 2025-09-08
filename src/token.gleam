pub type Token {
  Token(token_type: TokenType, lexeme: String, literal: String, line: Int)
}

pub type TokenType {
  // Single-character tokens
  LeftParen
  RightParen
  LeftBrace
  RightBrace
  Comma
  Dot
  Minus
  Plus
  Semicolon
  Slash
  Star
  // One or two character tokens
  Bang
  BangEqual
  Equal
  EqualEqual
  Greater
  GreaterEqual
  Less
  LessEqual
  // Literals
  Identifier
  String
  Number
  // Keywords
  And
  Class
  Else
  False
  Fun
  For
  If
  Nil
  Or
  Print
  Return
  Super
  This
  True
  Var
  While
  Eof
}

pub fn to_string(token: Token) {
  token_type_to_string(token.token_type)
  <> " "
  <> token.lexeme
  <> " "
  <> token.literal
}

// Helpers

fn token_type_to_string(token_type: TokenType) {
  case token_type {
    LeftParen -> "LeftParen"
    RightParen -> "RightParen"
    LeftBrace -> "LeftBrace"
    RightBrace -> "RightBrace"
    Comma -> "Comma"
    Dot -> "Dot"
    Minus -> "Minus"
    Plus -> "Plus"
    Semicolon -> "Semicolon"
    Slash -> "Slash"
    Star -> "Star"
    Bang -> "Bang"
    BangEqual -> "BangEqual"
    Equal -> "Equal"
    EqualEqual -> "EqualEqual"
    Greater -> "Greater"
    GreaterEqual -> "GreaterEqual"
    Less -> "Less"
    LessEqual -> "LessEqual"
    Identifier -> "Identifier"
    String -> "String"
    Number -> "Number"
    And -> "And"
    Class -> "Class"
    Else -> "Else"
    False -> "False"
    Fun -> "Fun"
    For -> "For"
    If -> "If"
    Nil -> "Nil"
    Or -> "Or"
    Print -> "Print"
    Return -> "Return"
    Super -> "Super"
    This -> "This"
    True -> "True"
    Var -> "Var"
    While -> "While"
    Eof -> "Eof"
  }
}
