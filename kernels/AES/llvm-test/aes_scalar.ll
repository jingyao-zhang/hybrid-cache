; ModuleID = 'aes_scalar.c'
source_filename = "aes_scalar.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@s_box = internal constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16
@rcon = internal constant [11 x i8] c"\00\01\02\04\08\10 @\80\1B6", align 1
@__const.main.key = private unnamed_addr constant [16 x i8] c"\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F", align 16
@.str = private unnamed_addr constant [13 x i8] c"Ciphertext: \00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"%02x \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @RotWord(ptr noundef %word) #0 {
entry:
  %word.addr = alloca ptr, align 8
  %temp = alloca i8, align 1
  store ptr %word, ptr %word.addr, align 8
  %0 = load ptr, ptr %word.addr, align 8
  %arrayidx = getelementptr inbounds i8, ptr %0, i64 0
  %1 = load i8, ptr %arrayidx, align 1
  store i8 %1, ptr %temp, align 1
  %2 = load ptr, ptr %word.addr, align 8
  %arrayidx1 = getelementptr inbounds i8, ptr %2, i64 1
  %3 = load i8, ptr %arrayidx1, align 1
  %4 = load ptr, ptr %word.addr, align 8
  %arrayidx2 = getelementptr inbounds i8, ptr %4, i64 0
  store i8 %3, ptr %arrayidx2, align 1
  %5 = load ptr, ptr %word.addr, align 8
  %arrayidx3 = getelementptr inbounds i8, ptr %5, i64 2
  %6 = load i8, ptr %arrayidx3, align 1
  %7 = load ptr, ptr %word.addr, align 8
  %arrayidx4 = getelementptr inbounds i8, ptr %7, i64 1
  store i8 %6, ptr %arrayidx4, align 1
  %8 = load ptr, ptr %word.addr, align 8
  %arrayidx5 = getelementptr inbounds i8, ptr %8, i64 3
  %9 = load i8, ptr %arrayidx5, align 1
  %10 = load ptr, ptr %word.addr, align 8
  %arrayidx6 = getelementptr inbounds i8, ptr %10, i64 2
  store i8 %9, ptr %arrayidx6, align 1
  %11 = load i8, ptr %temp, align 1
  %12 = load ptr, ptr %word.addr, align 8
  %arrayidx7 = getelementptr inbounds i8, ptr %12, i64 3
  store i8 %11, ptr %arrayidx7, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @SubWord(ptr noundef %word) #0 {
entry:
  %word.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  store ptr %word, ptr %word.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %word.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %idxprom1 = zext i8 %3 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1
  %4 = load i8, ptr %arrayidx2, align 1
  %5 = load ptr, ptr %word.addr, align 8
  %6 = load i32, ptr %i, align 4
  %idxprom3 = sext i32 %6 to i64
  %arrayidx4 = getelementptr inbounds i8, ptr %5, i64 %idxprom3
  store i8 %4, ptr %arrayidx4, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @KeyExpansion(ptr noundef %key, ptr noundef %roundKeys) #0 {
entry:
  %key.addr = alloca ptr, align 8
  %roundKeys.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  %temp = alloca [4 x i8], align 1
  %j = alloca i32, align 4
  %j22 = alloca i32, align 4
  store ptr %key, ptr %key.addr, align 8
  store ptr %roundKeys, ptr %roundKeys.addr, align 8
  store i32 0, ptr %i, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %key.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %4 = load ptr, ptr %roundKeys.addr, align 8
  %5 = load i32, ptr %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %arrayidx2 = getelementptr inbounds i8, ptr %4, i64 %idxprom1
  store i8 %3, ptr %arrayidx2, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, ptr %i, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond
  store i32 16, ptr %i, align 4
  br label %while.cond

while.cond:                                       ; preds = %for.end41, %for.end
  %7 = load i32, ptr %i, align 4
  %cmp3 = icmp slt i32 %7, 176
  br i1 %cmp3, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  store i32 0, ptr %j, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc11, %while.body
  %8 = load i32, ptr %j, align 4
  %cmp5 = icmp slt i32 %8, 4
  br i1 %cmp5, label %for.body6, label %for.end13

