fn main() {
	mut pwd_count := 0
	for n in 124075..580769 {
		if has_adjacent_twins(n) &&  has_decreasing_digits(n) {
			pwd_count++
		}
	}
	println(pwd_count)
}


fn has_decreasing_digits(number int) bool {
	mut prev_digit := 0
	for b in number.str(){
		digit := b.str().int() 
		if digit >= prev_digit {
			prev_digit = digit		
		} else {
			return false
		}
	}
	return true
}

// fn is_in_range(number int) bool {
// 	return  number > 124075 && number < 580769
// }

fn has_adjacent_twins(number int) bool {
	s := number.str()
	return  s[0] == s[1]  ||
		s[1] == s[2]  ||
		s[2] == s[3]  ||
		s[3] == s[4]  ||
		s[4] == s[5] 		
}