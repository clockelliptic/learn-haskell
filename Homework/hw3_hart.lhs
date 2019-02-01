Homework 3

PROBLEM 1 - `flatten`

> flatten xss = [x | xs <- xss, x <- xs]


PROBLEM 2 - `remdups`

> remdups xs = [element | (index, element) <- zip [0..(length xs)] xs,
>               element `notElem` take index xs]

PROBLEM 3 - `scansum`

> scanSum xs = [element | (i, element) <- zip [1.. length xs] xs,
>               let element = sum (take i xs)] 

PROBLEM 4 - `group`

> headset xs = takeWhile (== head xs) xs
> tailset xs = dropWhile (== head xs) xs

> groupASSIST xs ys
>                | not (null xs) && null ys = groupASSIST (tailset xs) [headset xs]
>                | not (null xs) && not (null ys) = groupASSIST (tailset xs) (ys++[headset xs])
>                | null xs && not (null ys) = ys
>                | otherwise = [[]]
                
> group x = groupASSIST x []

PROBLEM 5 - `listDiff`

> listDiff xs ys
>        | not (null ys) = listDiff [x | x <- xs, x /= head ys] (tail ys)
>        | null ys = xs

PROBLEM 6 - RLE: `myRLE`

> zipHeads li = zipWith ($) (replicate (length li) head) li
> zipLens li = zipWith ($) (replicate (length li) length) li

> myRLE xs = [(x,y) | 
>            (x,y) <- zip (zipLens $ group xs) (zipHeads $ group xs)]