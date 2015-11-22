unit ConvertHex_VHDL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Menus, StrUtils, ToolWin, Gradient,
  Buttons;

type
  TForm1 = class(TForm)
    TextVHDL_RE: TRichEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    SaveVHDLas1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N3: TMenuItem;
    SelectAll1: TMenuItem;
    N4: TMenuItem;
    ConverttoVHDL1: TMenuItem;
    ConverttoX16: TMenuItem;
    HEXStyle1: TMenuItem;
    Fliptext1: TMenuItem;
    FliptextandConvert1: TMenuItem;
    N2: TMenuItem;
    Splitter1: TSplitter;
    FlipFor8bits1: TMenuItem;
    flipfor16bits1: TMenuItem;
    Fliptext2: TMenuItem;
    FliptextandConvert2: TMenuItem;
    FlipFor8bits2: TMenuItem;
    flipfor8more2: TMenuItem;
    flipfor16bits2: TMenuItem;
    FliptextandHEXConvert1: TMenuItem;
    Panel1: TPanel;
    fliphex_cb: TCheckBox;
    quickconvert_bt: TButton;
    BlockR_lines: TComboBox;
    flipbits_cb: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    fliptext_bt: TSpeedButton;
    Label3: TLabel;
    fliptext: TCheckBox;
    Panel2: TPanel;
    Label4: TLabel;
    VHDLcode_RE: TMemo;
    N16Lines1: TMenuItem;
    N64Lines1: TMenuItem;
    Flipfor16bits3: TMenuItem;
    Flip8bitsHEX1: TMenuItem;
    Flip6bitsHEX1: TMenuItem;
    ConverttoX64: TMenuItem;
    Flip8bitsHEX2: TMenuItem;
    Flip16bitsHEX1: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    VHDL1: TMenuItem;
    Verilog1: TMenuItem;
    Mode1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure Open1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure TextVHDL_REMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VHDLcode_REMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure ConverttoX16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SaveVHDLas1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure HEXStyle1Click(Sender: TObject);
    procedure Fliptext1Click(Sender: TObject);
    procedure FliptextandConvert1Click(Sender: TObject);
    procedure ConverttoVHDL(list : TStrings; line_number : Integer);
    procedure FlipFor8bits1Click(Sender: TObject);
    procedure flipfor16bits1Click(Sender: TObject);
    procedure FliptextandHEXConvert1Click(Sender: TObject);
    procedure flipforXbits(Sender: TObject; fliptext:boolean; flipHEXX : boolean; bits,lines : integer);
    procedure fliptest1Click(Sender: TObject);
    procedure quickconvert_btClick(Sender: TObject);
    procedure fliptextClick(Sender: TObject);
    procedure flipbits_cbSelect(Sender: TObject);
    procedure ConverttoX64Click(Sender: TObject);
    procedure Flip8bitsHEX1Click(Sender: TObject);
    procedure Flipfor16bits3Click(Sender: TObject);
    procedure Flip6bitsHEX1Click(Sender: TObject);
    procedure Flip8bitsHEX2Click(Sender: TObject);
    procedure Flip16bitsHEX1Click(Sender: TObject);
    procedure VHDL1Click(Sender: TObject);
    procedure Verilog1Click(Sender: TObject);
  private
    Text_Select,fliptext_show, verilog : boolean;
    File_Name : TFileName;
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;
  Initarray : array[0..127] of string[7];

implementation
uses Clipbrd, Unit2;
{$R *.dfm}

function flipHEX(HEX : char): char;
begin
HEX := UpCase(HEX);
case HEX of
  '0' : flipHEX:='0';
  '1' : flipHEX:='8';
  '2' : flipHEX:='4';
  '3' : flipHEX:='C';
  '4' : flipHEX:='2';
  '5' : flipHEX:='A';
  '6' : flipHEX:='6';
  '7' : flipHEX:='E';
  '8' : flipHEX:='1';
  '9' : flipHEX:='9';
  'A' : flipHEX:='5';
  'B' : flipHEX:='D';
  'C' : flipHEX:='3';
  'D' : flipHEX:='B';
  'E' : flipHEX:='7';
  'F' : flipHEX:='F';
  else  flipHEX := HEX;
end;
end;

procedure TForm1.ConverttoVHDL(list : TStrings; line_number : Integer);
var
   Reading_Line,BlockCheck, NewLine1: String;
   RamBlock, initline : integer;
   list_line : integer;
   can_write_line : boolean;
