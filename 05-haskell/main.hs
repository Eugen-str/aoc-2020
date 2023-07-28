module Main where
import Text.Printf
import Control.Monad (mapM_)
import Data.List (sort)

to_bin :: String -> [Int]
to_bin "" = []
to_bin (x:xs) = if x == 'F' || x == 'L' then 0 : to_bin xs else 1 : to_bin xs

bin_to_dec :: [Int] -> Int
bin_to_dec = foldl (\acc bit -> acc*2 + bit) 0

seat_id :: Int -> Int -> Int
seat_id row col = row * 8 + col

parse_input :: String -> (Int, Int)
parse_input str = (row, col)
  where
    (rowStr, colStr) = splitAt 7 str
    row = bin_to_dec $ to_bin rowStr
    col = bin_to_dec $ to_bin colStr

solution2 :: [Int] -> Int
solution2 [] = -1
solution2 (x:y:xs)
  | x + 1 /= y = x + 1
  | otherwise = solution2 (y:xs)

main :: IO()
main = do
  inputLines <- lines <$> readFile "input.txt"
  let all_ids = map (uncurry seat_id . parse_input) inputLines
  printf "Solution 1 : %d\n" $ maximum all_ids
  printf "Solution 2 : %d\n" $ solution2 $ sort all_ids
