; ModuleID = 'aes.c'
source_filename = "aes.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

%struct.aes128ctx = type { i64* }
%struct.aes192ctx = type { i64* }
%struct.aes256ctx = type { i64* }

@Rcon = internal constant [10 x i8] c"\01\02\04\08\10 @\80\1B6", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes128_ecb_keyexp(%struct.aes128ctx* noundef %0, i8* noundef %1) #0 {
  %3 = alloca %struct.aes128ctx*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca [22 x i64], align 8
  store %struct.aes128ctx* %0, %struct.aes128ctx** %3, align 8
  store i8* %1, i8** %4, align 8
  %6 = call i8* @malloc(i64 noundef 704) #8
  %7 = bitcast i8* %6 to i64*
  %8 = load %struct.aes128ctx*, %struct.aes128ctx** %3, align 8
  %9 = getelementptr inbounds %struct.aes128ctx, %struct.aes128ctx* %8, i32 0, i32 0
  store i64* %7, i64** %9, align 8
  %10 = load %struct.aes128ctx*, %struct.aes128ctx** %3, align 8
  %11 = getelementptr inbounds %struct.aes128ctx, %struct.aes128ctx* %10, i32 0, i32 0
  %12 = load i64*, i64** %11, align 8
  %13 = icmp eq i64* %12, null
  br i1 %13, label %14, label %15

14:                                               ; preds = %2
  call void @exit(i32 noundef 111) #9
  unreachable

15:                                               ; preds = %2
  %16 = getelementptr inbounds [22 x i64], [22 x i64]* %5, i64 0, i64 0
  %17 = load i8*, i8** %4, align 8
  call void @br_aes_ct64_keysched(i64* noundef %16, i8* noundef %17, i32 noundef 16)
  %18 = load %struct.aes128ctx*, %struct.aes128ctx** %3, align 8
  %19 = getelementptr inbounds %struct.aes128ctx, %struct.aes128ctx* %18, i32 0, i32 0
  %20 = load i64*, i64** %19, align 8
  %21 = getelementptr inbounds [22 x i64], [22 x i64]* %5, i64 0, i64 0
  call void @br_aes_ct64_skey_expand(i64* noundef %20, i64* noundef %21, i32 noundef 10)
  ret void
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64 noundef) #1

