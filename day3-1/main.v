import (
	os
	math
)
const (
	input_file = './input.txt' 
	directions = { 
		'R': [ 1,  0],
		'L': [-1,  0],
		'U': [ 0,  1],
		'D': [ 0, -1]
	}
)

struct Point {
mut:
	x int
	y  int
	// distance int
}

pub fn (p Point) str() string {
	return "{$p.x,$p.y}"

}

fn main() {
	lines := read_file(input_file)	
	process(lines)
}

fn process(input[] string){

	line_a := input[0].split(',')
	line_b := input[1].split(',')


	points_a := get_points(line_a)
	points_b := get_points(line_b)

	start_point := Point{0 , 0}
	intersects := get_intersections(points_a, points_b)
	mut dist_intersects := intersects.map( dist_manhattan(start_point, it))
	println('intersects dist:$dist_intersects')
	dist_intersects.sort()
	println('answer:${dist_intersects[0]}')
}


fn get_intersections(points_a, points_b []Point) []Point {
	mut res := []Point
	for a in points_a{
		for b in points_b {
			if a.x == b.x && a.y == b.y {
				res << a
				break
			}
		}
	}

	return res
}

fn dist_manhattan(first, second Point) int{
	return int(math.abs(first.x - second.x) + math.abs(first.y - second.y))
}

fn get_points(movements []string) []Point {
	mut res := []Point

	mut point := Point{x: 0, y: 0} 
	
	//"R2", "U3", "R1", "2", "L8", "D3", "L1", "U2"
	for move in movements {
		// prev_point := point
		dir := move[0].str()
		steps := move[1..].int()
		res << points_between(point, dir, steps)
		point = res[res.len-1]
	}
	return res
}

fn points_between(start_point Point, direction string, steps int)[]Point{
	mut res := []Point
	mut point := start_point
	for _ in 0..steps{
		movement := directions[direction]
		point.x += movement[0] 
		point.y += movement[1] 
		res << point
	}
	return res
}

fn read_file(file_path string) []string {
	lines := os.read_lines(file_path) or { panic('$file_path file not found') }
        return lines
}





