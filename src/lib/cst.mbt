// cst is json
// "a" -> Char('a')
// "ab" -> Seq(Char('a'), Char('b'))
// ['or', "a", "b"] -> Alt(Char('a'), Char('b'))
// ['seq', "a", ['star', "b"]] -> Seq(Char('a'), Star(Char('b')))
// ['star', "ab*"] -> Star(Seq(Char('a'), Star(Char('b'))))
// ['plus', "ab+"] -> Plus(Seq(Char('a'), Char('b')))
// ['opt', "ab?"] -> Opt(Seq(Char('a'), Char('b')))

fn parse(cst : Json) -> Regex! {
  match cst {
    String(s) => {
      // TODO: reduce the Empty usage  
      let mut acc = Empty
      for i in s {
        acc = Seq(acc, Char(i))
      }
      acc
    }
    ["or", a, b] => Alt(parse!(a), parse!(b))
    ["seq", a, b] => Seq(parse!(a), parse!(b))
    ["star", a] => Star(parse!(a))
    ["plus", a] => Plus(parse!(a))
    ["opt", a] => Opt(parse!(a))
    _ => fail!("invalid cst \{cst}")
  }
}
