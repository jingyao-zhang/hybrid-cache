; ModuleID = 'aes_scalar.ll'
source_filename = "aes_scalar.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@s_box = internal unnamed_addr constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16
@rcon = internal unnamed_addr constant [11 x i8] c"\00\01\02\04\08\10 @\80\1B6", align 1
@__const.main.key = private unnamed_addr constant [16 x i8] c"\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F", align 16

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @RotWord(ptr nocapture noundef %word) local_unnamed_addr #0 {
entry:
  %0 = load <4 x i8>, ptr %word, align 1, !tbaa !5
  %1 = shufflevector <4 x i8> %0, <4 x i8> poison, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  store <4 x i8> %1, ptr %word, align 1, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @SubWord(ptr nocapture noundef %word) local_unnamed_addr #0 {
entry:
  %0 = load i8, ptr %word, align 1, !tbaa !5
  %idxprom1 = zext i8 %0 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1
  %1 = load i8, ptr %arrayidx2, align 1, !tbaa !5
  store i8 %1, ptr %word, align 1, !tbaa !5
  %arrayidx.1 = getelementptr inbounds i8, ptr %word, i64 1
  %2 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %idxprom1.1 = zext i8 %2 to i64
  %arrayidx2.1 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.1
  %3 = load i8, ptr %arrayidx2.1, align 1, !tbaa !5
  store i8 %3, ptr %arrayidx.1, align 1, !tbaa !5
  %arrayidx.2 = getelementptr inbounds i8, ptr %word, i64 2
  %4 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %idxprom1.2 = zext i8 %4 to i64
  %arrayidx2.2 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.2
  %5 = load i8, ptr %arrayidx2.2, align 1, !tbaa !5
  store i8 %5, ptr %arrayidx.2, align 1, !tbaa !5
  %arrayidx.3 = getelementptr inbounds i8, ptr %word, i64 3
  %6 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %idxprom1.3 = zext i8 %6 to i64
  %arrayidx2.3 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.3
  %7 = load i8, ptr %arrayidx2.3, align 1, !tbaa !5
  store i8 %7, ptr %arrayidx.3, align 1, !tbaa !5
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @KeyExpansion(ptr nocapture noundef readonly %key, ptr nocapture noundef %roundKeys) local_unnamed_addr #2 {
entry:
  %0 = load i8, ptr %key, align 1, !tbaa !5
  store i8 %0, ptr %roundKeys, align 1, !tbaa !5
  %arrayidx.1 = getelementptr inbounds i8, ptr %key, i64 1
  %1 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %arrayidx2.1 = getelementptr inbounds i8, ptr %roundKeys, i64 1
  store i8 %1, ptr %arrayidx2.1, align 1, !tbaa !5
  %arrayidx.2 = getelementptr inbounds i8, ptr %key, i64 2
  %2 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %arrayidx2.2 = getelementptr inbounds i8, ptr %roundKeys, i64 2
  store i8 %2, ptr %arrayidx2.2, align 1, !tbaa !5
  %arrayidx.3 = getelementptr inbounds i8, ptr %key, i64 3
  %3 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %arrayidx2.3 = getelementptr inbounds i8, ptr %roundKeys, i64 3
  store i8 %3, ptr %arrayidx2.3, align 1, !tbaa !5
  %arrayidx.4 = getelementptr inbounds i8, ptr %key, i64 4
  %4 = load i8, ptr %arrayidx.4, align 1, !tbaa !5
  %arrayidx2.4 = getelementptr inbounds i8, ptr %roundKeys, i64 4
  store i8 %4, ptr %arrayidx2.4, align 1, !tbaa !5
  %arrayidx.5 = getelementptr inbounds i8, ptr %key, i64 5
  %5 = load i8, ptr %arrayidx.5, align 1, !tbaa !5
  %arrayidx2.5 = getelementptr inbounds i8, ptr %roundKeys, i64 5
  store i8 %5, ptr %arrayidx2.5, align 1, !tbaa !5
  %arrayidx.6 = getelementptr inbounds i8, ptr %key, i64 6
  %6 = load i8, ptr %arrayidx.6, align 1, !tbaa !5
  %arrayidx2.6 = getelementptr inbounds i8, ptr %roundKeys, i64 6
  store i8 %6, ptr %arrayidx2.6, align 1, !tbaa !5
  %arrayidx.7 = getelementptr inbounds i8, ptr %key, i64 7
  %7 = load i8, ptr %arrayidx.7, align 1, !tbaa !5
  %arrayidx2.7 = getelementptr inbounds i8, ptr %roundKeys, i64 7
  store i8 %7, ptr %arrayidx2.7, align 1, !tbaa !5
  %arrayidx.8 = getelementptr inbounds i8, ptr %key, i64 8
  %8 = load i8, ptr %arrayidx.8, align 1, !tbaa !5
  %arrayidx2.8 = getelementptr inbounds i8, ptr %roundKeys, i64 8
  store i8 %8, ptr %arrayidx2.8, align 1, !tbaa !5
  %arrayidx.9 = getelementptr inbounds i8, ptr %key, i64 9
  %9 = load i8, ptr %arrayidx.9, align 1, !tbaa !5
  %arrayidx2.9 = getelementptr inbounds i8, ptr %roundKeys, i64 9
  store i8 %9, ptr %arrayidx2.9, align 1, !tbaa !5
  %arrayidx.10 = getelementptr inbounds i8, ptr %key, i64 10
  %10 = load i8, ptr %arrayidx.10, align 1, !tbaa !5
  %arrayidx2.10 = getelementptr inbounds i8, ptr %roundKeys, i64 10
  store i8 %10, ptr %arrayidx2.10, align 1, !tbaa !5
  %arrayidx.11 = getelementptr inbounds i8, ptr %key, i64 11
  %11 = load i8, ptr %arrayidx.11, align 1, !tbaa !5
  %arrayidx2.11 = getelementptr inbounds i8, ptr %roundKeys, i64 11
  store i8 %11, ptr %arrayidx2.11, align 1, !tbaa !5
  %arrayidx.12 = getelementptr inbounds i8, ptr %key, i64 12
  %12 = load i8, ptr %arrayidx.12, align 1, !tbaa !5
  %arrayidx2.12 = getelementptr inbounds i8, ptr %roundKeys, i64 12
  store i8 %12, ptr %arrayidx2.12, align 1, !tbaa !5
  %arrayidx.13 = getelementptr inbounds i8, ptr %key, i64 13
  %13 = load i8, ptr %arrayidx.13, align 1, !tbaa !5
  %arrayidx2.13 = getelementptr inbounds i8, ptr %roundKeys, i64 13
  store i8 %13, ptr %arrayidx2.13, align 1, !tbaa !5
  %arrayidx.14 = getelementptr inbounds i8, ptr %key, i64 14
  %14 = load i8, ptr %arrayidx.14, align 1, !tbaa !5
  %arrayidx2.14 = getelementptr inbounds i8, ptr %roundKeys, i64 14
  store i8 %14, ptr %arrayidx2.14, align 1, !tbaa !5
  %arrayidx.15 = getelementptr inbounds i8, ptr %key, i64 15
  %15 = load i8, ptr %arrayidx.15, align 1, !tbaa !5
  %arrayidx2.15 = getelementptr inbounds i8, ptr %roundKeys, i64 15
  store i8 %15, ptr %arrayidx2.15, align 1, !tbaa !5
  %uglygep3 = getelementptr i8, ptr %roundKeys, i64 12
  %load_initial = load <4 x i8>, ptr %uglygep3, align 1
  br label %for.cond4.preheader

for.cond4.preheader:                              ; preds = %if.end, %entry
  %store_forwarded = phi <4 x i8> [ %load_initial, %entry ], [ %34, %if.end ]
  %indvars.iv = phi i64 [ 16, %entry ], [ %indvars.iv.next, %if.end ]
  %16 = and i64 %indvars.iv, 12
  %cmp14 = icmp eq i64 %16, 0
  br i1 %cmp14, label %if.then, label %if.end

