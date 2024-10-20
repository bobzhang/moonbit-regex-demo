enum Instr {
  Char(Char)
  Match
  Jmp(Label)
  Split(Label, Label)
  Label(Label) // pseduo instruction
} derive(Show)

type Program Array[Instr]

impl Show for Program with output(self : Program, logger) -> Unit {
  // let buf = Buffer::new()
  for instr in self._ {
    logger.write_object(instr)
    logger.write_char('\n')
  }
}

enum MachineInstr {
  MChar(Char)
  MMatch
  MJmp(Int)
  MSplit(Int, Int)
} derive(Show)
