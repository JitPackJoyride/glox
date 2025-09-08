import argv
import gleam/int
import gleam/io
import gleam/list
import input/input.{input}
import scanner
import simplifile
import token

pub type LoxError {
  SyntaxError(line: Int, where: String, message: String)
  RunFileError(path: String, error: simplifile.FileError)
  RunReplError
}

pub fn main() {
  case argv.load().arguments {
    [path] -> {
      case run_file(path) {
        Ok(_) -> Ok(Nil)
        Error(val) -> panic as report(val)
      }
    }
    [_, ..] -> io.println("Usage: gleam run [script]") |> Ok
    _ -> {
      case run_prompt() {
        Ok(_) -> Ok(Nil)
        Error(val) -> panic as report(val)
      }
    }
  }
}

fn run_file(path: String) -> Result(Nil, LoxError) {
  case simplifile.read(path) {
    Ok(source) -> run(source)
    Error(error) -> Error(RunFileError(path, error))
  }
}

fn run_prompt() -> Result(Nil, LoxError) {
  case input("> ") {
    Ok("") -> Ok(Nil)
    Ok(prompt) -> {
      case run(prompt) {
        Ok(_) -> run_prompt()
        Error(val) -> {
          case val {
            SyntaxError(_, _, _) -> {
              report(val) |> io.println
              run_prompt()
            }
            _ -> Error(val)
          }
        }
      }
    }
    _ -> Error(RunReplError)
  }
}

fn run(source: String) -> Result(Nil, LoxError) {
  scanner.scan_tokens(source)
  |> list.each(fn(token) { token.to_string(token) |> io.println })
  Ok(Nil)
}

fn report(error: LoxError) -> String {
  case error {
    SyntaxError(line, where, message) ->
      "SyntaxError:\n[line "
      <> int.to_string(line)
      <> "] Error "
      <> where
      <> ": "
      <> message
    RunFileError(path, error) ->
      simplifile.describe_error(error)
      |> fn(error: String) {
        "RunFileError:\nUnable to read '" <> path <> "': " <> error
      }
    RunReplError -> "RunReplError:\nUnable to read REPL input"
  }
}
