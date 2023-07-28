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
    for passport in passports:
        if verify1(passport):
            result += 1

    return result

def verify1(passport):
    required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    names = [f.name for f in passport]

    for req in required_fields:
        if not req in names:
            return False

    return True

def solution2(passports):
    result = 0
    for passport in passports:
        if verify1(passport) and verify2(passport):
            result += 1

    return result

def verify2(passport):
    field_verify = {
        "byr": verify_byr,
        "iyr": verify_iyr,
        "eyr": verify_eyr,
        "hgt": verify_hgt,
        "hcl": verify_hcl,
        "ecl": verify_ecl,
        "pid": verify_pid,
        "cid": verify_cid
    }

    for field in passport:
        if not field_verify[field.name](field.value):
            return False

    return True

def verify_byr(value):
    return 1920 <= int(value) <= 2002

def verify_iyr(value):
    return 2010 <= int(value) <= 2020

def verify_eyr(value):
    return 2020 <= int(value) <= 2030

def verify_hgt(value):
    if "cm" in value:
        return 150 <= int(value.replace("cm", "")) <= 193
    else:
        return 59 <= int(value.replace("in", "")) <= 76

def verify_hcl(value):
    if not value[0] == '#' or not len(value) == 7:
        return False

    allowed = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
               'a', 'b', 'c', 'd', 'e', 'f']

    for i in range(1, 5):
        if value[i] not in allowed:
            return False

    return True

def verify_ecl(value):
    allowed = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    if not value in allowed:
        return False

    return True

def verify_pid(value):
    if not len(value) == 9:
        return False

    for i in range(0, 9):
        if not value[i].isdigit():
            return False

    return True

def verify_cid(value):
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

        print("\nSolution 1 :", solution1(passports))
        print("\nSolution 2 :", solution2(passports))
