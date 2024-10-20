pub fn eval_from_json(x : Json, s : String) -> Bool! {
  let r = parse!(x)
  let p = compile(r)
  let state = { ..State::default(), data: s }
  // interpret(state, s)
  interpret(state, assemble(p))
}

test {
  let regex : Json = ["seq", ["plus", "a"], ["plus", "b"]]
  let r = parse!(regex)
  let p = compile(r)
  let i = assemble(p)
  inspect!(
    i,
    content=
      #|0 : MChar('a')
      #|1 : MSplit(0, 2)
      #|2 : MChar('b')
      #|3 : MSplit(2, 4)
      #|4 : MMatch
      #|
    ,
  )
  let state = { ..State::default(), data: "ab" }
  let result = interpret(state, assemble(p))
  inspect!(result, content="true")
}
