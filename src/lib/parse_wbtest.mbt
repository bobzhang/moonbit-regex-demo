test {
  inspect!(
    parse?("abcd"),
    content="Ok(Seq(Seq(Seq(Seq(Empty, Char('a')), Char('b')), Char('c')), Char('d')))",
  )
  inspect!(parse?(["star", "a"]), content="Ok(Star(Seq(Empty, Char('a'))))")

  //a+b+
  inspect!(
    parse?(["seq", ["plus", "a"], ["plus", "b"]]),
    content="Ok(Seq(Plus(Seq(Empty, Char('a'))), Plus(Seq(Empty, Char('b')))))",
  )
}