for.body6:                                        ; preds = %for.cond4
  %9 = load ptr, ptr %roundKeys.addr, align 8
  %10 = load i32, ptr %i, align 4
  %sub = sub nsw i32 %10, 4
  %11 = load i32, ptr %j, align 4
  %add = add nsw i32 %sub, %11
  %idxprom7 = sext i32 %add to i64
  %arrayidx8 = getelementptr inbounds i8, ptr %9, i64 %idxprom7
  %12 = load i8, ptr %arrayidx8, align 1
  %13 = load i32, ptr %j, align 4
  %idxprom9 = sext i32 %13 to i64
  %arrayidx10 = getelementptr inbounds [4 x i8], ptr %temp, i64 0, i64 %idxprom9
  store i8 %12, ptr %arrayidx10, align 1
  br label %for.inc11

for.inc11:                                        ; preds = %for.body6
  %14 = load i32, ptr %j, align 4
  %inc12 = add nsw i32 %14, 1
  store i32 %inc12, ptr %j, align 4
  br label %for.cond4, !llvm.loop !9

for.end13:                                        ; preds = %for.cond4
  %15 = load i32, ptr %i, align 4
  %rem = srem i32 %15, 16
  %cmp14 = icmp eq i32 %rem, 0
  br i1 %cmp14, label %if.then, label %if.end

if.then:                                          ; preds = %for.end13
  %arraydecay = getelementptr inbounds [4 x i8], ptr %temp, i64 0, i64 0
  call void @RotWord(ptr noundef %arraydecay)
  %arraydecay15 = getelementptr inbounds [4 x i8], ptr %temp, i64 0, i64 0
  call void @SubWord(ptr noundef %arraydecay15)
  %arrayidx16 = getelementptr inbounds [4 x i8], ptr %temp, i64 0, i64 0
  %16 = load i8, ptr %arrayidx16, align 1
  %conv = zext i8 %16 to i32
  %17 = load i32, ptr %i, align 4
  %div = sdiv i32 %17, 16
  %idxprom17 = sext i32 %div to i64
  %arrayidx18 = getelementptr inbounds [11 x i8], ptr @rcon, i64 0, i64 %idxprom17
  %18 = load i8, ptr %arrayidx18, align 1
  %conv19 = zext i8 %18 to i32
  %xor = xor i32 %conv, %conv19
  %conv20 = trunc i32 %xor to i8
  %arrayidx21 = getelementptr inbounds [4 x i8], ptr %temp, i64 0, i64 0
  store i8 %conv20, ptr %arrayidx21, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %for.end13
  store i32 0, ptr %j22, align 4
  br label %for.cond23

for.cond23:                                       ; preds = %for.inc39, %if.end
  %19 = load i32, ptr %j22, align 4
  %cmp24 = icmp slt i32 %19, 4
  br i1 %cmp24, label %for.body26, label %for.end41

for.body26:                                       ; preds = %for.cond23
  %20 = load ptr, ptr %roundKeys.addr, align 8
  %21 = load i32, ptr %i, align 4
  %sub27 = sub nsw i32 %21, 16
  %idxprom28 = sext i32 %sub27 to i64
  %arrayidx29 = getelementptr inbounds i8, ptr %20, i64 %idxprom28
  %22 = load i8, ptr %arrayidx29, align 1
  %conv30 = zext i8 %22 to i32
  %23 = load i32, ptr %j22, align 4
  %idxprom31 = sext i32 %23 to i64
  %arrayidx32 = getelementptr inbounds [4 x i8], ptr %temp, i64 0, i64 %idxprom31
  %24 = load i8, ptr %arrayidx32, align 1
  %conv33 = zext i8 %24 to i32
  %xor34 = xor i32 %conv30, %conv33
  %conv35 = trunc i32 %xor34 to i8
  %25 = load ptr, ptr %roundKeys.addr, align 8
  %26 = load i32, ptr %i, align 4
  %idxprom36 = sext i32 %26 to i64
  %arrayidx37 = getelementptr inbounds i8, ptr %25, i64 %idxprom36
  store i8 %conv35, ptr %arrayidx37, align 1
  %27 = load i32, ptr %i, align 4
  %inc38 = add nsw i32 %27, 1
  store i32 %inc38, ptr %i, align 4
  br label %for.inc39

