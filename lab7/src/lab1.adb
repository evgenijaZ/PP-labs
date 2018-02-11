---------------------------------------
-- Zubrych E.S.
-- Labwork 1
-- MA = MB * MC + a * ( MK + MT)
---------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, DataOperations, Ada.Synchronous_Task_Control;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;

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
   --Semaphors
   S1,S2,S3,Sa,Smb:Suspension_Object;
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
         Set_True(S1);
         Suspend_Until_True(S2);
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
         Set_True(S2);
         Suspend_Until_True(S1);
         Put_Line("T2 finished");
      end T2;
   begin
      null;
   end Tasks;

begin
   Put_Line("Program started");
   Tasks;
end Lab1;
