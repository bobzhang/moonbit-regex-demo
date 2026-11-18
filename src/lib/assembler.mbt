///|
fn collect_labels(p : Program) -> Map[Label, Int32] {
  let labels : Map[Label, Int32] = {}
  let mut i = 0
  for instr in p.0 {
    match instr {
      Label(l) => labels[l] = i
      _ => i += 1
    }
  }
  labels
}

///|
struct MProgram(Array[MachineInstr])

///|
impl Show for MProgram with fn output(self, logger) {
  for i, instr in self.0 {
    logger.write_string("\{i} : ")
    logger.write_object(Repr(instr))
    logger.write_char('\n')
  }
}

///|
pub fn assemble(p : Program) -> MProgram {
  let labels = collect_labels(p)
  let instrs = []
  for instr in p.0 {
    match instr {
      Char(c) => instrs.push(MChar(c))
      Match => instrs.push(MMatch)
      Jmp(l) => instrs.push(MJmp(labels[l]))
      Split(l1, l2) => instrs.push(MSplit(labels[l1], labels[l2]))
      Label(_l) => ()
    }
  }
  MProgram(instrs)
}
