; RUN: opt -mtriple=i386-pc-linux-gnu -inferattrs -basic-aa -aa-eval -print-all-alias-modref-info -disable-output 2>&1 %s | FileCheck %s

; CHECK-LABEL: Function: test_memcmp_const_size
; CHECK:      Just Ref:  Ptr: i8* %a	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %a.gep.1	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: NoModRef:  Ptr: i8* %a.gep.5	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b.gep.1	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: NoModRef:  Ptr: i8* %b.gep.5	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 4)
define i32 @test_memcmp_const_size(i8* noalias %a, i8* noalias %b) {
entry:
  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 4)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  %b.gep.1 = getelementptr i8, i8* %b, i32 1
  store i8 2, i8* %b.gep.1
  %b.gep.5 = getelementptr i8, i8* %b, i32 5
  store i8 3, i8* %b.gep.5
  ret i32 %res
}

; CHECK-LABEL: Function: test_memcmp_variable_size
; CHECK:      Just Ref:  Ptr: i8* %a	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %a.gep.1	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %a.gep.5	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b.gep.1	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b.gep.5	<->  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 %n)
define i32 @test_memcmp_variable_size(i8* noalias %a, i8* noalias %b, i64 %n) {
entry:
  %res = tail call i32 @memcmp(i8* %a, i8* %b, i64 %n)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  %b.gep.1 = getelementptr i8, i8* %b, i32 1
  store i8 2, i8* %b.gep.1
  %b.gep.5 = getelementptr i8, i8* %b, i32 5
  store i8 3, i8* %b.gep.5
  ret i32 %res
}

declare i32 @memcmp(i8*, i8*, i64)
declare i32 @bcmp(i8*, i8*, i64)

; CHECK-LABEL: Function: test_bcmp_const_size
; CHECK:      Just Ref:  Ptr: i8* %a	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %a.gep.1	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: NoModRef:  Ptr: i8* %a.gep.5	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b.gep.1	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 4)
; CHECK-NEXT: NoModRef:  Ptr: i8* %b.gep.5	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 4)
define i32 @test_bcmp_const_size(i8* noalias %a, i8* noalias %b) {
entry:
  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 4)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  %b.gep.1 = getelementptr i8, i8* %b, i32 1
  store i8 2, i8* %b.gep.1
  %b.gep.5 = getelementptr i8, i8* %b, i32 5
  store i8 3, i8* %b.gep.5
  ret i32 %res
}

; CHECK-LABEL: Function: test_bcmp_variable_size
; CHECK:      Just Ref:  Ptr: i8* %a	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %a.gep.1	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %a.gep.5	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b.gep.1	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b.gep.5	<->  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 %n)
define i32 @test_bcmp_variable_size(i8* noalias %a, i8* noalias %b, i64 %n) {
entry:
  %res = tail call i32 @bcmp(i8* %a, i8* %b, i64 %n)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  %b.gep.1 = getelementptr i8, i8* %b, i32 1
  store i8 2, i8* %b.gep.1
  %b.gep.5 = getelementptr i8, i8* %b, i32 5
  store i8 3, i8* %b.gep.5
  ret i32 %res
}

declare i8* @memchr(i8*, i32, i64)

; CHECK-LABEL: Function: test_memchr_const_size
; CHECK: Just Ref:  Ptr: i8* %res      <->  %res = call i8* @memchr(i8* %a, i32 42, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %a.gep.1  <->  %res = call i8* @memchr(i8* %a, i32 42, i64 4)
; CHECK-NEXT: NoModRef:  Ptr: i8* %a.gep.5  <->  %res = call i8* @memchr(i8* %a, i32 42, i64 4)
define i8* @test_memchr_const_size(i8* noalias %a) {
entry:
  %res = call i8* @memchr(i8* %a, i32 42, i64 4)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  ret i8* %res
}

declare i8* @memccpy(i8*, i8*, i32, i64)

; CHECK-LABEL: Function: test_memccpy_const_size
; CHECK:      Just Mod:  Ptr: i8* %a        <->  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b        <->  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)
; CHECK-NEXT: Just Mod:  Ptr: i8* %res      <->  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)
; CHECK-NEXT: Just Mod:  Ptr: i8* %a.gep.1  <->  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)
; CHECK-NEXT: NoModRef:  Ptr: i8* %a.gep.5  <->  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)
; CHECK-NEXT: Just Ref:  Ptr: i8* %b.gep.1  <->  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)
; CHECK-NEXT: NoModRef:  Ptr: i8* %b.gep.5  <->  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)

