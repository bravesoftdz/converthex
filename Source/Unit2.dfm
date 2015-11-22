object Form2: TForm2
  Left = 311
  Top = 148
  BorderStyle = bsToolWindow
  Caption = 'Setup of text file'
  ClientHeight = 211
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 16
    Caption = 'BLOCK #'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 184
    Top = 8
    Width = 193
    Height = 177
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    Lines.Strings = (
      #39'Block'#39' is require at top of each RAM '
      'block.'
      'The next lines should be in hex upto the '
      'amount of lines required.'
      'If you want your own use replace the '
      'text.'
      '#########################'
      '                      Note'
      '#########################'
      'The msb is the first nibble of the line'
      'lsb last nibble of the line'
      'that why you can flip the text')
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 8
    Top = 24
    Width = 177
    Height = 161
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    Lines.Strings = (
      'FFFFFFFFFFFFFFFFFFFFFFFFF'
      'FFFFFFF7FFFDDDDDDDFFFFFFF'
      '7FDBBFFFFFFFFFFFFFFFFBFFF'
      'D557AFAB6FF6F7DBDB7EF7FF7'
      '777777DFEDFFAADAAAAAF4D5B'
      'F6FFFFFFFF7DDBBBFFFFFF7BB'
      'FDFFEFFFBFFFFFFFFFEDB6DB6'
      'FFDBF7FEEEFFFFEDF7DB7DF6F'
      'AAAAAA956B6DBF7DB6FEDDFFF'
      'EEEFEEF7FFEEEAD55552D5555'
      'C37802DBF6DFFDBBBFFFBFFF7')
    ReadOnly = True
    TabOrder = 1
  end
  object Button1: TButton
    Left = 126
    Top = 184
    Width = 129
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = Button1Click
  end
end
