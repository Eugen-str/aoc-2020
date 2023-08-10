var
  sample = @[0,3,6]
  input = @[6,3,15,13,1,0]

proc get_recent_nums(list: seq[int]): seq[tuple[num: int, idx: int]] =
    result = @[]

    let x = list[len(list) - 1]

    for num in countdown(list.len - 1, 0):
      if list[num] == x:
        result.add((num: list[num], idx: num))
      if len(result) == 2:
        break

proc next_number(list: var seq[int]) =
  let next = get_recent_nums(list)

  case len(next):
    of 1:
      list.add(0)
    of 2:
      list.add(next[0].idx - next[1].idx)
    else:
      echo "Error!!!"

proc solution(list: var seq[int], n: int): int =
  for i in 0..(n - len(list) - 1):
    next_number(list)

  return list[len(list) - 1]

proc main() =
  echo "Solution 1 : ", solution(input, 2020)
  # Solution 2 technically should work, but takes really long to execute using this method.
  echo "Solution 2 : ", solution(input, 30_000_000)

main()
