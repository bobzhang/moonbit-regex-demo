fn collect_labels(p : Program) -> Map[Label, Int] {
  let labels = {}
  let mut i = 0
  for instr in p._ {
    match instr {
      Label(l) => labels[l] = i
      _ => i += 1
    }
  }
  labels
}

type MProgram Array[MachineInstr]

impl Show for MProgram with output(self, logger) {
  for i, instr in self._ {
    logger.write_string("\{i} : ")
    logger.write_object(instr)
    logger.write_char('\n')
  }
}

pub fn assemble(p : Program) -> MProgram {
  let labels = collect_labels(p)
  let instrs = []
  for instr in p._ {
    match instr {
      Char(c) => instrs.push(MChar(c))
      Match => instrs.push(MMatch)
      Jmp(l) => instrs.push(MJmp(labels[l].unwrap()))
      Split(l1, l2) =>
        instrs.push(MSplit(labels[l1].unwrap(), labels[l2].unwrap()))
      Label(_l) => ()
    }
  }
  instrs
}
