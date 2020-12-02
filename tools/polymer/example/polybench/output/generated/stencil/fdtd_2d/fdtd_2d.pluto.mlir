#map0 = affine_map<()[s0] -> (s0 - 1)>
#map1 = affine_map<()[s0] -> (32, s0)>
#map2 = affine_map<()[s0, s1] -> (3, s0, s1)>
#map3 = affine_map<(d0) -> (d0 - 1)>
#map4 = affine_map<()[s0, s1] -> (32, s0, s1)>
#map5 = affine_map<()[s0] -> (4, s0)>
#map6 = affine_map<()[s0] -> ((s0 - 1) floordiv 32 + 1)>
#map7 = affine_map<(d0) -> (d0 * 32)>
#map8 = affine_map<(d0)[s0] -> (s0, d0 * 32 + 32)>
#map9 = affine_map<()[s0, s1] -> ((s0 - 1) floordiv 32 + 1, (s1 - 1) floordiv 32 + 1)>
#map10 = affine_map<(d0)[s0, s1] -> (s0, s1, d0 * 32 + 32)>
#map11 = affine_map<()[s0] -> (s0 ceildiv 32)>
#map12 = affine_map<(d0) -> (1, d0 * 32)>
#set0 = affine_set<()[s0, s1] : (s0 - 3 >= 0, s1 - 2 == 0)>
#set1 = affine_set<()[s0, s1] : (s0 - 2 == 0, s1 - 3 >= 0)>
#set2 = affine_set<()[s0, s1] : (s0 - 4 >= 0, s1 - 4 >= 0)>
#set3 = affine_set<()[s0, s1] : (s0 - 4 >= 0, -s1 + 3 >= 0)>
#set4 = affine_set<()[s0, s1] : (-s0 + 3 >= 0, s1 - 4 >= 0)>
#set5 = affine_set<()[s0, s1] : (-s0 + 3 >= 0, -s1 + 3 >= 0)>
#set6 = affine_set<(d0) : (d0 == 0)>
module  {
  func @kernel_fdtd_2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<1000x1200xf64>, %arg4: memref<1000x1200xf64>, %arg5: memref<1000x1200xf64>, %arg6: memref<500xf64>) {
    %0 = index_cast %arg0 : i32 to index
    %1 = index_cast %arg2 : i32 to index
    %2 = index_cast %arg1 : i32 to index
    affine.for %arg7 = 0 to %0 {
      %3 = alloca() : memref<1xf64>
      call @S0(%3, %arg6, %arg7) : (memref<1xf64>, memref<500xf64>, index) -> ()
      affine.for %arg8 = 0 to %1 {
        call @S1(%arg4, %arg8, %3) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
      }
      affine.for %arg8 = 1 to %2 {
        affine.for %arg9 = 0 to %1 {
          call @S2(%arg4, %arg8, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
      }
      affine.for %arg8 = 0 to %2 {
        affine.for %arg9 = 1 to %1 {
          call @S3(%arg3, %arg8, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
      }
      affine.for %arg8 = 0 to #map0()[%2] {
        affine.for %arg9 = 0 to #map0()[%1] {
          call @S4(%arg5, %arg8, %arg9, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
        }
      }
    }
    return
  }
  func @S0(%arg0: memref<1xf64>, %arg1: memref<500xf64>, %arg2: index) attributes {scop.stmt} {
    %0 = affine.load %arg1[symbol(%arg2)] : memref<500xf64>
    affine.store %0, %arg0[0] : memref<1xf64>
    return
  }
  func @S1(%arg0: memref<1000x1200xf64>, %arg1: index, %arg2: memref<1xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg2[0] : memref<1xf64>
    affine.store %0, %arg0[0, symbol(%arg1)] : memref<1000x1200xf64>
    return
  }
  func @S2(%arg0: memref<1000x1200xf64>, %arg1: index, %arg2: index, %arg3: memref<1000x1200xf64>) attributes {scop.stmt} {
    %cst = constant 5.000000e-01 : f64
    %0 = affine.load %arg0[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    %1 = affine.load %arg3[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    %2 = affine.load %arg3[symbol(%arg1) - 1, symbol(%arg2)] : memref<1000x1200xf64>
    %3 = subf %1, %2 : f64
    %4 = mulf %cst, %3 : f64
    %5 = subf %0, %4 : f64
    affine.store %5, %arg0[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    return
  }
  func @S3(%arg0: memref<1000x1200xf64>, %arg1: index, %arg2: index, %arg3: memref<1000x1200xf64>) attributes {scop.stmt} {
    %cst = constant 5.000000e-01 : f64
    %0 = affine.load %arg0[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    %1 = affine.load %arg3[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    %2 = affine.load %arg3[symbol(%arg1), symbol(%arg2) - 1] : memref<1000x1200xf64>
    %3 = subf %1, %2 : f64
    %4 = mulf %cst, %3 : f64
    %5 = subf %0, %4 : f64
    affine.store %5, %arg0[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    return
  }
  func @S4(%arg0: memref<1000x1200xf64>, %arg1: index, %arg2: index, %arg3: memref<1000x1200xf64>, %arg4: memref<1000x1200xf64>) attributes {scop.stmt} {
    %cst = constant 0.69999999999999996 : f64
    %0 = affine.load %arg0[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    %1 = affine.load %arg4[symbol(%arg1), symbol(%arg2) + 1] : memref<1000x1200xf64>
    %2 = affine.load %arg4[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    %3 = subf %1, %2 : f64
    %4 = affine.load %arg3[symbol(%arg1) + 1, symbol(%arg2)] : memref<1000x1200xf64>
    %5 = addf %3, %4 : f64
    %6 = affine.load %arg3[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    %7 = subf %5, %6 : f64
    %8 = mulf %cst, %7 : f64
    %9 = subf %0, %8 : f64
    affine.store %9, %arg0[symbol(%arg1), symbol(%arg2)] : memref<1000x1200xf64>
    return
  }
  func @kernel_fdtd_2d_new(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<1000x1200xf64>, %arg4: memref<1000x1200xf64>, %arg5: memref<1000x1200xf64>, %arg6: memref<500xf64>) {
    %c1 = constant 1 : index
    %c0 = constant 0 : index
    %0 = alloca() : memref<1xf64>
    %1 = index_cast %arg2 : i32 to index
    %2 = index_cast %arg1 : i32 to index
    %3 = index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %3 {
      call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
      affine.for %arg8 = 1 to min #map1()[%2] {
        call @S2(%arg4, %arg7, %arg8, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
      }
      affine.for %arg8 = 1 to min #map2()[%2, %1] {
        call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
        affine.for %arg9 = 1 to min #map1()[%2] {
          %4 = affine.apply #map3(%arg9)
          call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
          call @S3(%arg3, %arg7, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          call @S2(%arg4, %arg7, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
      }
      affine.if #set0()[%2, %1] {
        call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
      }
      affine.if #set1()[%2, %1] {
        call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        call @S4(%arg5, %arg7, %c0, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
        call @S3(%arg3, %arg7, %c1, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        call @S2(%arg4, %arg7, %c1, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
      }
      affine.if #set2()[%2, %1] {
        call @S0(%0, %arg6, %arg7) : (memref<1xf64>, memref<500xf64>, index) -> ()
        call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
        affine.for %arg8 = 1 to min #map1()[%2] {
          %4 = affine.apply #map3(%arg8)
          call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
          call @S3(%arg3, %arg7, %arg8, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          call @S2(%arg4, %arg7, %arg8, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
      }
      affine.if #set3()[%2, %1] {
        call @S0(%0, %arg6, %arg7) : (memref<1xf64>, memref<500xf64>, index) -> ()
        call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
      }
      affine.if #set4()[%2, %1] {
        call @S0(%0, %arg6, %arg7) : (memref<1xf64>, memref<500xf64>, index) -> ()
        call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        affine.for %arg8 = 1 to %2 {
          %4 = affine.apply #map3(%arg8)
          call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
          call @S3(%arg3, %arg7, %arg8, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          call @S2(%arg4, %arg7, %arg8, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
      }
      affine.if #set5()[%2, %1] {
        call @S0(%0, %arg6, %arg7) : (memref<1xf64>, memref<500xf64>, index) -> ()
      }
      affine.for %arg8 = 4 to min #map4()[%2, %1] {
        call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
        affine.for %arg9 = 1 to min #map1()[%2] {
          %4 = affine.apply #map3(%arg9)
          call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
          call @S3(%arg3, %arg7, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          call @S2(%arg4, %arg7, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
      }
      affine.for %arg8 = max #map5()[%1] to min #map1()[%2] {
        call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
      }
      affine.for %arg8 = max #map5()[%2] to min #map1()[%1] {
        call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        affine.for %arg9 = 1 to %2 {
          %4 = affine.apply #map3(%arg9)
          call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
          call @S3(%arg3, %arg7, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          call @S2(%arg4, %arg7, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
      }
      affine.for %arg8 = 1 to #map6()[%2] {
        affine.for %arg9 = #map7(%arg8) to min #map8(%arg8)[%2] {
          call @S2(%arg4, %arg7, %arg9, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
        }
        affine.for %arg9 = 1 to min #map1()[%1] {
          affine.for %arg10 = #map7(%arg8) to min #map8(%arg8)[%2] {
            %4 = affine.apply #map3(%arg10)
            call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
            call @S3(%arg3, %arg7, %arg10, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
            call @S2(%arg4, %arg7, %arg10, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          }
        }
      }
      affine.for %arg8 = 1 to min #map9()[%2, %1] {
        affine.for %arg9 = #map7(%arg8) to min #map10(%arg8)[%2, %1] {
          call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
          affine.for %arg10 = 1 to 32 {
            %4 = affine.apply #map3(%arg10)
            call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
            call @S3(%arg3, %arg7, %arg10, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
            call @S2(%arg4, %arg7, %arg10, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          }
        }
        affine.for %arg9 = %1 to min #map8(%arg8)[%2] {
          call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
        }
        affine.for %arg9 = %2 to min #map8(%arg8)[%1] {
          call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          affine.for %arg10 = 1 to 32 {
            %4 = affine.apply #map3(%arg10)
            call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
            call @S3(%arg3, %arg7, %arg10, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
            call @S2(%arg4, %arg7, %arg10, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
          }
        }
        affine.for %arg9 = 1 to #map6()[%2] {
          affine.for %arg10 = #map7(%arg8) to min #map8(%arg8)[%1] {
            affine.for %arg11 = #map7(%arg9) to min #map8(%arg9)[%2] {
              %4 = affine.apply #map3(%arg11)
              call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
              call @S3(%arg3, %arg7, %arg11, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
              call @S2(%arg4, %arg7, %arg11, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
            }
          }
        }
      }
      affine.for %arg8 = #map11()[%1] to #map6()[%2] {
        affine.for %arg9 = #map7(%arg8) to min #map8(%arg8)[%2] {
          call @S1(%arg4, %arg7, %0) : (memref<1000x1200xf64>, index, memref<1xf64>) -> ()
        }
      }
      affine.for %arg8 = #map11()[%2] to #map6()[%1] {
        affine.for %arg9 = 0 to #map6()[%2] {
          affine.for %arg10 = #map7(%arg8) to min #map8(%arg8)[%1] {
            affine.if #set6(%arg9) {
              call @S3(%arg3, %arg7, %c0, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
            }
            affine.for %arg11 = max #map12(%arg9) to min #map8(%arg9)[%2] {
              %4 = affine.apply #map3(%arg11)
              call @S4(%arg5, %arg7, %4, %arg4, %arg3) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>, memref<1000x1200xf64>) -> ()
              call @S3(%arg3, %arg7, %arg11, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
              call @S2(%arg4, %arg7, %arg11, %arg5) : (memref<1000x1200xf64>, index, index, memref<1000x1200xf64>) -> ()
            }
          }
        }
      }
    }
    return
  }
}
