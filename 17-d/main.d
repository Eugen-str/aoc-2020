import std.stdio;
import std.file;
import std.string;
import std.conv;

struct Cell{
    int x;
    int y;
    int z;
};

Cell[] get_initial_cells(string[] board){
    Cell[] cells;

    for(int i = 0; i < board.length; i++){
        for(int j = 0; j < board[i].length; j++){
            if(board[i][j] == '#'){
                Cell x = {j, i, 0};
                cells ~= x;
            }
        }
    }
    return cells;
}

int count_neighbours(Cell cell, Cell[] cells){
    int result = 0;
    for(int dx = -1; dx <= 1; dx++)
        for(int dy = -1; dy <= 1; dy++)
            for(int dz = -1; dz <= 1; dz++){
                if(!(dx == 0 && dy == 0 && dz == 0)){
                    Cell x = {dx + cell.x, dy + cell.y, dz + cell.z};
                    foreach(e; cells){
                        if(x == e){
                            result++;
                        }
                    }
                }
            }
    return result;
}

Cell[] get_inactive(Cell[] active){
    Cell[] inactive;
    foreach(ac_cell; active)
        for(int dx = -1; dx <= 1; dx++)
            for(int dy = -1; dy <= 1; dy++)
                for(int dz = -1; dz <= 1; dz++){
                    if(!(dx == 0 && dy == 0 && dz == 0)){
                        Cell x = {dx + ac_cell.x, dy + ac_cell.y, dz + ac_cell.z};
                        bool found = false;

                        foreach(e; active){
                            if(x == e){
                                found = true;
                                break;
                            }
                        }

                        if(!found){
                            foreach(in_cell; inactive){
                                if(in_cell == x){
                                    found = true;
                                    break;
                                }
                            }
                        }

                        if(!found)
                            inactive ~= x;
                    }
                }
    return inactive;
}

Cell[] next_cycle(Cell[] active, Cell[] inactive){
    Cell[] next;
    foreach(cell; active){
        
        if(count_neighbours(cell, active) == 2 || count_neighbours(cell, active) == 3)
            next ~= cell;
    }
    foreach(cell; inactive){
        if(count_neighbours(cell, active) == 3)
            next ~= cell;
    }
    return next;
}

ulong solution1(string[] input){
    Cell[] start = get_initial_cells(input);
    Cell[] inactive = get_inactive(start);
    Cell[] active = next_cycle(start, inactive);
    for(int i = 0; i < 5; i++){
        inactive = get_inactive(active);
        active = next_cycle(active, inactive);
    }
    return active.length;
}

int main(){
    string[] input;
    foreach(line; readText("input.txt").splitLines()){
        input ~= line;
    }

    writeln("Solution 1 : ", solution1(input));
    return 0;
}
