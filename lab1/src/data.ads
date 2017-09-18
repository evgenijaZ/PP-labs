package Data is
   
   type Matrix is private;
   type Vector is private;
         
   procedure Vector_Input(A : out Vector; N : in Integer);
   procedure Vector_Output(A : in Vector; N : in Integer);
   procedure Vector_Generate (A : out Vector; N : in Integer);
   procedure Matrix_Input(A : out Matrix; N : in Integer);
   procedure Matrix_Output(A : in Matrix; N : in Integer);
   procedure Matrix_Generate (A : out Matrix; N : in Integer);
   procedure Value_Generate (A : out Integer);
   
   function F1(A : in Matrix; D : in Matrix; B : in Vector; N : in Integer) return Matrix;
   function F2(a : in Integer; G : in Matrix; K : in Matrix; L : in Matrix; N : in Integer) return Matrix;
   function F3(P : in Matrix; R : in Matrix; S : in Vector; T : in Vector; N : in Integer) return Vector;
   
   function Amount ( A: in Vector; B: in Vector; N : in Integer) return Vector;
   function Amount ( A: in Matrix; B: in Matrix; N : in Integer) return Matrix;
   function Multiple ( A: in Integer; B: in out Matrix; N : in Integer) return Matrix;
   function Multiple ( A: in Matrix; B: in Matrix; N : in Integer) return Matrix;  
   function Multiple ( A: in Matrix; B: in Vector; N : in Integer) return Vector;
   function Max (A: Vector; N : in Integer) return Integer;
   function Trans (A: in Matrix; N : in Integer) return Matrix;
   
private
   type Vector is array(1..100) of Integer;
   type Matrix is array (1..100,1..100) of Integer;
      
end Data;
