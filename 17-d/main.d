import std.stdio;
import std.file;
import std.string;
import std.conv;

struct Cell{
    int x;
    int y;
    int z;
};

struct Cell4{
    int x;
    int y;
    int z;
    int w;
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

                        foreach(e; active)
                            if(x == e){
                                found = true;
                                break;
                            }

                        if(!found)
                            foreach(in_cell; inactive)
                                if(in_cell == x){
                                    found = true;
                                    break;
                                }

                        if(!found) inactive ~= x;
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

Cell4[] get_initial_cells_4D(string[] board){
    Cell4[] cells;

    for(int i = 0; i < board.length; i++){
        for(int j = 0; j < board[i].length; j++){
            if(board[i][j] == '#'){
                Cell4 x = {j, i, 0, 0};
                cells ~= x;
            }
        }
    }
    return cells;
}

int count_neighbours_4D(Cell4 cell, Cell4[] cells){
    int result = 0;
    for(int dx = -1; dx <= 1; dx++)
        for(int dy = -1; dy <= 1; dy++)
            for(int dz = -1; dz <= 1; dz++)
                for (int dw = -1; dw <= 1; dw++){
                    if(!(dx == 0 && dy == 0 && dz == 0 && dw == 0)){
                        Cell4 x = {dx + cell.x, dy + cell.y, dz + cell.z, dw + cell.w};
                        foreach(e; cells){
                            if(x == e){
                                result++;
                            }
                        }
                    }
                }
    return result;
}

Cell4[] get_inactive_4D(Cell4[] active){
    Cell4[] inactive;
    foreach(ac_cell; active)
        for(int dx = -1; dx <= 1; dx++)
            for(int dy = -1; dy <= 1; dy++)
                for(int dz = -1; dz <= 1; dz++)
                    for(int dw = -1; dw <= 1; dw++){
                        if(!(dx == 0 && dy == 0 && dz == 0 && dw == 0)){
                            Cell4 x = {dx + ac_cell.x, dy + ac_cell.y, dz + ac_cell.z, dw + ac_cell.w};
                            bool found = false;
                            
                            foreach(e; active)
                                if(x == e){
                                    found = true;
                                    break;
                                }
                            
                            if(!found)
                                foreach(in_cell; inactive)
                                    if(in_cell == x){
                                        found = true;
                                        break;
                                    }
                            
                            if(!found) inactive ~= x;
                        }
                    }
    return inactive;
}

Cell4[] next_cycle_4D(Cell4[] active, Cell4[] inactive){
    Cell4[] next;
    foreach(cell; active){
        if(count_neighbours_4D(cell, active) == 2 || count_neighbours_4D(cell, active) == 3)
            next ~= cell;
    }
    foreach(cell; inactive){
        if(count_neighbours_4D(cell, active) == 3)
            next ~= cell;
    }
    return next;
}

ulong solution2(string[] input){
    Cell4[] start = get_initial_cells_4D(input);
    Cell4[] inactive = get_inactive_4D(start);
    Cell4[] active = next_cycle_4D(start, inactive);
    for(int i = 0; i < 5; i++){
        inactive = get_inactive_4D(active);
        active = next_cycle_4D(active, inactive);
    }
    return active.length;
}

int main(){
    string[] input;
    foreach(line; readText("input.txt").splitLines()){
        input ~= line;
    }

    writeln("Solution 1 : ", solution1(input));
    //takes a few minutes...
    writeln("Solution 2 : ", solution2(input));
    return 0;
}
