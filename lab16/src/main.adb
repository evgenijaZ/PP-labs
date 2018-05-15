with System;              use System;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Calendar; use Ada.Calendar;
procedure Main is
   N : Integer := 1000;
   P : Integer := 4;
   H : Integer := N / P;
   startTime : Time;
   endTime : Time;

   type GeneralVector is array (Integer range <>) of Integer;
   subtype Vector is GeneralVector (1 .. N);
   subtype VectorH is GeneralVector (1 .. H);
   subtype Vector2H is GeneralVector (1 .. 2 * H);
   subtype Vector3H is GeneralVector (1 .. 3 * H);

   type GeneralMatrix is array (Integer range <>, Integer range <>) of Integer;
   subtype Matrix is GeneralMatrix (1 .. N, 1 .. N);
   subtype MatrixH is GeneralMatrix (1 .. N, 1 .. H);
   subtype Matrix2H is GeneralMatrix (1 .. N, 1 .. 2 * H);
   subtype Matrix3H is GeneralMatrix (1 .. N, 1 .. 3 * H);

    procedure Start is
   task T1 is
      entry Data1 (B_p : in Vector; MC_p : in Matrix);
      entry Data2 (e_p : in Integer; MD_p : in MatrixH);
      entry Data3 (ME_p : in MatrixH);
   end T1;

   task T2 is
      entry Data2 (MD_p : in Matrix2H; e_p : in Integer);
      entry Data3 (ME_p : in Matrix2H);
      entry Rezult1 (A_p : in VectorH);
      entry Rezult23 (A_p : in Vector2H);
   end T2;

   task T3 is
      entry Data3 (ME_p : in Matrix3H);
      entry Data1 (B_p : in Vector; MC_p : in Matrix);
      entry Rezult3 (A_p : in VectorH);
   end T3;

   task T4 is
      entry Data2 (MD_p : in MatrixH; e_p : in Integer);
      entry Data1 (B_p : in Vector; MC_p : in Matrix);
   end T4;

   task body T1 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      e        : Integer;
      ME       : MatrixH;
      A        : VectorH;
      MR       : Matrix;
      from, to : Integer;
   begin
      Put_Line ("T1 started");
      from := 1;
      to   := H;
      --Receive B, MC from T2
      accept Data1 (B_p : in Vector; MC_p : in Matrix) do
         B  := B_p;
         MC := MC_p;
      end Data1;
      --Receive MD, e from T2
      accept Data2 (e_p : in Integer; MD_p : in MatrixH) do
         e  := e_p;
         MD := MD_p;
      end Data2;
      --Receive ME from T2
      accept Data3 (ME_p : in MatrixH) do
         ME := ME_p;
      end Data3;
      --Calculate A = B * (MC * MDH - MEH * e)
      for i in 1 .. N loop
         for j in from .. to loop
            MR (i, j) := 0;
            for k in 1 .. N loop
               MR (i, j) := MR (i, j) + MC (i, k) * MD (k, j);
            end loop;
            MR (i, j) := MR (i, j) - ME (i, j) * e;
         end loop;
      end loop;
      for j in from .. to loop
         A (j) := 0;
         for k in 1 .. N loop
            A (j) := A (j) + B (k) * MR (k, j);
         end loop;
      end loop;
      --Send A to T2
      T2.Rezult1 (A);
      --Put_Line ("T1 finished");
   end T1;

   task body T2 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      MD_t     : Matrix2H;
      MD_t2    : MatrixH;
      e        : Integer;
      ME       : MatrixH;
      ME_t     : Matrix2H;
      ME_t2    : MatrixH;
      A        : Vector;
      MR       : Matrix;
      from, to : Integer;
   begin
      Put_Line ("T2 started");
      from := 1;
      to   := H;
      --Input B, MC
      for i in 1 .. N loop
         B (i) := 1;
         for j in 1 .. N loop
            MC (i, j) := 1;
         end loop;
      end loop;
      --Send B, MC to T1
      T1.Data1 (B, MC);
      --Receive MD, e from T3
      accept Data2 (MD_p : in Matrix2H; e_p : in Integer) do
         MD_t := MD_p;
         e    := e_p;
         --MD:=MD_p(1..N,H+1..2*H);
         for i in 1 .. N loop
            for j in H + 1 .. 2 * H loop
               MD (i, j - H) := MD_p (i, j);
            end loop;
         end loop;
      end Data2;
      --Send B, MC to T3
      T3.Data1 (B, MC);
      --Send MD, e to T1
      for i in 1 .. N loop
         for j in 1 .. H loop
            MD_t2 (i, j) := MD_t (i, j);
         end loop;
      end loop;
      T1.Data2 (e, MD_t2);
      --Receive ME from T3
      accept Data3 (ME_p : in Matrix2H) do
         ME_t := ME_p;
         --ME:=ME_p(H+1..2*H);
         for i in 1 .. N loop
            for j in H + 1 .. 2 * H loop
               ME (i, j - H) := ME_p (i, j);
            end loop;
         end loop;
      end Data3;
      --Send ME to T1
      for i in 1 .. N loop
         for j in 1 .. H loop
            ME_t2 (i, j) := ME_t (i, j);
         end loop;
      end loop;
      T1.Data3 (ME_t2);
      --Calculate A = B * (MC * MDH - MEH * e)
      for i in 1 .. N loop
         for j in from .. to loop
            MR (i, j) := 0;
            for k in 1 .. N loop
               MR (i, j) := MR (i, j) + MC (i, k) * MD (k, j);
            end loop;
            MR (i, j) := MR (i, j) - ME (i, j) * e;
         end loop;
      end loop;

      for j in H + 1 .. 2 * H loop
         A (j) := 0;
         for k in 1 .. N loop
            A (j) := A (j) + B (k) * MR (k, j - H);
         end loop;
      end loop;
      --Receive A from T1
      accept Rezult1 (A_p : in VectorH) do
         A (1 .. H) := A_p;
      end Rezult1;
      --Receive A from T3
      accept Rezult23 (A_p : in Vector2H) do
         A (2 * H + 1 .. N) := A_p;
      end Rezult23;
      --Output A
      if N <= 12 then
         for i in 1 .. N loop
            Put (A (i));
            Put (" ");
         end loop;
         Put_Line ("");
      end if;
      --Put_Line ("T2 finished");
   end T2;

   task body T3 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      MD_t     : Matrix;
      MD_t2    : Matrix2H;
      MD_t3    : MatrixH;
      e        : Integer;
      ME       : MatrixH;
      ME_t     : Matrix3H;
      ME_t2    : Matrix2H;
      A        : Vector2H;
      MR       : Matrix;
      from, to : Integer;
   begin
      Put_Line ("T3 started");
      from := 1;
      to   := H;
      --Input MD, e
      for i in 1 .. N loop
         for j in 1 .. N loop
            MD_t (i, j) := 1;
         end loop;
      end loop;
      e := 1;
      -- MD:=MD_t(2*H+1..3*H);
      for i in 1 .. N loop
         for j in 2 * H + 1 .. 3 * H loop
            MD (i, j - 2 * H) := MD_t (i, j);
         end loop;
      end loop;
      --Send MD, e to T2
      for i in 1 .. N loop
         for j in 1 .. 2 * H loop
            MD_t2 (i, j) := MD_t (i, j);
         end loop;
      end loop;
      T2.Data2 (MD_t2, e);
      --Receive ME from T4
      accept Data3 (ME_p : in Matrix3H) do
         ME_t := ME_p;
         -- ME:=ME_p(2*H+1..3*H);
         for i in 1 .. N loop
            for j in 2 * H + 1 .. 3 * H loop
               ME (i, j - 2 * H) := ME_p (i, j);
            end loop;
         end loop;
      end Data3;
      --Send MD, e to T4
      for i in 1 .. N loop
         for j in 3 * H + 1 .. N loop
            MD_t3 (i, j - 3 * H) := MD_t (i, j);
         end loop;
      end loop;
      T4.Data2 (MD_t3, e);
      --Receive B, MC from T2
      accept Data1 (B_p : in Vector; MC_p : in Matrix) do
         B  := B_p;
         MC := MC_p;
      end Data1;
      --Send B, MC to T4
      T4.Data1 (B, MC);
      --Send ME to T3
      for i in 1 .. N loop
         for j in 1 .. 2 * H loop
            ME_t2 (i, j) := ME_t (i, j);
         end loop;
      end loop;
      T2.Data3 (ME_t2);
      --Calculate A = B * (MC * MDH - MEH * e)
      for i in 1 .. N loop
         for j in from .. to loop
            MR (i, j) := 0;
            for k in 1 .. N loop
               MR (i, j) := MR (i, j) + MC (i, k) * MD (k, j);
            end loop;
            MR (i, j) := MR (i, j) - ME (i, j) * e;
         end loop;
      end loop;
      for j in from .. to loop
         A (j) := 0;
         for k in 1 .. N loop
            A (j) := A (j) + B (k) * MR (k, j);
         end loop;
      end loop;
      --Receive A from T4
      accept Rezult3 (A_p : in VectorH) do
         A (H + 1 .. 2 * H) := A_p;
      end Rezult3;
      --Send A to T2
      T2.Rezult23 (A);
      --Put_Line ("T3 finished");
   end T3;

   task body T4 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      e        : Integer;
      ME       : MatrixH;
      ME_t     : Matrix;
      ME_t2    : Matrix3H;
      A        : VectorH;
      MR       : Matrix;
      from, to : Integer;
   begin
      Put_Line ("T4 started");
      from := 1;
      to   := H;
      --Input ME
      for i in 1 .. N loop
         for j in 1 .. N loop
            ME_t (i, j) := 1;
         end loop;
      end loop;
      -- ME:=ME_t(3*H+1..N);
      for i in 1 .. N loop
         for j in 3 * H + 1 .. N loop
            ME (i, j - 3 * H) := ME_t (i, j);
         end loop;
      end loop;
      --Send ME to T3
      for i in 1 .. N loop
         for j in 1 .. 3 * H loop
            ME_t2 (i, j) := ME_t (i, j);
         end loop;
      end loop;
      T3.Data3 (ME_t2);
      --Receive MD, e from T3
      accept Data2 (MD_p : in MatrixH; e_p : in Integer) do
         MD := MD_p;
         e  := e_p;
      end Data2;
      --Receive B, MC from T3
      accept Data1 (B_p : in Vector; MC_p : in Matrix) do
         B  := B_p;
         MC := MC_p;
      end Data1;
      --Calculate A = B * (MC * MDH - MEH * e)
      for i in 1 .. N loop
         for j in from .. to loop
            MR (i, j) := 0;
            for k in 1 .. N loop
               MR (i, j) := MR (i, j) + MC (i, k) * MD (k, j);
            end loop;
            MR (i, j) := MR (i, j) - ME (i, j) * e;
         end loop;
      end loop;
      for j in from .. to loop
         A (j) := 0;
         for k in 1 .. N loop
            A (j) := A (j) + B (k) * MR (k, j);
         end loop;
      end loop;
      --Send A to T3
      T3.Rezult3 (A);
      -- Put_Line ("T4 finished");
   end T4;

   begin
      null;
   end Start;

begin

   startTime := Clock;
   Start;
   endTime:=Clock;
   Put("Time: ");
   Put(Integer(endTime-startTime),10);
end Main;
