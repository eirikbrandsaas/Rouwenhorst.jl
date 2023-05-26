using Rouwenhorst
using Test

@testset "Test results compared to original Matlab file" begin
    N = 2
    T = 3
    rho = fill(0.95,T)
    sigma_eps = fill(0.1,T)
    ygrd_Matlab = [-0.1 -0.1379 -0.1648;0.1 0.1379 0.1648]
    trans_Matlab = fill(0.0,(N,N,T))
    trans_Matlab[:,:,1] = [0.5 0.5; 0.5 0.5]
    trans_Matlab[:,:,2] = [0.8444 0.1556; 0.1556 0.8444]
    trans_Matlab[:,:,3] = [0.8975 0.1025; 0.1025 0.8975]

    ygrd, trans = genrouwenhorst(rho,sigma_eps,N,T)
    @test isequal(round.(ygrd;digits=4),ygrd_Matlab)
    @test isequal(round.(trans;digits=4),trans_Matlab)


    ###########
    N = 2
    T = 3
    rho = [0.95, 0.95, 0.9]
    sigma_eps = fill(0.1,T)
    ygrd_Matlab = [-0.1 -0.1379 -0.1594;0.1 0.1379 0.1594]
    trans_Matlab = fill(0.0,(N,N,T))
    trans_Matlab[:,:,1] = [0.5 0.5; 0.5 0.5]
    trans_Matlab[:,:,2] = [0.8444 0.1556; 0.1556 0.8444]
    trans_Matlab[:,:,3] = [0.8894 0.1106; 0.1106 0.8894]

    ygrd, trans = genrouwenhorst(rho,sigma_eps,N,T)
    @test isequal(round.(ygrd;digits=4),ygrd_Matlab)
    @test isequal(round.(trans;digits=4),trans_Matlab)

    ##
    N = 3
    T = 3
    rho = [0.95, 0.95, 0.9]
    sigma_eps = [0.1,0.5,0.1]
    ygrd_Matlab = [-0.1414 -0.7198 -0.663;0 0 0 ;0.1414 0.7198 0.663]
    trans_Matlab = fill(0.0,(N,N,T))
    trans_Matlab[:,:,1] = [0.25 0.5 0.25;0.25 0.5 0.25;0.25 0.5 0.25]
    trans_Matlab[:,:,2] = [0.3520 0.4826 0.1654; 0.2413 0.5174 0.2413;0.1654 0.4826 0.3520]
    trans_Matlab[:,:,3] = [0.9771 0.0227 0.0001; 0.0114 0.9773 0.0114;0.0001 0.0227 0.9771 ]

    ygrd, trans = genrouwenhorst(rho,sigma_eps,N,T)
    @test isequal(round.(ygrd;digits=4),ygrd_Matlab)
    @test isequal(round.(trans;digits=4),trans_Matlab)
    
end

@testset "Test Assertions/Errors" begin
    N=2
    rho = [0.95, 0.95]
    sigma_eps = [0.1,0.5]
    
    @test_throws AssertionError genrouwenhorst(rho,sigma_eps,1,N)    
    @test_throws AssertionError genrouwenhorst(rho,sigma_eps,N,1)
    @test_throws AssertionError genrouwenhorst(rho[1:1],sigma_eps,N,N)
    @test_throws AssertionError genrouwenhorst(rho,sigma_eps[1:1],N,N)
    @test_throws AssertionError genrouwenhorst(rho,fill(0.1,N+1),N,N)
end