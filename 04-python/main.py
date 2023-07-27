class Field:
    def __init__(self, name, value):
        self.name = name
        self.value = value

def parse_field(fields, line):
    for field in line.split(' '):
        temp = field.split(':')
        fields.append(Field(temp[0], temp[1]))

def solution1(passports):
    result = 0
    c = 0
    for passport in passports:
        c += 1
        if verify1(passport):
            print(c)
            result += 1

    return result

def verify1(passport):
    required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    names = [f.name for f in passport]

    for req in required_fields:
        if not req in names:
            return False

    return True

if __name__ == "__main__":
    fields = []
    passports = []

    with open("input.txt", "r") as f:
        input = f.read().splitlines()

        for line in input:
            if len(line):
                parse_field(fields, line)
            else:
                passports.append(fields)
                fields = []
        passports.append(fields)

        print("\nSolution 1 : ", solution1(passports))