begin
VHDLcode_RE.Lines.Clear;
RamBlock := 0;
initline := 0;
list_line := 0;
can_write_line := false;
while list_line <> list.Count-1 do
     begin
          Reading_Line := list.Strings[list_line];
          //VHDLcode_RE.Lines.Add(copy(Reading_Line,0,5));
          //BlockCheck := 'BLOCK '+ IntToStr(RamBlock);
          if can_write_line then
            begin
              if (initline < line_number) then
              begin
                if  initline = 0 then
                VHDLcode_RE.Lines.Add('generic map( ');
                if initline = (line_number-1) then
                 begin
                      NewLine1 := Initarray[initline]+' => X"'+trim(Reading_Line)+'"';
                      VHDLcode_RE.Lines.Add(NewLine1);
                      VHDLcode_RE.Lines.Add(')');
                      can_write_line := false;
                 end
                else
                 begin
                      NewLine1 := Initarray[initline]+' => X"'+Reading_Line+'",';
                      VHDLcode_RE.Lines.Add(NewLine1);
                 end;
                initline := initline + 1;
              end;
            end;

          if AnsiCompareText( (copy(Reading_Line,0,5)) ,'BLOCK') = 0 then
            begin
            RamBlock := RamBlock +1;
            VHDLcode_RE.Lines.Add('--BLOCK '+inttostr(RamBlock)+ ' ' +copy(Reading_Line,0,length(Reading_Line)));
            initline := 0;
            can_write_line := true
            end
          else
           if (Reading_Line = '') then
           begin
               VHDLcode_RE.Lines.Add('');
           end;
         list_line := list_line + 1;
     end;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    begin
     TextVHDL_RE.Lines.LoadFromFile(OpenDialog1.FileName);
     
      File_Name := OpenDialog1.FileName;
      Edit1.Enabled:= true;
      label3.Visible:= true;
      panel1.Visible:= true;
     end;

end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
if Text_Select = true then
  VHDLcode_RE.CopyToClipboard
else
  TextVHDL_RE.CopyToClipboard;
end;

procedure TForm1.TextVHDL_REMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Text_Select := false;
end;

procedure TForm1.VHDLcode_REMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Text_Select:=true;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var HasSelection: Boolean;
begin
Paste1.Enabled := Clipboard.HasFormat(CF_TEXT);

if VHDLcode_RE.Focused = true then
  begin
    ConverttoVHDL1.Enabled := false;
    Fliptext2.Enabled := false;
    FliptextandConvert2.Enabled := false;
    FlipFor8bits2.Enabled := false;
    flipfor8more2.Enabled := false;
    flipfor16bits2.Enabled := false;
    Paste1.Enabled := true;
    HasSelection := VHDLcode_RE.SelLength > 0;
    Copy1.Enabled := HasSelection;
  end
else
   begin
     ConverttoVHDL1.Enabled := true;
     Fliptext2.Enabled := true;
     FliptextandConvert2.Enabled := true;
     FlipFor8bits2.Enabled := true;
     flipfor8more2.Enabled := true;
     flipfor16bits2.Enabled := true;
     Paste1.Enabled := false;
     HasSelection := TextVHDL_RE.SelLength > 0;
    Copy1.Enabled := HasSelection;
   end;
end;

procedure TForm1.SelectAll1Click(Sender: TObject);
begin
if Text_Select = true then
  VHDLcode_RE.SelectAll
else
  TextVHDL_RE.SelectAll;
end;

procedure TForm1.Paste1Click(Sender: TObject);
begin
if Text_Select = true then
  VHDLcode_RE.PasteFromClipboard
else
  TextVHDL_RE.PasteFromClipboard;
end;

procedure TForm1.ConverttoX16Click(Sender: TObject);
begin
flipforXbits(sender,false,false,0,16);
end;
{
attribute INIT_00 of RAM0: label is
"b23584bbFFFFFAABBBBBCCCCCCCCCCC56784923574354834FEDCBA987654321F";
}


procedure TForm1.FormCreate(Sender: TObject);
var
i : byte;
begin
for i := 0 to 127 do
  Initarray[i] := 'INIT_'+IntToHex(i,2);
panel2.Height := (form1.Height - 38) div 2;
verilog := false

end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.SaveVHDLas1Click(Sender: TObject);
begin
if SaveDialog1.Execute then
  VHDLcode_RE.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.File1Click(Sender: TObject);
begin
if VHDLcode_RE.Focused = true then
  SaveVHDLas1.Enabled := true
else
 SaveVHDLas1.Enabled :=false;
end;

procedure TForm1.HEXStyle1Click(Sender: TObject);
begin
form2.show;
form1.Enabled:=false;
end;

procedure TForm1.Fliptext1Click(Sender: TObject);
begin
flipforXbits(sender,true,false,0,16);
end;

procedure TForm1.FliptextandConvert1Click(Sender: TObject);
begin
flipforXbits(sender,true,false,0,64);
end;

procedure TForm1.FlipFor8bits1Click(Sender: TObject);
begin
flipforXbits(sender,true,false,8,64);
end;

