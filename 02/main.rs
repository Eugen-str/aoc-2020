use std::fs;

#[derive(Debug)]
struct Policy{
    range: (u32, u32),
    letter: char,
    password: String,
}

fn logic_xor(a: bool, b: bool) -> bool{
    (a || b) && !(a && b)
}

#[allow(dead_code)]
impl Policy{
    fn new(line: &str) -> Option<Policy>{
        let parts: Vec<&str> = line
            .split(|x| x == ' ' || x == ':')
            .collect();

        let range: Vec<u32> = parts[0]
            .split('-')
            .filter_map(|n| n.parse::<u32>().ok())
            .collect();

        Some(Policy{
            range: (range[0], range[1]),
            letter: parts[1].chars().next()?,
            password: parts[3].to_string()
        })
    }

    fn solution1(self) -> bool{
        let len: u32 = self.password
            .chars()
            .filter(|&c| c == self.letter)
            .collect::<String>()
            .len() as u32;

        let (min, max) = self.range;
        min <= len && len <= max
    }

    fn solution2(self) -> bool{
        //bad rust code probably lol
        let chars: Vec<char> = self.password.chars().collect();

        let (idx1, idx2) = self.range;

        logic_xor(&chars[(idx1 - 1) as usize] == &self.letter,
                  &chars[(idx2 - 1) as usize] == &self.letter)
    }
}

fn main(){
    let path = "input.txt";
    let input =
        fs::read_to_string(path)
        .unwrap();

    let mut result: u32 = 0;
    for line in input.lines(){
        if let Some(p) = Policy::new(line){
            if p.solution2(){
                result += 1;
            }
        }
    }
    println!("{}", result);
}
