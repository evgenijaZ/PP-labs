generic
   N : in Natural;
   
package DataOperations is

   subtype Index is Positive range 1..N;
   type Vector is array (Index) of integer;
   type Matrix is array (Index) of Vector; 
   
   procedure Input(V : out Vector);

   procedure Generate(V : out Vector);

   procedure FillWithOne(V : out Vector);

   procedure Input (MA : out Matrix);

   procedure Generate(MA : out Matrix);

   procedure FillWithOne(MA : out Matrix);

   procedure Output(V : in Vector);

   procedure Output(MA : in Matrix);

end DataOperations;
