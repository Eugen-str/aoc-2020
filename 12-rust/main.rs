use std::fs;

struct Ferry{
    position: (i32, i32),
    angle: i32,
}

fn solution1(input: &String) -> i32{
    let mut ferry = Ferry{
        position: (0, 0),
        angle: 0
    };

    for line in input.lines(){
        let command = line.chars().nth(0).expect("Error!");
        let value: i32 = line[1..].parse::<i32>().unwrap();

        match command{
            'N' => ferry.position.0 += value,
            'S' => ferry.position.0 -= value,
            'E' => ferry.position.1 += value,
            'W' => ferry.position.1 -= value,
            'L' => ferry.angle -= value,
            'R' => ferry.angle += value,
            'F' => {
                let ac_angle = (360 - &ferry.angle).abs() % 360;
                match ac_angle{
                    90 => ferry.position.0 += value,
                    270 => ferry.position.0 -= value,
                    0 => ferry.position.1 += value,
                    180 => ferry.position.1 -= value,
                    _ => panic!(),
                }
            }
            _ => panic!(),
        }
    }

    return (ferry.position.0).abs() + (ferry.position.1).abs();
}

fn main(){
    let input =
        fs::read_to_string("input.txt")
        .unwrap();

    println!("Solution 1 : {}", solution1(&input));
}
