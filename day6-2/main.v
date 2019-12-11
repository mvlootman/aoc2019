import ( os )
const ( input_file = './input.txt' )

fn main(){
	input := read_file(input_file)
	
	orbitals := add_orbitals(input)
	steps := count_orbits(orbitals, "YOU", "SAN")
	println('answer:$steps')
}

fn count_orbits(orbitals map[string]string, from, to string) int {
	mut res := 0
	mut dist_from_starting := map[string]int
	
	from_orbital := orbitals[from]
	to_orbital := orbitals[to]
	println('from_orbital:$from_orbital to_orbital:$to_orbital')
	
	// build up distance map from starting point
	mut next := from_orbital
	for {
		if next in orbitals{
			dist_from_starting[next] = res
			res++
			next = orbitals[next]
		}
		else { break }
	}

	next = to_orbital
	res = 0
	for {
		if next in orbitals{
			// check if we cross paths with the from path (then we know the length to from at the crossing node)
			if next in  dist_from_starting{
				return res + dist_from_starting[next]
			}
			res++
			next = orbitals[next]
		}
		else { break }
	}
	return -1 // no route found
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