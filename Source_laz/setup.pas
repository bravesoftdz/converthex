unit setup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask;

type
  Tsetup_fm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    lines_required: TRadioGroup;
    fliphex_rg: TRadioGroup;
    fliphex_cb: TCheckBox;
    Edit1: TEdit;
    procedure fliphex_cbClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  setup_fm: Tsetup_fm;

implementation

{$R *.dfm}

procedure Tsetup_fm.fliphex_cbClick(Sender: TObject);
begin
if fliphex_cb.Checked then
   fliphex_rg.Enabled:= true
else
   fliphex_rg.Enabled := false;
end;

end.
