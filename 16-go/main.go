package main

import(
	"fmt"
	"io/ioutil"
	"strings"
	"regexp"
	"strconv"
)

type Rule struct{
	name string
	valid_range Range
}

type Range struct{
	x1 int
	y1 int
	x2 int
	y2 int
}

func parse_file(path string) []string {
	data, err := ioutil.ReadFile(path)

	if err != nil{
		panic(err)
	}

	return strings.Split(string(data[:]), "\n\n")
}

func parse_rules(input string) []Rule {
	var rules []Rule
	r := regexp.MustCompile(`(.+): (\d+)-(\d+) or (\d+)-(\d+)`)
	matches := r.FindAllStringSubmatch(input, -1)

	for _, match := range matches{
		name := match[1]
		x1, _ := strconv.Atoi(match[2])
		y1, _ := strconv.Atoi(match[3])
		x2, _ := strconv.Atoi(match[4])
		y2, _ := strconv.Atoi(match[5])
		rules = append(rules, Rule{name, Range{x1, y1, x2, y2}})
	}

	return rules
}

func parse_tickets(tickets string) []int {
	var values []int

	fields := strings.Split(tickets, ":")

	for _, group := range strings.Split(fields[1], ","){
		for _, elem := range strings.Split(group, "\n"){
			if elem != "" {
				num, _ := strconv.Atoi(elem)
				values = append(values, num)
			}
		}
	}

	return values
}

func get_sum_invalid(rules []Rule, values []int) int {
	count := 0

	for _, n := range values{
		check := false
		for _, r := range rules{
			if !(n < r.valid_range.x1 || n > r.valid_range.y1 && n < r.valid_range.x2 || n > r.valid_range.y2){
				check = true
			}
		}
		if !check{ count += n }
	}

	return count
}

func parse_valid_tickets(rules []Rule, input string) [][]int {
	var matrix [][]int

	lines := strings.Split(strings.TrimSpace(input), "\n")
	for _, line := range lines {
		var row []int
		values := strings.Split(strings.TrimSpace(line), ",")
		for _, num := range values {
			value, _ := strconv.Atoi(num)
			row = append(row, value)
		}
		matrix = append(matrix, row)
	}

	var final [][]int
	for _, i := range matrix[1:]{
		if get_sum_invalid(rules, i) == 0{
			final = append(final, i)
		}
	}
	return final
}

func solution1(input []string) int {
	rules := parse_rules(input[0])
	values := parse_tickets(input[2])

	return get_sum_invalid(rules, values)
}

func main(){
	input := parse_file("input.txt")

	fmt.Printf("\nSolution 1 : %d", solution1(input))
	//fmt.Printf("\nSolution 2 : %d", solution2(input))
}
