import ( os )
const ( input_file = './input.txt' )

struct Op {
mut:
	op_code 	int
	arg1 		int
	arg2 		int
	write_pos 	int
}

fn main() {
	input := read_file(input_file)	
	process(input)
}

fn process(input string){
	items := input.split(',')
	mut opcodes := items.map(it.int())

	// preprocess instructions
	// replace position 1 with the value 12 and replace position 2 with the value 2
	opcodes[1] = 12 
	opcodes[2] = 2 
		
	for i :=0; i < opcodes.len; i+=4{
		mut op := Op{}
		op_code := int(opcodes[i])

		match op_code {
			1,2 { 
				op.op_code = op_code
				op.arg1 = int(opcodes[i+1]) 
				op.arg2 = int(opcodes[i+2]) 
				op.write_pos = int(opcodes[i+3]) 
			}
			99 {
				op.op_code = op_code
			}
			else { continue }
		}
		
		match op.op_code {
			1 { handle(mut opcodes, add_op, opcodes[op.arg1], opcodes[op.arg2], op.write_pos) }
			2 { handle(mut opcodes, multiply_op, opcodes[op.arg1], opcodes[op.arg2], op.write_pos) }
			99 { break}
		}
	 }

	 println('answer:${opcodes[0]}')
}

fn add_op(a,b int) int {
	return a + b
}

fn multiply_op(a,b int) int {
	return a * b
}

fn handle(opcodes mut []int, op fn(a,b int)int, arg1, arg2, write_pos int){
	result := op(arg1, arg2)
	opcodes[write_pos] = result
}

fn read_file(file_path string) string {
	lines := os.read_lines(file_path) or { panic('$file_path file not found') }
        return lines[0]
}