with Ada.Integer_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

package body Data is

   function F1(A : in Matrix; D : in Matrix; B : in Vector) return Matrix is
      E : Matrix;
   begin
      return E;
   end F1;

   function F2(a : in Integer; G : in Matrix; K : in Matrix; L : in Matrix) return Matrix is
      F : Matrix;
   begin
      return F;
   end F2;

   function F3(P : in Matrix; R : in Matrix; S : in Vector; T : in Vector) return Vector is
      O : Vector;
   begin
      return O;
   end F3;

   procedure Matrix_Input (A : out Matrix) is
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

   procedure Matrix_Output(A : in Matrix) is
   begin
      Put_Line ("Matrix:");
      for i in 1..N loop
         for j in 1..N loop
            Ada.Integer_Text_IO.Put(A(i,j));
         end loop;
         New_Line;
      end loop;
   end Matrix_Output;


   procedure Vector_Input (A : out Vector) is
      item : Integer;
   begin
      Put_Line ("Enter vector values:");
      for i in 1..N loop
         Ada.Integer_Text_IO.Get(item);
         A(i) := item;
      end loop;
   end Vector_Input;

   procedure Vector_Output(A : in Vector) is
   begin
      Put_Line ("Vector:");
      for i in 1..N loop
         Ada.Integer_Text_IO.Put(A(i));
      end loop;
      New_Line;
   end Vector_Output;

   function Max (A: Vector) return Integer is
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

   function Amount ( A: in Vector; B: in Vector) return Vector is
      C : Vector;
   begin
      for i in 1..N loop
         C(i):=A(i)+B(i);
      end loop;
      return C;
   end Amount;

   function Multiple ( A: in Integer; B: in out Matrix) return Matrix is
      C:Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            C(i,j):=A*B(i,j);
         end loop;
      end loop;
      return C;
   end Multiple;

   function Trans (A: in Matrix) return Matrix is
      B:Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            B(i,j):=A(j,i);
         end loop;
      end loop;
      return B;
   end Trans;

   function Amount ( A: in Matrix; B: in Matrix) return Matrix is
      C:Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
           C(i,j):=A(i,j)+B(i,j);
         end loop;
      end loop;
      return C;
   end Amount;


   function Multiple ( A: in Matrix; B: in Matrix) return Matrix is
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


end Data;
