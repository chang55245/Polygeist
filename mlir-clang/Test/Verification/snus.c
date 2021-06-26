// RUN: mlir-clang %s -detect-reduction --function=kernel_nussinov | FileCheck %s

#define max_score(s1, s2) ((s1 >= s2) ? s1 : s2)

void set(double table[20]);

void kernel_nussinov(double* out, int n)  {
  double table[20];
  set(table);
#pragma scop
   for (int k=0; k<10; k++) {
      out[n] = max_score(out[n], table[k]);
   }
  //}
#pragma endscop
}

// CHECK:   func @kernel_nussinov(%arg0: memref<?xf64>, %arg1: i32) {
// CHECK-NEXT:     %0 = memref.alloca() : memref<20xf64>
// CHECK-NEXT:     %1 = index_cast %arg1 : i32 to index
// CHECK-NEXT:     %2 = memref.cast %0 : memref<20xf64> to memref<?xf64>
// CHECK-NEXT:     call @set(%2) : (memref<?xf64>) -> ()
// CHECK-NEXT:     %3 = affine.load %arg0[symbol(%1)] : memref<?xf64>
// CHECK-NEXT:     %4 = affine.for %arg2 = 0 to 10 iter_args(%arg3 = %3) -> (f64) {
// CHECK-NEXT:       %5 = affine.load %0[%arg2] : memref<20xf64>
// CHECK-NEXT:       %6 = cmpf uge, %arg3, %5 : f64
// CHECK-NEXT:       %7 = scf.if %6 -> (f64) {
// CHECK-NEXT:         scf.yield %arg3 : f64
// CHECK-NEXT:       } else {
// CHECK-NEXT:         %8 = affine.load %0[%arg2] : memref<20xf64>
// CHECK-NEXT:         scf.yield %8 : f64
// CHECK-NEXT:       }
// CHECK-NEXT:       affine.yield %7 : f64
// CHECK-NEXT:     }
// CHECK-NEXT:     affine.store %4, %arg0[symbol(%1)] : memref<?xf64>
// CHECK-NEXT:     return
// CHECK-NEXT:   }