for.inc39:                                        ; preds = %for.body26
  %28 = load i32, ptr %j22, align 4
  %inc40 = add nsw i32 %28, 1
  store i32 %inc40, ptr %j22, align 4
  br label %for.cond23, !llvm.loop !10

for.end41:                                        ; preds = %for.cond23
  br label %while.cond, !llvm.loop !11

while.end:                                        ; preds = %while.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @AddRoundKey(ptr noundef %state, ptr noundef %roundKey) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %roundKey.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  store ptr %roundKey, ptr %roundKey.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %roundKey.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %3 to i32
  %4 = load ptr, ptr %state.addr, align 8
  %5 = load i32, ptr %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %arrayidx2 = getelementptr inbounds i8, ptr %4, i64 %idxprom1
  %6 = load i8, ptr %arrayidx2, align 1
  %conv3 = zext i8 %6 to i32
  %xor = xor i32 %conv3, %conv
  %conv4 = trunc i32 %xor to i8
  store i8 %conv4, ptr %arrayidx2, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !12

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @SubBytes(ptr noundef %state) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %state.addr, align 8
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %idxprom1 = zext i8 %3 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1
  %4 = load i8, ptr %arrayidx2, align 1
  %5 = load ptr, ptr %state.addr, align 8
  %6 = load i32, ptr %i, align 4
  %idxprom3 = sext i32 %6 to i64
  %arrayidx4 = getelementptr inbounds i8, ptr %5, i64 %idxprom3
  store i8 %4, ptr %arrayidx4, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !13

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ShiftRows(ptr noundef %state) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %temp = alloca i8, align 1
  store ptr %state, ptr %state.addr, align 8
  %0 = load ptr, ptr %state.addr, align 8
  %arrayidx = getelementptr inbounds i8, ptr %0, i64 1
  %1 = load i8, ptr %arrayidx, align 1
  store i8 %1, ptr %temp, align 1
  %2 = load ptr, ptr %state.addr, align 8
  %arrayidx1 = getelementptr inbounds i8, ptr %2, i64 5
  %3 = load i8, ptr %arrayidx1, align 1
  %4 = load ptr, ptr %state.addr, align 8
  %arrayidx2 = getelementptr inbounds i8, ptr %4, i64 1
  store i8 %3, ptr %arrayidx2, align 1
  %5 = load ptr, ptr %state.addr, align 8
  %arrayidx3 = getelementptr inbounds i8, ptr %5, i64 9
  %6 = load i8, ptr %arrayidx3, align 1
  %7 = load ptr, ptr %state.addr, align 8
  %arrayidx4 = getelementptr inbounds i8, ptr %7, i64 5
  store i8 %6, ptr %arrayidx4, align 1
  %8 = load ptr, ptr %state.addr, align 8
  %arrayidx5 = getelementptr inbounds i8, ptr %8, i64 13
  %9 = load i8, ptr %arrayidx5, align 1
  %10 = load ptr, ptr %state.addr, align 8
  %arrayidx6 = getelementptr inbounds i8, ptr %10, i64 9
  store i8 %9, ptr %arrayidx6, align 1
  %11 = load i8, ptr %temp, align 1
  %12 = load ptr, ptr %state.addr, align 8
  %arrayidx7 = getelementptr inbounds i8, ptr %12, i64 13
  store i8 %11, ptr %arrayidx7, align 1
  %13 = load ptr, ptr %state.addr, align 8
  %arrayidx8 = getelementptr inbounds i8, ptr %13, i64 2
  %14 = load i8, ptr %arrayidx8, align 1
  store i8 %14, ptr %temp, align 1
  %15 = load ptr, ptr %state.addr, align 8
  %arrayidx9 = getelementptr inbounds i8, ptr %15, i64 10
  %16 = load i8, ptr %arrayidx9, align 1
  %17 = load ptr, ptr %state.addr, align 8
  %arrayidx10 = getelementptr inbounds i8, ptr %17, i64 2
  store i8 %16, ptr %arrayidx10, align 1
  %18 = load i8, ptr %temp, align 1
  %19 = load ptr, ptr %state.addr, align 8
  %arrayidx11 = getelementptr inbounds i8, ptr %19, i64 10
  store i8 %18, ptr %arrayidx11, align 1
  %20 = load ptr, ptr %state.addr, align 8
  %arrayidx12 = getelementptr inbounds i8, ptr %20, i64 6
  %21 = load i8, ptr %arrayidx12, align 1
  store i8 %21, ptr %temp, align 1
  %22 = load ptr, ptr %state.addr, align 8
  %arrayidx13 = getelementptr inbounds i8, ptr %22, i64 14
  %23 = load i8, ptr %arrayidx13, align 1
  %24 = load ptr, ptr %state.addr, align 8
  %arrayidx14 = getelementptr inbounds i8, ptr %24, i64 6
  store i8 %23, ptr %arrayidx14, align 1
  %25 = load i8, ptr %temp, align 1
  %26 = load ptr, ptr %state.addr, align 8
  %arrayidx15 = getelementptr inbounds i8, ptr %26, i64 14
  store i8 %25, ptr %arrayidx15, align 1
  %27 = load ptr, ptr %state.addr, align 8
  %arrayidx16 = getelementptr inbounds i8, ptr %27, i64 3
  %28 = load i8, ptr %arrayidx16, align 1
  store i8 %28, ptr %temp, align 1
  %29 = load ptr, ptr %state.addr, align 8
  %arrayidx17 = getelementptr inbounds i8, ptr %29, i64 15
  %30 = load i8, ptr %arrayidx17, align 1
  %31 = load ptr, ptr %state.addr, align 8
  %arrayidx18 = getelementptr inbounds i8, ptr %31, i64 3
  store i8 %30, ptr %arrayidx18, align 1
  %32 = load ptr, ptr %state.addr, align 8
  %arrayidx19 = getelementptr inbounds i8, ptr %32, i64 11
  %33 = load i8, ptr %arrayidx19, align 1
  %34 = load ptr, ptr %state.addr, align 8
  %arrayidx20 = getelementptr inbounds i8, ptr %34, i64 15
  store i8 %33, ptr %arrayidx20, align 1
  %35 = load ptr, ptr %state.addr, align 8
  %arrayidx21 = getelementptr inbounds i8, ptr %35, i64 7
  %36 = load i8, ptr %arrayidx21, align 1
  %37 = load ptr, ptr %state.addr, align 8
  %arrayidx22 = getelementptr inbounds i8, ptr %37, i64 11
  store i8 %36, ptr %arrayidx22, align 1
  %38 = load i8, ptr %temp, align 1
  %39 = load ptr, ptr %state.addr, align 8
  %arrayidx23 = getelementptr inbounds i8, ptr %39, i64 7
  store i8 %38, ptr %arrayidx23, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i8 @gmul(i8 noundef zeroext %a, i8 noundef zeroext %b) #0 {
