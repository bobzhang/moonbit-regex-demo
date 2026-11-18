///|
fn compile_json(x : Json) -> MProgram raise {
  let r = parse(x)
  assemble(compile(r))
}

///|
test {
  inspect(
    (Ok(compile_json(["seq", ["plus", "a"], ["plus", "b"]])) catch {
      error => Err(error)
    }).unwrap(),
    content=(
      #|0 : MChar('a')
      #|1 : MSplit(0, 2)
      #|2 : MChar('b')
      #|3 : MSplit(2, 4)
      #|4 : MMatch
      #|
    ),
  )
}
