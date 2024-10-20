enum Regex {
  Seq(Regex, Regex)
  Alt(Regex, Regex)
  Star(Regex) // e*
  Plus(Regex) // e+
  Opt(Regex) // e?
  Char(Char)
  Empty // matches empty string
} derive(Show)

type Label String derive(Eq, Hash, Show)

let label_counter : Ref[Int] = { val: 0 }

fn gen_label() -> Label {
  label_counter.val += 1
  Label("__label\{label_counter.val}")
}

pub fn reset_label_counter() -> Unit {
  label_counter.val = 0
}
