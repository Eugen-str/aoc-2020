import re

def convert_to_bin(n, pad):
    bin_n = bin(n)[2:]
    bin_full = ""

    for i in range(pad - len(bin_n)):
        bin_full += '0'
    bin_full += bin_n

    return bin_full

def apply_mask(val, mask):
    bin_val = list(convert_to_bin(val, 36))

    for i in range(len(mask)):
        if not mask[i] == 'X':
            bin_val[i] = mask[i]

    return int(''.join(bin_val), 2)

def apply_mask2(idx, mask):
    bin_idx = list(convert_to_bin(idx, 36))

    for i in range(len(mask)):
        if not mask[i] == '0':
            bin_idx[i] = mask[i]

    return ''.join(bin_idx)

def floating_bits(idx, n):
    idx = list(idx)
    n = list(n)

    idx_n = len(n) - 1
    for i in range(len(idx)):
        if idx[i] == "X":
            idx[i] = n[idx_n]
            idx_n -= 1

    return int(''.join(idx), 2)

def solution2(memory, idx, mask, val):
    bin_idx = apply_mask2(idx, mask)

    bits = bin_idx.count('X')
    for i in range(2 ** bits):
        memory[floating_bits(bin_idx, convert_to_bin(i, bits))] = val

def solution(input):
    mask = None
    memory1 = {}
    memory2 = {}

    for line in input:
        pattern = r"mem\[(\d+)\]\s=\s(\d+)"

        match = re.search(pattern, line)
        if match:
            idx = int(match.group(1))
            val = int(match.group(2))

            memory1[idx] = apply_mask(val, mask)

            solution2(memory2, idx, mask, val)
        else:
            mask = line.split()[2]

    count1 = 0
    for v in memory1.values():
        count1 += v

    count2 = 0
    for v in memory2.values():
        count2 += v

    return count1, count2

if __name__ == "__main__":
    with open("input.txt", "r") as f:
        input = f.read().splitlines()

        result1, result2 = solution(input)

        print("\nSolution 1 :", result1)
        print("\nSolution 2 :", result2)