procedure TForm1.flipforXbits(Sender: TObject;fliptext: boolean; flipHEXX : boolean; bits,lines : integer);
var i,j, k : integer;
    tempstring : string;
    convertText : TStringlist;
begin
convertText := TStringList.Create;
 for i:= 0 to TextVHDL_RE.Lines.Count-1 do
   if (AnsiCompareText( (copy(TextVHDL_RE.Lines.Strings[i],0,5)) ,'BLOCK') = 0)
       or (TextVHDL_RE.Lines.Strings[i] ='') then
   convertText.Add(TextVHDL_RE.Lines.Strings[i])
   else
     begin
        if bits = 0 then
          if fliptext then
              convertText.Add(trim(ReverseString(TextVHDL_RE.Lines.Strings[i])))
          else
              convertText.Add(trim(TextVHDL_RE.Lines.Strings[i]))
        else
        begin
        tempstring := '';
        k := 0;
        repeat
          tempstring := tempstring + ReverseString(copy(TextVHDL_RE.Lines.Strings[i],k+1,bits));
          k := k + bits;
        until k = 64;
        if flipHEXX then
           for j := 0 to length(tempstring) do
              tempstring[j] := flipHEX(tempstring[j]);
        convertText.Add(ReverseString(tempstring));
        end;
     end;
  ConverttoVHDL(convertText,lines);
  VHDLcode_re.SelStart := vhdlcode_re.Perform(EM_LINEINDEX, 0, 0);
  vhdlcode_re.SelLength :=0 ;
end;


procedure TForm1.flipfor16bits1Click(Sender: TObject);
begin
flipforXbits(sender,true,false,16,16);
end;

procedure TForm1.FliptextandHEXConvert1Click(Sender: TObject);
begin
flipforXbits(sender,true,false,8,16);
end;

procedure TForm1.fliptest1Click(Sender: TObject);
begin
flipforXbits(Sender,true,false,1,64);
end;

procedure TForm1.quickconvert_btClick(Sender: TObject);
var flipbit : integer;
begin
if flipbits_cb.ItemIndex = 0 then
   flipbit := 0
else
   flipbit := ((strtoint(flipbits_cb.Items[flipbits_cb.ItemIndex])) div 8);
flipforXbits(Sender,fliptext.Checked,fliphex_cb.Checked,flipbit,strtoint(blockr_lines.Items[blockr_lines.ItemIndex]))
end;

procedure TForm1.fliptextClick(Sender: TObject);
begin
if fliptext.Checked then
  begin
     label1.Enabled := true;
     flipbits_cb.Enabled := true;
     if flipbits_cb.ItemIndex = 0 then
       fliphex_cb.Enabled := false
     else
       fliphex_cb.Enabled := true;
  end
else
  begin
     label1.Enabled := false;
     flipbits_cb.Enabled := false;
     fliphex_cb.Enabled := false;
  end;
end;



procedure TForm1.flipbits_cbSelect(Sender: TObject);
begin
if flipbits_cb.ItemIndex = 0 then
  begin
  fliphex_cb.Enabled := false;
  fliphex_cb.Checked := false;
 end
else
 begin
   fliphex_cb.Enabled := true;
 end;
end;

procedure TForm1.ConverttoX64Click(Sender: TObject);
begin
flipforXbits(sender,false,false,0,64);
end;

procedure TForm1.Flip8bitsHEX1Click(Sender: TObject);
begin
flipforXbits(sender,true,true,8,64);
end;

procedure TForm1.Flipfor16bits3Click(Sender: TObject);
begin
flipforXbits(sender,true,false,16,64);
end;

procedure TForm1.Flip6bitsHEX1Click(Sender: TObject);
begin
flipforXbits(sender,true,true,16,64);
end;

procedure TForm1.Flip8bitsHEX2Click(Sender: TObject);
begin
 flipforXbits(sender,true,true,8,16);
end;

procedure TForm1.Flip16bitsHEX1Click(Sender: TObject);
begin
flipforXbits(sender,true,true,16,16);
end;


procedure TForm1.VHDL1Click(Sender: TObject);
begin
if verilog1.Checked then
  begin
    verilog := false;
    vhdl1.Checked := true;
    form1.Caption := 'HEX convetor for Block RAM (VHDL mode)';
    converttoX16.Caption := '&Convert to VHDL (16)';
    converttox64.Caption := 'C&onvert to VHDL (64)';
  end;
end;

procedure TForm1.Verilog1Click(Sender: TObject);
begin
if vhdl1.Checked then
  begin
    verilog := true;
    verilog1.Checked := true;
    form1.Caption := 'HEX convetor for Block RAM (Verilog mode)';
    converttoX16.Caption := '&Convert to Verilog (16)';
    converttox64.Caption := 'C&onvert to Verilog (64)';
  end;
end;

end.
