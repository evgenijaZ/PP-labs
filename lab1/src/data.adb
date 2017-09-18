with Ada.Integer_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics;
with Ada.Numerics.Discrete_Random;
package body Data is

   function F1(A : in Matrix; D : in Matrix; B : in Vector; N : in Integer) return Matrix is
      E : Matrix;
   begin
      E := Multiple(A, D, N);
      E := Multiple(Max(B, N), E, N);
      return E;
   end F1;

   function F2(a : in Integer; G : in Matrix; K : in Matrix; L : in Matrix; N : in Integer) return Matrix is
      F,T : Matrix;
   begin
      T:=Trans(G,N);
      F:=Multiple(a,T,N);
      T:=Multiple(K,L,N);
      F:=Amount(F,T,N);
      return F;
   end F2;

   function F3(P : in Matrix; R : in Matrix; S : in Vector; T : in Vector; N : in Integer) return Vector is
      O : Vector;
      A : Matrix;
   begin
      A:=Multiple(P,R,N);
      O:=Multiple(A,S,N);
      O:=Amount(O,S,N);
      return O;
   end F3;

   procedure Matrix_Input (A : out Matrix; N : in Integer) is
      item : Integer;
   begin
      Put_Line ("Enter matrix values:");
      for i in 1..N loop
         for j in 1..N loop
            Ada.Integer_Text_IO.Get (item);
            A(i,j) := item;
         end loop;
      end loop;
   end Matrix_Input;

   procedure Matrix_Output(A : in Matrix; N : in Integer) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            Ada.Integer_Text_IO.Put(A(i,j));
         end loop;
         New_Line;
      end loop;
   end Matrix_Output;


   procedure Matrix_Generate (A : out Matrix; N : in Integer) is
      type Rand_Range is range 1..10;
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      seed : Rand_Int.Generator;
      Num : Rand_Range;
   begin
      Rand_Int.Reset(seed);
      for i in 1..N loop
         for j in 1..N loop
            Num := Rand_Int.Random(seed);
            A(i,j) := Integer(Num);
         end loop;
      end loop;
   end Matrix_Generate;

   procedure Vector_Generate (A : out Vector; N : in Integer) is
      type Rand_Range is range 1..10;
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      seed : Rand_Int.Generator;
      Num : Rand_Range;
   begin
      Rand_Int.Reset(seed);
      for i in 1..N loop
         Num := Rand_Int.Random(seed);
         A(i) := Integer(Num);
      end loop;
   end Vector_Generate;

   procedure Value_Generate (A : out Integer) is
      type Rand_Range is range 1..10;
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      seed : Rand_Int.Generator;
      Num : Rand_Range;
   begin
      Rand_Int.Reset(seed);
      Num := Rand_Int.Random(seed);
      A := Integer(Num);
   end Value_Generate;

   procedure Vector_Input (A : out Vector; N : in Integer) is
      item : Integer;
   begin
      Put_Line ("Enter vector values:");
      for i in 1..N loop
         Ada.Integer_Text_IO.Get(item);
         A(i) := item;
      end loop;
   end Vector_Input;

   procedure Vector_Output(A : in Vector; N : in Integer) is
   begin
      for i in 1..N loop
         Ada.Integer_Text_IO.Put(A(i));
      end loop;
      New_Line;
   end Vector_Output;

   function Max (A: Vector; N : in Integer) return Integer is
      x : Integer;
   begin
      x := A(1);
      for i in 1..N loop
         if A(i)>x then
            x := A(i);
         end if;
      end loop;
      return x;
   end Max;

   function Amount ( A: in Vector; B: in Vector; N : in Integer) return Vector is
      C : Vector;
   begin
      for i in 1..N loop
         C(i):=A(i)+B(i);
      end loop;
      return C;
   end Amount;

   function Multiple ( A: in Integer; B: in out Matrix; N : in Integer) return Matrix is
      C:Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            C(i,j):=A*B(i,j);
         end loop;
      end loop;
      return C;
   end Multiple;

   function Trans (A: in Matrix; N : in Integer) return Matrix is
      B:Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            B(i,j):=A(j,i);
         end loop;
      end loop;
      return B;
   end Trans;

   function Amount ( A: in Matrix; B: in Matrix; N : in Integer) return Matrix is
      C:Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            C(i,j):=A(i,j)+B(i,j);
         end loop;
      end loop;
      return C;
   end Amount;


   function Multiple ( A: in Matrix; B: in Matrix; N : in Integer) return Matrix is
      C:Matrix;
   begin
      for row in 1..N loop
         for col in 1..N loop
            C(row,col):=0;
            for inner in 1..N loop
               C(row,col) := C(row,col) + A(row,inner) * B(inner,col);
            end loop;
         end loop;
      end loop;
      return C;
   end Multiple;


   function Multiple ( A: in Matrix; B: in Vector; N : in Integer) return Vector is
      C:Vector;
   begin
      for row in 1..N loop
         C(row):=0;
         for col in 1..N loop
            C(row) := C(row) + A(row,col) * B(col);
         end loop;
      end loop;
      return C;
   end Multiple;

end Data;