entry:
  %a.addr = alloca i8, align 1
  %b.addr = alloca i8, align 1
  %p = alloca i8, align 1
  %counter = alloca i8, align 1
  %carry = alloca i8, align 1
  store i8 %a, ptr %a.addr, align 1
  store i8 %b, ptr %b.addr, align 1
  store i8 0, ptr %p, align 1
  store i8 0, ptr %counter, align 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i8, ptr %counter, align 1
  %conv = zext i8 %0 to i32
  %cmp = icmp slt i32 %conv, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i8, ptr %b.addr, align 1
  %conv2 = zext i8 %1 to i32
  %and = and i32 %conv2, 1
  %cmp3 = icmp ne i32 %and, 0
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %2 = load i8, ptr %a.addr, align 1
  %conv5 = zext i8 %2 to i32
  %3 = load i8, ptr %p, align 1
  %conv6 = zext i8 %3 to i32
  %xor = xor i32 %conv6, %conv5
  %conv7 = trunc i32 %xor to i8
  store i8 %conv7, ptr %p, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %4 = load i8, ptr %a.addr, align 1
  %conv8 = zext i8 %4 to i32
  %and9 = and i32 %conv8, 128
  %conv10 = trunc i32 %and9 to i8
  store i8 %conv10, ptr %carry, align 1
  %5 = load i8, ptr %a.addr, align 1
  %conv11 = zext i8 %5 to i32
  %shl = shl i32 %conv11, 1
  %conv12 = trunc i32 %shl to i8
  store i8 %conv12, ptr %a.addr, align 1
  %6 = load i8, ptr %carry, align 1
  %conv13 = zext i8 %6 to i32
  %cmp14 = icmp ne i32 %conv13, 0
  br i1 %cmp14, label %if.then16, label %if.end20

