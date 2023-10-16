module Morphir.Snowpark.MapValueLiteralTests exposing (mapValueLiteralTests)
import Expect
import Test exposing (Test, describe, test)
import Morphir.IR.Literal as Literal
import Morphir.Snowpark.Backend exposing (mapValue)
import Morphir.Scala.AST as Scala
import Morphir.IR.Value as Value
import Morphir.IR.Type as Type

functionNamespace : List String
functionNamespace = ["com", "snowpark", "functions"]

booleanReference : Type.Type ()
booleanReference = Type.Reference () ( [ [ "morphir" ], [ "s", "d", "k" ] ], [ [ "basics" ] ], [ "boolean" ] ) []
booleanTest : Scala.Value
booleanTest =  Scala.Apply
                        (Scala.Ref functionNamespace "lit")
                        ([Scala.ArgValue
                            Nothing (Scala.Literal (Scala.BooleanLit True))])

stringReference : Type.Type ()
stringReference = Type.Reference () ( [ [ "morphir" ], [ "s", "d", "k" ] ], [ [ "basics" ] ], [ "boolean" ] ) []
stringTest : Scala.Value
stringTest =  Scala.Apply
                        (Scala.Ref functionNamespace "lit")
                        ([Scala.ArgValue
                            Nothing (Scala.Literal (Scala.StringLit "Hello world"))])

characterReference : Type.Type ()
characterReference = Type.Reference () ( [ [ "morphir" ], [ "s", "d", "k" ] ], [ [ "basics" ] ], [ "character" ] ) []
characterTest : Scala.Value
characterTest =  Scala.Apply
                        (Scala.Ref functionNamespace "lit")
                        ([Scala.ArgValue
                            Nothing (Scala.Literal (Scala.CharacterLit 'C'))])

floatReference : Type.Type ()
floatReference = Type.Reference () ( [ [ "morphir" ], [ "s", "d", "k" ] ], [ [ "basics" ] ], [ "float" ] ) []
floatTest : Scala.Value
floatTest =  Scala.Apply
                        (Scala.Ref functionNamespace "lit")
                        ([Scala.ArgValue
                            Nothing (Scala.Literal (Scala.FloatLit 3.24))])


integerReference : Type.Type ()
integerReference = Type.Reference () ( [ [ "morphir" ], [ "s", "d", "k" ] ], [ [ "basics" ] ], [ "integer" ] ) []
integerTest : Scala.Value
integerTest =  Scala.Apply
                        (Scala.Ref functionNamespace "lit")
                        ([Scala.ArgValue
                            Nothing (Scala.Literal (Scala.IntegerLit 5))])

mapValueLiteralTests: Test
mapValueLiteralTests =
    let
        assertBooleanLiteral =
            test ("Convert boolean") <|
            \_ ->
                Expect.equal booleanTest (mapValue (Value.Literal booleanReference (Literal.BoolLiteral True)))
        assertStringLiteral =
            test ("Convert string") <|
            \_ ->
                Expect.equal stringTest (mapValue (Value.Literal stringReference (Literal.StringLiteral "Hello world")))
        assertCharacterLiteral =
            test ("Convert character") <|
            \_ ->
                Expect.equal characterTest (mapValue (Value.Literal characterReference (Literal.CharLiteral 'C')))
        assertFloatLiteral =
            test ("Convert float") <|
            \_ ->
                Expect.equal floatTest (mapValue (Value.Literal floatReference (Literal.FloatLiteral 3.24)))
        assertIntegerLiteral =
            test ("Convert integer") <|
            \_ ->
                Expect.equal integerTest (mapValue (Value.Literal integerReference (Literal.WholeNumberLiteral 5)))
    in
    describe "literalMapTransform"
        [
            assertBooleanLiteral,
            assertStringLiteral,
            assertCharacterLiteral,
            assertFloatLiteral,
            assertIntegerLiteral
        ]