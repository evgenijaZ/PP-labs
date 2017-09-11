package Data is
   N : Integer;
   NMax : constant := 100;
   type Vector is array(1..NMax) of Integer;
   type Matrix is array (1..NMax,1..NMax) of Integer;
   

   
   procedure Vector_Input(A : out Vector);
   procedure Vector_Output(A : in Vector);
   procedure Vector_Generate (A : out Vector);
   procedure Matrix_Input(A : out Matrix);
   procedure Matrix_Output(A : in Matrix);
   procedure Matrix_Generate (A : out Matrix);
   
   function F1(A : in Matrix; D : in Matrix; B : in Vector) return Matrix;
   function F2(a : in Integer; G : in Matrix; K : in Matrix; L : in Matrix) return Matrix;
   function F3(P : in Matrix; R : in Matrix; S : in Vector; T : in Vector) return Vector;
   
   function Amount ( A: in Vector; B: in Vector) return Vector;
   function Amount ( A: in Matrix; B: in Matrix) return Matrix;
   function Multiple ( A: in Integer; B: in out Matrix) return Matrix;
   function Multiple ( A: in Matrix; B: in Matrix) return Matrix;
   function Max (A: Vector) return Integer;
   function Trans (A: in Matrix) return Matrix;
   

   
end Data;
