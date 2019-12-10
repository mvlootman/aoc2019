import ( os )
const ( input_file = './input.txt' )

fn main() {
	masses := read_file(input_file)	
	calc_fuel(masses)
}

fn calc_fuel(masses []string){
	total_fuel := masses.map(calc_total_fuel(it.int())).reduce(sum, 0)
	println('total_fuel:$total_fuel')
}

// calc_total_fuel calculates the fuel required for the mass including the fuel required for the extra weight of the extra fuel
fn calc_total_fuel(mass int) int {
	mut total_fuel := mass
	mut xf := mass
	for {
		xf = fuel_for_mass(xf)
		if xf > 0 { total_fuel += xf } else { break }
	}
	return total_fuel
}

fn fuel_for_mass(mass int) int {
	return ( mass / 3) - 2
}

fn sum(prev int, curr int) int {
	return prev + curr
}

fn read_file(file_path string) []string {
	lines := os.read_lines(file_path) or { panic('$file_path file not found') }
        return lines
}