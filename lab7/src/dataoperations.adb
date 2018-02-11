with Ada
  .Text_IO, Ada
  .Integer_Text_IO, Ada.Numerics
  .Discrete_Random, Ada
  .Strings, Ada.Strings
  .Fixed;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body DataOperations is

   subtype Random_Range is Positive range 1 .. 10;
   package Random_Integer is new Ada.Numerics.Discrete_Random (Random_Range);
   G           : Random_Integer.Generator;
   Random_Item : Random_Range;
   procedure Input (a : out Integer) is
   begin
      Put_Line ("Input value:");
      Ada.Integer_Text_IO.Get (Item => a);
   end Input;

   procedure Generate (a : out Integer) is
   begin
      Random_Integer.Reset (G);
      Random_Item := Random_Integer.Random (G);
      a           := Random_Item;
   end Generate;

   procedure FillWithOne (a : out Integer) is
   begin
      a := 1;
   end FillWithOne;

   procedure Input (A : out Vector) is
   begin
      Put_Line ("Input vector:");
      for i in 1 .. N loop
         Get (Item => A (i));
      end loop;
   end Input;

   procedure Generate (A : out Vector) is
   begin
      Random_Integer.Reset (G);
      for i in 1 .. N loop
         Random_Item := Random_Integer.Random (G);
         A (i)       := Random_Item;
      end loop;
   end Generate;

   procedure FillWithOne (A : out Vector) is
   begin
      for i in 1 .. N loop
         A (i) := 1;
      end loop;
   end FillWithOne;

   procedure Input (MA : out Matrix) is
   begin
      Put_Line ("Enter matrix values:");
      for i in 1 .. N loop
         for j in 1 .. N loop
            Ada.Integer_Text_IO.Get (Item => MA (i) (j));
         end loop;
      end loop;
   end Input;

   procedure Generate (MA : out Matrix) is
   begin
      Random_Integer.Reset (G);
      for i in 1 .. N loop
         for j in 1 .. N loop
            Random_Item := Random_Integer.Random (G);
            MA (i) (j)  := Random_Item;
         end loop;
      end loop;
   end Generate;

   procedure FillWithOne (MA : out Matrix) is
   begin
      for i in 1 .. N loop
         for j in 1 .. N loop
            MA (i) (j) := 1;
         end loop;
      end loop;
   end FillWithOne;

   procedure Output (V : in Vector) is
   begin
      New_Line;
      for i in 1 .. N loop
         Put (Item => V (i), Width => 4);
      end loop;
      New_Line;
   end Output;

   procedure Output (MA : in Matrix) is
   begin
      New_Line;
      for i in 1 .. N loop
         for j in 1 .. N loop
            Put (Item => MA (i) (j), Width => 4);
         end loop;
         New_Line;
      end loop;
      New_Line;
   end Output;

   procedure Multiple
     (A    : in     Integer;
      MB   : in out Matrix;
      From :        Integer;
      To   :        Integer;
      MR   :    out Matrix)
   is
   begin

      for i in From .. To loop
         for j in From .. To loop
            MR (i) (j) := MB (i) (j) * A;
         end loop;
      end loop;
   end Multiple;

   procedure Multiple
     (Left  : in     Matrix;
      Right : in     Matrix;
      From  :        Integer;
      To    :        Integer;
      MR    :    out Matrix)
   is
   begin
      for i in Left'Range loop
         for J in From .. To loop
            MR (i) (J) := 0;
            for K in Right'Range loop
               MR (i) (J) := MR (i) (J) + Left (i) (K) * Right (K) (J);
            end loop;
         end loop;
      end loop;
   end Multiple;

   procedure Amount
     (A    : in     Matrix;
      B    : in     Matrix;
      From :        Integer;
      To   :        Integer;
      MR   :    out Matrix)
   is
   begin
      for i in From .. To loop
         for J in From .. To loop
            MR (i) (J) := A (i) (J) + B (i) (J);
         end loop;
      end loop;
   end Amount;

end DataOperations;
