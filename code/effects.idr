data EFFECT : Type where
    STATE     : Type -> EFFECT
    EXCEPTION : Type -> EFFECT
    FILEIO    : Type -> EFFECT
    STDIO     : EFFECT
    RND       : EFFECT

data Eff : (m : Type -> Type) -> (es : List EFFECT) -> 
    (a : Type) -> Type

example : Eff IO [EXCEPTION String, STDIO, STATE Int] ()

type Env = [(String, Int)]

-- Simple type def of binary tree in Idris
data Tree a = Leaf
            | Node (Tree a) a (Tree a)

-- Takes in a tree and produces a tagged tree with
-- State containing an integer passed inside of
-- the function. 
tag : Tree a -> Eff m [STATE Int] (Tree (Int, a))
tag Leaf = return Leaf
tag (Node l x r) = do
    l' <- tag l
    lbl <- get; put (lbl + 1)
    r' <- tag r
    return (Node l' (lbl, x) r')

get : Eff m [STATE x] x

put : x -> Eff m [STATE x] ()

EffM :  (m   : Type -> Type) ->
        (es  : List EFFECT) ->
        (es' : List EFFECT) ->
        (a   : Type) -> Type

runPure : Env id es -> EffM id es es' a -> a

tagFrom : Int -> Tree a -> Tree (Int, a)
tagFrom x t = runPure [x] (tag t)