if.then:                                          ; preds = %for.cond4.preheader
  %17 = extractelement <4 x i8> %store_forwarded, i64 1
  %idxprom1.i = zext i8 %17 to i64
  %arrayidx2.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.i
  %18 = load i8, ptr %arrayidx2.i, align 1, !tbaa !5
  %19 = extractelement <4 x i8> %store_forwarded, i64 2
  %idxprom1.1.i = zext i8 %19 to i64
  %arrayidx2.1.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.1.i
  %20 = load i8, ptr %arrayidx2.1.i, align 1, !tbaa !5
  %21 = extractelement <4 x i8> %store_forwarded, i64 3
  %idxprom1.2.i = zext i8 %21 to i64
  %arrayidx2.2.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.2.i
  %22 = load i8, ptr %arrayidx2.2.i, align 1, !tbaa !5
  %23 = extractelement <4 x i8> %store_forwarded, i64 0
  %idxprom1.3.i = zext i8 %23 to i64
  %arrayidx2.3.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.3.i
  %24 = load i8, ptr %arrayidx2.3.i, align 1, !tbaa !5
  %div.udiv82 = lshr i64 %indvars.iv, 4
  %idxprom17 = and i64 %div.udiv82, 268435455
  %arrayidx18 = getelementptr inbounds [11 x i8], ptr @rcon, i64 0, i64 %idxprom17
  %25 = load i8, ptr %arrayidx18, align 1, !tbaa !5
  %xor62 = xor i8 %25, %18
  %26 = insertelement <4 x i8> poison, i8 %xor62, i64 0
  %27 = insertelement <4 x i8> %26, i8 %20, i64 1
  %28 = insertelement <4 x i8> %27, i8 %22, i64 2
  %29 = insertelement <4 x i8> %28, i8 %24, i64 3
  br label %if.end

if.end:                                           ; preds = %if.then, %for.cond4.preheader
  %30 = phi <4 x i8> [ %29, %if.then ], [ %store_forwarded, %for.cond4.preheader ]
  %31 = add nsw i64 %indvars.iv, -16
  %arrayidx30 = getelementptr inbounds i8, ptr %roundKeys, i64 %31
  %arrayidx38 = getelementptr inbounds i8, ptr %roundKeys, i64 %indvars.iv
  %32 = or i64 %indvars.iv, 3
  %33 = load <4 x i8>, ptr %arrayidx30, align 1, !tbaa !5
  %34 = xor <4 x i8> %33, %30
  store <4 x i8> %34, ptr %arrayidx38, align 1, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4
  %cmp3 = icmp ult i64 %32, 175
  br i1 %cmp3, label %for.cond4.preheader, label %while.end, !llvm.loop !8

while.end:                                        ; preds = %if.end
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @AddRoundKey(ptr nocapture noundef %state, ptr nocapture noundef readonly %roundKey) local_unnamed_addr #0 {
entry:
  %0 = load i8, ptr %roundKey, align 1, !tbaa !5
  %1 = load i8, ptr %state, align 1, !tbaa !5
  %xor8 = xor i8 %1, %0
  store i8 %xor8, ptr %state, align 1, !tbaa !5
  %arrayidx.1 = getelementptr inbounds i8, ptr %roundKey, i64 1
  %2 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %arrayidx2.1 = getelementptr inbounds i8, ptr %state, i64 1
  %3 = load i8, ptr %arrayidx2.1, align 1, !tbaa !5
  %xor8.1 = xor i8 %3, %2
  store i8 %xor8.1, ptr %arrayidx2.1, align 1, !tbaa !5
  %arrayidx.2 = getelementptr inbounds i8, ptr %roundKey, i64 2
  %4 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %arrayidx2.2 = getelementptr inbounds i8, ptr %state, i64 2
  %5 = load i8, ptr %arrayidx2.2, align 1, !tbaa !5
  %xor8.2 = xor i8 %5, %4
  store i8 %xor8.2, ptr %arrayidx2.2, align 1, !tbaa !5
  %arrayidx.3 = getelementptr inbounds i8, ptr %roundKey, i64 3
  %6 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %arrayidx2.3 = getelementptr inbounds i8, ptr %state, i64 3
  %7 = load i8, ptr %arrayidx2.3, align 1, !tbaa !5
  %xor8.3 = xor i8 %7, %6
  store i8 %xor8.3, ptr %arrayidx2.3, align 1, !tbaa !5
  %arrayidx.4 = getelementptr inbounds i8, ptr %roundKey, i64 4
  %8 = load i8, ptr %arrayidx.4, align 1, !tbaa !5
  %arrayidx2.4 = getelementptr inbounds i8, ptr %state, i64 4
  %9 = load i8, ptr %arrayidx2.4, align 1, !tbaa !5
  %xor8.4 = xor i8 %9, %8
  store i8 %xor8.4, ptr %arrayidx2.4, align 1, !tbaa !5
  %arrayidx.5 = getelementptr inbounds i8, ptr %roundKey, i64 5
  %10 = load i8, ptr %arrayidx.5, align 1, !tbaa !5
  %arrayidx2.5 = getelementptr inbounds i8, ptr %state, i64 5
  %11 = load i8, ptr %arrayidx2.5, align 1, !tbaa !5
  %xor8.5 = xor i8 %11, %10
  store i8 %xor8.5, ptr %arrayidx2.5, align 1, !tbaa !5
  %arrayidx.6 = getelementptr inbounds i8, ptr %roundKey, i64 6
  %12 = load i8, ptr %arrayidx.6, align 1, !tbaa !5
  %arrayidx2.6 = getelementptr inbounds i8, ptr %state, i64 6
  %13 = load i8, ptr %arrayidx2.6, align 1, !tbaa !5
  %xor8.6 = xor i8 %13, %12
  store i8 %xor8.6, ptr %arrayidx2.6, align 1, !tbaa !5
  %arrayidx.7 = getelementptr inbounds i8, ptr %roundKey, i64 7
  %14 = load i8, ptr %arrayidx.7, align 1, !tbaa !5
  %arrayidx2.7 = getelementptr inbounds i8, ptr %state, i64 7
  %15 = load i8, ptr %arrayidx2.7, align 1, !tbaa !5
  %xor8.7 = xor i8 %15, %14
  store i8 %xor8.7, ptr %arrayidx2.7, align 1, !tbaa !5
  %arrayidx.8 = getelementptr inbounds i8, ptr %roundKey, i64 8
  %16 = load i8, ptr %arrayidx.8, align 1, !tbaa !5
  %arrayidx2.8 = getelementptr inbounds i8, ptr %state, i64 8
  %17 = load i8, ptr %arrayidx2.8, align 1, !tbaa !5
  %xor8.8 = xor i8 %17, %16
  store i8 %xor8.8, ptr %arrayidx2.8, align 1, !tbaa !5
  %arrayidx.9 = getelementptr inbounds i8, ptr %roundKey, i64 9
  %18 = load i8, ptr %arrayidx.9, align 1, !tbaa !5
  %arrayidx2.9 = getelementptr inbounds i8, ptr %state, i64 9
  %19 = load i8, ptr %arrayidx2.9, align 1, !tbaa !5
  %xor8.9 = xor i8 %19, %18
  store i8 %xor8.9, ptr %arrayidx2.9, align 1, !tbaa !5
  %arrayidx.10 = getelementptr inbounds i8, ptr %roundKey, i64 10
  %20 = load i8, ptr %arrayidx.10, align 1, !tbaa !5
  %arrayidx2.10 = getelementptr inbounds i8, ptr %state, i64 10
  %21 = load i8, ptr %arrayidx2.10, align 1, !tbaa !5
  %xor8.10 = xor i8 %21, %20
  store i8 %xor8.10, ptr %arrayidx2.10, align 1, !tbaa !5
  %arrayidx.11 = getelementptr inbounds i8, ptr %roundKey, i64 11
  %22 = load i8, ptr %arrayidx.11, align 1, !tbaa !5
  %arrayidx2.11 = getelementptr inbounds i8, ptr %state, i64 11
  %23 = load i8, ptr %arrayidx2.11, align 1, !tbaa !5
  %xor8.11 = xor i8 %23, %22
  store i8 %xor8.11, ptr %arrayidx2.11, align 1, !tbaa !5
  %arrayidx.12 = getelementptr inbounds i8, ptr %roundKey, i64 12
  %24 = load i8, ptr %arrayidx.12, align 1, !tbaa !5
  %arrayidx2.12 = getelementptr inbounds i8, ptr %state, i64 12
  %25 = load i8, ptr %arrayidx2.12, align 1, !tbaa !5
  %xor8.12 = xor i8 %25, %24
  store i8 %xor8.12, ptr %arrayidx2.12, align 1, !tbaa !5
  %arrayidx.13 = getelementptr inbounds i8, ptr %roundKey, i64 13
  %26 = load i8, ptr %arrayidx.13, align 1, !tbaa !5
  %arrayidx2.13 = getelementptr inbounds i8, ptr %state, i64 13
  %27 = load i8, ptr %arrayidx2.13, align 1, !tbaa !5
  %xor8.13 = xor i8 %27, %26
  store i8 %xor8.13, ptr %arrayidx2.13, align 1, !tbaa !5
  %arrayidx.14 = getelementptr inbounds i8, ptr %roundKey, i64 14
  %28 = load i8, ptr %arrayidx.14, align 1, !tbaa !5
  %arrayidx2.14 = getelementptr inbounds i8, ptr %state, i64 14
  %29 = load i8, ptr %arrayidx2.14, align 1, !tbaa !5
  %xor8.14 = xor i8 %29, %28
  store i8 %xor8.14, ptr %arrayidx2.14, align 1, !tbaa !5
  %arrayidx.15 = getelementptr inbounds i8, ptr %roundKey, i64 15
  %30 = load i8, ptr %arrayidx.15, align 1, !tbaa !5
  %arrayidx2.15 = getelementptr inbounds i8, ptr %state, i64 15
  %31 = load i8, ptr %arrayidx2.15, align 1, !tbaa !5
  %xor8.15 = xor i8 %31, %30
  store i8 %xor8.15, ptr %arrayidx2.15, align 1, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @SubBytes(ptr nocapture noundef %state) local_unnamed_addr #0 {
