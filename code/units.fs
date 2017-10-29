[<Measure>]
type inch

[<Measure>]
type foot

// Conversion factor: 
let inchesPerFoot = 12.0<inch/foot>

let distanceInFeet = 3.0<foot>
let distanceInInches = distanceInFeet * inchesPerFoot

printfn "%f", distanceInInches |> ignore