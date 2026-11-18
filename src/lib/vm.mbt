///|
#derive(Default)
struct State {
  pc : Int32 // program counter
  sp : Int32 // string pointer
  data : String
}

///|
pub fn interpret(state : State, instr : MProgram) -> Bool {
  fn recursive(pc, sp) {
    // if state  
    match instr.0[pc] {
      MChar(c) => {
        if sp >= state.data.length() || state.data.get_char(sp) != Some(c) {
          return false
        }
        recursive(pc + 1, sp + c.utf16_len())
      }
      MMatch => return true
      MJmp(l) => recursive(l, sp)
      MSplit(l1, l2) => recursive(l1, sp) || recursive(l2, sp)
    }
  }

  recursive(state.pc, state.sp)
}
