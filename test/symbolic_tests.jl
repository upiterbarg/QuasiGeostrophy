using QuasiGeostrophy
using Test
import QuasiGeostrophy:compute

include(pwd() * "/test/test_utils.jl")

@wrapper a=1 b=2 

@testset "Impero operator matching" begin

    println("for $a = ", a.data, " and $b = ", b.data)
    for unary_operator in unary_operators
        b_name, b_symbol = Meta.parse.(unary_operator)
        @eval c = $b_symbol(a)
        println("The value of $c is ", compute(c))
        @test @eval ( compute(c) == $b_symbol(a.data) )
    end

    for binary_operator in binary_operators
        b_name, b_symbol = Meta.parse.(binary_operator)
        @eval c = $b_symbol(a, b)
        println("The value of $c is ", compute(c))
        @test @eval compute(c) == $b_symbol(a.data, b.data) 
    end

end
