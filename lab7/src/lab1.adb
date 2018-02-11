---------------------------------------
-- Zubrych E.S.
-- Labwork 1
-- MA = MB * MC + a * ( MK + MT)
---------------------------------------

with Ada
  .Text_IO, Ada
  .Integer_Text_IO, DataOperations, Ada
  .Synchronous_Task_Control;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;

procedure Lab1 is

   N : Integer := 4;
   P : Integer := 2;
   H : Integer := N / P;

   package Operations is new DataOperations (N);
   use Operations;

   MC, MK, MT : Matrix;
   --Common resources
   a  : Integer;
   MB : Matrix;
            --Middle
         Mbc  : Matrix;
         Mkt  : Matrix;
         Makt : Matrix;
   --Result
   MA : Matrix;
   --Semaphors
   S1, S2, S3, Scs1, Scs2 : Suspension_Object;
   --Tasks
   procedure Tasks is
      task T1 is
         pragma Storage_Size (3_000_000);
      end T1;
      task body T1 is
         a1  : Integer;
         MB1 : Matrix;

      begin
         Put_Line ("T1 started");
         --input a, MK, MC
         FillWithOne (a);
         FillWithOne (MK);
         FillWithOne (MC);
         --signal the completion of the input a, MK, MC
         Set_True (S1);
         --wait for data input in task T2
         Suspend_Until_True (S2);

         --critical section 1
         --Suspend_Until_True(Scs1);
         a1 := a;
         Set_True (Scs1);

         --critical section 2
         --Suspend_Until_True(Scs2);
         MB1 := MB;
         Set_True (Scs2);

         --calculating
         Multiple (MB1, MC, 1, H, Mbc);
         Amount (MK, MT, 1, H, Mkt);
         Multiple (a, Mkt, 1, H, Makt);
         Amount (Mbc, Makt, 1, H, MA);
         Set_True (S3);

         Put_Line ("T1 finished");
      end T1;

      task T2 is
         pragma Storage_Size (3_000_000);
      end T2;

      task body T2 is
         a2  : Integer;
         MB2 : Matrix;
      begin
         Put_Line ("T2 started");
         --input MB, MT
         FillWithOne (MB);
         FillWithOne (MT);
         --signal the completion of the input MB, MT
         Set_True (S2);
         --wait for data input in task T1
         Suspend_Until_True (S1);

         --critical section 1
         Suspend_Until_True (Scs1);
         a2 := a;
         Set_True (Scs1);

         --critical section 2
         Suspend_Until_True (Scs2);
         MB2 := MB;
         Set_True (Scs2);

         --calculating
         Multiple (MB2, MC, H + 1, N, Mbc);
         Amount (MK, MT, H + 1, N, Mkt);
         Multiple (a, Mkt, H + 1, N, Makt);
         Amount (Mbc, Makt, H + 1, N, MA);
         Suspend_Until_True (S3);


         Output (MA);

         Put_Line ("T2 finished");
      end T2;
   begin
      null;
   end Tasks;

begin
   Put_Line ("Program started");
   Tasks;
end Lab1;
