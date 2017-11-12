import Data.Vect

replic : (n : Nat) -> Vect n Nat
replic n = replicateHelper n n where
  replicateHelper : (n : Nat) -> Nat -> Vect n Nat
  replicateHelper Z _ = Nil
  replicateHelper (S n) val = (val :: replicateHelper n val)