define i8* @test_memccpy_const_size(i8* noalias %a, i8* noalias %b) {
entry:
  %res = call i8* @memccpy(i8* %a, i8* %b, i32 42, i64 4)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  %b.gep.1 = getelementptr i8, i8* %b, i32 1
  store i8 2, i8* %b.gep.1
  %b.gep.5 = getelementptr i8, i8* %b, i32 5
  store i8 3, i8* %b.gep.5
  ret i8* %res
}

declare i8* @strncpy(i8*, i8*, i64)

define i8* @test_strncpy_const_size(i8* noalias %a, i8* noalias %b) {
; CHECK-LABEL: Function: test_strncpy_const_size
; CHECK:       Just Mod:  Ptr: i8* %a	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
; CHECK-NEXT:  Just Ref:  Ptr: i8* %b	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %res	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %a.gep.1	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
; CHECK-NEXT:  NoModRef:  Ptr: i8* %a.gep.5	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
; CHECK-NEXT:  Just Ref:  Ptr: i8* %b.gep.1	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
; CHECK-NEXT:  NoModRef:  Ptr: i8* %b.gep.5	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
;
entry:
  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 4)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  %b.gep.1 = getelementptr i8, i8* %b, i32 1
  store i8 2, i8* %b.gep.1
  %b.gep.5 = getelementptr i8, i8* %b, i32 5
  store i8 3, i8* %b.gep.5
  ret i8* %res
}

define i8* @test_strncpy_variable_size(i8* noalias %a, i8* noalias %b, i64 %n) {
; CHECK-LABEL: Function: test_strncpy_variable_size
; CHECK:       Just Mod:  Ptr: i8* %a	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT:  Just Ref:  Ptr: i8* %b	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %res	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %a.gep.1	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %a.gep.5	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT:  Just Ref:  Ptr: i8* %b.gep.1	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
; CHECK-NEXT:  Just Ref:  Ptr: i8* %b.gep.5	<->  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
;
entry:
  %res = tail call i8* @strncpy(i8* %a, i8* %b, i64 %n)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  %b.gep.1 = getelementptr i8, i8* %b, i32 1
  store i8 2, i8* %b.gep.1
  %b.gep.5 = getelementptr i8, i8* %b, i32 5
  store i8 3, i8* %b.gep.5
  ret i8* %res
}

declare i8* @__memset_chk(i8* writeonly, i32, i64, i64)

; CHECK-LABEL: Function: test_memset_chk_const_size
define i8* @test_memset_chk_const_size(i8* noalias %a, i64 %n) {
; CHECK:       Just Mod (MustAlias):  Ptr: i8* %a	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 4, i64 %n)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %res	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 4, i64 %n)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %a.gep.1	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 4, i64 %n)
; CHECK-NEXT:  NoModRef:  Ptr: i8* %a.gep.5	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 4, i64 %n)
;
entry:
  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 4, i64 %n)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  ret i8* %res
}

define i8* @test_memset_chk_variable_size(i8* noalias %a, i64 %n.1, i64 %n.2) {
; CHECK-LABEL: Function: test_memset_chk_variable_size
; CHECK:       Just Mod (MustAlias):  Ptr: i8* %a	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 %n.1, i64 %n.2)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %res	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 %n.1, i64 %n.2)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %a.gep.1	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 %n.1, i64 %n.2)
; CHECK-NEXT:  Just Mod:  Ptr: i8* %a.gep.5	<->  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 %n.1, i64 %n.2)
;
entry:
  %res = tail call i8* @__memset_chk(i8* %a, i32 0, i64 %n.1, i64 %n.2)
  %a.gep.1 = getelementptr i8, i8* %a, i32 1
  store i8 0, i8* %a.gep.1
  %a.gep.5 = getelementptr i8, i8* %a, i32 5
  store i8 1, i8* %a.gep.5
  ret i8* %res
}