if.then16:                                        ; preds = %if.end
  %7 = load i8, ptr %a.addr, align 1
  %conv17 = zext i8 %7 to i32
  %xor18 = xor i32 %conv17, 27
  %conv19 = trunc i32 %xor18 to i8
  store i8 %conv19, ptr %a.addr, align 1
  br label %if.end20

if.end20:                                         ; preds = %if.then16, %if.end
  %8 = load i8, ptr %b.addr, align 1
  %conv21 = zext i8 %8 to i32
  %shr = ashr i32 %conv21, 1
  %conv22 = trunc i32 %shr to i8
  store i8 %conv22, ptr %b.addr, align 1
  br label %for.inc

for.inc:                                          ; preds = %if.end20
  %9 = load i8, ptr %counter, align 1
  %inc = add i8 %9, 1
  store i8 %inc, ptr %counter, align 1
  br label %for.cond, !llvm.loop !14

for.end:                                          ; preds = %for.cond
  %10 = load i8, ptr %p, align 1
  ret i8 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @MixColumns(ptr noundef %state) #0 {
entry:
  %state.addr = alloca ptr, align 8
  %i = alloca i8, align 1
  %a = alloca [4 x i8], align 1
  %b = alloca [4 x i8], align 1
  store ptr %state, ptr %state.addr, align 8
  store i8 0, ptr %i, align 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i8, ptr %i, align 1
  %conv = zext i8 %0 to i32
  %cmp = icmp slt i32 %conv, 4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load ptr, ptr %state.addr, align 8
  %2 = load i8, ptr %i, align 1
  %conv2 = zext i8 %2 to i32
  %mul = mul nsw i32 %conv2, 4
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %arrayidx3 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 0
  store i8 %3, ptr %arrayidx3, align 1
  %4 = load ptr, ptr %state.addr, align 8
  %5 = load i8, ptr %i, align 1
  %conv4 = zext i8 %5 to i32
  %mul5 = mul nsw i32 %conv4, 4
  %add = add nsw i32 %mul5, 1
  %idxprom6 = sext i32 %add to i64
  %arrayidx7 = getelementptr inbounds i8, ptr %4, i64 %idxprom6
  %6 = load i8, ptr %arrayidx7, align 1
  %arrayidx8 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 1
  store i8 %6, ptr %arrayidx8, align 1
  %7 = load ptr, ptr %state.addr, align 8
  %8 = load i8, ptr %i, align 1
  %conv9 = zext i8 %8 to i32
  %mul10 = mul nsw i32 %conv9, 4
  %add11 = add nsw i32 %mul10, 2
  %idxprom12 = sext i32 %add11 to i64
  %arrayidx13 = getelementptr inbounds i8, ptr %7, i64 %idxprom12
  %9 = load i8, ptr %arrayidx13, align 1
  %arrayidx14 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 2
  store i8 %9, ptr %arrayidx14, align 1
  %10 = load ptr, ptr %state.addr, align 8
  %11 = load i8, ptr %i, align 1
  %conv15 = zext i8 %11 to i32
  %mul16 = mul nsw i32 %conv15, 4
  %add17 = add nsw i32 %mul16, 3
  %idxprom18 = sext i32 %add17 to i64
  %arrayidx19 = getelementptr inbounds i8, ptr %10, i64 %idxprom18
  %12 = load i8, ptr %arrayidx19, align 1
  %arrayidx20 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 3
  store i8 %12, ptr %arrayidx20, align 1
  %arrayidx21 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 0
  %13 = load i8, ptr %arrayidx21, align 1
  %call = call zeroext i8 @gmul(i8 noundef zeroext %13, i8 noundef zeroext 2)
  %conv22 = zext i8 %call to i32
  %arrayidx23 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 3
  %14 = load i8, ptr %arrayidx23, align 1
  %call24 = call zeroext i8 @gmul(i8 noundef zeroext %14, i8 noundef zeroext 1)
  %conv25 = zext i8 %call24 to i32
  %xor = xor i32 %conv22, %conv25
  %arrayidx26 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 2
  %15 = load i8, ptr %arrayidx26, align 1
  %call27 = call zeroext i8 @gmul(i8 noundef zeroext %15, i8 noundef zeroext 1)
  %conv28 = zext i8 %call27 to i32
  %xor29 = xor i32 %xor, %conv28
  %arrayidx30 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 1
  %16 = load i8, ptr %arrayidx30, align 1
  %call31 = call zeroext i8 @gmul(i8 noundef zeroext %16, i8 noundef zeroext 3)
  %conv32 = zext i8 %call31 to i32
  %xor33 = xor i32 %xor29, %conv32
  %conv34 = trunc i32 %xor33 to i8
  %arrayidx35 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 0
  store i8 %conv34, ptr %arrayidx35, align 1
  %arrayidx36 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 1
  %17 = load i8, ptr %arrayidx36, align 1
  %call37 = call zeroext i8 @gmul(i8 noundef zeroext %17, i8 noundef zeroext 2)
  %conv38 = zext i8 %call37 to i32
  %arrayidx39 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 0
  %18 = load i8, ptr %arrayidx39, align 1
  %call40 = call zeroext i8 @gmul(i8 noundef zeroext %18, i8 noundef zeroext 1)
  %conv41 = zext i8 %call40 to i32
  %xor42 = xor i32 %conv38, %conv41
  %arrayidx43 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 3
  %19 = load i8, ptr %arrayidx43, align 1
  %call44 = call zeroext i8 @gmul(i8 noundef zeroext %19, i8 noundef zeroext 1)
  %conv45 = zext i8 %call44 to i32
  %xor46 = xor i32 %xor42, %conv45
  %arrayidx47 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 2
  %20 = load i8, ptr %arrayidx47, align 1
  %call48 = call zeroext i8 @gmul(i8 noundef zeroext %20, i8 noundef zeroext 3)
  %conv49 = zext i8 %call48 to i32
  %xor50 = xor i32 %xor46, %conv49
  %conv51 = trunc i32 %xor50 to i8
  %arrayidx52 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 1
  store i8 %conv51, ptr %arrayidx52, align 1
  %arrayidx53 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 2
  %21 = load i8, ptr %arrayidx53, align 1
  %call54 = call zeroext i8 @gmul(i8 noundef zeroext %21, i8 noundef zeroext 2)
  %conv55 = zext i8 %call54 to i32
  %arrayidx56 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 1
  %22 = load i8, ptr %arrayidx56, align 1
  %call57 = call zeroext i8 @gmul(i8 noundef zeroext %22, i8 noundef zeroext 1)
  %conv58 = zext i8 %call57 to i32
  %xor59 = xor i32 %conv55, %conv58
  %arrayidx60 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 0
  %23 = load i8, ptr %arrayidx60, align 1
  %call61 = call zeroext i8 @gmul(i8 noundef zeroext %23, i8 noundef zeroext 1)
  %conv62 = zext i8 %call61 to i32
  %xor63 = xor i32 %xor59, %conv62
  %arrayidx64 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 3
  %24 = load i8, ptr %arrayidx64, align 1
  %call65 = call zeroext i8 @gmul(i8 noundef zeroext %24, i8 noundef zeroext 3)
  %conv66 = zext i8 %call65 to i32
  %xor67 = xor i32 %xor63, %conv66
  %conv68 = trunc i32 %xor67 to i8
  %arrayidx69 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 2
  store i8 %conv68, ptr %arrayidx69, align 1
  %arrayidx70 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 3
  %25 = load i8, ptr %arrayidx70, align 1
  %call71 = call zeroext i8 @gmul(i8 noundef zeroext %25, i8 noundef zeroext 2)
  %conv72 = zext i8 %call71 to i32
  %arrayidx73 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 2
  %26 = load i8, ptr %arrayidx73, align 1
  %call74 = call zeroext i8 @gmul(i8 noundef zeroext %26, i8 noundef zeroext 1)
  %conv75 = zext i8 %call74 to i32
  %xor76 = xor i32 %conv72, %conv75
  %arrayidx77 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 1
  %27 = load i8, ptr %arrayidx77, align 1
  %call78 = call zeroext i8 @gmul(i8 noundef zeroext %27, i8 noundef zeroext 1)
  %conv79 = zext i8 %call78 to i32
  %xor80 = xor i32 %xor76, %conv79
  %arrayidx81 = getelementptr inbounds [4 x i8], ptr %a, i64 0, i64 0
  %28 = load i8, ptr %arrayidx81, align 1
  %call82 = call zeroext i8 @gmul(i8 noundef zeroext %28, i8 noundef zeroext 3)
  %conv83 = zext i8 %call82 to i32
  %xor84 = xor i32 %xor80, %conv83
  %conv85 = trunc i32 %xor84 to i8
  %arrayidx86 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 3
  store i8 %conv85, ptr %arrayidx86, align 1
  %arrayidx87 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 0
  %29 = load i8, ptr %arrayidx87, align 1
  %30 = load ptr, ptr %state.addr, align 8
  %31 = load i8, ptr %i, align 1
  %conv88 = zext i8 %31 to i32
  %mul89 = mul nsw i32 %conv88, 4
  %idxprom90 = sext i32 %mul89 to i64
  %arrayidx91 = getelementptr inbounds i8, ptr %30, i64 %idxprom90
  store i8 %29, ptr %arrayidx91, align 1
  %arrayidx92 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 1
  %32 = load i8, ptr %arrayidx92, align 1
  %33 = load ptr, ptr %state.addr, align 8
  %34 = load i8, ptr %i, align 1
  %conv93 = zext i8 %34 to i32
  %mul94 = mul nsw i32 %conv93, 4
  %add95 = add nsw i32 %mul94, 1
  %idxprom96 = sext i32 %add95 to i64
  %arrayidx97 = getelementptr inbounds i8, ptr %33, i64 %idxprom96
  store i8 %32, ptr %arrayidx97, align 1
  %arrayidx98 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 2
  %35 = load i8, ptr %arrayidx98, align 1
  %36 = load ptr, ptr %state.addr, align 8
  %37 = load i8, ptr %i, align 1
  %conv99 = zext i8 %37 to i32
  %mul100 = mul nsw i32 %conv99, 4
  %add101 = add nsw i32 %mul100, 2
  %idxprom102 = sext i32 %add101 to i64
  %arrayidx103 = getelementptr inbounds i8, ptr %36, i64 %idxprom102
  store i8 %35, ptr %arrayidx103, align 1
  %arrayidx104 = getelementptr inbounds [4 x i8], ptr %b, i64 0, i64 3
  %38 = load i8, ptr %arrayidx104, align 1
  %39 = load ptr, ptr %state.addr, align 8
  %40 = load i8, ptr %i, align 1
  %conv105 = zext i8 %40 to i32
  %mul106 = mul nsw i32 %conv105, 4
  %add107 = add nsw i32 %mul106, 3
  %idxprom108 = sext i32 %add107 to i64
  %arrayidx109 = getelementptr inbounds i8, ptr %39, i64 %idxprom108
  store i8 %38, ptr %arrayidx109, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %41 = load i8, ptr %i, align 1
  %inc = add i8 %41, 1
  store i8 %inc, ptr %i, align 1
  br label %for.cond, !llvm.loop !15

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @AES128Encrypt(ptr noundef %input, ptr noundef %output, ptr noundef %key) #0 {
entry:
  %input.addr = alloca ptr, align 8
  %output.addr = alloca ptr, align 8
  %key.addr = alloca ptr, align 8
  %state = alloca [16 x i8], align 16
  %roundKeys = alloca [176 x i8], align 16
  %i = alloca i32, align 4
  store ptr %input, ptr %input.addr, align 8
  store ptr %output, ptr %output.addr, align 8
  store ptr %key, ptr %key.addr, align 8
  %arraydecay = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  %0 = load ptr, ptr %input.addr, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %arraydecay, ptr align 1 %0, i64 16, i1 false)
  %1 = load ptr, ptr %key.addr, align 8
  %arraydecay1 = getelementptr inbounds [176 x i8], ptr %roundKeys, i64 0, i64 0
  call void @KeyExpansion(ptr noundef %1, ptr noundef %arraydecay1)
  %arraydecay2 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  %arraydecay3 = getelementptr inbounds [176 x i8], ptr %roundKeys, i64 0, i64 0
  call void @AddRoundKey(ptr noundef %arraydecay2, ptr noundef %arraydecay3)
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %2, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arraydecay4 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  call void @SubBytes(ptr noundef %arraydecay4)
  %arraydecay5 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  call void @ShiftRows(ptr noundef %arraydecay5)
  %arraydecay6 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  call void @MixColumns(ptr noundef %arraydecay6)
  %arraydecay7 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  %arraydecay8 = getelementptr inbounds [176 x i8], ptr %roundKeys, i64 0, i64 0
  %3 = load i32, ptr %i, align 4
  %mul = mul nsw i32 16, %3
  %idx.ext = sext i32 %mul to i64
  %add.ptr = getelementptr inbounds i8, ptr %arraydecay8, i64 %idx.ext
  call void @AddRoundKey(ptr noundef %arraydecay7, ptr noundef %add.ptr)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, ptr %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !16