entry:
  %0 = load i8, ptr %state, align 1, !tbaa !5
  %idxprom1 = zext i8 %0 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1
  %1 = load i8, ptr %arrayidx2, align 1, !tbaa !5
  store i8 %1, ptr %state, align 1, !tbaa !5
  %arrayidx.1 = getelementptr inbounds i8, ptr %state, i64 1
  %2 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %idxprom1.1 = zext i8 %2 to i64
  %arrayidx2.1 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.1
  %3 = load i8, ptr %arrayidx2.1, align 1, !tbaa !5
  store i8 %3, ptr %arrayidx.1, align 1, !tbaa !5
  %arrayidx.2 = getelementptr inbounds i8, ptr %state, i64 2
  %4 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %idxprom1.2 = zext i8 %4 to i64
  %arrayidx2.2 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.2
  %5 = load i8, ptr %arrayidx2.2, align 1, !tbaa !5
  store i8 %5, ptr %arrayidx.2, align 1, !tbaa !5
  %arrayidx.3 = getelementptr inbounds i8, ptr %state, i64 3
  %6 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %idxprom1.3 = zext i8 %6 to i64
  %arrayidx2.3 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.3
  %7 = load i8, ptr %arrayidx2.3, align 1, !tbaa !5
  store i8 %7, ptr %arrayidx.3, align 1, !tbaa !5
  %arrayidx.4 = getelementptr inbounds i8, ptr %state, i64 4
  %8 = load i8, ptr %arrayidx.4, align 1, !tbaa !5
  %idxprom1.4 = zext i8 %8 to i64
  %arrayidx2.4 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.4
  %9 = load i8, ptr %arrayidx2.4, align 1, !tbaa !5
  store i8 %9, ptr %arrayidx.4, align 1, !tbaa !5
  %arrayidx.5 = getelementptr inbounds i8, ptr %state, i64 5
  %10 = load i8, ptr %arrayidx.5, align 1, !tbaa !5
  %idxprom1.5 = zext i8 %10 to i64
  %arrayidx2.5 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.5
  %11 = load i8, ptr %arrayidx2.5, align 1, !tbaa !5
  store i8 %11, ptr %arrayidx.5, align 1, !tbaa !5
  %arrayidx.6 = getelementptr inbounds i8, ptr %state, i64 6
  %12 = load i8, ptr %arrayidx.6, align 1, !tbaa !5
  %idxprom1.6 = zext i8 %12 to i64
  %arrayidx2.6 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.6
  %13 = load i8, ptr %arrayidx2.6, align 1, !tbaa !5
  store i8 %13, ptr %arrayidx.6, align 1, !tbaa !5
  %arrayidx.7 = getelementptr inbounds i8, ptr %state, i64 7
  %14 = load i8, ptr %arrayidx.7, align 1, !tbaa !5
  %idxprom1.7 = zext i8 %14 to i64
  %arrayidx2.7 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.7
  %15 = load i8, ptr %arrayidx2.7, align 1, !tbaa !5
  store i8 %15, ptr %arrayidx.7, align 1, !tbaa !5
  %arrayidx.8 = getelementptr inbounds i8, ptr %state, i64 8
  %16 = load i8, ptr %arrayidx.8, align 1, !tbaa !5
  %idxprom1.8 = zext i8 %16 to i64
  %arrayidx2.8 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.8
  %17 = load i8, ptr %arrayidx2.8, align 1, !tbaa !5
  store i8 %17, ptr %arrayidx.8, align 1, !tbaa !5
  %arrayidx.9 = getelementptr inbounds i8, ptr %state, i64 9
  %18 = load i8, ptr %arrayidx.9, align 1, !tbaa !5
  %idxprom1.9 = zext i8 %18 to i64
  %arrayidx2.9 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.9
  %19 = load i8, ptr %arrayidx2.9, align 1, !tbaa !5
  store i8 %19, ptr %arrayidx.9, align 1, !tbaa !5
  %arrayidx.10 = getelementptr inbounds i8, ptr %state, i64 10
  %20 = load i8, ptr %arrayidx.10, align 1, !tbaa !5
  %idxprom1.10 = zext i8 %20 to i64
  %arrayidx2.10 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.10
  %21 = load i8, ptr %arrayidx2.10, align 1, !tbaa !5
  store i8 %21, ptr %arrayidx.10, align 1, !tbaa !5
  %arrayidx.11 = getelementptr inbounds i8, ptr %state, i64 11
  %22 = load i8, ptr %arrayidx.11, align 1, !tbaa !5
  %idxprom1.11 = zext i8 %22 to i64
  %arrayidx2.11 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.11
  %23 = load i8, ptr %arrayidx2.11, align 1, !tbaa !5
  store i8 %23, ptr %arrayidx.11, align 1, !tbaa !5
  %arrayidx.12 = getelementptr inbounds i8, ptr %state, i64 12
  %24 = load i8, ptr %arrayidx.12, align 1, !tbaa !5
  %idxprom1.12 = zext i8 %24 to i64
  %arrayidx2.12 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.12
  %25 = load i8, ptr %arrayidx2.12, align 1, !tbaa !5
  store i8 %25, ptr %arrayidx.12, align 1, !tbaa !5
  %arrayidx.13 = getelementptr inbounds i8, ptr %state, i64 13
  %26 = load i8, ptr %arrayidx.13, align 1, !tbaa !5
  %idxprom1.13 = zext i8 %26 to i64
  %arrayidx2.13 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.13
  %27 = load i8, ptr %arrayidx2.13, align 1, !tbaa !5
  store i8 %27, ptr %arrayidx.13, align 1, !tbaa !5
  %arrayidx.14 = getelementptr inbounds i8, ptr %state, i64 14
  %28 = load i8, ptr %arrayidx.14, align 1, !tbaa !5
  %idxprom1.14 = zext i8 %28 to i64
  %arrayidx2.14 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.14
  %29 = load i8, ptr %arrayidx2.14, align 1, !tbaa !5
  store i8 %29, ptr %arrayidx.14, align 1, !tbaa !5
  %arrayidx.15 = getelementptr inbounds i8, ptr %state, i64 15
  %30 = load i8, ptr %arrayidx.15, align 1, !tbaa !5
  %idxprom1.15 = zext i8 %30 to i64
  %arrayidx2.15 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.15
  %31 = load i8, ptr %arrayidx2.15, align 1, !tbaa !5
  store i8 %31, ptr %arrayidx.15, align 1, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @ShiftRows(ptr nocapture noundef %state) local_unnamed_addr #0 {
