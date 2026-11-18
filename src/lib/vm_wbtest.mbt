///|
pub fn eval_from_json(x : Json, s : String) -> Bool raise {
  let r = parse(x)
  let p = compile(r)
  let state = { ..(Default::default() : State), data: s, }
  // interpret(state, s)
  interpret(state, assemble(p))
}

///|
test {
  let regex : Json = ["seq", ["plus", "a"], ["plus", "b"]]
  let r = parse(regex)
  let p = compile(r)
  let i = assemble(p)
  inspect(
    i,
    content=(
      #|0 : MChar('a')
      #|1 : MSplit(0, 2)
      #|2 : MChar('b')
      #|3 : MSplit(2, 4)
      #|4 : MMatch
      #|
    ),
  )
  let state = { ..(Default::default() : State), data: "ab", }
  let result = interpret(state, assemble(p))
  inspect(result, content="true")
}

///|
test "match supplementary Unicode characters" {
  assert_true(eval_from_json("😀a", "😀abc"))
  assert_false(eval_from_json("😀a", "😀b"))
}
