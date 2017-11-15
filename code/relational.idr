import Data.Vect

data U : Type where
  STRING : U
  BOOL : U
  CHAR : U
  NAT : U
  VECT : Nat -> U -> U

el : U -> Type
el STRING     = String
el BOOL       = Bool
el CHAR       = Char
el NAT        = Nat
el (VECT n u) = Vect n (el u)

Attribute : Type
Attribute = (String, U)

Schema : Type
Schema = List Attribute

Cars : Schema
Cars = (   ("model", STRING)
        :: ("time", VECT 6 CHAR)
        :: ("wet", BOOL)
        :: Nil)

Students : Schema
Students = (   ("name", STRING)
            :: ("id", VECT 6 CHAR)
            :: ("classyear", VECT 4 CHAR)
            :: Nil)

data Row : Schema -> Type where
    EmptyRow : Row Nil
    ConsRow : el u -> Row s -> Row ((name, u) :: s)

data Handle : Schema -> Type

-- Connect takes in a server name, a table name, and a schema, and executes IO operations on that table. 
connect : String -> String -> (s : Schema) -> IO (Handle s)
-- This type ensures that upon connection, if successful, the table on the server must have the same schema. 

-- Only modeling a single 'read' operation. 
data RA : Schema -> Type where
    Read : Handle s -> RA s

-- Takes in a query written with our relational algebra and then sends back a table that corresponds to our schema. 
toSQL : RA s -> IO (List (Row s))

kevin : Row Students
kevin = ConsRow "Kevin Jiah-Chih Liao"
    (ConsRow ('1'::'2'::'3'::'4'::'5'::'6'::Nil)
    (ConsRow ('2'::'0'::'1'::'8'::Nil)
    EmptyRow))

zonda : Row Cars
zonda = ConsRow "Pagani Zonda C12 F   "
    (ConsRow ('1' :: ':' :: '1' :: '8' :: '.' :: '4' :: Nil)
    (ConsRow False EmptyRow))