entry:
  %arrayidx = getelementptr inbounds i8, ptr %state, i64 1
  %0 = load i8, ptr %arrayidx, align 1, !tbaa !5
  %arrayidx1 = getelementptr inbounds i8, ptr %state, i64 5
  %1 = load i8, ptr %arrayidx1, align 1, !tbaa !5
  store i8 %1, ptr %arrayidx, align 1, !tbaa !5
  %arrayidx3 = getelementptr inbounds i8, ptr %state, i64 9
  %2 = load i8, ptr %arrayidx3, align 1, !tbaa !5
  store i8 %2, ptr %arrayidx1, align 1, !tbaa !5
  %arrayidx5 = getelementptr inbounds i8, ptr %state, i64 13
  %3 = load i8, ptr %arrayidx5, align 1, !tbaa !5
  store i8 %3, ptr %arrayidx3, align 1, !tbaa !5
  store i8 %0, ptr %arrayidx5, align 1, !tbaa !5
  %arrayidx8 = getelementptr inbounds i8, ptr %state, i64 2
  %4 = load i8, ptr %arrayidx8, align 1, !tbaa !5
  %arrayidx9 = getelementptr inbounds i8, ptr %state, i64 10
  %5 = load i8, ptr %arrayidx9, align 1, !tbaa !5
  store i8 %5, ptr %arrayidx8, align 1, !tbaa !5
  store i8 %4, ptr %arrayidx9, align 1, !tbaa !5
  %arrayidx12 = getelementptr inbounds i8, ptr %state, i64 6
  %6 = load i8, ptr %arrayidx12, align 1, !tbaa !5
  %arrayidx13 = getelementptr inbounds i8, ptr %state, i64 14
  %7 = load i8, ptr %arrayidx13, align 1, !tbaa !5
  store i8 %7, ptr %arrayidx12, align 1, !tbaa !5
  store i8 %6, ptr %arrayidx13, align 1, !tbaa !5
  %arrayidx16 = getelementptr inbounds i8, ptr %state, i64 3
  %8 = load i8, ptr %arrayidx16, align 1, !tbaa !5
  %arrayidx17 = getelementptr inbounds i8, ptr %state, i64 15
  %9 = load i8, ptr %arrayidx17, align 1, !tbaa !5
  store i8 %9, ptr %arrayidx16, align 1, !tbaa !5
  %arrayidx19 = getelementptr inbounds i8, ptr %state, i64 11
  %10 = load i8, ptr %arrayidx19, align 1, !tbaa !5
  store i8 %10, ptr %arrayidx17, align 1, !tbaa !5
  %arrayidx21 = getelementptr inbounds i8, ptr %state, i64 7
  %11 = load i8, ptr %arrayidx21, align 1, !tbaa !5
  store i8 %11, ptr %arrayidx19, align 1, !tbaa !5
  store i8 %8, ptr %arrayidx21, align 1, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local zeroext i8 @gmul(i8 noundef zeroext %a, i8 noundef zeroext %b) local_unnamed_addr #3 {
