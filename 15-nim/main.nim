import std/tables

var
  #sample = @[0,3,6]
  input = @[6,3,15,13,1,0]

proc get_recent_nums(list: seq[int]): seq[tuple[num: int, idx: int]] =
    result = @[]

    let x = list[len(list) - 1]

    for i in countdown(list.len - 1, 0):
      if list[i] == x:
        result.add((num: list[i], idx: i))
        if len(result) == 2:
          break

proc next_number(list: var seq[int]) =
  let next = get_recent_nums(list)

  if len(next) == 2:
    list.add(next[0].idx - next[1].idx)
  else:
    list.add(0)

proc slow_solution(list: var seq[int], n: int): int =
  for i in 0..(n - len(list) - 1):
    next_number(list)

  return list[len(list) - 1]

#
#
#  Slow solution took way too long for part two,
#  new function takes ~10,688s.
#
#

proc fast_solution(list: var seq[int], n: int): int =
  var nums = initTable[int, int]()
  var next, prev: int

  for i in 0..<n:
    if i < len(list):
      next = list[i]
    else:
      if prev in nums:
        next = i - nums[prev]
      else:
        next = 0

    if i != 0:
      nums[prev] = i

    prev = next

  return prev

proc main() =
  echo "Solution 1 : ", fast_solution(input, 2020)
  echo "Solution 2 : ", fast_solution(input, 30_000_000)

main()
