import Data.ZZ

%hide plus

data Unit : Int -> Int -> Int -> Type

Dimensionless : Type
Dimensionless = Unit 0 0 0

Metres : Type
Metres = Unit 1 0 0

Seconds : Type
Seconds = Unit 0 1 0

Kilograms : Type
Kilograms = Unit 0 0 1

data Quantity u = Q Double

metres : Double -> Quantity Metres
metres v = (Q v)

seconds : Double -> Quantity Seconds
seconds v = (Q v)

kilograms : Double -> Quantity Kilograms
kilograms v = (Q v)

plus : Quantity u -> Quantity u -> Quantity u
plus (Q x) (Q y) = Q (x + y)

units : a -> (a -> Quantity u) -> Quantity u
units x f = f x

{- times : Quantity (Unit m s g) -> Quantity (Unit m' s' g') 
    -> Quantity (Unit (m + m') (s + s') (g + g'))
times (Q x) (Q y) = Q (x * y)

inverse : Quantity (Unit m s g) -> Quantity (Unit (-m) (-s) (-g))
inverse (Q x) = Q (1 / x)

over : Quantity (Unit m s g) -> Quantity (Unit m' s' g')
-> Quantity (Unit (m -m') (s - s') (g - g'))
over x y = times x (inverse y)

Newtons : Type
Newtons = Unit 1 -2 1

newtons : Double -> Quantity Newtons
newtons val = over 
    (times (kilograms val) (metres 1)) 
    (times (seconds 1) (seconds 1)) -}