entry:
  %0 = and i8 %b, 1
  %cmp3.not = icmp eq i8 %0, 0
  %xor29 = select i1 %cmp3.not, i8 0, i8 %a
  %shl = shl i8 %a, 1
  %1 = xor i8 %shl, 27
  %cmp14.not30 = icmp slt i8 %a, 0
  %a.addr.1 = select i1 %cmp14.not30, i8 %1, i8 %shl
  %2 = and i8 %b, 2
  %cmp3.not.1 = icmp eq i8 %2, 0
  %xor29.1 = select i1 %cmp3.not.1, i8 0, i8 %a.addr.1
  %spec.select.1 = xor i8 %xor29.1, %xor29
  %shl.1 = shl i8 %a.addr.1, 1
  %3 = xor i8 %shl.1, 27
  %cmp14.not30.1 = icmp slt i8 %a.addr.1, 0
  %a.addr.1.1 = select i1 %cmp14.not30.1, i8 %3, i8 %shl.1
  %4 = and i8 %b, 4
  %cmp3.not.2 = icmp eq i8 %4, 0
  %xor29.2 = select i1 %cmp3.not.2, i8 0, i8 %a.addr.1.1
  %spec.select.2 = xor i8 %spec.select.1, %xor29.2
  %shl.2 = shl i8 %a.addr.1.1, 1
  %5 = xor i8 %shl.2, 27
  %cmp14.not30.2 = icmp slt i8 %a.addr.1.1, 0
  %a.addr.1.2 = select i1 %cmp14.not30.2, i8 %5, i8 %shl.2
  %6 = and i8 %b, 8
  %cmp3.not.3 = icmp eq i8 %6, 0
  %xor29.3 = select i1 %cmp3.not.3, i8 0, i8 %a.addr.1.2
  %spec.select.3 = xor i8 %spec.select.2, %xor29.3
  %shl.3 = shl i8 %a.addr.1.2, 1
  %7 = xor i8 %shl.3, 27
  %cmp14.not30.3 = icmp slt i8 %a.addr.1.2, 0
  %a.addr.1.3 = select i1 %cmp14.not30.3, i8 %7, i8 %shl.3
  %8 = and i8 %b, 16
  %cmp3.not.4 = icmp eq i8 %8, 0
  %xor29.4 = select i1 %cmp3.not.4, i8 0, i8 %a.addr.1.3
  %spec.select.4 = xor i8 %spec.select.3, %xor29.4
  %shl.4 = shl i8 %a.addr.1.3, 1
  %9 = xor i8 %shl.4, 27
  %cmp14.not30.4 = icmp slt i8 %a.addr.1.3, 0
  %a.addr.1.4 = select i1 %cmp14.not30.4, i8 %9, i8 %shl.4
  %10 = and i8 %b, 32
  %cmp3.not.5 = icmp eq i8 %10, 0
  %xor29.5 = select i1 %cmp3.not.5, i8 0, i8 %a.addr.1.4
  %spec.select.5 = xor i8 %spec.select.4, %xor29.5
  %shl.5 = shl i8 %a.addr.1.4, 1
  %11 = xor i8 %shl.5, 27
  %cmp14.not30.5 = icmp slt i8 %a.addr.1.4, 0
  %a.addr.1.5 = select i1 %cmp14.not30.5, i8 %11, i8 %shl.5
  %12 = and i8 %b, 64
  %cmp3.not.6 = icmp eq i8 %12, 0
  %xor29.6 = select i1 %cmp3.not.6, i8 0, i8 %a.addr.1.5
  %spec.select.6 = xor i8 %spec.select.5, %xor29.6
  %shl.6 = shl i8 %a.addr.1.5, 1
  %13 = xor i8 %shl.6, 27
  %cmp14.not30.6 = icmp slt i8 %a.addr.1.5, 0
  %a.addr.1.6 = select i1 %cmp14.not30.6, i8 %13, i8 %shl.6
  %cmp3.not.7.inv = icmp slt i8 %b, 0
  %xor29.7 = select i1 %cmp3.not.7.inv, i8 %a.addr.1.6, i8 0
  %spec.select.7 = xor i8 %spec.select.6, %xor29.7
  ret i8 %spec.select.7
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
define dso_local void @MixColumns(ptr nocapture noundef %state) local_unnamed_addr #0 {
entry:
  %0 = load i8, ptr %state, align 1, !tbaa !5
  %arrayidx7 = getelementptr inbounds i8, ptr %state, i64 1
  %1 = load i8, ptr %arrayidx7, align 1, !tbaa !5
  %arrayidx13 = getelementptr inbounds i8, ptr %state, i64 2
  %2 = load i8, ptr %arrayidx13, align 1, !tbaa !5
  %arrayidx19 = getelementptr inbounds i8, ptr %state, i64 3
  %3 = load i8, ptr %arrayidx19, align 1, !tbaa !5
  %shl.i = shl i8 %0, 1
  %4 = xor i8 %shl.i, 27
  %cmp14.not30.i = icmp slt i8 %0, 0
  %a.addr.1.i = select i1 %cmp14.not30.i, i8 %4, i8 %shl.i
  %shl.i150 = shl i8 %3, 1
  %5 = xor i8 %shl.i150, 27
  %cmp14.not30.i151 = icmp slt i8 %3, 0
  %a.addr.1.i152 = select i1 %cmp14.not30.i151, i8 %5, i8 %shl.i150
  %shl.i171 = shl i8 %2, 1
  %6 = xor i8 %shl.i171, 27
  %cmp14.not30.i172 = icmp slt i8 %2, 0
  %a.addr.1.i173 = select i1 %cmp14.not30.i172, i8 %6, i8 %shl.i171
  %shl.i192 = shl i8 %1, 1
  %7 = xor i8 %shl.i192, 27
  %cmp14.not30.i193 = icmp slt i8 %1, 0
  %a.addr.1.i194 = select i1 %cmp14.not30.i193, i8 %7, i8 %shl.i192
  %spec.select.1.i = xor i8 %3, %2
  %8 = xor i8 %spec.select.1.i, %1
  %9 = xor i8 %8, %a.addr.1.i
  %xor33140 = xor i8 %9, %a.addr.1.i194
  %10 = xor i8 %spec.select.1.i, %0
  %11 = xor i8 %10, %a.addr.1.i194
  %xor50143 = xor i8 %11, %a.addr.1.i173
  %spec.select.1.i364 = xor i8 %1, %0
  %12 = xor i8 %a.addr.1.i173, %3
  %13 = xor i8 %12, %spec.select.1.i364
  %xor67146 = xor i8 %13, %a.addr.1.i152
  %14 = xor i8 %a.addr.1.i, %2
  %15 = xor i8 %14, %spec.select.1.i364
  %xor84149 = xor i8 %15, %a.addr.1.i152
  store i8 %xor33140, ptr %state, align 1, !tbaa !5
  store i8 %xor50143, ptr %arrayidx7, align 1, !tbaa !5
  store i8 %xor67146, ptr %arrayidx13, align 1, !tbaa !5
  store i8 %xor84149, ptr %arrayidx19, align 1, !tbaa !5
  %arrayidx.1 = getelementptr inbounds i8, ptr %state, i64 4
  %16 = load i8, ptr %arrayidx.1, align 1, !tbaa !5
  %arrayidx7.1 = getelementptr inbounds i8, ptr %state, i64 5
  %17 = load i8, ptr %arrayidx7.1, align 1, !tbaa !5
  %arrayidx13.1 = getelementptr inbounds i8, ptr %state, i64 6
  %18 = load i8, ptr %arrayidx13.1, align 1, !tbaa !5
  %arrayidx19.1 = getelementptr inbounds i8, ptr %state, i64 7
  %19 = load i8, ptr %arrayidx19.1, align 1, !tbaa !5
  %shl.i.1 = shl i8 %16, 1
  %20 = xor i8 %shl.i.1, 27
  %cmp14.not30.i.1 = icmp slt i8 %16, 0
  %a.addr.1.i.1 = select i1 %cmp14.not30.i.1, i8 %20, i8 %shl.i.1
  %shl.i150.1 = shl i8 %19, 1
  %21 = xor i8 %shl.i150.1, 27
  %cmp14.not30.i151.1 = icmp slt i8 %19, 0
  %a.addr.1.i152.1 = select i1 %cmp14.not30.i151.1, i8 %21, i8 %shl.i150.1
  %shl.i171.1 = shl i8 %18, 1
  %22 = xor i8 %shl.i171.1, 27
  %cmp14.not30.i172.1 = icmp slt i8 %18, 0
  %a.addr.1.i173.1 = select i1 %cmp14.not30.i172.1, i8 %22, i8 %shl.i171.1
  %shl.i192.1 = shl i8 %17, 1
  %23 = xor i8 %shl.i192.1, 27
  %cmp14.not30.i193.1 = icmp slt i8 %17, 0
  %a.addr.1.i194.1 = select i1 %cmp14.not30.i193.1, i8 %23, i8 %shl.i192.1
  %spec.select.1.i.1 = xor i8 %19, %18
  %24 = xor i8 %spec.select.1.i.1, %17
  %25 = xor i8 %24, %a.addr.1.i.1
  %xor33140.1 = xor i8 %25, %a.addr.1.i194.1
  %26 = xor i8 %spec.select.1.i.1, %16
  %27 = xor i8 %26, %a.addr.1.i194.1
  %xor50143.1 = xor i8 %27, %a.addr.1.i173.1
  %spec.select.1.i364.1 = xor i8 %17, %16
  %28 = xor i8 %a.addr.1.i173.1, %19
  %29 = xor i8 %28, %spec.select.1.i364.1
  %xor67146.1 = xor i8 %29, %a.addr.1.i152.1
  %30 = xor i8 %a.addr.1.i.1, %18
  %31 = xor i8 %30, %spec.select.1.i364.1
  %xor84149.1 = xor i8 %31, %a.addr.1.i152.1
  store i8 %xor33140.1, ptr %arrayidx.1, align 1, !tbaa !5
  store i8 %xor50143.1, ptr %arrayidx7.1, align 1, !tbaa !5
  store i8 %xor67146.1, ptr %arrayidx13.1, align 1, !tbaa !5
  store i8 %xor84149.1, ptr %arrayidx19.1, align 1, !tbaa !5
  %arrayidx.2 = getelementptr inbounds i8, ptr %state, i64 8
  %32 = load i8, ptr %arrayidx.2, align 1, !tbaa !5
  %arrayidx7.2 = getelementptr inbounds i8, ptr %state, i64 9
  %33 = load i8, ptr %arrayidx7.2, align 1, !tbaa !5
  %arrayidx13.2 = getelementptr inbounds i8, ptr %state, i64 10
  %34 = load i8, ptr %arrayidx13.2, align 1, !tbaa !5
  %arrayidx19.2 = getelementptr inbounds i8, ptr %state, i64 11
  %35 = load i8, ptr %arrayidx19.2, align 1, !tbaa !5
  %shl.i.2 = shl i8 %32, 1
  %36 = xor i8 %shl.i.2, 27
  %cmp14.not30.i.2 = icmp slt i8 %32, 0
  %a.addr.1.i.2 = select i1 %cmp14.not30.i.2, i8 %36, i8 %shl.i.2
  %shl.i150.2 = shl i8 %35, 1
  %37 = xor i8 %shl.i150.2, 27
  %cmp14.not30.i151.2 = icmp slt i8 %35, 0
  %a.addr.1.i152.2 = select i1 %cmp14.not30.i151.2, i8 %37, i8 %shl.i150.2
  %shl.i171.2 = shl i8 %34, 1
  %38 = xor i8 %shl.i171.2, 27
  %cmp14.not30.i172.2 = icmp slt i8 %34, 0
  %a.addr.1.i173.2 = select i1 %cmp14.not30.i172.2, i8 %38, i8 %shl.i171.2
  %shl.i192.2 = shl i8 %33, 1
  %39 = xor i8 %shl.i192.2, 27
  %cmp14.not30.i193.2 = icmp slt i8 %33, 0
  %a.addr.1.i194.2 = select i1 %cmp14.not30.i193.2, i8 %39, i8 %shl.i192.2
  %spec.select.1.i.2 = xor i8 %35, %34
  %40 = xor i8 %spec.select.1.i.2, %33
  %41 = xor i8 %40, %a.addr.1.i.2
  %xor33140.2 = xor i8 %41, %a.addr.1.i194.2
  %42 = xor i8 %spec.select.1.i.2, %32
  %43 = xor i8 %42, %a.addr.1.i194.2
  %xor50143.2 = xor i8 %43, %a.addr.1.i173.2
  %spec.select.1.i364.2 = xor i8 %33, %32
  %44 = xor i8 %a.addr.1.i173.2, %35
  %45 = xor i8 %44, %spec.select.1.i364.2
  %xor67146.2 = xor i8 %45, %a.addr.1.i152.2
  %46 = xor i8 %a.addr.1.i.2, %34
  %47 = xor i8 %46, %spec.select.1.i364.2
  %xor84149.2 = xor i8 %47, %a.addr.1.i152.2
  store i8 %xor33140.2, ptr %arrayidx.2, align 1, !tbaa !5
  store i8 %xor50143.2, ptr %arrayidx7.2, align 1, !tbaa !5
  store i8 %xor67146.2, ptr %arrayidx13.2, align 1, !tbaa !5
  store i8 %xor84149.2, ptr %arrayidx19.2, align 1, !tbaa !5
  %arrayidx.3 = getelementptr inbounds i8, ptr %state, i64 12
  %48 = load i8, ptr %arrayidx.3, align 1, !tbaa !5
  %arrayidx7.3 = getelementptr inbounds i8, ptr %state, i64 13
  %49 = load i8, ptr %arrayidx7.3, align 1, !tbaa !5
  %arrayidx13.3 = getelementptr inbounds i8, ptr %state, i64 14
  %50 = load i8, ptr %arrayidx13.3, align 1, !tbaa !5
  %arrayidx19.3 = getelementptr inbounds i8, ptr %state, i64 15
  %51 = load i8, ptr %arrayidx19.3, align 1, !tbaa !5
  %shl.i.3 = shl i8 %48, 1
  %52 = xor i8 %shl.i.3, 27
  %cmp14.not30.i.3 = icmp slt i8 %48, 0
  %a.addr.1.i.3 = select i1 %cmp14.not30.i.3, i8 %52, i8 %shl.i.3
  %shl.i150.3 = shl i8 %51, 1
  %53 = xor i8 %shl.i150.3, 27
  %cmp14.not30.i151.3 = icmp slt i8 %51, 0
  %a.addr.1.i152.3 = select i1 %cmp14.not30.i151.3, i8 %53, i8 %shl.i150.3
  %shl.i171.3 = shl i8 %50, 1
  %54 = xor i8 %shl.i171.3, 27
  %cmp14.not30.i172.3 = icmp slt i8 %50, 0
  %a.addr.1.i173.3 = select i1 %cmp14.not30.i172.3, i8 %54, i8 %shl.i171.3
  %shl.i192.3 = shl i8 %49, 1
  %55 = xor i8 %shl.i192.3, 27
  %cmp14.not30.i193.3 = icmp slt i8 %49, 0
  %a.addr.1.i194.3 = select i1 %cmp14.not30.i193.3, i8 %55, i8 %shl.i192.3
  %spec.select.1.i.3 = xor i8 %51, %50
  %56 = xor i8 %spec.select.1.i.3, %49
  %57 = xor i8 %56, %a.addr.1.i.3
  %xor33140.3 = xor i8 %57, %a.addr.1.i194.3
  %58 = xor i8 %spec.select.1.i.3, %48
  %59 = xor i8 %58, %a.addr.1.i194.3
  %xor50143.3 = xor i8 %59, %a.addr.1.i173.3
  %spec.select.1.i364.3 = xor i8 %49, %48
  %60 = xor i8 %a.addr.1.i173.3, %51
  %61 = xor i8 %60, %spec.select.1.i364.3
  %xor67146.3 = xor i8 %61, %a.addr.1.i152.3
  %62 = xor i8 %a.addr.1.i.3, %50
  %63 = xor i8 %62, %spec.select.1.i364.3
  %xor84149.3 = xor i8 %63, %a.addr.1.i152.3
  store i8 %xor33140.3, ptr %arrayidx.3, align 1, !tbaa !5
  store i8 %xor50143.3, ptr %arrayidx7.3, align 1, !tbaa !5
  store i8 %xor67146.3, ptr %arrayidx13.3, align 1, !tbaa !5
  store i8 %xor84149.3, ptr %arrayidx19.3, align 1, !tbaa !5
  ret void
}