for.end:                                          ; preds = %for.cond
  %arraydecay9 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  call void @SubBytes(ptr noundef %arraydecay9)
  %arraydecay10 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  call void @ShiftRows(ptr noundef %arraydecay10)
  %arraydecay11 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  %arraydecay12 = getelementptr inbounds [176 x i8], ptr %roundKeys, i64 0, i64 0
  %add.ptr13 = getelementptr inbounds i8, ptr %arraydecay12, i64 160
  call void @AddRoundKey(ptr noundef %arraydecay11, ptr noundef %add.ptr13)
  %5 = load ptr, ptr %output.addr, align 8
  %arraydecay14 = getelementptr inbounds [16 x i8], ptr %state, i64 0, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %5, ptr align 16 %arraydecay14, i64 16, i1 false)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %input = alloca [16 x i8], align 16
  %key = alloca [16 x i8], align 16
  %output = alloca [16 x i8], align 16
  %j = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  call void @llvm.memset.p0.i64(ptr align 16 %input, i8 0, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %key, ptr align 16 @__const.main.key, i64 16, i1 false)
  call void @llvm.memset.p0.i64(ptr align 16 %output, i8 0, i64 16, i1 false)
  %arraydecay = getelementptr inbounds [16 x i8], ptr %input, i64 0, i64 0
  %arraydecay1 = getelementptr inbounds [16 x i8], ptr %output, i64 0, i64 0
  %arraydecay2 = getelementptr inbounds [16 x i8], ptr %key, i64 0, i64 0
  call void @AES128Encrypt(ptr noundef %arraydecay, ptr noundef %arraydecay1, ptr noundef %arraydecay2)
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 0, ptr %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %j, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, ptr %j, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds [16 x i8], ptr %output, i64 0, i64 %idxprom
  %2 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %2 to i32
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %conv)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, ptr %j, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, ptr %j, align 4
  br label %for.cond, !llvm.loop !17

for.end:                                          ; preds = %for.cond
  %call4 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

declare i32 @printf(ptr noundef, ...) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
