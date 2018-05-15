with System;              use System;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure Main is
   N : Integer := 12;
   P : Integer := 4;
   H : Integer := N / P;

   type GeneralVector is array (Integer range <>) of Integer;
   subtype Vector is GeneralVector (1 .. N);
   subtype VectorH is GeneralVector (1 .. H);
   subtype Vector2H is GeneralVector (1 .. 2 * H);

   type GeneralMatrix is array (Integer range <>) of Vector;
   subtype Matrix is GeneralMatrix (1 .. N);
   subtype MatrixH is GeneralMatrix (1 .. H);
   subtype Matrix2H is GeneralMatrix (1 .. 2 * H);
   subtype Matrix3H is GeneralMatrix (1 .. 3 * H);

   task T1 is
      entry Data1 (B_p : in Vector; MC : in Matrix);
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
      entry Data2 (MD_p : in Matrix2H; e_p : in Integer);
      entry Data1 (B_p : in Vector; MC_p : in Matrix);
   end T4;

   task body T1 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      e        : Integer;
      ME       : MatrixH;
      A        : VectorH;
      from, to : Integer;
   begin
      Put_Line ("T1 started");
      from := 1;
      to   := H;
      --Receive B, MC from T2
      --Receive MD, e from T2
      --Receive ME from T2
      --Calculate A
      --Send A to T2
      --Put_Line ("T1 finished");
   end T1;

   task body T2 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      MD_t     : Matrix2H;
      e        : Integer;
      ME       : MatrixH;
      ME_t     : Matrix2H;
      A        : Vector;
      from, to : Integer;
   begin
      Put_Line ("T2 started");
      from := H + 1;
      to   := 2 * H;
      --Input B, MC
      --Send B, MC to T1
      --Receive MD, e from T3
      --Send B, MC to T3
      --Send MD, e to T1
      --Receive ME from T3
      --Send ME to T1
      --Receive A from T1
      --Receive A from T3
      --Output A

      --Put_Line ("T2 finished");
   end T2;

   task body T3 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      MD_t     : Matrix;
      e        : Integer;
      ME       : MatrixH;
      ME_t     : Matrix3H;
      A        : Vector;
      A_t      : Vector2H;
      from, to : Integer;
   begin
      Put_Line ("T3 started");
      from := 2 * H + 1;
      to   := 3 * H;
      --Input MD, e
      --Send MD, e to T2
      --Receive ME from T4
      --Send MD, e to T4
      --Receive B, MC from T2
      --Send B, MC to T4
      --Calculate A
      --Receive A from T4
      --Send A to T2
      --Put_Line ("T3 finished");
   end T3;

   task body T4 is
      B        : Vector;
      MC       : Matrix;
      MD       : MatrixH;
      e        : Integer;
      ME       : MatrixH;
      ME_t     : Matrix;
      A        : Vector;
      from, to : Integer;
   begin
      Put_Line ("T4 started");
      from := 3 * H + 1;
      to   := N;
      --Input ME
      --Send ME to T3
      --Receive MD, e from T3
      --Receive B, MC from T3
      --Calculate A
      --Send A to T3
      -- Put_Line ("T4 finished");
   end T4;

begin
   null;
end Main;