; Function Attrs: nofree nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @AES128Encrypt(ptr nocapture noundef readonly %input, ptr nocapture noundef writeonly %output, ptr nocapture noundef readonly %key) local_unnamed_addr #4 {
entry:
  %state = alloca [16 x i8], align 16
  %roundKeys = alloca [176 x i8], align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %state) #8
  call void @llvm.lifetime.start.p0(i64 176, ptr nonnull %roundKeys) #8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %state, ptr noundef nonnull align 1 dereferenceable(16) %input, i64 16, i1 false)
  %0 = load <16 x i8>, ptr %key, align 1, !tbaa !5
  store <16 x i8> %0, ptr %roundKeys, align 16, !tbaa !5
  %uglygep = getelementptr inbounds i8, ptr %roundKeys, i64 12
  %load_initial = load <4 x i8>, ptr %uglygep, align 4
  br label %for.cond4.preheader.i

for.cond4.preheader.i:                            ; preds = %if.end.i, %entry
  %store_forwarded = phi <4 x i8> [ %load_initial, %entry ], [ %19, %if.end.i ]
  %indvars.iv.i = phi i64 [ 16, %entry ], [ %indvars.iv.next.i, %if.end.i ]
  %1 = and i64 %indvars.iv.i, 12
  %cmp14.i = icmp eq i64 %1, 0
  br i1 %cmp14.i, label %if.then.i, label %if.end.i

if.then.i:                                        ; preds = %for.cond4.preheader.i
  %2 = extractelement <4 x i8> %store_forwarded, i64 1
  %idxprom1.i.i = zext i8 %2 to i64
  %arrayidx2.i.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.i.i
  %3 = load i8, ptr %arrayidx2.i.i, align 1, !tbaa !5
  %4 = extractelement <4 x i8> %store_forwarded, i64 2
  %idxprom1.1.i.i = zext i8 %4 to i64
  %arrayidx2.1.i.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.1.i.i
  %5 = load i8, ptr %arrayidx2.1.i.i, align 1, !tbaa !5
  %6 = extractelement <4 x i8> %store_forwarded, i64 3
  %idxprom1.2.i.i = zext i8 %6 to i64
  %arrayidx2.2.i.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.2.i.i
  %7 = load i8, ptr %arrayidx2.2.i.i, align 1, !tbaa !5
  %8 = extractelement <4 x i8> %store_forwarded, i64 0
  %idxprom1.3.i.i = zext i8 %8 to i64
  %arrayidx2.3.i.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.3.i.i
  %9 = load i8, ptr %arrayidx2.3.i.i, align 1, !tbaa !5
  %div.udiv82.i = lshr i64 %indvars.iv.i, 4
  %idxprom17.i = and i64 %div.udiv82.i, 268435455
  %arrayidx18.i = getelementptr inbounds [11 x i8], ptr @rcon, i64 0, i64 %idxprom17.i
  %10 = load i8, ptr %arrayidx18.i, align 1, !tbaa !5
  %xor62.i = xor i8 %10, %3
  %11 = insertelement <4 x i8> poison, i8 %xor62.i, i64 0
  %12 = insertelement <4 x i8> %11, i8 %5, i64 1
  %13 = insertelement <4 x i8> %12, i8 %7, i64 2
  %14 = insertelement <4 x i8> %13, i8 %9, i64 3
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %for.cond4.preheader.i
  %15 = phi <4 x i8> [ %14, %if.then.i ], [ %store_forwarded, %for.cond4.preheader.i ]
  %16 = add nsw i64 %indvars.iv.i, -16
  %arrayidx30.i = getelementptr inbounds i8, ptr %roundKeys, i64 %16
  %arrayidx38.i = getelementptr inbounds i8, ptr %roundKeys, i64 %indvars.iv.i
  %17 = or i64 %indvars.iv.i, 3
  %18 = load <4 x i8>, ptr %arrayidx30.i, align 4, !tbaa !5
  %19 = xor <4 x i8> %18, %15
  store <4 x i8> %19, ptr %arrayidx38.i, align 4, !tbaa !5
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 4
  %cmp3.i = icmp ult i64 %17, 175
  br i1 %cmp3.i, label %for.cond4.preheader.i, label %KeyExpansion.exit, !llvm.loop !8

