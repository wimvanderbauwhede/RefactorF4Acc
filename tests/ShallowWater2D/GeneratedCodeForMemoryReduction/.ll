; ModuleID = '.bc'
source_filename = "TyTraC/shapiro_map_24.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @shapiro_map_24(i32, i32, i32, i32, i32, float, float, float, float, float, float, float*, float) local_unnamed_addr #0 {
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca float, align 4
  %20 = alloca float, align 4
  %21 = alloca float, align 4
  %22 = alloca float, align 4
  %23 = alloca float, align 4
  %24 = alloca float, align 4
  %25 = alloca float*, align 8
  %26 = alloca float, align 4
  %27 = alloca float, align 4
  %28 = alloca float, align 4
  %29 = alloca float, align 4
  %30 = alloca float, align 4
  store i32 %0, i32* %14, align 4
  store i32 %1, i32* %15, align 4
  store i32 %2, i32* %16, align 4
  store i32 %3, i32* %17, align 4
  store i32 %4, i32* %18, align 4
  store float %5, float* %19, align 4
  store float %6, float* %20, align 4
  store float %7, float* %21, align 4
  store float %8, float* %22, align 4
  store float %9, float* %23, align 4
  store float %10, float* %24, align 4
  store float* %11, float** %25, align 8
  store float %12, float* %26, align 4
  store float 0x3E112E0BE0000000, float* %27, align 4
  %31 = load i32, i32* %14, align 4
  %32 = icmp eq i32 %31, 1
  br i1 %32, label %33, label %87

; <label>:33:                                     ; preds = %13
  %34 = load float, float* %19, align 4
  %35 = fpext float %34 to double
  %36 = fmul double 2.500000e-01, %35
  %37 = load i32, i32* %16, align 4
  %38 = load i32, i32* %15, align 4
  %39 = add nsw i32 %37, %38
  %40 = load i32, i32* %18, align 4
  %41 = add nsw i32 %39, %40
  %42 = load i32, i32* %17, align 4
  %43 = add nsw i32 %41, %42
  %44 = sitofp i32 %43 to double
  %45 = fmul double %36, %44
  %46 = fsub double 1.000000e+00, %45
  %47 = load float, float* %20, align 4
  %48 = fpext float %47 to double
  %49 = fmul double %46, %48
  %50 = fptrunc double %49 to float
  store float %50, float* %28, align 4
  %51 = load float, float* %19, align 4
  %52 = fpext float %51 to double
  %53 = fmul double 2.500000e-01, %52
  %54 = load i32, i32* %16, align 4
  %55 = sitofp i32 %54 to float
  %56 = load float, float* %22, align 4
  %57 = fmul float %55, %56
  %58 = load i32, i32* %15, align 4
  %59 = sitofp i32 %58 to float
  %60 = load float, float* %21, align 4
  %61 = fmul float %59, %60
  %62 = fadd float %57, %61
  %63 = fpext float %62 to double
  %64 = fmul double %53, %63
  %65 = fptrunc double %64 to float
  store float %65, float* %29, align 4
  %66 = load float, float* %19, align 4
  %67 = fpext float %66 to double
  %68 = fmul double 2.500000e-01, %67
  %69 = load i32, i32* %18, align 4
  %70 = sitofp i32 %69 to float
  %71 = load float, float* %24, align 4
  %72 = fmul float %70, %71
  %73 = load i32, i32* %17, align 4
  %74 = sitofp i32 %73 to float
  %75 = load float, float* %23, align 4
  %76 = fmul float %74, %75
  %77 = fadd float %72, %76
  %78 = fpext float %77 to double
  %79 = fmul double %68, %78
  %80 = fptrunc double %79 to float
  store float %80, float* %30, align 4
  %81 = load float, float* %28, align 4
  %82 = load float, float* %29, align 4
  %83 = fadd float %81, %82
  %84 = load float, float* %30, align 4
  %85 = fadd float %83, %84
  %86 = load float*, float** %25, align 8
  store float %85, float* %86, align 4
  br label %90

; <label>:87:                                     ; preds = %13
  %88 = load float, float* %20, align 4
  %89 = load float*, float** %25, align 8
  store float %88, float* %89, align 4
  br label %90

; <label>:90:                                     ; preds = %87, %33
  %91 = load float*, float** %25, align 8
  %92 = load float, float* %91, align 4
  %93 = fmul float 1.000000e+00, %92
  %94 = load float, float* %26, align 4
  %95 = fmul float 0x3E112E0BE0000000, %94
  %96 = fadd float %93, %95
  %97 = load float*, float** %25, align 8
  store float %96, float* %97, align 4
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 7.0.1 (tags/RELEASE_701/final)"}
