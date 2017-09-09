package Data is
   N : Integer;

   type Vector is array (1..N) of Integer;
   type Matrix is array (1..N,1..N) of Integer;
   
   --procedure Matrix_Input();
   --procedure Matrix_Output();
   
   function F1(A : in Matrix; D : in Matrix; B : in Vector) return Matrix;
   function F2(a : in Integer; G : in Matrix; K : in Matrix; L : in Matrix) return Matrix;
   function F3(P : in Matrix; R : in Matrix; S : in Vector; T : in Vector) return Vector;
   
end Data;