KeyExpansion.exit:                                ; preds = %if.end.i
  %arrayidx2.1.i = getelementptr inbounds i8, ptr %state, i64 1
  %arrayidx2.2.i = getelementptr inbounds i8, ptr %state, i64 2
  %arrayidx2.3.i = getelementptr inbounds i8, ptr %state, i64 3
  %arrayidx2.4.i = getelementptr inbounds i8, ptr %state, i64 4
  %arrayidx2.5.i = getelementptr inbounds i8, ptr %state, i64 5
  %arrayidx2.6.i = getelementptr inbounds i8, ptr %state, i64 6
  %arrayidx2.7.i = getelementptr inbounds i8, ptr %state, i64 7
  %arrayidx2.8.i = getelementptr inbounds i8, ptr %state, i64 8
  %arrayidx2.9.i = getelementptr inbounds i8, ptr %state, i64 9
  %arrayidx2.10.i = getelementptr inbounds i8, ptr %state, i64 10
  %arrayidx2.11.i = getelementptr inbounds i8, ptr %state, i64 11
  %arrayidx2.12.i = getelementptr inbounds i8, ptr %state, i64 12
  %arrayidx2.13.i = getelementptr inbounds i8, ptr %state, i64 13
  %arrayidx2.14.i = getelementptr inbounds i8, ptr %state, i64 14
  %arrayidx2.15.i = getelementptr inbounds i8, ptr %state, i64 15
  %20 = load <16 x i8>, ptr %roundKeys, align 16, !tbaa !5
  %21 = load <16 x i8>, ptr %state, align 16, !tbaa !5
  %22 = xor <16 x i8> %21, %20
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %23 = extractelement <16 x i8> %109, i64 0
  %idxprom1.i = zext i8 %23 to i64
  %arrayidx2.i = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.i
  %24 = extractelement <16 x i8> %109, i64 1
  %idxprom1.1.i = zext i8 %24 to i64
  %arrayidx2.1.i18 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.1.i
  %25 = extractelement <16 x i8> %109, i64 2
  %idxprom1.2.i = zext i8 %25 to i64
  %arrayidx2.2.i20 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.2.i
  %26 = extractelement <16 x i8> %109, i64 3
  %idxprom1.3.i = zext i8 %26 to i64
  %arrayidx2.3.i22 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.3.i
  %27 = extractelement <16 x i8> %109, i64 4
  %idxprom1.4.i = zext i8 %27 to i64
  %arrayidx2.4.i24 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.4.i
  %28 = extractelement <16 x i8> %109, i64 5
  %idxprom1.5.i = zext i8 %28 to i64
  %arrayidx2.5.i26 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.5.i
  %29 = extractelement <16 x i8> %109, i64 6
  %idxprom1.6.i = zext i8 %29 to i64
  %arrayidx2.6.i28 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.6.i
  %30 = extractelement <16 x i8> %109, i64 7
  %idxprom1.7.i = zext i8 %30 to i64
  %arrayidx2.7.i30 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.7.i
  %31 = extractelement <16 x i8> %109, i64 8
  %idxprom1.8.i = zext i8 %31 to i64
  %arrayidx2.8.i32 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.8.i
  %32 = extractelement <16 x i8> %109, i64 9
  %idxprom1.9.i = zext i8 %32 to i64
  %arrayidx2.9.i34 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.9.i
  %33 = extractelement <16 x i8> %109, i64 10
  %idxprom1.10.i = zext i8 %33 to i64
  %arrayidx2.10.i36 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.10.i
  %34 = extractelement <16 x i8> %109, i64 11
  %idxprom1.11.i = zext i8 %34 to i64
  %arrayidx2.11.i38 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.11.i
  %35 = extractelement <16 x i8> %109, i64 12
  %idxprom1.12.i = zext i8 %35 to i64
  %arrayidx2.12.i40 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.12.i
  %36 = extractelement <16 x i8> %109, i64 13
  %idxprom1.13.i = zext i8 %36 to i64
  %arrayidx2.13.i42 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.13.i
  %37 = extractelement <16 x i8> %109, i64 14
  %idxprom1.14.i = zext i8 %37 to i64
  %arrayidx2.14.i44 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.14.i
  %38 = extractelement <16 x i8> %109, i64 15
  %idxprom1.15.i = zext i8 %38 to i64
  %arrayidx2.15.i46 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.15.i
  %add.ptr13 = getelementptr inbounds i8, ptr %roundKeys, i64 160
  %39 = load i8, ptr %arrayidx2.i, align 1, !tbaa !5
  %40 = load i8, ptr %arrayidx2.1.i18, align 1, !tbaa !5
  %41 = load i8, ptr %arrayidx2.2.i20, align 1, !tbaa !5
  %42 = load i8, ptr %arrayidx2.3.i22, align 1, !tbaa !5
  %43 = load i8, ptr %arrayidx2.4.i24, align 1, !tbaa !5
  %44 = load i8, ptr %arrayidx2.5.i26, align 1, !tbaa !5
  %45 = load i8, ptr %arrayidx2.6.i28, align 1, !tbaa !5
  %46 = load i8, ptr %arrayidx2.7.i30, align 1, !tbaa !5
  %47 = load i8, ptr %arrayidx2.8.i32, align 1, !tbaa !5
  %48 = load i8, ptr %arrayidx2.9.i34, align 1, !tbaa !5
  %49 = load i8, ptr %arrayidx2.10.i36, align 1, !tbaa !5
  %50 = load i8, ptr %arrayidx2.11.i38, align 1, !tbaa !5
  %51 = load i8, ptr %arrayidx2.12.i40, align 1, !tbaa !5
  %52 = load i8, ptr %arrayidx2.13.i42, align 1, !tbaa !5
  %53 = load i8, ptr %arrayidx2.14.i44, align 1, !tbaa !5
  %54 = load i8, ptr %arrayidx2.15.i46, align 1, !tbaa !5
  %55 = load <16 x i8>, ptr %add.ptr13, align 16, !tbaa !5
  %56 = insertelement <16 x i8> poison, i8 %39, i64 0
  %57 = insertelement <16 x i8> %56, i8 %44, i64 1
  %58 = insertelement <16 x i8> %57, i8 %49, i64 2
  %59 = insertelement <16 x i8> %58, i8 %54, i64 3
  %60 = insertelement <16 x i8> %59, i8 %43, i64 4
  %61 = insertelement <16 x i8> %60, i8 %48, i64 5
  %62 = insertelement <16 x i8> %61, i8 %53, i64 6
  %63 = insertelement <16 x i8> %62, i8 %42, i64 7
  %64 = insertelement <16 x i8> %63, i8 %47, i64 8
  %65 = insertelement <16 x i8> %64, i8 %52, i64 9
  %66 = insertelement <16 x i8> %65, i8 %41, i64 10
  %67 = insertelement <16 x i8> %66, i8 %46, i64 11
  %68 = insertelement <16 x i8> %67, i8 %51, i64 12
  %69 = insertelement <16 x i8> %68, i8 %40, i64 13
  %70 = insertelement <16 x i8> %69, i8 %45, i64 14
  %71 = insertelement <16 x i8> %70, i8 %50, i64 15
  %72 = xor <16 x i8> %71, %55
  store <16 x i8> %72, ptr %state, align 16, !tbaa !5
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(16) %output, ptr noundef nonnull align 16 dereferenceable(16) %state, i64 16, i1 false)
  call void @llvm.lifetime.end.p0(i64 176, ptr nonnull %roundKeys) #8
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %state) #8
  ret void

