module Morphir.Type.Counter exposing (..)


type Counter a
    = Counter (Int -> ( Int, a ))


apply : Int -> Counter a -> ( Int, a )
apply seed (Counter counter) =
    counter seed


next : (Int -> a) -> Counter a
next f =
    Counter
        (\counter ->
            ( counter + 1, f counter )
        )


ignore : a -> Counter a
ignore a =
    Counter
        (\counter ->
            ( counter, a )
        )


map : (a -> b) -> Counter a -> Counter b
map f (Counter indexerA) =
    Counter
        (\index ->
            let
                ( indexA, a ) =
                    indexerA index
            in
            ( indexA, f a )
        )


map2 : (a -> b -> c) -> Counter a -> Counter b -> Counter c
map2 f (Counter indexerA) (Counter indexerB) =
    Counter
        (\index ->
            let
                ( indexA, a ) =
                    indexerA index

                ( indexB, b ) =
                    indexerB indexA
            in
            ( indexB, f a b )
        )


concat : List (Counter a) -> Counter (List a)
concat counters =
    Counter
        (\counter ->
            counters
                |> List.foldr
                    (\(Counter nextCounter) ( counterSoFar, itemsSoFar ) ->
                        let
                            ( nextCount, nextItem ) =
                                nextCounter counterSoFar
                        in
                        ( nextCount, nextItem :: itemsSoFar )
                    )
                    ( counter, [] )
        )


andThen : (a -> Counter b) -> Counter a -> Counter b
andThen f (Counter counterA) =
    Counter
        (\counter ->
            let
                ( nextCount, a ) =
                    counterA counter

                (Counter counterB) =
                    f a
            in
            counterB nextCount
        )
