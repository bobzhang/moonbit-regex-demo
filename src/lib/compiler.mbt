fn compile_aux(regex : Regex) -> Array[Instr] {
  match regex {
    Empty => []
    Seq(r1, r2) => [..compile_aux(r1), ..compile_aux(r2)]
    Alt(r1, r2) => {
      let l1 = gen_label()
      let l2 = gen_label()
      let l3 = gen_label()
      [
        Split(l1, l2),
        Label(l1),
        ..compile_aux(r1),
        Jmp(l3),
        Label(l2),
        ..compile_aux(r2),
        Label(l3),
      ]
    }
    Opt(r) => {
      // r?
      // no loop involved
      let l1 = gen_label()
      let l2 = gen_label()
      [Split(l1, l2), Label(l1), ..compile_aux(r), Label(l2)]
    }
    Star(r) => {
      // r *  
      let l1 = gen_label()
      let l2 = gen_label()
      let l3 = gen_label()
      [
        Label(l1),
        Split(l2, l3),
        Label(l2),
        ..compile_aux(r),
        Jmp(l1),
        Label(l3),
      ]
    }
    Plus(r) => {
      // r+   
      let l1 = gen_label()
      let l3 = gen_label()
      [Label(l1), ..compile_aux(r), Split(l1, l3), Label(l3)]
    }
    Char(c) => [Char(c)]
  }
}

pub fn compile(regex : Regex) -> Program {
  [..compile_aux(regex), Match]
}
