import ( os )
const ( input_file = './input.txt' )


fn main(){
	input := read_file(input_file)
	
	orbitals := add_orbitals(input)
	x := count_orbits(orbitals)
	println(x)
}


fn count_orbits(orbitals map[string]string) int {
	mut res := 0
	for _,v in orbitals{
		res++
		// (key)  orbits (value) COM
		// check if (value) COM orbits something else etc.
		mut s := v
		for {
			if s in orbitals{
				res++
				s = orbitals[s]
			}
			else { break }
		}
	}
	return res
} 

fn add_orbitals(orbits []string) map[string]string  {
	// map[string]string 
	// key=orbiting object value=thing e.g. key:Moon value:Earth
        mut orbital := map[string]string
	for o in orbits {
		nodes := o.split(')')
		orbital[nodes[1]] = nodes[0]
	}
	return orbital
}


fn read_file(file_path string) []string {
	lines := os.read_lines(file_path) or { panic('$file_path file not found') }
        return lines
}