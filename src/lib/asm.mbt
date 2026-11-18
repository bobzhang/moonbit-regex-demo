///|
#derive(Debug)
enum Instr {
  Char(Char)
  Match
  Jmp(Label)
  Split(Label, Label)
  Label(Label) // pseduo instruction
}

///|
struct Program(Array[Instr])

///|
impl Show for Program with fn output(self : Program, logger) -> Unit {
  // let buf = Buffer::new()
  for instr in self.0 {
    logger.write_object(Repr(instr))
    logger.write_char('\n')
  }
}

///|
#derive(Debug)
enum MachineInstr {
  MChar(Char)
  MMatch
  MJmp(Int32)
  MSplit(Int32, Int32)
}

///|
impl Show for Instr with fn output(self, logger) {
  logger.write_object(Repr(self))
}

///|
impl Show for MachineInstr with fn output(self, logger) {
  logger.write_object(Repr(self))
}