for.body:                                         ; preds = %for.body, %KeyExpansion.exit
  %indvars.iv = phi i64 [ 1, %KeyExpansion.exit ], [ %indvars.iv.next, %for.body ]
  %73 = phi <16 x i8> [ %22, %KeyExpansion.exit ], [ %109, %for.body ]
  %74 = extractelement <16 x i8> %73, i64 0
  %idxprom1.i93 = zext i8 %74 to i64
  %arrayidx2.i94 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.i93
  %75 = load i8, ptr %arrayidx2.i94, align 1, !tbaa !5
  store i8 %75, ptr %state, align 16, !tbaa !5
  %76 = extractelement <16 x i8> %73, i64 1
  %idxprom1.1.i96 = zext i8 %76 to i64
  %arrayidx2.1.i97 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.1.i96
  %77 = load i8, ptr %arrayidx2.1.i97, align 1, !tbaa !5
  %78 = extractelement <16 x i8> %73, i64 2
  %idxprom1.2.i99 = zext i8 %78 to i64
  %arrayidx2.2.i100 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.2.i99
  %79 = load i8, ptr %arrayidx2.2.i100, align 1, !tbaa !5
  %80 = extractelement <16 x i8> %73, i64 3
  %idxprom1.3.i102 = zext i8 %80 to i64
  %arrayidx2.3.i103 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.3.i102
  %81 = load i8, ptr %arrayidx2.3.i103, align 1, !tbaa !5
  %82 = extractelement <16 x i8> %73, i64 4
  %idxprom1.4.i105 = zext i8 %82 to i64
  %arrayidx2.4.i106 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.4.i105
  %83 = load i8, ptr %arrayidx2.4.i106, align 1, !tbaa !5
  store i8 %83, ptr %arrayidx2.4.i, align 4, !tbaa !5
  %84 = extractelement <16 x i8> %73, i64 5
  %idxprom1.5.i108 = zext i8 %84 to i64
  %arrayidx2.5.i109 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.5.i108
  %85 = load i8, ptr %arrayidx2.5.i109, align 1, !tbaa !5
  %86 = extractelement <16 x i8> %73, i64 6
  %idxprom1.6.i111 = zext i8 %86 to i64
  %arrayidx2.6.i112 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.6.i111
  %87 = load i8, ptr %arrayidx2.6.i112, align 1, !tbaa !5
  %88 = extractelement <16 x i8> %73, i64 7
  %idxprom1.7.i114 = zext i8 %88 to i64
  %arrayidx2.7.i115 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.7.i114
  %89 = load i8, ptr %arrayidx2.7.i115, align 1, !tbaa !5
  %90 = extractelement <16 x i8> %73, i64 8
  %idxprom1.8.i117 = zext i8 %90 to i64
  %arrayidx2.8.i118 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.8.i117
  %91 = load i8, ptr %arrayidx2.8.i118, align 1, !tbaa !5
  store i8 %91, ptr %arrayidx2.8.i, align 8, !tbaa !5
  %92 = extractelement <16 x i8> %73, i64 9
  %idxprom1.9.i120 = zext i8 %92 to i64
  %arrayidx2.9.i121 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.9.i120
  %93 = load i8, ptr %arrayidx2.9.i121, align 1, !tbaa !5
  %94 = extractelement <16 x i8> %73, i64 10
  %idxprom1.10.i123 = zext i8 %94 to i64
  %arrayidx2.10.i124 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.10.i123
  %95 = load i8, ptr %arrayidx2.10.i124, align 1, !tbaa !5
  %96 = extractelement <16 x i8> %73, i64 11
  %idxprom1.11.i126 = zext i8 %96 to i64
  %arrayidx2.11.i127 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.11.i126
  %97 = load i8, ptr %arrayidx2.11.i127, align 1, !tbaa !5
  %98 = extractelement <16 x i8> %73, i64 12
  %idxprom1.12.i129 = zext i8 %98 to i64
  %arrayidx2.12.i130 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.12.i129
  %99 = load i8, ptr %arrayidx2.12.i130, align 1, !tbaa !5
  store i8 %99, ptr %arrayidx2.12.i, align 4, !tbaa !5
  %100 = extractelement <16 x i8> %73, i64 13
  %idxprom1.13.i132 = zext i8 %100 to i64
  %arrayidx2.13.i133 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.13.i132
  %101 = load i8, ptr %arrayidx2.13.i133, align 1, !tbaa !5
  %102 = extractelement <16 x i8> %73, i64 14
  %idxprom1.14.i135 = zext i8 %102 to i64
  %arrayidx2.14.i136 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.14.i135
  %103 = load i8, ptr %arrayidx2.14.i136, align 1, !tbaa !5
  %104 = extractelement <16 x i8> %73, i64 15
  %idxprom1.15.i138 = zext i8 %104 to i64
  %arrayidx2.15.i139 = getelementptr inbounds [256 x i8], ptr @s_box, i64 0, i64 %idxprom1.15.i138
  %105 = load i8, ptr %arrayidx2.15.i139, align 1, !tbaa !5
  store i8 %85, ptr %arrayidx2.1.i, align 1, !tbaa !5
  store i8 %93, ptr %arrayidx2.5.i, align 1, !tbaa !5
  store i8 %101, ptr %arrayidx2.9.i, align 1, !tbaa !5
  store i8 %77, ptr %arrayidx2.13.i, align 1, !tbaa !5
  store i8 %95, ptr %arrayidx2.2.i, align 2, !tbaa !5
  store i8 %79, ptr %arrayidx2.10.i, align 2, !tbaa !5
  store i8 %103, ptr %arrayidx2.6.i, align 2, !tbaa !5
  store i8 %87, ptr %arrayidx2.14.i, align 2, !tbaa !5
  store i8 %105, ptr %arrayidx2.3.i, align 1, !tbaa !5
  store i8 %97, ptr %arrayidx2.15.i, align 1, !tbaa !5
  store i8 %89, ptr %arrayidx2.11.i, align 1, !tbaa !5
  store i8 %81, ptr %arrayidx2.7.i, align 1, !tbaa !5
  call void @MixColumns(ptr noundef nonnull %state)
  %106 = shl nuw nsw i64 %indvars.iv, 4
  %add.ptr = getelementptr inbounds i8, ptr %roundKeys, i64 %106
  %107 = load <16 x i8>, ptr %add.ptr, align 16, !tbaa !5
  %108 = load <16 x i8>, ptr %state, align 16, !tbaa !5
  %109 = xor <16 x i8> %108, %107
  store <16 x i8> %109, ptr %state, align 16, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 10
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !10
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #5

; Function Attrs: nofree nosync nounwind memory(none) uwtable
define dso_local i32 @main() local_unnamed_addr #6 {
entry:
  %input = alloca [4 x [16 x i8]], align 16
  %output = alloca [4 x [16 x i8]], align 16
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %input) #8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(64) %input, i8 0, i64 64, i1 false)
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %output) #8
  call void @AES128Encrypt(ptr noundef nonnull %input, ptr noundef nonnull %output, ptr noundef nonnull @__const.main.key)
  %arrayidx.1 = getelementptr inbounds [4 x [16 x i8]], ptr %input, i64 0, i64 1
  %arrayidx2.1 = getelementptr inbounds [4 x [16 x i8]], ptr %output, i64 0, i64 1
  call void @AES128Encrypt(ptr noundef nonnull %arrayidx.1, ptr noundef nonnull %arrayidx2.1, ptr noundef nonnull @__const.main.key)
  %arrayidx.2 = getelementptr inbounds [4 x [16 x i8]], ptr %input, i64 0, i64 2
  %arrayidx2.2 = getelementptr inbounds [4 x [16 x i8]], ptr %output, i64 0, i64 2
  call void @AES128Encrypt(ptr noundef nonnull %arrayidx.2, ptr noundef nonnull %arrayidx2.2, ptr noundef nonnull @__const.main.key)
  %arrayidx.3 = getelementptr inbounds [4 x [16 x i8]], ptr %input, i64 0, i64 3
  %arrayidx2.3 = getelementptr inbounds [4 x [16 x i8]], ptr %output, i64 0, i64 3
  call void @AES128Encrypt(ptr noundef nonnull %arrayidx.3, ptr noundef nonnull %arrayidx2.3, ptr noundef nonnull @__const.main.key)
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %output) #8
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %input) #8
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #7

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { nofree nosync nounwind memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
