package main

import (
	"fmt"
	"os"
	"bufio"
	"strings"
	"strconv"
)

type state struct{
	acc int
	idx int
	visited []int
}

type instruction struct{
	name string
	value int
}

func lines_to_inst(lines []string) []instruction {
	var instructions []instruction

	for _, line := range lines{
		a := strings.Split(line, " ")
		inst := a[0]
		val, _ := strconv.Atoi(a[1])

		instructions = append(instructions, instruction{name: inst, value: val})
	}

	return instructions
}

func check_visited(idxs []int) bool {
	visited := make(map[int]bool)

	if len(idxs) < 2{
		return false
	}

	for _, num := range idxs{
		if visited[num]{
			return true
		}
		visited[num] = true
	}

	return false
}

func solve(instrs []instruction) state {
	state := state{acc: 0, idx: 0, visited: []int{}}

	for !check_visited(state.visited) && state.idx < len(instrs){
		switch instrs[state.idx].name{
		case "nop":
			state.idx += 1
		case "acc":
			state.acc += instrs[state.idx].value
			state.idx += 1
		case "jmp":
			if(state.idx + instrs[state.idx].value < len(instrs)){
				state.idx += instrs[state.idx].value
			}
		}

		state.visited = append(state.visited, state.idx)
	}

	return state
}

func solution1(instrs []instruction) int {
	state := solve(instrs)

	return state.acc
}

func solution2(instrs []instruction) int {
	original := make([]instruction, len(instrs))
	copy(original[:], instrs[:])

	var nop_idx int = 0
	state := solve(instrs)

	for state.idx != len(instrs) - 1 {
		j := 0
		for i := 0; i < len(instrs); i++ {
			if(original[i].name == "jmp" && j == nop_idx){
				instrs[i].name = "nop"
				state = solve(instrs)
				break
			} else {
				j++
			}
		}
		copy(instrs[:], original[:])
		nop_idx++
	}

	return state.acc
}

func main(){
	file, err := os.Open("input.txt")

	if err != nil{
		panic(err)
	}

	var lines []string

	read := bufio.NewScanner(file)
	for read.Scan(){
		line := read.Text()
		lines = append(lines, line)
	}

	fmt.Printf("Solution 1 : %v\n", solution1(lines_to_inst(lines)))
	fmt.Printf("Solution 2 : %v\n", solution2(lines_to_inst(lines)))
}
