///|
#derive(Debug)
enum Regex {
  Seq(Regex, Regex)
  Alt(Regex, Regex)
  Star(Regex) // e*
  Plus(Regex) // e+
  Opt(Regex) // e?
  Char(Char)
  Empty // matches empty string
}

///|
#derive(Eq, Hash, Debug)
struct Label(String)

///|
let label_counter : Ref[Int32] = { val: 0, }

///|
fn gen_label() -> Label {
  label_counter.val += 1
  Label("__label\{label_counter.val}")
}

///|
pub fn reset_label_counter() -> Unit {
  label_counter.val = 0
}

///|
impl Show for Regex with fn output(self, logger) {
  logger.write_object(Repr(self))
}

///|
impl Show for Label with fn output(self, logger) {
  logger.write_object(Repr(self))
}