; Function Attrs: noreturn
declare void @exit(i32 noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_aes_ct64_keysched(i64* noundef %0, i8* noundef %1, i32 noundef %2) #0 {
  %4 = alloca i64*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca [60 x i32], align 4
  %14 = alloca i32, align 4
  %15 = alloca [8 x i64], align 8
  store i64* %0, i64** %4, align 8
  store i8* %1, i8** %5, align 8
  store i32 %2, i32* %6, align 4
  %16 = load i32, i32* %6, align 4
  %17 = sub i32 %16, 16
  %18 = lshr i32 %17, 2
  %19 = add i32 10, %18
  store i32 %19, i32* %14, align 4
  %20 = load i32, i32* %6, align 4
  %21 = lshr i32 %20, 2
  store i32 %21, i32* %10, align 4
  %22 = load i32, i32* %14, align 4
  %23 = add i32 %22, 1
  %24 = shl i32 %23, 2
  store i32 %24, i32* %11, align 4
  %25 = getelementptr inbounds [60 x i32], [60 x i32]* %13, i64 0, i64 0
  %26 = load i32, i32* %6, align 4
  %27 = lshr i32 %26, 2
  %28 = zext i32 %27 to i64
  %29 = load i8*, i8** %5, align 8
  call void @br_range_dec32le(i32* noundef %25, i64 noundef %28, i8* noundef %29)
  %30 = load i32, i32* %6, align 4
  %31 = lshr i32 %30, 2
  %32 = sub i32 %31, 1
  %33 = zext i32 %32 to i64
  %34 = getelementptr inbounds [60 x i32], [60 x i32]* %13, i64 0, i64 %33
  %35 = load i32, i32* %34, align 4
  store i32 %35, i32* %12, align 4
  %36 = load i32, i32* %10, align 4
  store i32 %36, i32* %7, align 4
  store i32 0, i32* %8, align 4
  store i32 0, i32* %9, align 4
  br label %37

37:                                               ; preds = %89, %3
  %38 = load i32, i32* %7, align 4
  %39 = load i32, i32* %11, align 4
  %40 = icmp ult i32 %38, %39
  br i1 %40, label %41, label %92

41:                                               ; preds = %37
  %42 = load i32, i32* %8, align 4
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %58

44:                                               ; preds = %41
  %45 = load i32, i32* %12, align 4
  %46 = shl i32 %45, 24
  %47 = load i32, i32* %12, align 4
  %48 = lshr i32 %47, 8
  %49 = or i32 %46, %48
  store i32 %49, i32* %12, align 4
  %50 = load i32, i32* %12, align 4
  %51 = call i32 @sub_word(i32 noundef %50)
  %52 = load i32, i32* %9, align 4
  %53 = zext i32 %52 to i64
  %54 = getelementptr inbounds [10 x i8], [10 x i8]* @Rcon, i64 0, i64 %53
  %55 = load i8, i8* %54, align 1
  %56 = zext i8 %55 to i32
  %57 = xor i32 %51, %56
  store i32 %57, i32* %12, align 4
  br label %68

58:                                               ; preds = %41
  %59 = load i32, i32* %10, align 4
  %60 = icmp ugt i32 %59, 6
  br i1 %60, label %61, label %67

61:                                               ; preds = %58
  %62 = load i32, i32* %8, align 4
  %63 = icmp eq i32 %62, 4
  br i1 %63, label %64, label %67

64:                                               ; preds = %61
  %65 = load i32, i32* %12, align 4
  %66 = call i32 @sub_word(i32 noundef %65)
  store i32 %66, i32* %12, align 4
  br label %67

67:                                               ; preds = %64, %61, %58
  br label %68

68:                                               ; preds = %67, %44
  %69 = load i32, i32* %7, align 4
  %70 = load i32, i32* %10, align 4
  %71 = sub i32 %69, %70
  %72 = zext i32 %71 to i64
  %73 = getelementptr inbounds [60 x i32], [60 x i32]* %13, i64 0, i64 %72
  %74 = load i32, i32* %73, align 4
  %75 = load i32, i32* %12, align 4
  %76 = xor i32 %75, %74
  store i32 %76, i32* %12, align 4
  %77 = load i32, i32* %12, align 4
  %78 = load i32, i32* %7, align 4
  %79 = zext i32 %78 to i64
  %80 = getelementptr inbounds [60 x i32], [60 x i32]* %13, i64 0, i64 %79
  store i32 %77, i32* %80, align 4
  %81 = load i32, i32* %8, align 4
  %82 = add i32 %81, 1
  store i32 %82, i32* %8, align 4
  %83 = load i32, i32* %10, align 4
  %84 = icmp eq i32 %82, %83
  br i1 %84, label %85, label %88

85:                                               ; preds = %68
  store i32 0, i32* %8, align 4
  %86 = load i32, i32* %9, align 4
  %87 = add i32 %86, 1
  store i32 %87, i32* %9, align 4
  br label %88

88:                                               ; preds = %85, %68
  br label %89

89:                                               ; preds = %88
  %90 = load i32, i32* %7, align 4
  %91 = add i32 %90, 1
  store i32 %91, i32* %7, align 4
  br label %37, !llvm.loop !10

92:                                               ; preds = %37
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %93

93:                                               ; preds = %163, %92
  %94 = load i32, i32* %7, align 4
  %95 = load i32, i32* %11, align 4
  %96 = icmp ult i32 %94, %95
  br i1 %96, label %97, label %168

97:                                               ; preds = %93
  %98 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 0
  %99 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 4
  %100 = getelementptr inbounds [60 x i32], [60 x i32]* %13, i64 0, i64 0
  %101 = load i32, i32* %7, align 4
  %102 = zext i32 %101 to i64
  %103 = getelementptr inbounds i32, i32* %100, i64 %102
  call void @br_aes_ct64_interleave_in(i64* noundef %98, i64* noundef %99, i32* noundef %103)
  %104 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 0
  %105 = load i64, i64* %104, align 8
  %106 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 1
  store i64 %105, i64* %106, align 8
  %107 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 0
  %108 = load i64, i64* %107, align 8
  %109 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 2
  store i64 %108, i64* %109, align 8
  %110 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 0
  %111 = load i64, i64* %110, align 8
  %112 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 3
  store i64 %111, i64* %112, align 8
  %113 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 4
  %114 = load i64, i64* %113, align 8
  %115 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 5
  store i64 %114, i64* %115, align 8
  %116 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 4
  %117 = load i64, i64* %116, align 8
  %118 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 6
  store i64 %117, i64* %118, align 8
  %119 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 4
  %120 = load i64, i64* %119, align 8
  %121 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 7
  store i64 %120, i64* %121, align 8
  %122 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 0
  call void @br_aes_ct64_ortho(i64* noundef %122)
  %123 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 0
  %124 = load i64, i64* %123, align 8
  %125 = and i64 %124, 1229782938247303441
  %126 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 1
  %127 = load i64, i64* %126, align 8
  %128 = and i64 %127, 2459565876494606882
  %129 = or i64 %125, %128
  %130 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 2
  %131 = load i64, i64* %130, align 8
  %132 = and i64 %131, 4919131752989213764
  %133 = or i64 %129, %132
  %134 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 3
  %135 = load i64, i64* %134, align 8
  %136 = and i64 %135, -8608480567731124088
  %137 = or i64 %133, %136
  %138 = load i64*, i64** %4, align 8
  %139 = load i32, i32* %8, align 4
  %140 = add i32 %139, 0
  %141 = zext i32 %140 to i64
  %142 = getelementptr inbounds i64, i64* %138, i64 %141
  store i64 %137, i64* %142, align 8
  %143 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 4
  %144 = load i64, i64* %143, align 8
  %145 = and i64 %144, 1229782938247303441
  %146 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 5
  %147 = load i64, i64* %146, align 8
  %148 = and i64 %147, 2459565876494606882
  %149 = or i64 %145, %148
  %150 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 6
  %151 = load i64, i64* %150, align 8
  %152 = and i64 %151, 4919131752989213764
  %153 = or i64 %149, %152
  %154 = getelementptr inbounds [8 x i64], [8 x i64]* %15, i64 0, i64 7
  %155 = load i64, i64* %154, align 8
  %156 = and i64 %155, -8608480567731124088
  %157 = or i64 %153, %156
  %158 = load i64*, i64** %4, align 8
  %159 = load i32, i32* %8, align 4
  %160 = add i32 %159, 1
  %161 = zext i32 %160 to i64
  %162 = getelementptr inbounds i64, i64* %158, i64 %161
  store i64 %157, i64* %162, align 8
  br label %163

163:                                              ; preds = %97
  %164 = load i32, i32* %7, align 4
  %165 = add i32 %164, 4
  store i32 %165, i32* %7, align 4
  %166 = load i32, i32* %8, align 4
  %167 = add i32 %166, 2
  store i32 %167, i32* %8, align 4
  br label %93, !llvm.loop !12

168:                                              ; preds = %93
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_aes_ct64_skey_expand(i64* noundef %0, i64* noundef %1, i32 noundef %2) #0 {
  %4 = alloca i64*, align 8
  %5 = alloca i64*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  store i64* %0, i64** %4, align 8
  store i64* %1, i64** %5, align 8
  store i32 %2, i32* %6, align 4
  %14 = load i32, i32* %6, align 4
  %15 = add i32 %14, 1
  %16 = shl i32 %15, 1
  store i32 %16, i32* %9, align 4
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %17

17:                                               ; preds = %77, %3
  %18 = load i32, i32* %7, align 4
  %19 = load i32, i32* %9, align 4
  %20 = icmp ult i32 %18, %19
  br i1 %20, label %21, label %82

21:                                               ; preds = %17
  %22 = load i64*, i64** %5, align 8
  %23 = load i32, i32* %7, align 4
  %24 = zext i32 %23 to i64
  %25 = getelementptr inbounds i64, i64* %22, i64 %24
  %26 = load i64, i64* %25, align 8
  store i64 %26, i64* %13, align 8
  store i64 %26, i64* %12, align 8
  store i64 %26, i64* %11, align 8
  store i64 %26, i64* %10, align 8
  %27 = load i64, i64* %10, align 8
  %28 = and i64 %27, 1229782938247303441
  store i64 %28, i64* %10, align 8
  %29 = load i64, i64* %11, align 8
  %30 = and i64 %29, 2459565876494606882
  store i64 %30, i64* %11, align 8
  %31 = load i64, i64* %12, align 8
  %32 = and i64 %31, 4919131752989213764
  store i64 %32, i64* %12, align 8
  %33 = load i64, i64* %13, align 8
  %34 = and i64 %33, -8608480567731124088
  store i64 %34, i64* %13, align 8
  %35 = load i64, i64* %11, align 8
  %36 = lshr i64 %35, 1
  store i64 %36, i64* %11, align 8
  %37 = load i64, i64* %12, align 8
  %38 = lshr i64 %37, 2
  store i64 %38, i64* %12, align 8
  %39 = load i64, i64* %13, align 8
  %40 = lshr i64 %39, 3
  store i64 %40, i64* %13, align 8
  %41 = load i64, i64* %10, align 8
  %42 = shl i64 %41, 4
  %43 = load i64, i64* %10, align 8
  %44 = sub i64 %42, %43
  %45 = load i64*, i64** %4, align 8
  %46 = load i32, i32* %8, align 4
  %47 = add i32 %46, 0
  %48 = zext i32 %47 to i64
  %49 = getelementptr inbounds i64, i64* %45, i64 %48
  store i64 %44, i64* %49, align 8
  %50 = load i64, i64* %11, align 8
  %51 = shl i64 %50, 4
  %52 = load i64, i64* %11, align 8
  %53 = sub i64 %51, %52
  %54 = load i64*, i64** %4, align 8
  %55 = load i32, i32* %8, align 4
  %56 = add i32 %55, 1
  %57 = zext i32 %56 to i64
  %58 = getelementptr inbounds i64, i64* %54, i64 %57
  store i64 %53, i64* %58, align 8
  %59 = load i64, i64* %12, align 8
  %60 = shl i64 %59, 4
  %61 = load i64, i64* %12, align 8
  %62 = sub i64 %60, %61
  %63 = load i64*, i64** %4, align 8
  %64 = load i32, i32* %8, align 4
  %65 = add i32 %64, 2
  %66 = zext i32 %65 to i64
  %67 = getelementptr inbounds i64, i64* %63, i64 %66
  store i64 %62, i64* %67, align 8
  %68 = load i64, i64* %13, align 8
  %69 = shl i64 %68, 4
  %70 = load i64, i64* %13, align 8
  %71 = sub i64 %69, %70
  %72 = load i64*, i64** %4, align 8
  %73 = load i32, i32* %8, align 4
  %74 = add i32 %73, 3
  %75 = zext i32 %74 to i64
  %76 = getelementptr inbounds i64, i64* %72, i64 %75
  store i64 %71, i64* %76, align 8
  br label %77

77:                                               ; preds = %21
  %78 = load i32, i32* %7, align 4
  %79 = add i32 %78, 1
  store i32 %79, i32* %7, align 4
  %80 = load i32, i32* %8, align 4
  %81 = add i32 %80, 4
  store i32 %81, i32* %8, align 4
  br label %17, !llvm.loop !13

82:                                               ; preds = %17
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes128_ctr_keyexp(%struct.aes128ctx* noundef %0, i8* noundef %1) #0 {
  %3 = alloca %struct.aes128ctx*, align 8
  %4 = alloca i8*, align 8
  store %struct.aes128ctx* %0, %struct.aes128ctx** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %struct.aes128ctx*, %struct.aes128ctx** %3, align 8
  %6 = load i8*, i8** %4, align 8
  call void @aes128_ecb_keyexp(%struct.aes128ctx* noundef %5, i8* noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes192_ecb_keyexp(%struct.aes192ctx* noundef %0, i8* noundef %1) #0 {
  %3 = alloca %struct.aes192ctx*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca [26 x i64], align 8
  store %struct.aes192ctx* %0, %struct.aes192ctx** %3, align 8
  store i8* %1, i8** %4, align 8
  %6 = call i8* @malloc(i64 noundef 832) #8
  %7 = bitcast i8* %6 to i64*
  %8 = load %struct.aes192ctx*, %struct.aes192ctx** %3, align 8
  %9 = getelementptr inbounds %struct.aes192ctx, %struct.aes192ctx* %8, i32 0, i32 0
  store i64* %7, i64** %9, align 8
  %10 = load %struct.aes192ctx*, %struct.aes192ctx** %3, align 8
  %11 = getelementptr inbounds %struct.aes192ctx, %struct.aes192ctx* %10, i32 0, i32 0
  %12 = load i64*, i64** %11, align 8
  %13 = icmp eq i64* %12, null
  br i1 %13, label %14, label %15

14:                                               ; preds = %2
  call void @exit(i32 noundef 111) #9
  unreachable

15:                                               ; preds = %2
  %16 = getelementptr inbounds [26 x i64], [26 x i64]* %5, i64 0, i64 0
  %17 = load i8*, i8** %4, align 8
  call void @br_aes_ct64_keysched(i64* noundef %16, i8* noundef %17, i32 noundef 24)
  %18 = load %struct.aes192ctx*, %struct.aes192ctx** %3, align 8
  %19 = getelementptr inbounds %struct.aes192ctx, %struct.aes192ctx* %18, i32 0, i32 0
  %20 = load i64*, i64** %19, align 8
  %21 = getelementptr inbounds [26 x i64], [26 x i64]* %5, i64 0, i64 0
  call void @br_aes_ct64_skey_expand(i64* noundef %20, i64* noundef %21, i32 noundef 12)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes192_ctr_keyexp(%struct.aes192ctx* noundef %0, i8* noundef %1) #0 {
  %3 = alloca %struct.aes192ctx*, align 8
  %4 = alloca i8*, align 8
  store %struct.aes192ctx* %0, %struct.aes192ctx** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %struct.aes192ctx*, %struct.aes192ctx** %3, align 8
  %6 = load i8*, i8** %4, align 8
  call void @aes192_ecb_keyexp(%struct.aes192ctx* noundef %5, i8* noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes256_ecb_keyexp(%struct.aes256ctx* noundef %0, i8* noundef %1) #0 {
  %3 = alloca %struct.aes256ctx*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca [30 x i64], align 8
  store %struct.aes256ctx* %0, %struct.aes256ctx** %3, align 8
  store i8* %1, i8** %4, align 8
  %6 = call i8* @malloc(i64 noundef 960) #8
  %7 = bitcast i8* %6 to i64*
  %8 = load %struct.aes256ctx*, %struct.aes256ctx** %3, align 8
  %9 = getelementptr inbounds %struct.aes256ctx, %struct.aes256ctx* %8, i32 0, i32 0
  store i64* %7, i64** %9, align 8
  %10 = load %struct.aes256ctx*, %struct.aes256ctx** %3, align 8
  %11 = getelementptr inbounds %struct.aes256ctx, %struct.aes256ctx* %10, i32 0, i32 0
  %12 = load i64*, i64** %11, align 8
  %13 = icmp eq i64* %12, null
  br i1 %13, label %14, label %15

14:                                               ; preds = %2
  call void @exit(i32 noundef 111) #9
  unreachable

15:                                               ; preds = %2
  %16 = getelementptr inbounds [30 x i64], [30 x i64]* %5, i64 0, i64 0
  %17 = load i8*, i8** %4, align 8
  call void @br_aes_ct64_keysched(i64* noundef %16, i8* noundef %17, i32 noundef 32)
  %18 = load %struct.aes256ctx*, %struct.aes256ctx** %3, align 8
  %19 = getelementptr inbounds %struct.aes256ctx, %struct.aes256ctx* %18, i32 0, i32 0
  %20 = load i64*, i64** %19, align 8
  %21 = getelementptr inbounds [30 x i64], [30 x i64]* %5, i64 0, i64 0
  call void @br_aes_ct64_skey_expand(i64* noundef %20, i64* noundef %21, i32 noundef 14)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes256_ctr_keyexp(%struct.aes256ctx* noundef %0, i8* noundef %1) #0 {
  %3 = alloca %struct.aes256ctx*, align 8
  %4 = alloca i8*, align 8
  store %struct.aes256ctx* %0, %struct.aes256ctx** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %struct.aes256ctx*, %struct.aes256ctx** %3, align 8
  %6 = load i8*, i8** %4, align 8
  call void @aes256_ecb_keyexp(%struct.aes256ctx* noundef %5, i8* noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes128_ecb(i8* noundef %0, i8* noundef %1, i64 noundef %2, %struct.aes128ctx* noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca %struct.aes128ctx*, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i64 %2, i64* %7, align 8
  store %struct.aes128ctx* %3, %struct.aes128ctx** %8, align 8
  %9 = load i8*, i8** %5, align 8
  %10 = load i8*, i8** %6, align 8
  %11 = load i64, i64* %7, align 8
  %12 = load %struct.aes128ctx*, %struct.aes128ctx** %8, align 8
  %13 = getelementptr inbounds %struct.aes128ctx, %struct.aes128ctx* %12, i32 0, i32 0
  %14 = load i64*, i64** %13, align 8
  call void @aes_ecb(i8* noundef %9, i8* noundef %10, i64 noundef %11, i64* noundef %14, i32 noundef 10)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @aes_ecb(i8* noundef %0, i8* noundef %1, i64 noundef %2, i64* noundef %3, i32 noundef %4) #0 {
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64*, align 8
  %10 = alloca i32, align 4
  %11 = alloca [16 x i32], align 4
  %12 = alloca [64 x i8], align 1
  store i8* %0, i8** %6, align 8
  store i8* %1, i8** %7, align 8
  store i64 %2, i64* %8, align 8
  store i64* %3, i64** %9, align 8
  store i32 %4, i32* %10, align 4
  br label %13

13:                                               ; preds = %16, %5
  %14 = load i64, i64* %8, align 8
  %15 = icmp uge i64 %14, 4
  br i1 %15, label %16, label %29

16:                                               ; preds = %13
  %17 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %18 = load i8*, i8** %7, align 8
  call void @br_range_dec32le(i32* noundef %17, i64 noundef 16, i8* noundef %18)
  %19 = load i8*, i8** %6, align 8
  %20 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %21 = load i64*, i64** %9, align 8
  %22 = load i32, i32* %10, align 4
  call void @aes_ecb4x(i8* noundef %19, i32* noundef %20, i64* noundef %21, i32 noundef %22)
  %23 = load i64, i64* %8, align 8
  %24 = sub i64 %23, 4
  store i64 %24, i64* %8, align 8
  %25 = load i8*, i8** %7, align 8
  %26 = getelementptr inbounds i8, i8* %25, i64 64
  store i8* %26, i8** %7, align 8
  %27 = load i8*, i8** %6, align 8
  %28 = getelementptr inbounds i8, i8* %27, i64 64
  store i8* %28, i8** %6, align 8
  br label %13, !llvm.loop !14

29:                                               ; preds = %13
  %30 = load i64, i64* %8, align 8
  %31 = icmp ne i64 %30, 0
  br i1 %31, label %32, label %48

32:                                               ; preds = %29
  %33 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %34 = load i64, i64* %8, align 8
  %35 = mul i64 %34, 4
  %36 = load i8*, i8** %7, align 8
  call void @br_range_dec32le(i32* noundef %33, i64 noundef %35, i8* noundef %36)
  %37 = getelementptr inbounds [64 x i8], [64 x i8]* %12, i64 0, i64 0
  %38 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %39 = load i64*, i64** %9, align 8
  %40 = load i32, i32* %10, align 4
  call void @aes_ecb4x(i8* noundef %37, i32* noundef %38, i64* noundef %39, i32 noundef %40)
  %41 = load i8*, i8** %6, align 8
  %42 = getelementptr inbounds [64 x i8], [64 x i8]* %12, i64 0, i64 0
  %43 = load i64, i64* %8, align 8
  %44 = mul i64 %43, 16
  %45 = load i8*, i8** %6, align 8
  %46 = call i64 @llvm.objectsize.i64.p0i8(i8* %45, i1 false, i1 true, i1 false)
  %47 = call i8* @__memcpy_chk(i8* noundef %41, i8* noundef %42, i64 noundef %44, i64 noundef %46) #10
  br label %48

48:                                               ; preds = %32, %29
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes128_ctr(i8* noundef %0, i64 noundef %1, i8* noundef %2, %struct.aes128ctx* noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct.aes128ctx*, align 8
  store i8* %0, i8** %5, align 8
  store i64 %1, i64* %6, align 8
  store i8* %2, i8** %7, align 8
  store %struct.aes128ctx* %3, %struct.aes128ctx** %8, align 8
  %9 = load i8*, i8** %5, align 8
  %10 = load i64, i64* %6, align 8
  %11 = load i8*, i8** %7, align 8
  %12 = load %struct.aes128ctx*, %struct.aes128ctx** %8, align 8
  %13 = getelementptr inbounds %struct.aes128ctx, %struct.aes128ctx* %12, i32 0, i32 0
  %14 = load i64*, i64** %13, align 8
  call void @aes_ctr(i8* noundef %9, i64 noundef %10, i8* noundef %11, i64* noundef %14, i32 noundef 10)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @aes_ctr(i8* noundef %0, i64 noundef %1, i8* noundef %2, i64* noundef %3, i32 noundef %4) #0 {
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i64*, align 8
  %10 = alloca i32, align 4
  %11 = alloca [16 x i32], align 4
  %12 = alloca i64, align 8
  %13 = alloca i32, align 4
  %14 = alloca [64 x i8], align 1
  store i8* %0, i8** %6, align 8
  store i64 %1, i64* %7, align 8
  store i8* %2, i8** %8, align 8
  store i64* %3, i64** %9, align 8
  store i32 %4, i32* %10, align 4
  store i32 0, i32* %13, align 4
  %15 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %16 = load i8*, i8** %8, align 8
  call void @br_range_dec32le(i32* noundef %15, i64 noundef 3, i8* noundef %16)
  %17 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %18 = getelementptr inbounds i32, i32* %17, i64 4
  %19 = bitcast i32* %18 to i8*
  %20 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %21 = bitcast i32* %20 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %19, i8* align 4 %21, i64 12, i1 false)
  %22 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %23 = getelementptr inbounds i32, i32* %22, i64 8
  %24 = bitcast i32* %23 to i8*
  %25 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %26 = bitcast i32* %25 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %24, i8* align 4 %26, i64 12, i1 false)
  %27 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %28 = getelementptr inbounds i32, i32* %27, i64 12
  %29 = bitcast i32* %28 to i8*
  %30 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %31 = bitcast i32* %30 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %29, i8* align 4 %31, i64 12, i1 false)
  %32 = load i32, i32* %13, align 4
  %33 = call i32 @br_swap32(i32 noundef %32)
  %34 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 3
  store i32 %33, i32* %34, align 4
  %35 = load i32, i32* %13, align 4
  %36 = add i32 %35, 1
  %37 = call i32 @br_swap32(i32 noundef %36)
  %38 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 7
  store i32 %37, i32* %38, align 4
  %39 = load i32, i32* %13, align 4
  %40 = add i32 %39, 2
  %41 = call i32 @br_swap32(i32 noundef %40)
  %42 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 11
  store i32 %41, i32* %42, align 4
  %43 = load i32, i32* %13, align 4
  %44 = add i32 %43, 3
  %45 = call i32 @br_swap32(i32 noundef %44)
  %46 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 15
  store i32 %45, i32* %46, align 4
  br label %47

47:                                               ; preds = %50, %5
  %48 = load i64, i64* %7, align 8
  %49 = icmp ugt i64 %48, 64
  br i1 %49, label %50, label %59

50:                                               ; preds = %47
  %51 = load i8*, i8** %6, align 8
  %52 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %53 = load i64*, i64** %9, align 8
  %54 = load i32, i32* %10, align 4
  call void @aes_ctr4x(i8* noundef %51, i32* noundef %52, i64* noundef %53, i32 noundef %54)
  %55 = load i8*, i8** %6, align 8
  %56 = getelementptr inbounds i8, i8* %55, i64 64
  store i8* %56, i8** %6, align 8
  %57 = load i64, i64* %7, align 8
  %58 = sub i64 %57, 64
  store i64 %58, i64* %7, align 8
  br label %47, !llvm.loop !15

59:                                               ; preds = %47
  %60 = load i64, i64* %7, align 8
  %61 = icmp ugt i64 %60, 0
  br i1 %61, label %62, label %82

62:                                               ; preds = %59
  %63 = getelementptr inbounds [64 x i8], [64 x i8]* %14, i64 0, i64 0
  %64 = getelementptr inbounds [16 x i32], [16 x i32]* %11, i64 0, i64 0
  %65 = load i64*, i64** %9, align 8
  %66 = load i32, i32* %10, align 4
  call void @aes_ctr4x(i8* noundef %63, i32* noundef %64, i64* noundef %65, i32 noundef %66)
  store i64 0, i64* %12, align 8
  br label %67

67:                                               ; preds = %78, %62
  %68 = load i64, i64* %12, align 8
  %69 = load i64, i64* %7, align 8
  %70 = icmp ult i64 %68, %69
  br i1 %70, label %71, label %81

71:                                               ; preds = %67
  %72 = load i64, i64* %12, align 8
  %73 = getelementptr inbounds [64 x i8], [64 x i8]* %14, i64 0, i64 %72
  %74 = load i8, i8* %73, align 1
  %75 = load i8*, i8** %6, align 8
  %76 = load i64, i64* %12, align 8
  %77 = getelementptr inbounds i8, i8* %75, i64 %76
  store i8 %74, i8* %77, align 1
  br label %78

78:                                               ; preds = %71
  %79 = load i64, i64* %12, align 8
  %80 = add i64 %79, 1
  store i64 %80, i64* %12, align 8
  br label %67, !llvm.loop !16

81:                                               ; preds = %67
  br label %82

82:                                               ; preds = %81, %59
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes192_ecb(i8* noundef %0, i8* noundef %1, i64 noundef %2, %struct.aes192ctx* noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca %struct.aes192ctx*, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i64 %2, i64* %7, align 8
  store %struct.aes192ctx* %3, %struct.aes192ctx** %8, align 8
  %9 = load i8*, i8** %5, align 8
  %10 = load i8*, i8** %6, align 8
  %11 = load i64, i64* %7, align 8
  %12 = load %struct.aes192ctx*, %struct.aes192ctx** %8, align 8
  %13 = getelementptr inbounds %struct.aes192ctx, %struct.aes192ctx* %12, i32 0, i32 0
  %14 = load i64*, i64** %13, align 8
  call void @aes_ecb(i8* noundef %9, i8* noundef %10, i64 noundef %11, i64* noundef %14, i32 noundef 12)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes192_ctr(i8* noundef %0, i64 noundef %1, i8* noundef %2, %struct.aes192ctx* noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct.aes192ctx*, align 8
  store i8* %0, i8** %5, align 8
  store i64 %1, i64* %6, align 8
  store i8* %2, i8** %7, align 8
  store %struct.aes192ctx* %3, %struct.aes192ctx** %8, align 8
  %9 = load i8*, i8** %5, align 8
  %10 = load i64, i64* %6, align 8
  %11 = load i8*, i8** %7, align 8
  %12 = load %struct.aes192ctx*, %struct.aes192ctx** %8, align 8
  %13 = getelementptr inbounds %struct.aes192ctx, %struct.aes192ctx* %12, i32 0, i32 0
  %14 = load i64*, i64** %13, align 8
  call void @aes_ctr(i8* noundef %9, i64 noundef %10, i8* noundef %11, i64* noundef %14, i32 noundef 12)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes256_ecb(i8* noundef %0, i8* noundef %1, i64 noundef %2, %struct.aes256ctx* noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca %struct.aes256ctx*, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i64 %2, i64* %7, align 8
  store %struct.aes256ctx* %3, %struct.aes256ctx** %8, align 8
  %9 = load i8*, i8** %5, align 8
  %10 = load i8*, i8** %6, align 8
  %11 = load i64, i64* %7, align 8
  %12 = load %struct.aes256ctx*, %struct.aes256ctx** %8, align 8
  %13 = getelementptr inbounds %struct.aes256ctx, %struct.aes256ctx* %12, i32 0, i32 0
  %14 = load i64*, i64** %13, align 8
  call void @aes_ecb(i8* noundef %9, i8* noundef %10, i64 noundef %11, i64* noundef %14, i32 noundef 14)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes256_ctr(i8* noundef %0, i64 noundef %1, i8* noundef %2, %struct.aes256ctx* noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct.aes256ctx*, align 8
  store i8* %0, i8** %5, align 8
  store i64 %1, i64* %6, align 8
  store i8* %2, i8** %7, align 8
  store %struct.aes256ctx* %3, %struct.aes256ctx** %8, align 8
  %9 = load i8*, i8** %5, align 8
  %10 = load i64, i64* %6, align 8
  %11 = load i8*, i8** %7, align 8
  %12 = load %struct.aes256ctx*, %struct.aes256ctx** %8, align 8
  %13 = getelementptr inbounds %struct.aes256ctx, %struct.aes256ctx* %12, i32 0, i32 0
  %14 = load i64*, i64** %13, align 8
  call void @aes_ctr(i8* noundef %9, i64 noundef %10, i8* noundef %11, i64* noundef %14, i32 noundef 14)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes128_ctx_release(%struct.aes128ctx* noundef %0) #0 {
  %2 = alloca %struct.aes128ctx*, align 8
  store %struct.aes128ctx* %0, %struct.aes128ctx** %2, align 8
  %3 = load %struct.aes128ctx*, %struct.aes128ctx** %2, align 8
  %4 = getelementptr inbounds %struct.aes128ctx, %struct.aes128ctx* %3, i32 0, i32 0
  %5 = load i64*, i64** %4, align 8
  %6 = bitcast i64* %5 to i8*
  call void @free(i8* noundef %6)
  ret void
}

declare void @free(i8* noundef) #3

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes192_ctx_release(%struct.aes192ctx* noundef %0) #0 {
  %2 = alloca %struct.aes192ctx*, align 8
  store %struct.aes192ctx* %0, %struct.aes192ctx** %2, align 8
  %3 = load %struct.aes192ctx*, %struct.aes192ctx** %2, align 8
  %4 = getelementptr inbounds %struct.aes192ctx, %struct.aes192ctx* %3, i32 0, i32 0
  %5 = load i64*, i64** %4, align 8
  %6 = bitcast i64* %5 to i8*
  call void @free(i8* noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @aes256_ctx_release(%struct.aes256ctx* noundef %0) #0 {
  %2 = alloca %struct.aes256ctx*, align 8
  store %struct.aes256ctx* %0, %struct.aes256ctx** %2, align 8
  %3 = load %struct.aes256ctx*, %struct.aes256ctx** %2, align 8
  %4 = getelementptr inbounds %struct.aes256ctx, %struct.aes256ctx* %3, i32 0, i32 0
  %5 = load i64*, i64** %4, align 8
  %6 = bitcast i64* %5 to i8*
  call void @free(i8* noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_range_dec32le(i32* noundef %0, i64 noundef %1, i8* noundef %2) #0 {
  %4 = alloca i32*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  store i32* %0, i32** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8* %2, i8** %6, align 8
  br label %7

7:                                                ; preds = %11, %3
  %8 = load i64, i64* %5, align 8
  %9 = add i64 %8, -1
  store i64 %9, i64* %5, align 8
  %10 = icmp ugt i64 %8, 0
  br i1 %10, label %11, label %18

11:                                               ; preds = %7
  %12 = load i8*, i8** %6, align 8
  %13 = call i32 @br_dec32le(i8* noundef %12)
  %14 = load i32*, i32** %4, align 8
  %15 = getelementptr inbounds i32, i32* %14, i32 1
  store i32* %15, i32** %4, align 8
  store i32 %13, i32* %14, align 4
  %16 = load i8*, i8** %6, align 8
  %17 = getelementptr inbounds i8, i8* %16, i64 4
  store i8* %17, i8** %6, align 8
  br label %7, !llvm.loop !17

18:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @sub_word(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca [8 x i64], align 8
  store i32 %0, i32* %2, align 4
  %4 = getelementptr inbounds [8 x i64], [8 x i64]* %3, i64 0, i64 0
  %5 = bitcast i64* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %5, i8 0, i64 64, i1 false)
  %6 = load i32, i32* %2, align 4
  %7 = zext i32 %6 to i64
  %8 = getelementptr inbounds [8 x i64], [8 x i64]* %3, i64 0, i64 0
  store i64 %7, i64* %8, align 8
  %9 = getelementptr inbounds [8 x i64], [8 x i64]* %3, i64 0, i64 0
  call void @br_aes_ct64_ortho(i64* noundef %9)
  %10 = getelementptr inbounds [8 x i64], [8 x i64]* %3, i64 0, i64 0
  call void @br_aes_ct64_bitslice_Sbox(i64* noundef %10)
  %11 = getelementptr inbounds [8 x i64], [8 x i64]* %3, i64 0, i64 0
  call void @br_aes_ct64_ortho(i64* noundef %11)
  %12 = getelementptr inbounds [8 x i64], [8 x i64]* %3, i64 0, i64 0
  %13 = load i64, i64* %12, align 8
  %14 = trunc i64 %13 to i32
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_aes_ct64_interleave_in(i64* noundef %0, i64* noundef %1, i32* noundef %2) #0 {
  %4 = alloca i64*, align 8
  %5 = alloca i64*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  store i64* %0, i64** %4, align 8
  store i64* %1, i64** %5, align 8
  store i32* %2, i32** %6, align 8
  %11 = load i32*, i32** %6, align 8
  %12 = getelementptr inbounds i32, i32* %11, i64 0
  %13 = load i32, i32* %12, align 4
  %14 = zext i32 %13 to i64
  store i64 %14, i64* %7, align 8
  %15 = load i32*, i32** %6, align 8
  %16 = getelementptr inbounds i32, i32* %15, i64 1
  %17 = load i32, i32* %16, align 4
  %18 = zext i32 %17 to i64
  store i64 %18, i64* %8, align 8
  %19 = load i32*, i32** %6, align 8
  %20 = getelementptr inbounds i32, i32* %19, i64 2
  %21 = load i32, i32* %20, align 4
  %22 = zext i32 %21 to i64
  store i64 %22, i64* %9, align 8
  %23 = load i32*, i32** %6, align 8
  %24 = getelementptr inbounds i32, i32* %23, i64 3
  %25 = load i32, i32* %24, align 4
  %26 = zext i32 %25 to i64
  store i64 %26, i64* %10, align 8
  %27 = load i64, i64* %7, align 8
  %28 = shl i64 %27, 16
  %29 = load i64, i64* %7, align 8
  %30 = or i64 %29, %28
  store i64 %30, i64* %7, align 8
  %31 = load i64, i64* %8, align 8
  %32 = shl i64 %31, 16
  %33 = load i64, i64* %8, align 8
  %34 = or i64 %33, %32
  store i64 %34, i64* %8, align 8
  %35 = load i64, i64* %9, align 8
  %36 = shl i64 %35, 16
  %37 = load i64, i64* %9, align 8
  %38 = or i64 %37, %36
  store i64 %38, i64* %9, align 8
  %39 = load i64, i64* %10, align 8
  %40 = shl i64 %39, 16
  %41 = load i64, i64* %10, align 8
  %42 = or i64 %41, %40
  store i64 %42, i64* %10, align 8
  call void @LeftShift_counter(i32 noundef 4, i32 noundef 16)
  call void @OrCC_counter(i32 noundef 4)
  %43 = load i64, i64* %7, align 8
  %44 = and i64 %43, 281470681808895
  store i64 %44, i64* %7, align 8
  %45 = load i64, i64* %8, align 8
  %46 = and i64 %45, 281470681808895
  store i64 %46, i64* %8, align 8
  %47 = load i64, i64* %9, align 8
  %48 = and i64 %47, 281470681808895
  store i64 %48, i64* %9, align 8
  %49 = load i64, i64* %10, align 8
  %50 = and i64 %49, 281470681808895
  store i64 %50, i64* %10, align 8
  call void @AndCC_counter(i32 noundef 4)
  %51 = load i64, i64* %7, align 8
  %52 = shl i64 %51, 8
  %53 = load i64, i64* %7, align 8
  %54 = or i64 %53, %52
  store i64 %54, i64* %7, align 8
  %55 = load i64, i64* %8, align 8
  %56 = shl i64 %55, 8
  %57 = load i64, i64* %8, align 8
  %58 = or i64 %57, %56
  store i64 %58, i64* %8, align 8
  %59 = load i64, i64* %9, align 8
  %60 = shl i64 %59, 8
  %61 = load i64, i64* %9, align 8
  %62 = or i64 %61, %60
  store i64 %62, i64* %9, align 8
  %63 = load i64, i64* %10, align 8
  %64 = shl i64 %63, 8
  %65 = load i64, i64* %10, align 8
  %66 = or i64 %65, %64
  store i64 %66, i64* %10, align 8
  call void @LeftShift_counter(i32 noundef 4, i32 noundef 8)
  call void @OrCC_counter(i32 noundef 4)
  %67 = load i64, i64* %7, align 8
  %68 = and i64 %67, 71777214294589695
  store i64 %68, i64* %7, align 8
  %69 = load i64, i64* %8, align 8
  %70 = and i64 %69, 71777214294589695
  store i64 %70, i64* %8, align 8
  %71 = load i64, i64* %9, align 8
  %72 = and i64 %71, 71777214294589695
  store i64 %72, i64* %9, align 8
  %73 = load i64, i64* %10, align 8
  %74 = and i64 %73, 71777214294589695
  store i64 %74, i64* %10, align 8
  call void @AndCC_counter(i32 noundef 4)
  %75 = load i64, i64* %7, align 8
  %76 = load i64, i64* %9, align 8
  %77 = shl i64 %76, 8
  %78 = or i64 %75, %77
  %79 = load i64*, i64** %4, align 8
  store i64 %78, i64* %79, align 8
  %80 = load i64, i64* %8, align 8
  %81 = load i64, i64* %10, align 8
  %82 = shl i64 %81, 8
  %83 = or i64 %80, %82
  %84 = load i64*, i64** %5, align 8
  store i64 %83, i64* %84, align 8
  call void @LeftShift_counter(i32 noundef 2, i32 noundef 8)
  call void @OrCC_counter(i32 noundef 2)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_aes_ct64_ortho(i64* noundef %0) #0 {
  %2 = alloca i64*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i64, align 8
  %19 = alloca i64, align 8
  %20 = alloca i64, align 8
  %21 = alloca i64, align 8
  %22 = alloca i64, align 8
  %23 = alloca i64, align 8
  %24 = alloca i64, align 8
  %25 = alloca i64, align 8
  %26 = alloca i64, align 8
  store i64* %0, i64** %2, align 8
  br label %27

27:                                               ; preds = %1
  %28 = load i64*, i64** %2, align 8
  %29 = getelementptr inbounds i64, i64* %28, i64 0
  %30 = load i64, i64* %29, align 8
  store i64 %30, i64* %3, align 8
  %31 = load i64*, i64** %2, align 8
  %32 = getelementptr inbounds i64, i64* %31, i64 1
  %33 = load i64, i64* %32, align 8
  store i64 %33, i64* %4, align 8
  %34 = load i64, i64* %3, align 8
  %35 = and i64 %34, 6148914691236517205
  %36 = load i64, i64* %4, align 8
  %37 = and i64 %36, 6148914691236517205
  %38 = shl i64 %37, 1
  %39 = or i64 %35, %38
  %40 = load i64*, i64** %2, align 8
  %41 = getelementptr inbounds i64, i64* %40, i64 0
  store i64 %39, i64* %41, align 8
  %42 = load i64, i64* %3, align 8
  %43 = and i64 %42, -6148914691236517206
  %44 = lshr i64 %43, 1
  %45 = load i64, i64* %4, align 8
  %46 = and i64 %45, -6148914691236517206
  %47 = or i64 %44, %46
  %48 = load i64*, i64** %2, align 8
  %49 = getelementptr inbounds i64, i64* %48, i64 1
  store i64 %47, i64* %49, align 8
  br label %50

50:                                               ; preds = %27
  br label %51

51:                                               ; preds = %50
  %52 = load i64*, i64** %2, align 8
  %53 = getelementptr inbounds i64, i64* %52, i64 2
  %54 = load i64, i64* %53, align 8
  store i64 %54, i64* %5, align 8
  %55 = load i64*, i64** %2, align 8
  %56 = getelementptr inbounds i64, i64* %55, i64 3
  %57 = load i64, i64* %56, align 8
  store i64 %57, i64* %6, align 8
  %58 = load i64, i64* %5, align 8
  %59 = and i64 %58, 6148914691236517205
  %60 = load i64, i64* %6, align 8
  %61 = and i64 %60, 6148914691236517205
  %62 = shl i64 %61, 1
  %63 = or i64 %59, %62
  %64 = load i64*, i64** %2, align 8
  %65 = getelementptr inbounds i64, i64* %64, i64 2
  store i64 %63, i64* %65, align 8
  %66 = load i64, i64* %5, align 8
  %67 = and i64 %66, -6148914691236517206
  %68 = lshr i64 %67, 1
  %69 = load i64, i64* %6, align 8
  %70 = and i64 %69, -6148914691236517206
  %71 = or i64 %68, %70
  %72 = load i64*, i64** %2, align 8
  %73 = getelementptr inbounds i64, i64* %72, i64 3
  store i64 %71, i64* %73, align 8
  br label %74

74:                                               ; preds = %51
  br label %75

75:                                               ; preds = %74
  %76 = load i64*, i64** %2, align 8
  %77 = getelementptr inbounds i64, i64* %76, i64 4
  %78 = load i64, i64* %77, align 8
  store i64 %78, i64* %7, align 8
  %79 = load i64*, i64** %2, align 8
  %80 = getelementptr inbounds i64, i64* %79, i64 5
  %81 = load i64, i64* %80, align 8
  store i64 %81, i64* %8, align 8
  %82 = load i64, i64* %7, align 8
  %83 = and i64 %82, 6148914691236517205
  %84 = load i64, i64* %8, align 8
  %85 = and i64 %84, 6148914691236517205
  %86 = shl i64 %85, 1
  %87 = or i64 %83, %86
  %88 = load i64*, i64** %2, align 8
  %89 = getelementptr inbounds i64, i64* %88, i64 4
  store i64 %87, i64* %89, align 8
  %90 = load i64, i64* %7, align 8
  %91 = and i64 %90, -6148914691236517206
  %92 = lshr i64 %91, 1
  %93 = load i64, i64* %8, align 8
  %94 = and i64 %93, -6148914691236517206
  %95 = or i64 %92, %94
  %96 = load i64*, i64** %2, align 8
  %97 = getelementptr inbounds i64, i64* %96, i64 5
  store i64 %95, i64* %97, align 8
  br label %98

98:                                               ; preds = %75
  br label %99

99:                                               ; preds = %98
  %100 = load i64*, i64** %2, align 8
  %101 = getelementptr inbounds i64, i64* %100, i64 6
  %102 = load i64, i64* %101, align 8
  store i64 %102, i64* %9, align 8
  %103 = load i64*, i64** %2, align 8
  %104 = getelementptr inbounds i64, i64* %103, i64 7
  %105 = load i64, i64* %104, align 8
  store i64 %105, i64* %10, align 8
  %106 = load i64, i64* %9, align 8
  %107 = and i64 %106, 6148914691236517205
  %108 = load i64, i64* %10, align 8
  %109 = and i64 %108, 6148914691236517205
  %110 = shl i64 %109, 1
  %111 = or i64 %107, %110
  %112 = load i64*, i64** %2, align 8
  %113 = getelementptr inbounds i64, i64* %112, i64 6
  store i64 %111, i64* %113, align 8
  %114 = load i64, i64* %9, align 8
  %115 = and i64 %114, -6148914691236517206
  %116 = lshr i64 %115, 1
  %117 = load i64, i64* %10, align 8
  %118 = and i64 %117, -6148914691236517206
  %119 = or i64 %116, %118
  %120 = load i64*, i64** %2, align 8
  %121 = getelementptr inbounds i64, i64* %120, i64 7
  store i64 %119, i64* %121, align 8
  br label %122

122:                                              ; preds = %99
  call void @AndCC_counter(i32 noundef 16)
  call void @LeftShift_counter(i32 noundef 4, i32 noundef 1)
  call void @OrCC_counter(i32 noundef 8)
  call void @RightShift_counter(i32 noundef 4, i32 noundef 1)
  br label %123

123:                                              ; preds = %122
  %124 = load i64*, i64** %2, align 8
  %125 = getelementptr inbounds i64, i64* %124, i64 0
  %126 = load i64, i64* %125, align 8
  store i64 %126, i64* %11, align 8
  %127 = load i64*, i64** %2, align 8
  %128 = getelementptr inbounds i64, i64* %127, i64 2
  %129 = load i64, i64* %128, align 8
  store i64 %129, i64* %12, align 8
  %130 = load i64, i64* %11, align 8
  %131 = and i64 %130, 3689348814741910323
  %132 = load i64, i64* %12, align 8
  %133 = and i64 %132, 3689348814741910323
  %134 = shl i64 %133, 2
  %135 = or i64 %131, %134
  %136 = load i64*, i64** %2, align 8
  %137 = getelementptr inbounds i64, i64* %136, i64 0
  store i64 %135, i64* %137, align 8
  %138 = load i64, i64* %11, align 8
  %139 = and i64 %138, -3689348814741910324
  %140 = lshr i64 %139, 2
  %141 = load i64, i64* %12, align 8
  %142 = and i64 %141, -3689348814741910324
  %143 = or i64 %140, %142
  %144 = load i64*, i64** %2, align 8
  %145 = getelementptr inbounds i64, i64* %144, i64 2
  store i64 %143, i64* %145, align 8
  br label %146

146:                                              ; preds = %123
  br label %147

147:                                              ; preds = %146
  %148 = load i64*, i64** %2, align 8
  %149 = getelementptr inbounds i64, i64* %148, i64 1
  %150 = load i64, i64* %149, align 8
  store i64 %150, i64* %13, align 8
  %151 = load i64*, i64** %2, align 8
  %152 = getelementptr inbounds i64, i64* %151, i64 3
  %153 = load i64, i64* %152, align 8
  store i64 %153, i64* %14, align 8
  %154 = load i64, i64* %13, align 8
  %155 = and i64 %154, 3689348814741910323
  %156 = load i64, i64* %14, align 8
  %157 = and i64 %156, 3689348814741910323
  %158 = shl i64 %157, 2
  %159 = or i64 %155, %158
  %160 = load i64*, i64** %2, align 8
  %161 = getelementptr inbounds i64, i64* %160, i64 1
  store i64 %159, i64* %161, align 8
  %162 = load i64, i64* %13, align 8
  %163 = and i64 %162, -3689348814741910324
  %164 = lshr i64 %163, 2
  %165 = load i64, i64* %14, align 8
  %166 = and i64 %165, -3689348814741910324
  %167 = or i64 %164, %166
  %168 = load i64*, i64** %2, align 8
  %169 = getelementptr inbounds i64, i64* %168, i64 3
  store i64 %167, i64* %169, align 8
  br label %170

170:                                              ; preds = %147
  br label %171

171:                                              ; preds = %170
  %172 = load i64*, i64** %2, align 8
  %173 = getelementptr inbounds i64, i64* %172, i64 4
  %174 = load i64, i64* %173, align 8
  store i64 %174, i64* %15, align 8
  %175 = load i64*, i64** %2, align 8
  %176 = getelementptr inbounds i64, i64* %175, i64 6
  %177 = load i64, i64* %176, align 8
  store i64 %177, i64* %16, align 8
  %178 = load i64, i64* %15, align 8
  %179 = and i64 %178, 3689348814741910323
  %180 = load i64, i64* %16, align 8
  %181 = and i64 %180, 3689348814741910323
  %182 = shl i64 %181, 2
  %183 = or i64 %179, %182
  %184 = load i64*, i64** %2, align 8
  %185 = getelementptr inbounds i64, i64* %184, i64 4
  store i64 %183, i64* %185, align 8
  %186 = load i64, i64* %15, align 8
  %187 = and i64 %186, -3689348814741910324
  %188 = lshr i64 %187, 2
  %189 = load i64, i64* %16, align 8
  %190 = and i64 %189, -3689348814741910324
  %191 = or i64 %188, %190
  %192 = load i64*, i64** %2, align 8
  %193 = getelementptr inbounds i64, i64* %192, i64 6
  store i64 %191, i64* %193, align 8
  br label %194

194:                                              ; preds = %171
  br label %195

195:                                              ; preds = %194
  %196 = load i64*, i64** %2, align 8
  %197 = getelementptr inbounds i64, i64* %196, i64 5
  %198 = load i64, i64* %197, align 8
  store i64 %198, i64* %17, align 8
  %199 = load i64*, i64** %2, align 8
  %200 = getelementptr inbounds i64, i64* %199, i64 7
  %201 = load i64, i64* %200, align 8
  store i64 %201, i64* %18, align 8
  %202 = load i64, i64* %17, align 8
  %203 = and i64 %202, 3689348814741910323
  %204 = load i64, i64* %18, align 8
  %205 = and i64 %204, 3689348814741910323
  %206 = shl i64 %205, 2
  %207 = or i64 %203, %206
  %208 = load i64*, i64** %2, align 8
  %209 = getelementptr inbounds i64, i64* %208, i64 5
  store i64 %207, i64* %209, align 8
  %210 = load i64, i64* %17, align 8
  %211 = and i64 %210, -3689348814741910324
  %212 = lshr i64 %211, 2
  %213 = load i64, i64* %18, align 8
  %214 = and i64 %213, -3689348814741910324
  %215 = or i64 %212, %214
  %216 = load i64*, i64** %2, align 8
  %217 = getelementptr inbounds i64, i64* %216, i64 7
  store i64 %215, i64* %217, align 8
  br label %218

218:                                              ; preds = %195
  call void @AndCC_counter(i32 noundef 16)
  call void @LeftShift_counter(i32 noundef 4, i32 noundef 2)
  call void @OrCC_counter(i32 noundef 8)
  call void @RightShift_counter(i32 noundef 4, i32 noundef 2)
  br label %219

219:                                              ; preds = %218
  %220 = load i64*, i64** %2, align 8
  %221 = getelementptr inbounds i64, i64* %220, i64 0
  %222 = load i64, i64* %221, align 8
  store i64 %222, i64* %19, align 8
  %223 = load i64*, i64** %2, align 8
  %224 = getelementptr inbounds i64, i64* %223, i64 4
  %225 = load i64, i64* %224, align 8
  store i64 %225, i64* %20, align 8
  %226 = load i64, i64* %19, align 8
  %227 = and i64 %226, 1085102592571150095
  %228 = load i64, i64* %20, align 8
  %229 = and i64 %228, 1085102592571150095
  %230 = shl i64 %229, 4
  %231 = or i64 %227, %230
  %232 = load i64*, i64** %2, align 8
  %233 = getelementptr inbounds i64, i64* %232, i64 0
  store i64 %231, i64* %233, align 8
  %234 = load i64, i64* %19, align 8
  %235 = and i64 %234, -1085102592571150096
  %236 = lshr i64 %235, 4
  %237 = load i64, i64* %20, align 8
  %238 = and i64 %237, -1085102592571150096
  %239 = or i64 %236, %238
  %240 = load i64*, i64** %2, align 8
  %241 = getelementptr inbounds i64, i64* %240, i64 4
  store i64 %239, i64* %241, align 8
  br label %242

242:                                              ; preds = %219
  br label %243

243:                                              ; preds = %242
  %244 = load i64*, i64** %2, align 8
  %245 = getelementptr inbounds i64, i64* %244, i64 1
  %246 = load i64, i64* %245, align 8
  store i64 %246, i64* %21, align 8
  %247 = load i64*, i64** %2, align 8
  %248 = getelementptr inbounds i64, i64* %247, i64 5
  %249 = load i64, i64* %248, align 8
  store i64 %249, i64* %22, align 8
  %250 = load i64, i64* %21, align 8
  %251 = and i64 %250, 1085102592571150095
  %252 = load i64, i64* %22, align 8
  %253 = and i64 %252, 1085102592571150095
  %254 = shl i64 %253, 4
  %255 = or i64 %251, %254
  %256 = load i64*, i64** %2, align 8
  %257 = getelementptr inbounds i64, i64* %256, i64 1
  store i64 %255, i64* %257, align 8
  %258 = load i64, i64* %21, align 8
  %259 = and i64 %258, -1085102592571150096
  %260 = lshr i64 %259, 4
  %261 = load i64, i64* %22, align 8
  %262 = and i64 %261, -1085102592571150096
  %263 = or i64 %260, %262
  %264 = load i64*, i64** %2, align 8
  %265 = getelementptr inbounds i64, i64* %264, i64 5
  store i64 %263, i64* %265, align 8
  br label %266

266:                                              ; preds = %243
  br label %267

267:                                              ; preds = %266
  %268 = load i64*, i64** %2, align 8
  %269 = getelementptr inbounds i64, i64* %268, i64 2
  %270 = load i64, i64* %269, align 8
  store i64 %270, i64* %23, align 8
  %271 = load i64*, i64** %2, align 8
  %272 = getelementptr inbounds i64, i64* %271, i64 6
  %273 = load i64, i64* %272, align 8
  store i64 %273, i64* %24, align 8
  %274 = load i64, i64* %23, align 8
  %275 = and i64 %274, 1085102592571150095
  %276 = load i64, i64* %24, align 8
  %277 = and i64 %276, 1085102592571150095
  %278 = shl i64 %277, 4
  %279 = or i64 %275, %278
  %280 = load i64*, i64** %2, align 8
  %281 = getelementptr inbounds i64, i64* %280, i64 2
  store i64 %279, i64* %281, align 8
  %282 = load i64, i64* %23, align 8
  %283 = and i64 %282, -1085102592571150096
  %284 = lshr i64 %283, 4
  %285 = load i64, i64* %24, align 8
  %286 = and i64 %285, -1085102592571150096
  %287 = or i64 %284, %286
  %288 = load i64*, i64** %2, align 8
  %289 = getelementptr inbounds i64, i64* %288, i64 6
  store i64 %287, i64* %289, align 8
  br label %290

290:                                              ; preds = %267
  br label %291

291:                                              ; preds = %290
  %292 = load i64*, i64** %2, align 8
  %293 = getelementptr inbounds i64, i64* %292, i64 3
  %294 = load i64, i64* %293, align 8
  store i64 %294, i64* %25, align 8
  %295 = load i64*, i64** %2, align 8
  %296 = getelementptr inbounds i64, i64* %295, i64 7
  %297 = load i64, i64* %296, align 8
  store i64 %297, i64* %26, align 8
  %298 = load i64, i64* %25, align 8
  %299 = and i64 %298, 1085102592571150095
  %300 = load i64, i64* %26, align 8
  %301 = and i64 %300, 1085102592571150095
  %302 = shl i64 %301, 4
  %303 = or i64 %299, %302
  %304 = load i64*, i64** %2, align 8
  %305 = getelementptr inbounds i64, i64* %304, i64 3
  store i64 %303, i64* %305, align 8
  %306 = load i64, i64* %25, align 8
  %307 = and i64 %306, -1085102592571150096
  %308 = lshr i64 %307, 4
  %309 = load i64, i64* %26, align 8
  %310 = and i64 %309, -1085102592571150096
  %311 = or i64 %308, %310
  %312 = load i64*, i64** %2, align 8
  %313 = getelementptr inbounds i64, i64* %312, i64 7
  store i64 %311, i64* %313, align 8
  br label %314

314:                                              ; preds = %291
  call void @AndCC_counter(i32 noundef 16)
  call void @LeftShift_counter(i32 noundef 4, i32 noundef 4)
  call void @OrCC_counter(i32 noundef 8)
  call void @RightShift_counter(i32 noundef 4, i32 noundef 4)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @br_dec32le(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = getelementptr inbounds i8, i8* %3, i64 0
  %5 = load i8, i8* %4, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8*, i8** %2, align 8
  %8 = getelementptr inbounds i8, i8* %7, i64 1
  %9 = load i8, i8* %8, align 1
  %10 = zext i8 %9 to i32
  %11 = shl i32 %10, 8
  %12 = or i32 %6, %11
  %13 = load i8*, i8** %2, align 8
  %14 = getelementptr inbounds i8, i8* %13, i64 2
  %15 = load i8, i8* %14, align 1
  %16 = zext i8 %15 to i32
  %17 = shl i32 %16, 16
  %18 = or i32 %12, %17
  %19 = load i8*, i8** %2, align 8
  %20 = getelementptr inbounds i8, i8* %19, i64 3
  %21 = load i8, i8* %20, align 1
  %22 = zext i8 %21 to i32
  %23 = shl i32 %22, 24
  %24 = or i32 %18, %23
  ret i32 %24
}

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_aes_ct64_bitslice_Sbox(i64* noundef %0) #0 {
  %2 = alloca i64*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i64, align 8
  %19 = alloca i64, align 8
  %20 = alloca i64, align 8
  %21 = alloca i64, align 8
  %22 = alloca i64, align 8
  %23 = alloca i64, align 8
  %24 = alloca i64, align 8
  %25 = alloca i64, align 8
  %26 = alloca i64, align 8
  %27 = alloca i64, align 8
  %28 = alloca i64, align 8
  %29 = alloca i64, align 8
  %30 = alloca i64, align 8
  %31 = alloca i64, align 8
  %32 = alloca i64, align 8
  %33 = alloca i64, align 8
  %34 = alloca i64, align 8
  %35 = alloca i64, align 8
  %36 = alloca i64, align 8
  %37 = alloca i64, align 8
  %38 = alloca i64, align 8
  %39 = alloca i64, align 8
  %40 = alloca i64, align 8
  %41 = alloca i64, align 8
  %42 = alloca i64, align 8
  %43 = alloca i64, align 8
  %44 = alloca i64, align 8
  %45 = alloca i64, align 8
  %46 = alloca i64, align 8
  %47 = alloca i64, align 8
  %48 = alloca i64, align 8
  %49 = alloca i64, align 8
  %50 = alloca i64, align 8
  %51 = alloca i64, align 8
  %52 = alloca i64, align 8
  %53 = alloca i64, align 8
  %54 = alloca i64, align 8
  %55 = alloca i64, align 8
  %56 = alloca i64, align 8
  %57 = alloca i64, align 8
  %58 = alloca i64, align 8
  %59 = alloca i64, align 8
  %60 = alloca i64, align 8
  %61 = alloca i64, align 8
  %62 = alloca i64, align 8
  %63 = alloca i64, align 8
  %64 = alloca i64, align 8
  %65 = alloca i64, align 8
  %66 = alloca i64, align 8
  %67 = alloca i64, align 8
  %68 = alloca i64, align 8
  %69 = alloca i64, align 8
  %70 = alloca i64, align 8
  %71 = alloca i64, align 8
  %72 = alloca i64, align 8
  %73 = alloca i64, align 8
  %74 = alloca i64, align 8
  %75 = alloca i64, align 8
  %76 = alloca i64, align 8
  %77 = alloca i64, align 8
  %78 = alloca i64, align 8
  %79 = alloca i64, align 8
  %80 = alloca i64, align 8
  %81 = alloca i64, align 8
  %82 = alloca i64, align 8
  %83 = alloca i64, align 8
  %84 = alloca i64, align 8
  %85 = alloca i64, align 8
  %86 = alloca i64, align 8
  %87 = alloca i64, align 8
  %88 = alloca i64, align 8
  %89 = alloca i64, align 8
  %90 = alloca i64, align 8
  %91 = alloca i64, align 8
  %92 = alloca i64, align 8
  %93 = alloca i64, align 8
  %94 = alloca i64, align 8
  %95 = alloca i64, align 8
  %96 = alloca i64, align 8
  %97 = alloca i64, align 8
  %98 = alloca i64, align 8
  %99 = alloca i64, align 8
  %100 = alloca i64, align 8
  %101 = alloca i64, align 8
  %102 = alloca i64, align 8
  %103 = alloca i64, align 8
  %104 = alloca i64, align 8
  %105 = alloca i64, align 8
  %106 = alloca i64, align 8
  %107 = alloca i64, align 8
  %108 = alloca i64, align 8
  %109 = alloca i64, align 8
  %110 = alloca i64, align 8
  %111 = alloca i64, align 8
  %112 = alloca i64, align 8
  %113 = alloca i64, align 8
  %114 = alloca i64, align 8
  %115 = alloca i64, align 8
  %116 = alloca i64, align 8
  %117 = alloca i64, align 8
  %118 = alloca i64, align 8
  %119 = alloca i64, align 8
  %120 = alloca i64, align 8
  %121 = alloca i64, align 8
  %122 = alloca i64, align 8
  %123 = alloca i64, align 8
  %124 = alloca i64, align 8
  %125 = alloca i64, align 8
  store i64* %0, i64** %2, align 8
  %126 = load i64*, i64** %2, align 8
  %127 = getelementptr inbounds i64, i64* %126, i64 7
  %128 = load i64, i64* %127, align 8
  store i64 %128, i64* %3, align 8
  %129 = load i64*, i64** %2, align 8
  %130 = getelementptr inbounds i64, i64* %129, i64 6
  %131 = load i64, i64* %130, align 8
  store i64 %131, i64* %4, align 8
  %132 = load i64*, i64** %2, align 8
  %133 = getelementptr inbounds i64, i64* %132, i64 5
  %134 = load i64, i64* %133, align 8
  store i64 %134, i64* %5, align 8
  %135 = load i64*, i64** %2, align 8
  %136 = getelementptr inbounds i64, i64* %135, i64 4
  %137 = load i64, i64* %136, align 8
  store i64 %137, i64* %6, align 8
  %138 = load i64*, i64** %2, align 8
  %139 = getelementptr inbounds i64, i64* %138, i64 3
  %140 = load i64, i64* %139, align 8
  store i64 %140, i64* %7, align 8
  %141 = load i64*, i64** %2, align 8
  %142 = getelementptr inbounds i64, i64* %141, i64 2
  %143 = load i64, i64* %142, align 8
  store i64 %143, i64* %8, align 8
  %144 = load i64*, i64** %2, align 8
  %145 = getelementptr inbounds i64, i64* %144, i64 1
  %146 = load i64, i64* %145, align 8
  store i64 %146, i64* %9, align 8
  %147 = load i64*, i64** %2, align 8
  %148 = getelementptr inbounds i64, i64* %147, i64 0
  %149 = load i64, i64* %148, align 8
  store i64 %149, i64* %10, align 8
  %150 = load i64, i64* %6, align 8
  %151 = load i64, i64* %8, align 8
  %152 = xor i64 %150, %151
  store i64 %152, i64* %24, align 8
  %153 = load i64, i64* %3, align 8
  %154 = load i64, i64* %9, align 8
  %155 = xor i64 %153, %154
  store i64 %155, i64* %23, align 8
  %156 = load i64, i64* %3, align 8
  %157 = load i64, i64* %6, align 8
  %158 = xor i64 %156, %157
  store i64 %158, i64* %19, align 8
  %159 = load i64, i64* %3, align 8
  %160 = load i64, i64* %8, align 8
  %161 = xor i64 %159, %160
  store i64 %161, i64* %18, align 8
  %162 = load i64, i64* %4, align 8
  %163 = load i64, i64* %5, align 8
  %164 = xor i64 %162, %163
  store i64 %164, i64* %50, align 8
  %165 = load i64, i64* %50, align 8
  %166 = load i64, i64* %10, align 8
  %167 = xor i64 %165, %166
  store i64 %167, i64* %11, align 8
  %168 = load i64, i64* %11, align 8
  %169 = load i64, i64* %6, align 8
  %170 = xor i64 %168, %169
  store i64 %170, i64* %14, align 8
  %171 = load i64, i64* %23, align 8
  %172 = load i64, i64* %24, align 8
  %173 = xor i64 %171, %172
  store i64 %173, i64* %22, align 8
  %174 = load i64, i64* %11, align 8
  %175 = load i64, i64* %3, align 8
  %176 = xor i64 %174, %175
  store i64 %176, i64* %12, align 8
  %177 = load i64, i64* %11, align 8
  %178 = load i64, i64* %9, align 8
  %179 = xor i64 %177, %178
  store i64 %179, i64* %15, align 8
  %180 = load i64, i64* %15, align 8
  %181 = load i64, i64* %18, align 8
  %182 = xor i64 %180, %181
  store i64 %182, i64* %13, align 8
  %183 = load i64, i64* %7, align 8
  %184 = load i64, i64* %22, align 8
  %185 = xor i64 %183, %184
  store i64 %185, i64* %51, align 8
  %186 = load i64, i64* %51, align 8
  %187 = load i64, i64* %8, align 8
  %188 = xor i64 %186, %187
  store i64 %188, i64* %25, align 8
  %189 = load i64, i64* %51, align 8
  %190 = load i64, i64* %4, align 8
  %191 = xor i64 %189, %190
  store i64 %191, i64* %30, align 8
  %192 = load i64, i64* %25, align 8
  %193 = load i64, i64* %10, align 8
  %194 = xor i64 %192, %193
  store i64 %194, i64* %16, align 8
  %195 = load i64, i64* %25, align 8
  %196 = load i64, i64* %50, align 8
  %197 = xor i64 %195, %196
  store i64 %197, i64* %20, align 8
  %198 = load i64, i64* %30, align 8
  %199 = load i64, i64* %19, align 8
  %200 = xor i64 %198, %199
  store i64 %200, i64* %21, align 8
  %201 = load i64, i64* %10, align 8
  %202 = load i64, i64* %21, align 8
  %203 = xor i64 %201, %202
  store i64 %203, i64* %17, align 8
  %204 = load i64, i64* %20, align 8
  %205 = load i64, i64* %21, align 8
  %206 = xor i64 %204, %205
  store i64 %206, i64* %27, align 8
  %207 = load i64, i64* %20, align 8
  %208 = load i64, i64* %18, align 8
  %209 = xor i64 %207, %208
  store i64 %209, i64* %29, align 8
  %210 = load i64, i64* %50, align 8
  %211 = load i64, i64* %21, align 8
  %212 = xor i64 %210, %211
  store i64 %212, i64* %26, align 8
  %213 = load i64, i64* %23, align 8
  %214 = load i64, i64* %26, align 8
  %215 = xor i64 %213, %214
  store i64 %215, i64* %31, align 8
  %216 = load i64, i64* %3, align 8
  %217 = load i64, i64* %26, align 8
  %218 = xor i64 %216, %217
  store i64 %218, i64* %28, align 8
  call void @XorCC_counter(i32 noundef 23)
  %219 = load i64, i64* %22, align 8
  %220 = load i64, i64* %25, align 8
  %221 = and i64 %219, %220
  store i64 %221, i64* %52, align 8
  %222 = load i64, i64* %13, align 8
  %223 = load i64, i64* %16, align 8
  %224 = and i64 %222, %223
  store i64 %224, i64* %53, align 8
  %225 = load i64, i64* %53, align 8
  %226 = load i64, i64* %52, align 8
  %227 = xor i64 %225, %226
  store i64 %227, i64* %54, align 8
  %228 = load i64, i64* %14, align 8
  %229 = load i64, i64* %10, align 8
  %230 = and i64 %228, %229
  store i64 %230, i64* %55, align 8
  %231 = load i64, i64* %55, align 8
  %232 = load i64, i64* %52, align 8
  %233 = xor i64 %231, %232
  store i64 %233, i64* %56, align 8
  %234 = load i64, i64* %23, align 8
  %235 = load i64, i64* %26, align 8
  %236 = and i64 %234, %235
  store i64 %236, i64* %57, align 8
  %237 = load i64, i64* %15, align 8
  %238 = load i64, i64* %11, align 8
  %239 = and i64 %237, %238
  store i64 %239, i64* %58, align 8
  %240 = load i64, i64* %58, align 8
  %241 = load i64, i64* %57, align 8
  %242 = xor i64 %240, %241
  store i64 %242, i64* %59, align 8
  %243 = load i64, i64* %12, align 8
  %244 = load i64, i64* %17, align 8
  %245 = and i64 %243, %244
  store i64 %245, i64* %60, align 8
  %246 = load i64, i64* %60, align 8
  %247 = load i64, i64* %57, align 8
  %248 = xor i64 %246, %247
  store i64 %248, i64* %61, align 8
  %249 = load i64, i64* %19, align 8
  %250 = load i64, i64* %21, align 8
  %251 = and i64 %249, %250
  store i64 %251, i64* %62, align 8
  %252 = load i64, i64* %24, align 8
  %253 = load i64, i64* %27, align 8
  %254 = and i64 %252, %253
  store i64 %254, i64* %63, align 8
  %255 = load i64, i64* %63, align 8
  %256 = load i64, i64* %62, align 8
  %257 = xor i64 %255, %256
  store i64 %257, i64* %64, align 8
  %258 = load i64, i64* %18, align 8
  %259 = load i64, i64* %20, align 8
  %260 = and i64 %258, %259
  store i64 %260, i64* %65, align 8
  %261 = load i64, i64* %65, align 8
  %262 = load i64, i64* %62, align 8
  %263 = xor i64 %261, %262
  store i64 %263, i64* %66, align 8
  %264 = load i64, i64* %54, align 8
  %265 = load i64, i64* %64, align 8
  %266 = xor i64 %264, %265
  store i64 %266, i64* %67, align 8
  %267 = load i64, i64* %56, align 8
  %268 = load i64, i64* %66, align 8
  %269 = xor i64 %267, %268
  store i64 %269, i64* %68, align 8
  %270 = load i64, i64* %59, align 8
  %271 = load i64, i64* %64, align 8
  %272 = xor i64 %270, %271
  store i64 %272, i64* %69, align 8
  %273 = load i64, i64* %61, align 8
  %274 = load i64, i64* %66, align 8
  %275 = xor i64 %273, %274
  store i64 %275, i64* %70, align 8
  %276 = load i64, i64* %67, align 8
  %277 = load i64, i64* %30, align 8
  %278 = xor i64 %276, %277
  store i64 %278, i64* %71, align 8
  %279 = load i64, i64* %68, align 8
  %280 = load i64, i64* %29, align 8
  %281 = xor i64 %279, %280
  store i64 %281, i64* %72, align 8
  %282 = load i64, i64* %69, align 8
  %283 = load i64, i64* %31, align 8
  %284 = xor i64 %282, %283
  store i64 %284, i64* %73, align 8
  %285 = load i64, i64* %70, align 8
  %286 = load i64, i64* %28, align 8
  %287 = xor i64 %285, %286
  store i64 %287, i64* %74, align 8
  call void @AndCC_counter(i32 noundef 14)
  call void @XorCC_counter(i32 noundef 9)
  %288 = load i64, i64* %71, align 8
  %289 = load i64, i64* %72, align 8
  %290 = xor i64 %288, %289
  store i64 %290, i64* %75, align 8
  %291 = load i64, i64* %71, align 8
  %292 = load i64, i64* %73, align 8
  %293 = and i64 %291, %292
  store i64 %293, i64* %76, align 8
  %294 = load i64, i64* %74, align 8
  %295 = load i64, i64* %76, align 8
  %296 = xor i64 %294, %295
  store i64 %296, i64* %77, align 8
  %297 = load i64, i64* %75, align 8
  %298 = load i64, i64* %77, align 8
  %299 = and i64 %297, %298
  store i64 %299, i64* %78, align 8
  %300 = load i64, i64* %78, align 8
  %301 = load i64, i64* %72, align 8
  %302 = xor i64 %300, %301
  store i64 %302, i64* %79, align 8
  %303 = load i64, i64* %73, align 8
  %304 = load i64, i64* %74, align 8
  %305 = xor i64 %303, %304
  store i64 %305, i64* %80, align 8
  %306 = load i64, i64* %72, align 8
  %307 = load i64, i64* %76, align 8
  %308 = xor i64 %306, %307
  store i64 %308, i64* %81, align 8
  %309 = load i64, i64* %81, align 8
  %310 = load i64, i64* %80, align 8
  %311 = and i64 %309, %310
  store i64 %311, i64* %82, align 8
  %312 = load i64, i64* %82, align 8
  %313 = load i64, i64* %74, align 8
  %314 = xor i64 %312, %313
  store i64 %314, i64* %83, align 8
  %315 = load i64, i64* %73, align 8
  %316 = load i64, i64* %83, align 8
  %317 = xor i64 %315, %316
  store i64 %317, i64* %84, align 8
  %318 = load i64, i64* %77, align 8
  %319 = load i64, i64* %83, align 8
  %320 = xor i64 %318, %319
  store i64 %320, i64* %85, align 8
  %321 = load i64, i64* %74, align 8
  %322 = load i64, i64* %85, align 8
  %323 = and i64 %321, %322
  store i64 %323, i64* %86, align 8
  %324 = load i64, i64* %86, align 8
  %325 = load i64, i64* %84, align 8
  %326 = xor i64 %324, %325
  store i64 %326, i64* %87, align 8
  %327 = load i64, i64* %77, align 8
  %328 = load i64, i64* %86, align 8
  %329 = xor i64 %327, %328
  store i64 %329, i64* %88, align 8
  %330 = load i64, i64* %79, align 8
  %331 = load i64, i64* %88, align 8
  %332 = and i64 %330, %331
  store i64 %332, i64* %89, align 8
  %333 = load i64, i64* %75, align 8
  %334 = load i64, i64* %89, align 8
  %335 = xor i64 %333, %334
  store i64 %335, i64* %90, align 8
  call void @AndCC_counter(i32 noundef 5)
  call void @XorCC_counter(i32 noundef 11)
  %336 = load i64, i64* %90, align 8
  %337 = load i64, i64* %87, align 8
  %338 = xor i64 %336, %337
  store i64 %338, i64* %91, align 8
  %339 = load i64, i64* %79, align 8
  %340 = load i64, i64* %83, align 8
  %341 = xor i64 %339, %340
  store i64 %341, i64* %92, align 8
  %342 = load i64, i64* %79, align 8
  %343 = load i64, i64* %90, align 8
  %344 = xor i64 %342, %343
  store i64 %344, i64* %93, align 8
  %345 = load i64, i64* %83, align 8
  %346 = load i64, i64* %87, align 8
  %347 = xor i64 %345, %346
  store i64 %347, i64* %94, align 8
  %348 = load i64, i64* %92, align 8
  %349 = load i64, i64* %91, align 8
  %350 = xor i64 %348, %349
  store i64 %350, i64* %95, align 8
  %351 = load i64, i64* %94, align 8
  %352 = load i64, i64* %25, align 8
  %353 = and i64 %351, %352
  store i64 %353, i64* %32, align 8
  %354 = load i64, i64* %87, align 8
  %355 = load i64, i64* %16, align 8
  %356 = and i64 %354, %355
  store i64 %356, i64* %33, align 8
  %357 = load i64, i64* %83, align 8
  %358 = load i64, i64* %10, align 8
  %359 = and i64 %357, %358
  store i64 %359, i64* %34, align 8
  %360 = load i64, i64* %93, align 8
  %361 = load i64, i64* %26, align 8
  %362 = and i64 %360, %361
  store i64 %362, i64* %35, align 8
  %363 = load i64, i64* %90, align 8
  %364 = load i64, i64* %11, align 8
  %365 = and i64 %363, %364
  store i64 %365, i64* %36, align 8
  %366 = load i64, i64* %79, align 8
  %367 = load i64, i64* %17, align 8
  %368 = and i64 %366, %367
  store i64 %368, i64* %37, align 8
  %369 = load i64, i64* %92, align 8
  %370 = load i64, i64* %21, align 8
  %371 = and i64 %369, %370
  store i64 %371, i64* %38, align 8
  %372 = load i64, i64* %95, align 8
  %373 = load i64, i64* %27, align 8
  %374 = and i64 %372, %373
  store i64 %374, i64* %39, align 8
  %375 = load i64, i64* %91, align 8
  %376 = load i64, i64* %20, align 8
  %377 = and i64 %375, %376
  store i64 %377, i64* %40, align 8
  %378 = load i64, i64* %94, align 8
  %379 = load i64, i64* %22, align 8
  %380 = and i64 %378, %379
  store i64 %380, i64* %41, align 8
  %381 = load i64, i64* %87, align 8
  %382 = load i64, i64* %13, align 8
  %383 = and i64 %381, %382
  store i64 %383, i64* %42, align 8
  %384 = load i64, i64* %83, align 8
  %385 = load i64, i64* %14, align 8
  %386 = and i64 %384, %385
  store i64 %386, i64* %43, align 8
  %387 = load i64, i64* %93, align 8
  %388 = load i64, i64* %23, align 8
  %389 = and i64 %387, %388
  store i64 %389, i64* %44, align 8
  %390 = load i64, i64* %90, align 8
  %391 = load i64, i64* %15, align 8
  %392 = and i64 %390, %391
  store i64 %392, i64* %45, align 8
  %393 = load i64, i64* %79, align 8
  %394 = load i64, i64* %12, align 8
  %395 = and i64 %393, %394
  store i64 %395, i64* %46, align 8
  %396 = load i64, i64* %92, align 8
  %397 = load i64, i64* %19, align 8
  %398 = and i64 %396, %397
  store i64 %398, i64* %47, align 8
  %399 = load i64, i64* %95, align 8
  %400 = load i64, i64* %24, align 8
  %401 = and i64 %399, %400
  store i64 %401, i64* %48, align 8
  %402 = load i64, i64* %91, align 8
  %403 = load i64, i64* %18, align 8
  %404 = and i64 %402, %403
  store i64 %404, i64* %49, align 8
  call void @AndCC_counter(i32 noundef 18)
  call void @XorCC_counter(i32 noundef 5)
  %405 = load i64, i64* %47, align 8
  %406 = load i64, i64* %48, align 8
  %407 = xor i64 %405, %406
  store i64 %407, i64* %96, align 8
  %408 = load i64, i64* %42, align 8
  %409 = load i64, i64* %43, align 8
  %410 = xor i64 %408, %409
  store i64 %410, i64* %97, align 8
  %411 = load i64, i64* %37, align 8
  %412 = load i64, i64* %45, align 8
  %413 = xor i64 %411, %412
  store i64 %413, i64* %98, align 8
  %414 = load i64, i64* %41, align 8
  %415 = load i64, i64* %42, align 8
  %416 = xor i64 %414, %415
  store i64 %416, i64* %99, align 8
  %417 = load i64, i64* %34, align 8
  %418 = load i64, i64* %44, align 8
  %419 = xor i64 %417, %418
  store i64 %419, i64* %100, align 8
  %420 = load i64, i64* %34, align 8
  %421 = load i64, i64* %37, align 8
  %422 = xor i64 %420, %421
  store i64 %422, i64* %101, align 8
  %423 = load i64, i64* %39, align 8
  %424 = load i64, i64* %40, align 8
  %425 = xor i64 %423, %424
  store i64 %425, i64* %102, align 8
  %426 = load i64, i64* %32, align 8
  %427 = load i64, i64* %35, align 8
  %428 = xor i64 %426, %427
  store i64 %428, i64* %103, align 8
  %429 = load i64, i64* %38, align 8
  %430 = load i64, i64* %39, align 8
  %431 = xor i64 %429, %430
  store i64 %431, i64* %104, align 8
  %432 = load i64, i64* %48, align 8
  %433 = load i64, i64* %49, align 8
  %434 = xor i64 %432, %433
  store i64 %434, i64* %105, align 8
  %435 = load i64, i64* %44, align 8
  %436 = load i64, i64* %98, align 8
  %437 = xor i64 %435, %436
  store i64 %437, i64* %106, align 8
  %438 = load i64, i64* %100, align 8
  %439 = load i64, i64* %103, align 8
  %440 = xor i64 %438, %439
  store i64 %440, i64* %107, align 8
  %441 = load i64, i64* %36, align 8
  %442 = load i64, i64* %96, align 8
  %443 = xor i64 %441, %442
  store i64 %443, i64* %108, align 8
  %444 = load i64, i64* %35, align 8
  %445 = load i64, i64* %104, align 8
  %446 = xor i64 %444, %445
  store i64 %446, i64* %109, align 8
  %447 = load i64, i64* %96, align 8
  %448 = load i64, i64* %107, align 8
  %449 = xor i64 %447, %448
  store i64 %449, i64* %110, align 8
  %450 = load i64, i64* %46, align 8
  %451 = load i64, i64* %107, align 8
  %452 = xor i64 %450, %451
  store i64 %452, i64* %111, align 8
  %453 = load i64, i64* %102, align 8
  %454 = load i64, i64* %108, align 8
  %455 = xor i64 %453, %454
  store i64 %455, i64* %112, align 8
  %456 = load i64, i64* %99, align 8
  %457 = load i64, i64* %108, align 8
  %458 = xor i64 %456, %457
  store i64 %458, i64* %113, align 8
  %459 = load i64, i64* %36, align 8
  %460 = load i64, i64* %109, align 8
  %461 = xor i64 %459, %460
  store i64 %461, i64* %114, align 8
  %462 = load i64, i64* %111, align 8
  %463 = load i64, i64* %112, align 8
  %464 = xor i64 %462, %463
  store i64 %464, i64* %115, align 8
  %465 = load i64, i64* %33, align 8
  %466 = load i64, i64* %113, align 8
  %467 = xor i64 %465, %466
  store i64 %467, i64* %116, align 8
  %468 = load i64, i64* %109, align 8
  %469 = load i64, i64* %113, align 8
  %470 = xor i64 %468, %469
  store i64 %470, i64* %118, align 8
  %471 = load i64, i64* %106, align 8
  %472 = load i64, i64* %112, align 8
  %473 = xor i64 %472, -1
  %474 = xor i64 %471, %473
  store i64 %474, i64* %124, align 8
  %475 = load i64, i64* %98, align 8
  %476 = load i64, i64* %110, align 8
  %477 = xor i64 %476, -1
  %478 = xor i64 %475, %477
  store i64 %478, i64* %125, align 8
  %479 = load i64, i64* %114, align 8
  %480 = load i64, i64* %115, align 8
  %481 = xor i64 %479, %480
  store i64 %481, i64* %117, align 8
  %482 = load i64, i64* %103, align 8
  %483 = load i64, i64* %116, align 8
  %484 = xor i64 %482, %483
  store i64 %484, i64* %121, align 8
  %485 = load i64, i64* %101, align 8
  %486 = load i64, i64* %116, align 8
  %487 = xor i64 %485, %486
  store i64 %487, i64* %122, align 8
  %488 = load i64, i64* %97, align 8
  %489 = load i64, i64* %115, align 8
  %490 = xor i64 %488, %489
  store i64 %490, i64* %123, align 8
  %491 = load i64, i64* %114, align 8
  %492 = load i64, i64* %121, align 8
  %493 = xor i64 %492, -1
  %494 = xor i64 %491, %493
  store i64 %494, i64* %119, align 8
  %495 = load i64, i64* %105, align 8
  %496 = load i64, i64* %117, align 8
  %497 = xor i64 %496, -1
  %498 = xor i64 %495, %497
  store i64 %498, i64* %120, align 8
  call void @XorCC_counter(i32 noundef 30)
  call void @NotCC_counter(i32 noundef 4)
  %499 = load i64, i64* %118, align 8
  %500 = load i64*, i64** %2, align 8
  %501 = getelementptr inbounds i64, i64* %500, i64 7
  store i64 %499, i64* %501, align 8
  %502 = load i64, i64* %119, align 8
  %503 = load i64*, i64** %2, align 8
  %504 = getelementptr inbounds i64, i64* %503, i64 6
  store i64 %502, i64* %504, align 8
  %505 = load i64, i64* %120, align 8
  %506 = load i64*, i64** %2, align 8
  %507 = getelementptr inbounds i64, i64* %506, i64 5
  store i64 %505, i64* %507, align 8
  %508 = load i64, i64* %121, align 8
  %509 = load i64*, i64** %2, align 8
  %510 = getelementptr inbounds i64, i64* %509, i64 4
  store i64 %508, i64* %510, align 8
  %511 = load i64, i64* %122, align 8
  %512 = load i64*, i64** %2, align 8
  %513 = getelementptr inbounds i64, i64* %512, i64 3
  store i64 %511, i64* %513, align 8
  %514 = load i64, i64* %123, align 8
  %515 = load i64*, i64** %2, align 8
  %516 = getelementptr inbounds i64, i64* %515, i64 2
  store i64 %514, i64* %516, align 8
  %517 = load i64, i64* %124, align 8
  %518 = load i64*, i64** %2, align 8
  %519 = getelementptr inbounds i64, i64* %518, i64 1
  store i64 %517, i64* %519, align 8
  %520 = load i64, i64* %125, align 8
  %521 = load i64*, i64** %2, align 8
  %522 = getelementptr inbounds i64, i64* %521, i64 0
  store i64 %520, i64* %522, align 8
  ret void
}

declare void @XorCC_counter(i32 noundef) #3

declare void @AndCC_counter(i32 noundef) #3

declare void @NotCC_counter(i32 noundef) #3

declare void @LeftShift_counter(i32 noundef, i32 noundef) #3

declare void @OrCC_counter(i32 noundef) #3

declare void @RightShift_counter(i32 noundef, i32 noundef) #3

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @aes_ecb4x(i8* noundef %0, i32* noundef %1, i64* noundef %2, i32 noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i64*, align 8
  %8 = alloca i32, align 4
  %9 = alloca [16 x i32], align 4
  %10 = alloca [8 x i64], align 8
  %11 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i32* %1, i32** %6, align 8
  store i64* %2, i64** %7, align 8
  store i32 %3, i32* %8, align 4
  %12 = getelementptr inbounds [16 x i32], [16 x i32]* %9, i64 0, i64 0
  %13 = bitcast i32* %12 to i8*
  %14 = load i32*, i32** %6, align 8
  %15 = bitcast i32* %14 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %13, i8* align 4 %15, i64 64, i1 false)
  call void @WriteCC_counter(i32 noundef 16)
  store i32 0, i32* %11, align 4
  br label %16

16:                                               ; preds = %32, %4
  %17 = load i32, i32* %11, align 4
  %18 = icmp ult i32 %17, 4
  br i1 %18, label %19, label %35

19:                                               ; preds = %16
  %20 = load i32, i32* %11, align 4
  %21 = zext i32 %20 to i64
  %22 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 %21
  %23 = load i32, i32* %11, align 4
  %24 = add i32 %23, 4
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 %25
  %27 = getelementptr inbounds [16 x i32], [16 x i32]* %9, i64 0, i64 0
  %28 = load i32, i32* %11, align 4
  %29 = shl i32 %28, 2
  %30 = zext i32 %29 to i64
  %31 = getelementptr inbounds i32, i32* %27, i64 %30
  call void @br_aes_ct64_interleave_in(i64* noundef %22, i64* noundef %26, i32* noundef %31)
  br label %32

32:                                               ; preds = %19
  %33 = load i32, i32* %11, align 4
  %34 = add i32 %33, 1
  store i32 %34, i32* %11, align 4
  br label %16, !llvm.loop !18

35:                                               ; preds = %16
  %36 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  call void @br_aes_ct64_ortho(i64* noundef %36)
  %37 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  %38 = load i64*, i64** %7, align 8
  call void @add_round_key(i64* noundef %37, i64* noundef %38)
  store i32 1, i32* %11, align 4
  br label %39

39:                                               ; preds = %53, %35
  %40 = load i32, i32* %11, align 4
  %41 = load i32, i32* %8, align 4
  %42 = icmp ult i32 %40, %41
  br i1 %42, label %43, label %56

43:                                               ; preds = %39
  %44 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  call void @br_aes_ct64_bitslice_Sbox(i64* noundef %44)
  %45 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  call void @shift_rows(i64* noundef %45)
  %46 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  call void @mix_columns(i64* noundef %46)
  %47 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  %48 = load i64*, i64** %7, align 8
  %49 = load i32, i32* %11, align 4
  %50 = shl i32 %49, 3
  %51 = zext i32 %50 to i64
  %52 = getelementptr inbounds i64, i64* %48, i64 %51
  call void @add_round_key(i64* noundef %47, i64* noundef %52)
  br label %53

53:                                               ; preds = %43
  %54 = load i32, i32* %11, align 4
  %55 = add i32 %54, 1
  store i32 %55, i32* %11, align 4
  br label %39, !llvm.loop !19

56:                                               ; preds = %39
  %57 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  call void @br_aes_ct64_bitslice_Sbox(i64* noundef %57)
  %58 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  call void @shift_rows(i64* noundef %58)
  %59 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  %60 = load i64*, i64** %7, align 8
  %61 = load i32, i32* %8, align 4
  %62 = mul i32 8, %61
  %63 = zext i32 %62 to i64
  %64 = getelementptr inbounds i64, i64* %60, i64 %63
  call void @add_round_key(i64* noundef %59, i64* noundef %64)
  %65 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 0
  call void @br_aes_ct64_ortho(i64* noundef %65)
  store i32 0, i32* %11, align 4
  br label %66

66:                                               ; preds = %84, %56
  %67 = load i32, i32* %11, align 4
  %68 = icmp ult i32 %67, 4
  br i1 %68, label %69, label %87

69:                                               ; preds = %66
  %70 = getelementptr inbounds [16 x i32], [16 x i32]* %9, i64 0, i64 0
  %71 = load i32, i32* %11, align 4
  %72 = shl i32 %71, 2
  %73 = zext i32 %72 to i64
  %74 = getelementptr inbounds i32, i32* %70, i64 %73
  %75 = load i32, i32* %11, align 4
  %76 = zext i32 %75 to i64
  %77 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 %76
  %78 = load i64, i64* %77, align 8
  %79 = load i32, i32* %11, align 4
  %80 = add i32 %79, 4
  %81 = zext i32 %80 to i64
  %82 = getelementptr inbounds [8 x i64], [8 x i64]* %10, i64 0, i64 %81
  %83 = load i64, i64* %82, align 8
  call void @br_aes_ct64_interleave_out(i32* noundef %74, i64 noundef %78, i64 noundef %83)
  br label %84

84:                                               ; preds = %69
  %85 = load i32, i32* %11, align 4
  %86 = add i32 %85, 1
  store i32 %86, i32* %11, align 4
  br label %66, !llvm.loop !20

87:                                               ; preds = %66
  %88 = load i8*, i8** %5, align 8
  %89 = getelementptr inbounds [16 x i32], [16 x i32]* %9, i64 0, i64 0
  call void @br_range_enc32le(i8* noundef %88, i32* noundef %89, i64 noundef 16)
  ret void
}

; Function Attrs: nounwind
declare i8* @__memcpy_chk(i8* noundef, i8* noundef, i64 noundef, i64 noundef) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg) #6

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #7

declare void @WriteCC_counter(i32 noundef) #3

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @add_round_key(i64* noundef %0, i64* noundef %1) #0 {
  %3 = alloca i64*, align 8
  %4 = alloca i64*, align 8
  store i64* %0, i64** %3, align 8
  store i64* %1, i64** %4, align 8
  %5 = load i64*, i64** %4, align 8
  %6 = getelementptr inbounds i64, i64* %5, i64 0
  %7 = load i64, i64* %6, align 8
  %8 = load i64*, i64** %3, align 8
  %9 = getelementptr inbounds i64, i64* %8, i64 0
  %10 = load i64, i64* %9, align 8
  %11 = xor i64 %10, %7
  store i64 %11, i64* %9, align 8
  %12 = load i64*, i64** %4, align 8
  %13 = getelementptr inbounds i64, i64* %12, i64 1
  %14 = load i64, i64* %13, align 8
  %15 = load i64*, i64** %3, align 8
  %16 = getelementptr inbounds i64, i64* %15, i64 1
  %17 = load i64, i64* %16, align 8
  %18 = xor i64 %17, %14
  store i64 %18, i64* %16, align 8
  %19 = load i64*, i64** %4, align 8
  %20 = getelementptr inbounds i64, i64* %19, i64 2
  %21 = load i64, i64* %20, align 8
  %22 = load i64*, i64** %3, align 8
  %23 = getelementptr inbounds i64, i64* %22, i64 2
  %24 = load i64, i64* %23, align 8
  %25 = xor i64 %24, %21
  store i64 %25, i64* %23, align 8
  %26 = load i64*, i64** %4, align 8
  %27 = getelementptr inbounds i64, i64* %26, i64 3
  %28 = load i64, i64* %27, align 8
  %29 = load i64*, i64** %3, align 8
  %30 = getelementptr inbounds i64, i64* %29, i64 3
  %31 = load i64, i64* %30, align 8
  %32 = xor i64 %31, %28
  store i64 %32, i64* %30, align 8
  %33 = load i64*, i64** %4, align 8
  %34 = getelementptr inbounds i64, i64* %33, i64 4
  %35 = load i64, i64* %34, align 8
  %36 = load i64*, i64** %3, align 8
  %37 = getelementptr inbounds i64, i64* %36, i64 4
  %38 = load i64, i64* %37, align 8
  %39 = xor i64 %38, %35
  store i64 %39, i64* %37, align 8
  %40 = load i64*, i64** %4, align 8
  %41 = getelementptr inbounds i64, i64* %40, i64 5
  %42 = load i64, i64* %41, align 8
  %43 = load i64*, i64** %3, align 8
  %44 = getelementptr inbounds i64, i64* %43, i64 5
  %45 = load i64, i64* %44, align 8
  %46 = xor i64 %45, %42
  store i64 %46, i64* %44, align 8
  %47 = load i64*, i64** %4, align 8
  %48 = getelementptr inbounds i64, i64* %47, i64 6
  %49 = load i64, i64* %48, align 8
  %50 = load i64*, i64** %3, align 8
  %51 = getelementptr inbounds i64, i64* %50, i64 6
  %52 = load i64, i64* %51, align 8
  %53 = xor i64 %52, %49
  store i64 %53, i64* %51, align 8
  %54 = load i64*, i64** %4, align 8
  %55 = getelementptr inbounds i64, i64* %54, i64 7
  %56 = load i64, i64* %55, align 8
  %57 = load i64*, i64** %3, align 8
  %58 = getelementptr inbounds i64, i64* %57, i64 7
  %59 = load i64, i64* %58, align 8
  %60 = xor i64 %59, %56
  store i64 %60, i64* %58, align 8
  call void @XorCC_counter(i32 noundef 8)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @shift_rows(i64* noundef %0) #0 {
  %2 = alloca i64*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  store i64* %0, i64** %2, align 8
  store i32 0, i32* %3, align 4
  br label %5

5:                                                ; preds = %44, %1
  %6 = load i32, i32* %3, align 4
  %7 = icmp slt i32 %6, 8
  br i1 %7, label %8, label %47

8:                                                ; preds = %5
  %9 = load i64*, i64** %2, align 8
  %10 = load i32, i32* %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds i64, i64* %9, i64 %11
  %13 = load i64, i64* %12, align 8
  store i64 %13, i64* %4, align 8
  %14 = load i64, i64* %4, align 8
  %15 = and i64 %14, 65535
  %16 = load i64, i64* %4, align 8
  %17 = and i64 %16, 4293918720
  %18 = lshr i64 %17, 4
  %19 = or i64 %15, %18
  %20 = load i64, i64* %4, align 8
  %21 = and i64 %20, 983040
  %22 = shl i64 %21, 12
  %23 = or i64 %19, %22
  %24 = load i64, i64* %4, align 8
  %25 = and i64 %24, 280375465082880
  %26 = lshr i64 %25, 8
  %27 = or i64 %23, %26
  %28 = load i64, i64* %4, align 8
  %29 = and i64 %28, 1095216660480
  %30 = shl i64 %29, 8
  %31 = or i64 %27, %30
  %32 = load i64, i64* %4, align 8
  %33 = and i64 %32, -1152921504606846976
  %34 = lshr i64 %33, 12
  %35 = or i64 %31, %34
  %36 = load i64, i64* %4, align 8
  %37 = and i64 %36, 1152640029630136320
  %38 = shl i64 %37, 4
  %39 = or i64 %35, %38
  %40 = load i64*, i64** %2, align 8
  %41 = load i32, i32* %3, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i64, i64* %40, i64 %42
  store i64 %39, i64* %43, align 8
  call void @AndCC_counter(i32 noundef 7)
  call void @OrCC_counter(i32 noundef 6)
  call void @RightShift_counter(i32 noundef 1, i32 noundef 4)
  call void @RightShift_counter(i32 noundef 1, i32 noundef 8)
  call void @RightShift_counter(i32 noundef 1, i32 noundef 12)
  call void @LeftShift_counter(i32 noundef 1, i32 noundef 12)
  call void @LeftShift_counter(i32 noundef 1, i32 noundef 8)
  call void @LeftShift_counter(i32 noundef 1, i32 noundef 4)
  br label %44

44:                                               ; preds = %8
  %45 = load i32, i32* %3, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, i32* %3, align 4
  br label %5, !llvm.loop !21

47:                                               ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @mix_columns(i64* noundef %0) #0 {
  %2 = alloca i64*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i64, align 8
  store i64* %0, i64** %2, align 8
  %19 = load i64*, i64** %2, align 8
  %20 = getelementptr inbounds i64, i64* %19, i64 0
  %21 = load i64, i64* %20, align 8
  store i64 %21, i64* %3, align 8
  %22 = load i64*, i64** %2, align 8
  %23 = getelementptr inbounds i64, i64* %22, i64 1
  %24 = load i64, i64* %23, align 8
  store i64 %24, i64* %4, align 8
  %25 = load i64*, i64** %2, align 8
  %26 = getelementptr inbounds i64, i64* %25, i64 2
  %27 = load i64, i64* %26, align 8
  store i64 %27, i64* %5, align 8
  %28 = load i64*, i64** %2, align 8
  %29 = getelementptr inbounds i64, i64* %28, i64 3
  %30 = load i64, i64* %29, align 8
  store i64 %30, i64* %6, align 8
  %31 = load i64*, i64** %2, align 8
  %32 = getelementptr inbounds i64, i64* %31, i64 4
  %33 = load i64, i64* %32, align 8
  store i64 %33, i64* %7, align 8
  %34 = load i64*, i64** %2, align 8
  %35 = getelementptr inbounds i64, i64* %34, i64 5
  %36 = load i64, i64* %35, align 8
  store i64 %36, i64* %8, align 8
  %37 = load i64*, i64** %2, align 8
  %38 = getelementptr inbounds i64, i64* %37, i64 6
  %39 = load i64, i64* %38, align 8
  store i64 %39, i64* %9, align 8
  %40 = load i64*, i64** %2, align 8
  %41 = getelementptr inbounds i64, i64* %40, i64 7
  %42 = load i64, i64* %41, align 8
  store i64 %42, i64* %10, align 8
  %43 = load i64, i64* %3, align 8
  %44 = lshr i64 %43, 16
  %45 = load i64, i64* %3, align 8
  %46 = shl i64 %45, 48
  %47 = or i64 %44, %46
  store i64 %47, i64* %11, align 8
  %48 = load i64, i64* %4, align 8
  %49 = lshr i64 %48, 16
  %50 = load i64, i64* %4, align 8
  %51 = shl i64 %50, 48
  %52 = or i64 %49, %51
  store i64 %52, i64* %12, align 8
  %53 = load i64, i64* %5, align 8
  %54 = lshr i64 %53, 16
  %55 = load i64, i64* %5, align 8
  %56 = shl i64 %55, 48
  %57 = or i64 %54, %56
  store i64 %57, i64* %13, align 8
  %58 = load i64, i64* %6, align 8
  %59 = lshr i64 %58, 16
  %60 = load i64, i64* %6, align 8
  %61 = shl i64 %60, 48
  %62 = or i64 %59, %61
  store i64 %62, i64* %14, align 8
  %63 = load i64, i64* %7, align 8
  %64 = lshr i64 %63, 16
  %65 = load i64, i64* %7, align 8
  %66 = shl i64 %65, 48
  %67 = or i64 %64, %66
  store i64 %67, i64* %15, align 8
  %68 = load i64, i64* %8, align 8
  %69 = lshr i64 %68, 16
  %70 = load i64, i64* %8, align 8
  %71 = shl i64 %70, 48
  %72 = or i64 %69, %71
  store i64 %72, i64* %16, align 8
  %73 = load i64, i64* %9, align 8
  %74 = lshr i64 %73, 16
  %75 = load i64, i64* %9, align 8
  %76 = shl i64 %75, 48
  %77 = or i64 %74, %76
  store i64 %77, i64* %17, align 8
  %78 = load i64, i64* %10, align 8
  %79 = lshr i64 %78, 16
  %80 = load i64, i64* %10, align 8
  %81 = shl i64 %80, 48
  %82 = or i64 %79, %81
  store i64 %82, i64* %18, align 8
  call void @RightShift_counter(i32 noundef 8, i32 noundef 16)
  call void @LeftShift_counter(i32 noundef 8, i32 noundef 48)
  call void @OrCC_counter(i32 noundef 8)
  %83 = load i64, i64* %10, align 8
  %84 = load i64, i64* %18, align 8
  %85 = xor i64 %83, %84
  %86 = load i64, i64* %11, align 8
  %87 = xor i64 %85, %86
  %88 = load i64, i64* %3, align 8
  %89 = load i64, i64* %11, align 8
  %90 = xor i64 %88, %89
  %91 = call i64 @rotr32(i64 noundef %90)
  %92 = xor i64 %87, %91
  %93 = load i64*, i64** %2, align 8
  %94 = getelementptr inbounds i64, i64* %93, i64 0
  store i64 %92, i64* %94, align 8
  %95 = load i64, i64* %3, align 8
  %96 = load i64, i64* %11, align 8
  %97 = xor i64 %95, %96
  %98 = load i64, i64* %10, align 8
  %99 = xor i64 %97, %98
  %100 = load i64, i64* %18, align 8
  %101 = xor i64 %99, %100
  %102 = load i64, i64* %12, align 8
  %103 = xor i64 %101, %102
  %104 = load i64, i64* %4, align 8
  %105 = load i64, i64* %12, align 8
  %106 = xor i64 %104, %105
  %107 = call i64 @rotr32(i64 noundef %106)
  %108 = xor i64 %103, %107
  %109 = load i64*, i64** %2, align 8
  %110 = getelementptr inbounds i64, i64* %109, i64 1
  store i64 %108, i64* %110, align 8
  %111 = load i64, i64* %4, align 8
  %112 = load i64, i64* %12, align 8
  %113 = xor i64 %111, %112
  %114 = load i64, i64* %13, align 8
  %115 = xor i64 %113, %114
  %116 = load i64, i64* %5, align 8
  %117 = load i64, i64* %13, align 8
  %118 = xor i64 %116, %117
  %119 = call i64 @rotr32(i64 noundef %118)
  %120 = xor i64 %115, %119
  %121 = load i64*, i64** %2, align 8
  %122 = getelementptr inbounds i64, i64* %121, i64 2
  store i64 %120, i64* %122, align 8
  %123 = load i64, i64* %5, align 8
  %124 = load i64, i64* %13, align 8
  %125 = xor i64 %123, %124
  %126 = load i64, i64* %10, align 8
  %127 = xor i64 %125, %126
  %128 = load i64, i64* %18, align 8
  %129 = xor i64 %127, %128
  %130 = load i64, i64* %14, align 8
  %131 = xor i64 %129, %130
  %132 = load i64, i64* %6, align 8
  %133 = load i64, i64* %14, align 8
  %134 = xor i64 %132, %133
  %135 = call i64 @rotr32(i64 noundef %134)
  %136 = xor i64 %131, %135
  %137 = load i64*, i64** %2, align 8
  %138 = getelementptr inbounds i64, i64* %137, i64 3
  store i64 %136, i64* %138, align 8
  %139 = load i64, i64* %6, align 8
  %140 = load i64, i64* %14, align 8
  %141 = xor i64 %139, %140
  %142 = load i64, i64* %10, align 8
  %143 = xor i64 %141, %142
  %144 = load i64, i64* %18, align 8
  %145 = xor i64 %143, %144
  %146 = load i64, i64* %15, align 8
  %147 = xor i64 %145, %146
  %148 = load i64, i64* %7, align 8
  %149 = load i64, i64* %15, align 8
  %150 = xor i64 %148, %149
  %151 = call i64 @rotr32(i64 noundef %150)
  %152 = xor i64 %147, %151
  %153 = load i64*, i64** %2, align 8
  %154 = getelementptr inbounds i64, i64* %153, i64 4
  store i64 %152, i64* %154, align 8
  %155 = load i64, i64* %7, align 8
  %156 = load i64, i64* %15, align 8
  %157 = xor i64 %155, %156
  %158 = load i64, i64* %16, align 8
  %159 = xor i64 %157, %158
  %160 = load i64, i64* %8, align 8
  %161 = load i64, i64* %16, align 8
  %162 = xor i64 %160, %161
  %163 = call i64 @rotr32(i64 noundef %162)
  %164 = xor i64 %159, %163
  %165 = load i64*, i64** %2, align 8
  %166 = getelementptr inbounds i64, i64* %165, i64 5
  store i64 %164, i64* %166, align 8
  %167 = load i64, i64* %8, align 8
  %168 = load i64, i64* %16, align 8
  %169 = xor i64 %167, %168
  %170 = load i64, i64* %17, align 8
  %171 = xor i64 %169, %170
  %172 = load i64, i64* %9, align 8
  %173 = load i64, i64* %17, align 8
  %174 = xor i64 %172, %173
  %175 = call i64 @rotr32(i64 noundef %174)
  %176 = xor i64 %171, %175
  %177 = load i64*, i64** %2, align 8
  %178 = getelementptr inbounds i64, i64* %177, i64 6
  store i64 %176, i64* %178, align 8
  %179 = load i64, i64* %9, align 8
  %180 = load i64, i64* %17, align 8
  %181 = xor i64 %179, %180
  %182 = load i64, i64* %18, align 8
  %183 = xor i64 %181, %182
  %184 = load i64, i64* %10, align 8
  %185 = load i64, i64* %18, align 8
  %186 = xor i64 %184, %185
  %187 = call i64 @rotr32(i64 noundef %186)
  %188 = xor i64 %183, %187
  %189 = load i64*, i64** %2, align 8
  %190 = getelementptr inbounds i64, i64* %189, i64 7
  store i64 %188, i64* %190, align 8
  call void @LeftShift_counter(i32 noundef 8, i32 noundef 32)
  call void @RightShift_counter(i32 noundef 8, i32 noundef 32)
  call void @OrCC_counter(i32 noundef 8)
  call void @XorCC_counter(i32 noundef 38)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_aes_ct64_interleave_out(i32* noundef %0, i64 noundef %1, i64 noundef %2) #0 {
  %4 = alloca i32*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  store i32* %0, i32** %4, align 8
  store i64 %1, i64* %5, align 8
  store i64 %2, i64* %6, align 8
  %11 = load i64, i64* %5, align 8
  %12 = and i64 %11, 71777214294589695
  store i64 %12, i64* %7, align 8
  %13 = load i64, i64* %6, align 8
  %14 = and i64 %13, 71777214294589695
  store i64 %14, i64* %8, align 8
  call void @AndCC_counter(i32 noundef 2)
  %15 = load i64, i64* %5, align 8
  %16 = lshr i64 %15, 8
  %17 = and i64 %16, 71777214294589695
  store i64 %17, i64* %9, align 8
  %18 = load i64, i64* %6, align 8
  %19 = lshr i64 %18, 8
  %20 = and i64 %19, 71777214294589695
  store i64 %20, i64* %10, align 8
  call void @RightShift_counter(i32 noundef 2, i32 noundef 8)
  call void @AndCC_counter(i32 noundef 2)
  %21 = load i64, i64* %7, align 8
  %22 = lshr i64 %21, 8
  %23 = load i64, i64* %7, align 8
  %24 = or i64 %23, %22
  store i64 %24, i64* %7, align 8
  %25 = load i64, i64* %8, align 8
  %26 = lshr i64 %25, 8
  %27 = load i64, i64* %8, align 8
  %28 = or i64 %27, %26
  store i64 %28, i64* %8, align 8
  %29 = load i64, i64* %9, align 8
  %30 = lshr i64 %29, 8
  %31 = load i64, i64* %9, align 8
  %32 = or i64 %31, %30
  store i64 %32, i64* %9, align 8
  %33 = load i64, i64* %10, align 8
  %34 = lshr i64 %33, 8
  %35 = load i64, i64* %10, align 8
  %36 = or i64 %35, %34
  store i64 %36, i64* %10, align 8
  call void @RightShift_counter(i32 noundef 4, i32 noundef 8)
  call void @OrCC_counter(i32 noundef 4)
  %37 = load i64, i64* %7, align 8
  %38 = and i64 %37, 281470681808895
  store i64 %38, i64* %7, align 8
  %39 = load i64, i64* %8, align 8
  %40 = and i64 %39, 281470681808895
  store i64 %40, i64* %8, align 8
  %41 = load i64, i64* %9, align 8
  %42 = and i64 %41, 281470681808895
  store i64 %42, i64* %9, align 8
  %43 = load i64, i64* %10, align 8
  %44 = and i64 %43, 281470681808895
  store i64 %44, i64* %10, align 8
  call void @AndCC_counter(i32 noundef 4)
  %45 = load i64, i64* %7, align 8
  %46 = trunc i64 %45 to i32
  %47 = load i64, i64* %7, align 8
  %48 = lshr i64 %47, 16
  %49 = trunc i64 %48 to i32
  %50 = or i32 %46, %49
  %51 = load i32*, i32** %4, align 8
  %52 = getelementptr inbounds i32, i32* %51, i64 0
  store i32 %50, i32* %52, align 4
  %53 = load i64, i64* %8, align 8
  %54 = trunc i64 %53 to i32
  %55 = load i64, i64* %8, align 8
  %56 = lshr i64 %55, 16
  %57 = trunc i64 %56 to i32
  %58 = or i32 %54, %57
  %59 = load i32*, i32** %4, align 8
  %60 = getelementptr inbounds i32, i32* %59, i64 1
  store i32 %58, i32* %60, align 4
  %61 = load i64, i64* %9, align 8
  %62 = trunc i64 %61 to i32
  %63 = load i64, i64* %9, align 8
  %64 = lshr i64 %63, 16
  %65 = trunc i64 %64 to i32
  %66 = or i32 %62, %65
  %67 = load i32*, i32** %4, align 8
  %68 = getelementptr inbounds i32, i32* %67, i64 2
  store i32 %66, i32* %68, align 4
  %69 = load i64, i64* %10, align 8
  %70 = trunc i64 %69 to i32
  %71 = load i64, i64* %10, align 8
  %72 = lshr i64 %71, 16
  %73 = trunc i64 %72 to i32
  %74 = or i32 %70, %73
  %75 = load i32*, i32** %4, align 8
  %76 = getelementptr inbounds i32, i32* %75, i64 3
  store i32 %74, i32* %76, align 4
  call void @RightShift_counter(i32 noundef 4, i32 noundef 16)
  call void @OrCC_counter(i32 noundef 4)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_range_enc32le(i8* noundef %0, i32* noundef %1, i64 noundef %2) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i64, align 8
  store i8* %0, i8** %4, align 8
  store i32* %1, i32** %5, align 8
  store i64 %2, i64* %6, align 8
  br label %7

7:                                                ; preds = %11, %3
  %8 = load i64, i64* %6, align 8
  %9 = add i64 %8, -1
  store i64 %9, i64* %6, align 8
  %10 = icmp ugt i64 %8, 0
  br i1 %10, label %11, label %18

11:                                               ; preds = %7
  %12 = load i8*, i8** %4, align 8
  %13 = load i32*, i32** %5, align 8
  %14 = getelementptr inbounds i32, i32* %13, i32 1
  store i32* %14, i32** %5, align 8
  %15 = load i32, i32* %13, align 4
  call void @br_enc32le(i8* noundef %12, i32 noundef %15)
  %16 = load i8*, i8** %4, align 8
  %17 = getelementptr inbounds i8, i8* %16, i64 4
  store i8* %17, i8** %4, align 8
  br label %7, !llvm.loop !22

18:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i64 @rotr32(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = shl i64 %3, 32
  %5 = load i64, i64* %2, align 8
  %6 = lshr i64 %5, 32
  %7 = or i64 %4, %6
  ret i64 %7
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @br_enc32le(i8* noundef %0, i32 noundef %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = trunc i32 %5 to i8
  %7 = load i8*, i8** %3, align 8
  %8 = getelementptr inbounds i8, i8* %7, i64 0
  store i8 %6, i8* %8, align 1
  %9 = load i32, i32* %4, align 4
  %10 = lshr i32 %9, 8
  %11 = trunc i32 %10 to i8
  %12 = load i8*, i8** %3, align 8
  %13 = getelementptr inbounds i8, i8* %12, i64 1
  store i8 %11, i8* %13, align 1
  %14 = load i32, i32* %4, align 4
  %15 = lshr i32 %14, 16
  %16 = trunc i32 %15 to i8
  %17 = load i8*, i8** %3, align 8
  %18 = getelementptr inbounds i8, i8* %17, i64 2
  store i8 %16, i8* %18, align 1
  %19 = load i32, i32* %4, align 4
  %20 = lshr i32 %19, 24
  %21 = trunc i32 %20 to i8
  %22 = load i8*, i8** %3, align 8
  %23 = getelementptr inbounds i8, i8* %22, i64 3
  store i8 %21, i8* %23, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @br_swap32(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = and i32 %3, 16711935
  %5 = shl i32 %4, 8
  %6 = load i32, i32* %2, align 4
  %7 = lshr i32 %6, 8
  %8 = and i32 %7, 16711935
  %9 = or i32 %5, %8
  store i32 %9, i32* %2, align 4
  %10 = load i32, i32* %2, align 4
  %11 = shl i32 %10, 16
  %12 = load i32, i32* %2, align 4
  %13 = lshr i32 %12, 16
  %14 = or i32 %11, %13
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @aes_ctr4x(i8* noundef %0, i32* noundef %1, i64* noundef %2, i32 noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i64*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i32* %1, i32** %6, align 8
  store i64* %2, i64** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i8*, i8** %5, align 8
  %10 = load i32*, i32** %6, align 8
  %11 = load i64*, i64** %7, align 8
  %12 = load i32, i32* %8, align 4
  call void @aes_ecb4x(i8* noundef %9, i32* noundef %10, i64* noundef %11, i32 noundef %12)
  %13 = load i32*, i32** %6, align 8
  %14 = getelementptr inbounds i32, i32* %13, i64 3
  call void @inc4_be(i32* noundef %14)
  %15 = load i32*, i32** %6, align 8
  %16 = getelementptr inbounds i32, i32* %15, i64 7
  call void @inc4_be(i32* noundef %16)
  %17 = load i32*, i32** %6, align 8
  %18 = getelementptr inbounds i32, i32* %17, i64 11
  call void @inc4_be(i32* noundef %18)
  %19 = load i32*, i32** %6, align 8
  %20 = getelementptr inbounds i32, i32* %19, i64 15
  call void @inc4_be(i32* noundef %20)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @inc4_be(i32* noundef %0) #0 {
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  store i32* %0, i32** %2, align 8
  %4 = load i32*, i32** %2, align 8
  %5 = load i32, i32* %4, align 4
  %6 = call i32 @br_swap32(i32 noundef %5)
  %7 = add i32 %6, 4
  store i32 %7, i32* %3, align 4
  %8 = load i32, i32* %3, align 4
  %9 = call i32 @br_swap32(i32 noundef %8)
  %10 = load i32*, i32** %2, align 8
  store i32 %9, i32* %10, align 4
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #1 = { allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #2 = { noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #4 = { argmemonly nofree nounwind willreturn writeonly }
attributes #5 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.5a,+zcm,+zcz" }
attributes #6 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #7 = { argmemonly nofree nounwind willreturn }
attributes #8 = { allocsize(0) }
attributes #9 = { noreturn }
attributes #10 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 13, i32 3]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"branch-target-enforcement", i32 0}
!3 = !{i32 8, !"sign-return-address", i32 0}
!4 = !{i32 8, !"sign-return-address-all", i32 0}
!5 = !{i32 8, !"sign-return-address-with-bkey", i32 0}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 1}
!9 = !{!"Apple clang version 14.0.3 (clang-1403.0.22.14.1)"}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = distinct !{!12, !11}
!13 = distinct !{!13, !11}
!14 = distinct !{!14, !11}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
!19 = distinct !{!19, !11}
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !11}
!22 = distinct !{!22, !11}
