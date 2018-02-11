---------------------------------------
-- Zubrych E.S.
-- Labwork 1
-- MA = MB * MC + a * ( MK + MT)
---------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, DataOperations;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab1 is

   N:Integer:=100;
   P:Integer:=2;
   H:Integer:=N/P;

   package DataOperations is new DataOperations(N);
   use DataOperations;

   MC,MK,MT:Matrix;
   --Common resources
   a:Integer;
   MB:Matrix;
   --Result
   MA:Matrix;
   --Tasks
   procedure Tasks is
      task T1 is
         pragma Storage_Size (3_000_000);
      end T1;
      task body T1 is
      begin
         Put_Line("T1 started");
         --input
         FillWithOne(a);
         FillWithOne(MK);
         FillWithOne(MC);
         Put_Line("T1 finished");
      end T1;

      task T2 is
         pragma Storage_Size (3_000_000);
      end T2;

      task body T2 is
      begin
         Put_Line("T2 started");
         FillWithOne(MB);
         FillWithOne(MT);
         Put_Line("T2 finished");
      end T2;
   begin
      null;
   end Tasks;
begin
   Put_Line("Program started");
   Tasks;
end Lab1;
