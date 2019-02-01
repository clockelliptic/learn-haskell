
1)  Determine the types of "3", "even", and "even 3". How do you
     determine the last one?
    
    Now, determine the types of "head", "[1,2,3]", and "head [1,2,3]". What
     happens when applying a polymorphic function to an actual parameter?
     (hint, use the :t top level command of the Hugs interpreter).

MY ANSWERS:
'3'             has the type: 'Num'
'even'          has the type: 'Integral'
'even 3'        has the type: 'Bool'
'head'          has the type: '[a] -> a'
'[1,2,3]        has the type: 'Num a => [a]'
'head [1,2,3]   has the type: 'Num a => a'

2) For each type, write a function with that type.
     a)   (Float -> Float) -> Float
     b)   Float -> (Float -> Float)
     c)   (Float -> Float) -> (Float -> Float)
      
    I'm comletely stumpe don all of these.

3) Write the ncopies function. For example:
     ncopies 3 5     --> [5,5,5]
     ncopies 0 True  --> []
     ncopies 2 False --> [False, False]
     ncopies 4 "a"   --> ["a","a","a","a"]
  
  Well, there's already a function that does this. It's called `replicate`.

> ncopies a b = take a (repeat b)

> ncopies_is_replicate a b = replicate a b


4) Write a function diffs that returns a list of the differences between
     adjacent items. So, diffs [3,5,6,8] returns [2,1,2]. (HWIB, Lists II)

> diffs x =    
>    let pair_list = zip x $ tail x
>        in let pairdiff (a,b) = b - a
>            in let subList y = [f z | (z, f) <- zip y $ repeat pairdiff]
>                in subList pair_list

    {- After struggling with this and learning a lot I resorted to consulting
       StackExchange where I found a beautiful solution: -}

> diffs_better xs ys = [y-x | (y,x) <- zip ys xs] 

5) Write a function groupByN with the type:
     groupByN :: Int -> [a] -> [[a]]

     This function splits the given list in sub-lists (which result in a list 
     of lists), where the    sublists have a given length. Only the last sub-
     list may be shorter, if necessary. An example application of the 
     function is:
     
       in:   groupByN 3 [1,2,3,4,5,6,7,8,9,10]
       out:  [[1,2,3], [4,5,6], [7,8,9], [10]]

> groupByN :: Int -> [a] -> [[a]]
> groupByN _ [] = []
> groupByN n x
>     | n > 0 = take n x : groupByN n (drop n x)
>     | n == 0 = []
>     | n < 0 = error "Not sure what negatively sized segments even means... hmm. Try a positive number."


6) Design a way to represent straight lines in a cartesian coordinate system 
as internal data in Haskell (remember, y = mx + b) and then write a function 
that calculates the x-intercept (if any) for a given line (CRFP). Be sure to 
test your function with some interesting cases! Note that you will NOT be 
doing anything graphically. This is just a very simple algebra problem.

    We need to represent points in space (x, y):

> data Point = Point Float Float deriving (Show)

    We can represent a line using only its slope and its y-intercept.
    thus we have:
    
> data Line = Line Float Float deriving (Show)

    Keep in mind that the y-intercept is also y_0, the initial value of y
    when x is zero. This means that finding the x-intercept is as easy as:
    x-intercept = -1 * b / m
    
    With the condition that m must be a non-zero value.
    
    Note also that when we return the x-intercept we do not have to return
    a tuple because it is implied that y = 0.
    
> xIntercept :: Line -> Float
> xIntercept (Line m b)
>     | m == 0 = error "This is a horizontal line. There is no x-intercept."
>     | m /= 0 = (-b)/m

7) Write a function which converts a string of digits into an int.
   you will need the following predefined function:
        ord ‘1’       --> 49         first char in arg to its ascii code

   follow the following "pipeline" analysis when defining your function
   "167"  --> ['1','6','7'] --> [49,54,55] --> [1,6,7] --> [(1,100),(6,10),(7,1)]
   --> [100, 60, 7] --> 167
   (hint: the first function in the pipeline is very simple. why?)

        A string is just a list of Chars, so we can use groupByN  and 
        currying to do this (probably the beginner way...).
        
        Or we could just do it the easy way:
        
> strToInt x = read x :: Int