generic
   N : in Natural;

package DataOperations is

   subtype Index is Positive range 1 .. N;
   type Vector is array (Index) of Integer;
   type Matrix is array (Index) of Vector;

   procedure Input (a : out Integer);

   procedure Generate (a : out Integer);

   procedure FillWithOne (a : out Integer);

   procedure Input (A : out Vector);

   procedure Generate (A : out Vector);

   procedure FillWithOne (A : out Vector);

   procedure Input (MA : out Matrix);

   procedure Generate (MA : out Matrix);

   procedure FillWithOne (MA : out Matrix);

   procedure Output (V : in Vector);

   procedure Output (MA : in Matrix);

   function Multiple
     (A    : in Integer;
      MB   : in Matrix;
      From :    Integer;
      To   :    Integer) return Matrix;

   function Multiple
     (Left  : in Matrix;
      Right : in Matrix;
      From  :    Integer;
      To    :    Integer) return Matrix;

   function Amount
     (MA   : in Matrix;
      MB   : in Matrix;
      From :    Integer;
      To   :    Integer) return Matrix;

end DataOperations;
