//+------------------------------------------------------------------+
//|                                                  MACD Sample.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright   "2005-2014, MetaQuotes Software Corp."
#property link        "http://www.mql4.com"

//+------------------------------------------------------------------+
//| MT4 functions                                                    |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                       stdlib.mqh |
//|                Copyright Copyright © 2015 Cutting Edge Forex LLC |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#import "stdlib.ex4"

string ErrorDescription(int error_code);
int    RGB(int red_value,int green_value,int blue_value);
bool   CompareDoubles(double number1,double number2);
string DoubleToStrMorePrecision(double number,int precision);
string IntegerToHexString(int integer_number);

//---- errors returned from trade server
#define ERR_NO_ERROR                                  0
#define ERR_NO_RESULT                                 1
#define ERR_COMMON_ERROR                              2
#define ERR_INVALID_TRADE_PARAMETERS                  3
#define ERR_SERVER_BUSY                               4
#define ERR_OLD_VERSION                               5
#define ERR_NO_CONNECTION                             6
#define ERR_NOT_ENOUGH_RIGHTS                         7
#define ERR_TOO_FREQUENT_REQUESTS                     8
#define ERR_MALFUNCTIONAL_TRADE                       9
#define ERR_ACCOUNT_DISABLED                         64
#define ERR_INVALID_ACCOUNT                          65
#define ERR_TRADE_TIMEOUT                           128
#define ERR_INVALID_PRICE                           129
#define ERR_INVALID_STOPS                           130
#define ERR_INVALID_TRADE_VOLUME                    131
#define ERR_MARKET_CLOSED                           132
#define ERR_TRADE_DISABLED                          133
#define ERR_NOT_ENOUGH_MONEY                        134
#define ERR_PRICE_CHANGED                           135
#define ERR_OFF_QUOTES                              136
#define ERR_BROKER_BUSY                             137
#define ERR_REQUOTE                                 138
#define ERR_ORDER_LOCKED                            139
#define ERR_LONG_POSITIONS_ONLY_ALLOWED             140
#define ERR_TOO_MANY_REQUESTS                       141
#define ERR_TRADE_MODIFY_DENIED                     145
#define ERR_TRADE_CONTEXT_BUSY                      146
#define ERR_TRADE_EXPIRATION_DENIED                 147
#define ERR_TRADE_TOO_MANY_ORDERS                   148
#define ERR_TRADE_HEDGE_PROHIBITED                  149
#define ERR_TRADE_PROHIBITED_BY_FIFO                150
//---- mql4 run time errors
#define ERR_NO_MQLERROR                            4000
#define ERR_WRONG_FUNCTION_POINTER                 4001
#define ERR_ARRAY_INDEX_OUT_OF_RANGE               4002
#define ERR_NO_MEMORY_FOR_CALL_STACK               4003
#define ERR_RECURSIVE_STACK_OVERFLOW               4004
#define ERR_NOT_ENOUGH_STACK_FOR_PARAM             4005
#define ERR_NO_MEMORY_FOR_PARAM_STRING             4006
#define ERR_NO_MEMORY_FOR_TEMP_STRING              4007
#define ERR_NOT_INITIALIZED_STRING                 4008
#define ERR_NOT_INITIALIZED_ARRAYSTRING            4009
#define ERR_NO_MEMORY_FOR_ARRAYSTRING              4010
#define ERR_TOO_LONG_STRING                        4011
#define ERR_REMAINDER_FROM_ZERO_DIVIDE             4012
#define ERR_ZERO_DIVIDE                            4013
#define ERR_UNKNOWN_COMMAND                        4014
#define ERR_WRONG_JUMP                             4015
#define ERR_NOT_INITIALIZED_ARRAY                  4016
#define ERR_DLL_CALLS_NOT_ALLOWED                  4017
#define ERR_CANNOT_LOAD_LIBRARY                    4018
#define ERR_CANNOT_CALL_FUNCTION                   4019
#define ERR_EXTERNAL_CALLS_NOT_ALLOWED             4020
#define ERR_NO_MEMORY_FOR_RETURNED_STR             4021
#define ERR_SYSTEM_BUSY                            4022
#define ERR_INVALID_FUNCTION_PARAMSCNT             4050
#define ERR_INVALID_FUNCTION_PARAMVALUE            4051
#define ERR_STRING_FUNCTION_INTERNAL               4052
#define ERR_SOME_ARRAY_ERROR                       4053
#define ERR_INCORRECT_SERIESARRAY_USING            4054
#define ERR_CUSTOM_INDICATOR_ERROR                 4055
#define ERR_INCOMPATIBLE_ARRAYS                    4056
#define ERR_GLOBAL_VARIABLES_PROCESSING            4057
#define ERR_GLOBAL_VARIABLE_NOT_FOUND              4058
#define ERR_FUNC_NOT_ALLOWED_IN_TESTING            4059
#define ERR_FUNCTION_NOT_CONFIRMED                 4060
#define ERR_SEND_MAIL_ERROR                        4061
#define ERR_STRING_PARAMETER_EXPECTED              4062
#define ERR_INTEGER_PARAMETER_EXPECTED             4063
#define ERR_DOUBLE_PARAMETER_EXPECTED              4064
#define ERR_ARRAY_AS_PARAMETER_EXPECTED            4065
#define ERR_HISTORY_WILL_UPDATED                   4066
#define ERR_TRADE_ERROR                            4067
#define ERR_END_OF_FILE                            4099
#define ERR_SOME_FILE_ERROR                        4100
#define ERR_WRONG_FILE_NAME                        4101
#define ERR_TOO_MANY_OPENED_FILES                  4102
#define ERR_CANNOT_OPEN_FILE                       4103
#define ERR_INCOMPATIBLE_FILEACCESS                4104
#define ERR_NO_ORDER_SELECTED                      4105
#define ERR_UNKNOWN_SYMBOL                         4106
#define ERR_INVALID_PRICE_PARAM                    4107
#define ERR_INVALID_TICKET                         4108
#define ERR_TRADE_NOT_ALLOWED                      4109
#define ERR_LONGS_NOT_ALLOWED                      4110
#define ERR_SHORTS_NOT_ALLOWED                     4111
#define ERR_OBJECT_ALREADY_EXISTS                  4200
#define ERR_UNKNOWN_OBJECT_PROPERTY                4201
#define ERR_OBJECT_DOES_NOT_EXIST                  4202
#define ERR_UNKNOWN_OBJECT_TYPE                    4203
#define ERR_NO_OBJECT_NAME                         4204
#define ERR_OBJECT_COORDINATES_ERROR               4205
#define ERR_NO_SPECIFIED_SUBWINDOW                 4206
#define ERR_SOME_OBJECT_ERROR                      4207


#import "user32.dll"
//---- messages
int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
int      SendNotifyMessageA(int hWnd,int Msg,int wParam,int lParam);
int      PostMessageA(int hWnd,int Msg,int wParam,int lParam);
void     keybd_event(int bVk,int bScan,int dwFlags,int dwExtraInfo);
void     mouse_event(int dwFlags,int dx,int dy,int dwData,int dwExtraInfo);
//---- windows
int      FindWindowA(string lpClassName,string lpWindowName);
int      SetWindowTextA(int hWnd,string lpString);
int      GetWindowTextA(int hWnd,string lpString,int nMaxCount);
int      GetWindowTextLengthA(int hWnd);
int      GetWindow(int hWnd,int uCmd);

int      UpdateWindow(int hWnd);
int      EnableWindow(int hWnd,int bEnable);
int      DestroyWindow(int hWnd);
int      ShowWindow(int hWnd,int nCmdShow);
int      SetActiveWindow(int hWnd);
int      AnimateWindow(int hWnd,int dwTime,int dwFlags);
int      FlashWindow(int hWnd,int dwFlags /*bInvert*/);
int      CloseWindow(int hWnd);
int      MoveWindow(int hWnd,int X,int Y,int nWidth,int nHeight,int bRepaint);
int      SetWindowPos(int hWnd,int hWndInsertAfter,int X,int Y,int cx,int cy,int uFlags);
int      IsWindowVisible(int hWnd);
int      IsIconic(int hWnd);
int      IsZoomed(int hWnd);
int      SetFocus(int hWnd);
int      GetFocus();
int      GetActiveWindow();
int      IsWindowEnabled(int hWnd);
//---- miscelaneouse
int      MessageBoxA(int hWnd,string lpText,string lpCaption,int uType);
int      MessageBoxExA(int hWnd,string lpText,string lpCaption,int uType,int wLanguageId);
int      MessageBeep(int uType);
int      GetSystemMetrics(int nIndex);
int      ExitWindowsEx(int uFlags,int dwReserved);
int      SwapMouseButton(int fSwap);
#import

//---- Window Messages
#define WM_NULL                        0x0000
#define WM_CREATE                      0x0001
#define WM_DESTROY                     0x0002
#define WM_MOVE                        0x0003
#define WM_SIZE                        0x0005
#define WM_ACTIVATE                    0x0006
#define WM_SETFOCUS                    0x0007
#define WM_KILLFOCUS                   0x0008
#define WM_ENABLE                      0x000A
#define WM_SETREDRAW                   0x000B
#define WM_SETTEXT                     0x000C
#define WM_GETTEXT                     0x000D
#define WM_GETTEXTLENGTH               0x000E
#define WM_PAINT                       0x000F
#define WM_CLOSE                       0x0010
#define WM_QUERYENDSESSION             0x0011
#define WM_QUIT                        0x0012
#define WM_QUERYOPEN                   0x0013
#define WM_ERASEBKGND                  0x0014
#define WM_SYSCOLORCHANGE              0x0015
#define WM_ENDSESSION                  0x0016
#define WM_SHOWWINDOW                  0x0018
#define WM_WININICHANGE                0x001A
#define WM_SETTINGCHANGE               0x001A // WM_WININICHANGE
#define WM_DEVMODECHANGE               0x001B
#define WM_ACTIVATEAPP                 0x001C
#define WM_FONTCHANGE                  0x001D
#define WM_TIMECHANGE                  0x001E
#define WM_CANCELMODE                  0x001F
#define WM_SETCURSOR                   0x0020
#define WM_MOUSEACTIVATE               0x0021
#define WM_CHILDACTIVATE               0x0022
#define WM_QUEUESYNC                   0x0023
#define WM_GETMINMAXINFO               0x0024
#define WM_PAINTICON                   0x0026
#define WM_ICONERASEBKGND              0x0027
#define WM_NEXTDLGCTL                  0x0028
#define WM_SPOOLERSTATUS               0x002A
#define WM_DRAWITEM                    0x002B
#define WM_MEASUREITEM                 0x002C
#define WM_DELETEITEM                  0x002D
#define WM_VKEYTOITEM                  0x002E
#define WM_CHARTOITEM                  0x002F
#define WM_SETFONT                     0x0030
#define WM_GETFONT                     0x0031
#define WM_SETHOTKEY                   0x0032
#define WM_GETHOTKEY                   0x0033
#define WM_QUERYDRAGICON               0x0037
#define WM_COMPAREITEM                 0x0039
#define WM_GETOBJECT                   0x003D
#define WM_COMPACTING                  0x0041
#define WM_WINDOWPOSCHANGING           0x0046
#define WM_WINDOWPOSCHANGED            0x0047
#define WM_COPYDATA                    0x004A
#define WM_CANCELJOURNAL               0x004B
#define WM_NOTIFY                      0x004E
#define WM_INPUTLANGCHANGEREQUEST      0x0050
#define WM_INPUTLANGCHANGE             0x0051
#define WM_TCARD                       0x0052
#define WM_HELP                        0x0053
#define WM_USERCHANGED                 0x0054
#define WM_NOTIFYFORMAT                0x0055
#define WM_CONTEXTMENU                 0x007B
#define WM_STYLECHANGING               0x007C
#define WM_STYLECHANGED                0x007D
#define WM_DISPLAYCHANGE               0x007E
#define WM_GETICON                     0x007F
#define WM_SETICON                     0x0080
#define WM_NCCREATE                    0x0081
#define WM_NCDESTROY                   0x0082
#define WM_NCCALCSIZE                  0x0083
#define WM_NCHITTEST                   0x0084
#define WM_NCPAINT                     0x0085
#define WM_NCACTIVATE                  0x0086
#define WM_GETDLGCODE                  0x0087
#define WM_SYNCPAINT                   0x0088
#define WM_NCMOUSEMOVE                 0x00A0
#define WM_NCLBUTTONDOWN               0x00A1
#define WM_NCLBUTTONUP                 0x00A2
#define WM_NCLBUTTONDBLCLK             0x00A3
#define WM_NCRBUTTONDOWN               0x00A4
#define WM_NCRBUTTONUP                 0x00A5
#define WM_NCRBUTTONDBLCLK             0x00A6
#define WM_NCMBUTTONDOWN               0x00A7
#define WM_NCMBUTTONUP                 0x00A8
#define WM_NCMBUTTONDBLCLK             0x00A9
#define WM_KEYFIRST                    0x0100
#define WM_KEYDOWN                     0x0100
#define WM_KEYUP                       0x0101
#define WM_CHAR                        0x0102
#define WM_DEADCHAR                    0x0103
#define WM_SYSKEYDOWN                  0x0104
#define WM_SYSKEYUP                    0x0105
#define WM_SYSCHAR                     0x0106
#define WM_SYSDEADCHAR                 0x0107
#define WM_KEYLAST                     0x0108
#define WM_INITDIALOG                  0x0110
#define WM_COMMAND                     0x0111
#define WM_SYSCOMMAND                  0x0112
#define WM_TIMER                       0x0113
#define WM_HSCROLL                     0x0114
#define WM_VSCROLL                     0x0115
#define WM_INITMENU                    0x0116
#define WM_INITMENUPOPUP               0x0117
#define WM_MENUSELECT                  0x011F
#define WM_MENUCHAR                    0x0120
#define WM_ENTERIDLE                   0x0121
#define WM_MENURBUTTONUP               0x0122
#define WM_MENUDRAG                    0x0123
#define WM_MENUGETOBJECT               0x0124
#define WM_UNINITMENUPOPUP             0x0125
#define WM_MENUCOMMAND                 0x0126
#define WM_CTLCOLORMSGBOX              0x0132
#define WM_CTLCOLOREDIT                0x0133
#define WM_CTLCOLORLISTBOX             0x0134
#define WM_CTLCOLORBTN                 0x0135
#define WM_CTLCOLORDLG                 0x0136
#define WM_CTLCOLORSCROLLBAR           0x0137
#define WM_CTLCOLORSTATIC              0x0138
#define WM_MOUSEFIRST                  0x0200
#define WM_MOUSEMOVE                   0x0200
#define WM_LBUTTONDOWN                 0x0201
#define WM_LBUTTONUP                   0x0202
#define WM_LBUTTONDBLCLK               0x0203
#define WM_RBUTTONDOWN                 0x0204
#define WM_RBUTTONUP                   0x0205
#define WM_RBUTTONDBLCLK               0x0206
#define WM_MBUTTONDOWN                 0x0207
#define WM_MBUTTONUP                   0x0208
#define WM_MBUTTONDBLCLK               0x0209
#define WM_PARENTNOTIFY                0x0210
#define WM_ENTERMENULOOP               0x0211
#define WM_EXITMENULOOP                0x0212
#define WM_NEXTMENU                    0x0213
#define WM_SIZING                      0x0214
#define WM_CAPTURECHANGED              0x0215
#define WM_MOVING                      0x0216
#define WM_DEVICECHANGE                0x0219
#define WM_MDICREATE                   0x0220
#define WM_MDIDESTROY                  0x0221
#define WM_MDIACTIVATE                 0x0222
#define WM_MDIRESTORE                  0x0223
#define WM_MDINEXT                     0x0224
#define WM_MDIMAXIMIZE                 0x0225
#define WM_MDITILE                     0x0226
#define WM_MDICASCADE                  0x0227
#define WM_MDIICONARRANGE              0x0228
#define WM_MDIGETACTIVE                0x0229
#define WM_MDISETMENU                  0x0230
#define WM_ENTERSIZEMOVE               0x0231
#define WM_EXITSIZEMOVE                0x0232
#define WM_DROPFILES                   0x0233
#define WM_MDIREFRESHMENU              0x0234
#define WM_MOUSEHOVER                  0x02A1
#define WM_MOUSELEAVE                  0x02A3
#define WM_CUT                         0x0300
#define WM_COPY                        0x0301
#define WM_PASTE                       0x0302
#define WM_CLEAR                       0x0303
#define WM_UNDO                        0x0304
#define WM_RENDERFORMAT                0x0305
#define WM_RENDERALLFORMATS            0x0306
#define WM_DESTROYCLIPBOARD            0x0307
#define WM_DRAWCLIPBOARD               0x0308
#define WM_PAINTCLIPBOARD              0x0309
#define WM_VSCROLLCLIPBOARD            0x030A
#define WM_SIZECLIPBOARD               0x030B
#define WM_ASKCBFORMATNAME             0x030C
#define WM_CHANGECBCHAIN               0x030D
#define WM_HSCROLLCLIPBOARD            0x030E
#define WM_QUERYNEWPALETTE             0x030F
#define WM_PALETTEISCHANGING           0x0310
#define WM_PALETTECHANGED              0x0311
#define WM_HOTKEY                      0x0312
#define WM_PRINT                       0x0317
#define WM_PRINTCLIENT                 0x0318
#define WM_HANDHELDFIRST               0x0358
#define WM_HANDHELDLAST                0x035F
#define WM_AFXFIRST                    0x0360
#define WM_AFXLAST                     0x037F
#define WM_PENWINFIRST                 0x0380
#define WM_PENWINLAST                  0x038F
#define WM_APP                         0x8000

//---- keybd_event routines
#define KEYEVENTF_EXTENDEDKEY          0x0001
#define KEYEVENTF_KEYUP                0x0002
//---- mouse_event routines
#define MOUSEEVENTF_MOVE               0x0001 // mouse move
#define MOUSEEVENTF_LEFTDOWN           0x0002 // left button down
#define MOUSEEVENTF_LEFTUP             0x0004 // left button up
#define MOUSEEVENTF_RIGHTDOWN          0x0008 // right button down
#define MOUSEEVENTF_RIGHTUP            0x0010 // right button up
#define MOUSEEVENTF_MIDDLEDOWN         0x0020 // middle button down
#define MOUSEEVENTF_MIDDLEUP           0x0040 // middle button up
#define MOUSEEVENTF_WHEEL              0x0800 // wheel button rolled
#define MOUSEEVENTF_ABSOLUTE           0x8000 // absolute move

//---- GetSystemMetrics() codes
#define SM_CXSCREEN                    0
#define SM_CYSCREEN                    1
#define SM_CXVSCROLL                   2
#define SM_CYHSCROLL                   3
#define SM_CYCAPTION                   4
#define SM_CXBORDER                    5
#define SM_CYBORDER                    6
#define SM_CXDLGFRAME                  7
#define SM_CYDLGFRAME                  8
#define SM_CYVTHUMB                    9
#define SM_CXHTHUMB                    10
#define SM_CXICON                      11
#define SM_CYICON                      12
#define SM_CXCURSOR                    13
#define SM_CYCURSOR                    14
#define SM_CYMENU                      15
#define SM_CXFULLSCREEN                16
#define SM_CYFULLSCREEN                17
#define SM_CYKANJIWINDOW               18
#define SM_MOUSEPRESENT                19
#define SM_CYVSCROLL                   20
#define SM_CXHSCROLL                   21
#define SM_DEBUG                       22
#define SM_SWAPBUTTON                  23
#define SM_RESERVED1                   24
#define SM_RESERVED2                   25
#define SM_RESERVED3                   26
#define SM_RESERVED4                   27
#define SM_CXMIN                       28
#define SM_CYMIN                       29
#define SM_CXSIZE                      30
#define SM_CYSIZE                      31
#define SM_CXFRAME                     32
#define SM_CYFRAME                     33
#define SM_CXMINTRACK                  34
#define SM_CYMINTRACK                  35
#define SM_CXDOUBLECLK                 36
#define SM_CYDOUBLECLK                 37
#define SM_CXICONSPACING               38
#define SM_CYICONSPACING               39
#define SM_MENUDROPALIGNMENT           40
#define SM_PENWINDOWS                  41
#define SM_DBCSENABLED                 42
#define SM_CMOUSEBUTTONS               43
#define SM_SECURE                      44
#define SM_CXEDGE                      45
#define SM_CYEDGE                      46
#define SM_CXMINSPACING                47
#define SM_CYMINSPACING                48
#define SM_CXSMICON                    49
#define SM_CYSMICON                    50
#define SM_CYSMCAPTION                 51
#define SM_CXSMSIZE                    52
#define SM_CYSMSIZE                    53
#define SM_CXMENUSIZE                  54
#define SM_CYMENUSIZE                  55
#define SM_ARRANGE                     56
#define SM_CXMINIMIZED                 57
#define SM_CYMINIMIZED                 58
#define SM_CXMAXTRACK                  59
#define SM_CYMAXTRACK                  60
#define SM_CXMAXIMIZED                 61
#define SM_CYMAXIMIZED                 62
#define SM_NETWORK                     63
#define SM_CLEANBOOT                   67
#define SM_CXDRAG                      68
#define SM_CYDRAG                      69
#define SM_SHOWSOUNDS                  70
#define SM_CXMENUCHECK                 71 // Use instead of GetMenuCheckMarkDimensions()!
#define SM_CYMENUCHECK                 72
#define SM_SLOWMACHINE                 73
#define SM_MIDEASTENABLED              74
#define SM_MOUSEWHEELPRESENT           75
#define SM_XVIRTUALSCREEN              76
#define SM_YVIRTUALSCREEN              77
#define SM_CXVIRTUALSCREEN             78
#define SM_CYVIRTUALSCREEN             79
#define SM_CMONITORS                   80
#define SM_SAMEDISPLAYFORMAT           81

//---- GetWindow() Constants
#define GW_HWNDFIRST                   0
#define GW_HWNDLAST                    1
#define GW_HWNDNEXT                    2
#define GW_HWNDPREV                    3
#define GW_OWNER                       4
#define GW_CHILD                       5

//---- AnimateWindow() Commands
#define AW_HOR_POSITIVE                0x00000001
#define AW_HOR_NEGATIVE                0x00000002
#define AW_VER_POSITIVE                0x00000004
#define AW_VER_NEGATIVE                0x00000008
#define AW_CENTER                      0x00000010
#define AW_HIDE                        0x00010000
#define AW_ACTIVATE                    0x00020000
#define AW_SLIDE                       0x00040000
#define AW_BLEND                       0x00080000

//---- MessageBox() Flags
#define MB_OK                       	0x00000000
#define MB_OKCANCEL                 	0x00000001
#define MB_ABORTRETRYIGNORE         	0x00000002
#define MB_YESNOCANCEL              	0x00000003
#define MB_YESNO                    	0x00000004
#define MB_RETRYCANCEL              	0x00000005
#define MB_ICONHAND                 	0x00000010
#define MB_ICONQUESTION             	0x00000020
#define MB_ICONEXCLAMATION          	0x00000030
#define MB_ICONASTERISK             	0x00000040
#define MB_USERICON                 	0x00000080
#define MB_ICONWARNING              	MB_ICONEXCLAMATION
#define MB_ICONERROR                	MB_ICONHAND
#define MB_ICONINFORMATION          	MB_ICONASTERISK
#define MB_ICONSTOP                 	MB_ICONHAND
#define MB_DEFBUTTON1               	0x00000000
#define MB_DEFBUTTON2               	0x00000100
#define MB_DEFBUTTON3               	0x00000200
#define MB_DEFBUTTON4               	0x00000300
#define MB_APPLMODAL                	0x00000000
#define MB_SYSTEMMODAL              	0x00001000
#define MB_TASKMODAL                	0x00002000
#define MB_HELP                     	0x00004000 // Help Button
#define MB_NOFOCUS                  	0x00008000
#define MB_SETFOREGROUND            	0x00010000
#define MB_DEFAULT_DESKTOP_ONLY     	0x00020000
#define MB_TOPMOST                  	0x00040000
#define MB_RIGHT                    	0x00080000
#define MB_RTLREADING               	0x00100000

//---- Dialog Box Command IDs
#define IDOK                           1
#define IDCANCEL                       2
#define IDABORT                        3
#define IDRETRY                        4
#define IDIGNORE                       5
#define IDYES                          6
#define IDNO                           7
#define IDCLOSE                        8
#define IDHELP                         9
//+------------------------------------------------------------------+

#define BUY_ORDERS       1
#define SELL_ORDERS      2
#define ORDER_INCREMENT  4

enum Enum2       // Lot Size
  {
   Dynamic,     // Dynamic lots
   StepLots,    // Step lots
   Static,      // Fixed lots
  };
enum Enum4       // Initial Balance
  {
   AccountBal,  // Account Balance
   SpecificBal, // Specified Balance
  };
enum Enum5       // Broker Digits
{
	Digit5,      // 5 Digit Broker
	Digit4,      // 4 Digit Broker
};

extern int    Magic             = 16384;
extern Enum5  BrokerDigits      = Digit5;                     // Broker Digits 
       bool   DigiFix           = false;                      // Digit Fix 
extern Enum2  MoneyManagement   = StepLots;                   // Money Management
extern double MaxLotSize        = 100;
extern double RiskSetting       = 0.1;                        // Risk Setting   (Dynamic)
extern double StartingBalance   = 1000;
extern double LotSize           = 0.01;                       // Fixed Lot Size
extern double LotStep           = 0.01;                       // Stepping Lot Size
       int    Slippage          = 2;
extern bool   NoDropLotSize     = true;
extern Enum4  InitialBalance    = AccountBal;                 // Initial Balance
extern double SpecificBalance   = 1000.0;                     // Specified Balance
extern double StepBalance       = 100.0;                      // Stepping Balance
extern double TakeProfit        = 1000;
extern double BaseDistance      = 15;
extern double StopLoss          = 3;
extern int    MaxRecoveryOrders = 0;
extern double Offset            = 25;
extern double DriftAllowed      = 2.0;                        // Dift Allowed (Pips)
extern bool   SkipFriday        = true;
extern int    ClosingHour       = 20;     
extern int    ClosingMinute     = 10; 
       bool   ClosedOnCurrentBarCheck  = true;
       bool   ClosedOnPreviousBarCheck = false;
extern bool   Hedging           = false;
extern bool   InvertOrders      = false;
extern int    BrokerTimeOffset  = 0;
extern double MaxCurSpread      = 3.5;                        // Max Spread Live  (Pips)
extern double MaxAvgSpread      = 3.5;                        // Max Spread Avg   (Pips)

extern int    NoTrendHour1      = 4;
extern int    NoTrendHour2      = 18;
extern int    NoTrendHour3      = 55;
extern int    NoTrendHour4      = 55;

extern int    BandPerOpen       = 15;
extern int    BreakEntry        = 3;
extern int    MaxBreakEntry     = 8;
extern int    TrendPer          = 22;
extern int    TrendPer2         = 5;
extern int    TrendDist         = 100;
extern int    TrendDist2        = 55;

extern bool   UseAwesomeTrail   = true;
extern bool   UseBE             = false;
extern double BeActivationPips  = 10.0;
extern double BePlusPips        = 2.0;

extern bool   UseTrailStop      = true;
extern double TrailingStop      = 5.0;                        // Trailing Stop      (Pips)
extern double TSActivationPips  = 8.0;                        // TS Activation    (Pips)
extern double TrailingStep      = 0.5;                        // Trailing Step     (Pips)

extern bool   UseHybridStop     = true;
extern double ActivationPips    = 10.0;
extern double StopTrailAtPips   = 2.0;

double   CalculatedBalance     = 0.0;
double   CalculatedEquity      = 0.0;
double   CalculatedBalance2    = 0.0;
double   CalculatedEquity2     = 0.0;
double   InitialOrderOpenLots  = 0.0;

int      Shift = 3;
double   HighestDownFrac;
double   LowestUpFrac;
datetime UpFracTime;
datetime DownFracTime;
double   Spread;
double   Array_spread[30];
int      UpTo30Counter = 0;
double   avgspread = 0.2;
double   SpreadAvg = 0.2;
double   DigiMultiplier;
int      PipMultiplier = 1;
double   TS1;

int      MBars;
int      TradesThisBar;
int      BuysThisBar;
int      SellsThisBar;
bool     IsNewBar;
int      HBars;
int      DBars;
bool     IsNewDay;
bool     IsNewHour;

static datetime TimeStamp;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnInit()
{

	if (InitialBalance == SpecificBal)
	{
		CalculateInitialBalance();
	}
	
   //Adjust calculations for 5 digit brokers 
	double COMmultiplier = MathPow(10, Digits);
	DigiMultiplier = 1;
	//  double COMmultiplier=10;
	if (Digits == 5 && !DigiFix)
	{
		COMmultiplier /= 10;
	}
	if (Digits == 3 && !DigiFix)
	{
		COMmultiplier /= 100;
	}

	if (DigiFix || BrokerDigits == Digit4)
	{
		COMmultiplier /= 10;
		DigiMultiplier = 1;
	}
	else
	{
		DigiMultiplier = 10;
	}

	if (BrokerDigits == Digit5 && !DigiFix)
	{
		PipMultiplier = 10;
	}
	else {
		PipMultiplier = 1;
	}
   Slippage=Slippage*PipMultiplier;
	HighestDownFrac = iFractals(Symbol(), 0, MODE_LOWER, Shift);
   DownFracTime = TimeCurrent();
   LowestUpFrac = iFractals(Symbol(), 0, MODE_UPPER, Shift);
   UpFracTime = TimeCurrent();
   
   if(StopLoss==0)
   {
     TS1 = TrailingStop;
   }else{
     TS1 = StopLoss;
   }
   
   IsNewBar = true;
   MBars = iBars(Symbol(),PERIOD_CURRENT);
   TradesThisBar=0;
   BuysThisBar=0;
   SellsThisBar=0;
   TimeStamp = TimeCurrent();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick(void)
{

// Check if trading is possible
   if(!IsConnected())
   {
      Print("URGENT ACTION REQUIRED : There is no connection to the server!");
      Alert("URGENT ACTION REQUIRED : There is no connection to the server!");

      return;
   }
   if(IsStopped())
   {
      Print("ERROR :Expert Advisor has been stopped");
      Alert("ERROR :Expert Advisor has been stopped");

      return;
   }
   
   int    cnt,ticket,total;
//---
// initial data checks
// it is important to make sure that the expert works with a normal
// chart and the user did not make any mistakes setting external 
// variables (Lots, StopLoss, TakeProfit, 
// BaseDistance) in our case, we check TakeProfit
// on a chart of less than 100 bars
//---
   if(Bars<100)
   {
      Print("bars less than 100");
      return;
   }

   if(!(UseHybridStop) && (UseTrailStop) && (UseAwesomeTrail))
   {
      Print("You must choose either Trailing Stop -OR- Awesome Stops -OR- enable Hybrid mode.");
      MessageBox("You must choose either Trailing Stop -OR- Awesome Stops -OR- enable Hybrid mode.");
      return;
   }

   if((UseHybridStop) && !(UseTrailStop) && !(UseAwesomeTrail))
   {
      Print("You must choose both Trailing Stop -AND- Awesome Stops -WHEN- Hybrid mode is enabled.");
      MessageBox("You must choose both Trailing Stop -AND- Awesome Stops -WHEN- Hybrid mode is enabled.");
      return;
   }
   
   if((Digits==5 || Digits==3) && (BrokerDigits==Digit4))
   {
      Print(Symbol()," You selected 4 Digit Broker but your graph seems to have 5 digits (or 3 for JPY pairs). Please review your digits definition.");
      MessageBox(Symbol()+" You selected 4 Digit Broker but your graph seems to have 5 digits (or 3 for JPY pairs). Please review your digits definitions.","Digits setup may be wrong");
      return;
   }
   
   if((Offset)*DigiMultiplier < MarketInfo(NULL,MODE_STOPLEVEL))
   {
      MessageBox(" Offset is too small for broker's minimum stop levels. Please increase your pending order offset distance  ");
      Print(" Offset is too small for broker's minimum stop levels. Please increase your pending order offset distance to minimum stop levels (Points):  ",  DoubleToStr( MarketInfo(NULL,MODE_STOPLEVEL)));
      return;
   }
   
   if((TS1)*DigiMultiplier < MarketInfo(NULL,MODE_STOPLEVEL)|| (TS1==0 && (StopLoss)*DigiMultiplier < MarketInfo(NULL,MODE_STOPLEVEL)))
   {
      MessageBox(" Stop Loss is too small for broker's minimum stop levels. Please increase your Stop Loss  ");
      Print(" Your Stop Loss is too small for broker's minimum stop levels (Points):  ",  DoubleToStr( MarketInfo(NULL,MODE_STOPLEVEL)));
   }
   
   if(InitialBalance==SpecificBal)
   {
      CalculateInitialBalance();
   }else{
      CalculatedBalance= AccountBalance();
      CalculatedEquity = AccountEquity();
   }


//-- Reset Conditions ----------------------------------------------------------------------------------------------------------

   if((iBars(Symbol(),PERIOD_CURRENT)>MBars) )
   {
      IsNewBar = true;
      MBars = iBars(Symbol(),PERIOD_CURRENT);
      TradesThisBar=0;
      BuysThisBar=0;
      SellsThisBar=0;
      TimeStamp = TimeCurrent();
  }
  if((iBars(Symbol(),PERIOD_H1)>HBars) )
  {
      HBars = iBars(Symbol(),PERIOD_H1);
      IsNewHour = true;
  }
  if((iBars(Symbol(),PERIOD_D1)>DBars) )
  {
      DBars = iBars(Symbol(),PERIOD_D1);
      IsNewDay = true;
  }

  //-- Check For Broken Trades --------------------------------------------------------------------------------------------------

   CheckForBrokenTrades();
   
  //-- Check Open ---------------------------------------------------------------------------------------------------------------

   RefreshRates();
   total=OrdersTotal();

   /*
   if (total>1 && CalculatedEquity-CalculatedBalance>0 && MathAbs(CalculatedEquity-CalculatedBalance)>(CalculatedBalance*0.02)) {
      CloseAllOpenPositions();
   }
   */
   
   // 0=Sunday,1=Monday,2=Tuesday,3=Wednesday,4=Thursday,5=Friday,6=Saturday) of the last known server time; 
   int   CloseAlltradesDay     = 5;
   
   // ClosingHour 0 to 23 & Closing Minute 0 to 59 , BOTH based on Brokers Time;    
   if(total<1 && SkipFriday && (DayOfWeek()==CloseAlltradesDay && Hour()==ClosingHour+BrokerTimeOffset && Minute()>=ClosingMinute+BrokerTimeOffset))
   {
       return;
   }
   
   /*if(total<1 && ((TradeTime()==NoTrendHour1) || (TradeTime()==NoTrendHour2) || (TradeTime()==NoTrendHour3) || (TradeTime()==NoTrendHour4)))
   {
      return;
   }*/
   // interesting
   /*
   if (total<1 && Hour()>=0+BrokerTimeOffset && Hour()<=7+BrokerTimeOffset)
   {
       return;
   }
   */
   
   /*
   if (total<1 && (Hour()>=12+BrokerTimeOffset && Hour()<=17+BrokerTimeOffset))
   {
       return;
   }
   */
   
   // interesting
   /*
   if (total<1 && (Hour()>=20+BrokerTimeOffset && Hour()<=23+BrokerTimeOffset))
   {
       return;
   }
   */
   
   Spread = NormalizeDouble(((Ask - Bid) / Point / DigiMultiplier), 1);
   
   //-- Average Spread for the last 30 ticks-----------------------------------------------------------------------------------------------------
    double sumofspreads;
    int loopcount1;
    int loopcount2;
    ArrayCopy(Array_spread,Array_spread,0,1,29);
    Array_spread[29]=Spread;
    if(UpTo30Counter<30)
    {
       UpTo30Counter++;
    }
    sumofspreads=0;
    loopcount2=29;
    for(loopcount1=0; loopcount1<UpTo30Counter; loopcount1++)
    {
	   sumofspreads+=Array_spread[loopcount2];
	   loopcount2 --;
    }
    avgspread=sumofspreads/UpTo30Counter;

    SpreadAvg = NormalizeDouble(avgspread,1);
   
   //--- Spread Filters For Pending Orders-------------------------------------------------------------------------------------------------------
    RefreshRates();
    total=OrdersTotal();
	 if((SpreadAvg > MaxAvgSpread) && (total<1))
	 {
	   Print("Pending Orders Deleted Due to HIGH SPREAD. Average Spread :   ", DoubleToStr(SpreadAvg,1));
	   return;
	 }

	 if((Spread > MaxCurSpread) && (total<1))
	 {
	   Print("Pending Orders Cancelled Due to HIGH SPREAD. Current Spread :   ", DoubleToStr(Spread,1));
	   return;
	 }

    /*
	 if (TimeCurrent() > iTime(Symbol(), PERIOD_CURRENT, 0) + 30)
	 {
		Print("Time Delete Test :   ", DoubleToStr(Spread, 1));
		return;
	 }
	 */
   
   RefreshRates();
   double high  = iHigh(NULL,PERIOD_CURRENT,1);
   double low   = iLow(NULL,PERIOD_CURRENT,1);
   double open  = iOpen(NULL,PERIOD_CURRENT,0);
   double close = iClose(NULL,PERIOD_CURRENT,1);
   double bandClose = iClose(NULL, PERIOD_M1, 1);
   double bbCloseUppper = iBands(NULL, PERIOD_M15, BandPerOpen, 2, 0, PRICE_CLOSE, MODE_UPPER, 1);
   double bbCloseLower = iBands(NULL, PERIOD_M15, BandPerOpen, 2, 0, PRICE_CLOSE, MODE_LOWER, 1);
   double smmaClosePer1 = iMA(NULL, PERIOD_H4, TrendPer, 0, MODE_SMMA, PRICE_CLOSE, 1);
   double smmaClosePer2 = iMA(NULL, PERIOD_H4, TrendPer2, 0, MODE_SMMA, PRICE_CLOSE, 1);

   RefreshRates();
   int closedOrdersCurrentBar = ClosedOrdersPerBar(0);
   int closedOrdersPreviousBar = ClosedOrdersPerBar(1);
   
   total=OrdersTotal();
   if(total<1)
   {
      //--- no opened orders identified
      if(AccountFreeMargin()<(1000*CalculateLots()))
      {
         Print("We have no money. Free Margin = ",AccountFreeMargin());
         return;
      }
      if((Spread > MaxCurSpread) || (SpreadAvg > MaxAvgSpread))
      {
         Print("Spread too high. Spread = ",Spread," SpreadAvg = ",SpreadAvg);
         return;
      }

      double PriceBuy = NormalizeDouble((close+(Ask-Bid)),Digits);//++5 digits
      double PriceBuyOffset=NormalizeDouble(PriceBuy+(Offset*Point*DigiMultiplier),Digits);//++5 digits
      double PriceBuyOffset2=NormalizeDouble(PriceBuy+(Offset*Point*DigiMultiplier)-(DriftAllowed*Point*DigiMultiplier),Digits);//++5 digits
      
      double PriceSell = NormalizeDouble(close,Digits);
      double PriceSellOffset = NormalizeDouble(PriceSell-(Offset*Point*DigiMultiplier),Digits);
      double PriceSellOffset2 = NormalizeDouble(PriceSell-(Offset*Point*DigiMultiplier)+(DriftAllowed*Point*DigiMultiplier),Digits);
      
      //--- check for long position (BUY) possibility
      if(
         (Offset > 0 && Bid >= PriceBuyOffset /*&& Ask <= PriceBuyOffset2*/) ||
         (Offset ==0 && CheckOpen(
             bandClose, 
             bbCloseUppper + BreakEntry * Point * DigiMultiplier, 
             bbCloseUppper + MaxBreakEntry * Point * DigiMultiplier, 
             bbCloseLower - BreakEntry * Point * DigiMultiplier, 
             bbCloseLower - MaxBreakEntry * Point * DigiMultiplier, 
             MathMin(smmaClosePer1 + TrendDist * Point * DigiMultiplier, smmaClosePer2 + TrendDist2 * Point * DigiMultiplier), 
             MathMax(smmaClosePer1 - TrendDist * Point * DigiMultiplier, smmaClosePer2 - TrendDist2 * Point * DigiMultiplier), 
             Ask, 
             TradeTime()) == 0
         )
       )
        {
         if(!InvertOrders /*&& BuysThisBar==0*/ && !( (closedOrdersCurrentBar & BUY_ORDERS) > 0 || (closedOrdersPreviousBar & BUY_ORDERS) > 0 ))
         {
            ticket=OrderSend(Symbol(),OP_BUY,CalculateLots(),Ask,Slippage,0,CalculateTP(OP_BUY),"macd sample",Magic,0,Green);
            if(ticket>0)
              {
               if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
               {
                  TradesThisBar++;
                  BuysThisBar++;
                  IsNewDay=false;
                  IsNewHour=false;

                  RefreshRates();
                  InitialOrderOpenLots = OrderLots();
                  
                  if(StopLoss>0)
                  {
                     //To do : Verify stop loss if valid
                     double SL1=CheckStopLoss(OP_BUY,Ask,NormalizeDouble((Ask-(StopLoss*Point*DigiMultiplier)),Digits));
                  }
                  if(((StopLoss==0) && (TrailingStop>0)) ) 
                  {
                     //To do: Verify stop loss is valid
                     SL1=CheckStopLoss(OP_BUY,Ask,NormalizeDouble((Ask-(TrailingStop*Point*DigiMultiplier)),Digits));
                  }
                  
                  if(OrderModify(OrderTicket(),OrderOpenPrice(),/*SL1*/GetFiboStopLoss(OP_BUY,total),OrderTakeProfit(),0,Green))
                     Print("BUY order opened : ",OrderOpenPrice());
               }
              }
            else
               Print("Error opening BUY order : ",GetLastError());
         }
         else if(InvertOrders /*&& SellsThisBar==0*/ && !( (closedOrdersCurrentBar & SELL_ORDERS) > 0 || (closedOrdersPreviousBar & SELL_ORDERS) > 0))
         {
            ticket=OrderSend(Symbol(),OP_SELL,CalculateLots(),Bid,Slippage,0,CalculateTP(OP_SELL),"macd sample",Magic,0,Red);
            if(ticket>0)
              {
               if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
               {
                  TradesThisBar++;
                  SellsThisBar++;
                  IsNewDay=false;
                  IsNewHour=false;
                  
                  RefreshRates();
                  InitialOrderOpenLots = OrderLots();
                  if(OrderModify(OrderTicket(),OrderOpenPrice(),GetFiboStopLoss(OP_SELL,total),OrderTakeProfit(),0,Red))
                     Print("SELL order opened : ",OrderOpenPrice());
               }
              }
            else
               Print("Error opening SELL order : ",GetLastError());
         }
        }
      //--- check for short position (SELL) possibility
      if(
         (Offset >0 && Bid <= PriceSellOffset /*&& Bid >= PriceSellOffset2*/) || 
         (Offset == 0 && CheckOpen(
             bandClose, 
             bbCloseUppper + BreakEntry * Point * DigiMultiplier, 
             bbCloseUppper + MaxBreakEntry * Point * DigiMultiplier, 
             bbCloseLower - BreakEntry * Point * DigiMultiplier, 
             bbCloseLower - MaxBreakEntry * Point * DigiMultiplier, 
             MathMin(smmaClosePer1 + TrendDist * Point * DigiMultiplier, smmaClosePer2 + TrendDist2 * Point * DigiMultiplier), 
             MathMax(smmaClosePer1 - TrendDist * Point * DigiMultiplier, smmaClosePer2 - TrendDist2 * Point * DigiMultiplier), 
             Bid, 
             TradeTime()) == 1
          )
      )
        {
         if(!InvertOrders /*&& SellsThisBar==0*/ && !( (closedOrdersCurrentBar & SELL_ORDERS) > 0 || (closedOrdersPreviousBar & SELL_ORDERS) > 0))
         {        
            ticket=OrderSend(Symbol(),OP_SELL,CalculateLots(),Bid,Slippage,0,CalculateTP(OP_SELL),"macd sample",Magic,0,Red);
            if(ticket>0)
              {
               if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
               {
                  TradesThisBar++;
                  SellsThisBar++;
                  IsNewDay=false;
                  IsNewHour=false;

                  RefreshRates();
                  InitialOrderOpenLots = OrderLots();
                  
                  if(StopLoss>0 ) 
                  {
                     //To do: Verify stop loss is valid
                     double SL2=CheckStopLoss(OP_SELL,Bid,NormalizeDouble((Bid+(StopLoss*Point*DigiMultiplier)),Digits));
                  }
                  if((StopLoss==0) && (TrailingStop>0))
                  {
                     //To do: Verify stop loss is valid
                     SL2=CheckStopLoss(OP_SELL,Bid,NormalizeDouble((Bid+(TrailingStop*Point*DigiMultiplier)),Digits));
                  }
                  
                  if(OrderModify(OrderTicket(),OrderOpenPrice(),/*SL2*/GetFiboStopLoss(OP_SELL,total),OrderTakeProfit(),0,Red))
                     Print("SELL order opened : ",OrderOpenPrice());
               }
              }
            else
               Print("Error opening SELL order : ",GetLastError());
         } else if(InvertOrders /*&& BuysThisBar==0*/ && !( (closedOrdersCurrentBar & BUY_ORDERS) > 0 || (closedOrdersPreviousBar & BUY_ORDERS) > 0))
         {
            ticket=OrderSend(Symbol(),OP_BUY,CalculateLots(),Ask,Slippage,0,CalculateTP(OP_BUY),"macd sample",Magic,0,Green);
            if(ticket>0)
              {
               if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
               {
                  TradesThisBar++;
                  BuysThisBar++;
                  IsNewDay=false;
                  IsNewHour=false;

                  RefreshRates();
                  InitialOrderOpenLots = OrderLots();
                  if(OrderModify(OrderTicket(),OrderOpenPrice(),GetFiboStopLoss(OP_BUY,total),OrderTakeProfit(),0,Green))
                     Print("BUY order opened : ",OrderOpenPrice());
               }
              }
            else
               Print("Error opening BUY order : ",GetLastError());
         }
        }
     }
   else/* if((Spread <= MaxCurSpread) && (SpreadAvg <= MaxAvgSpread)) */
   {
      // If total < MaxRecoveryOrders check how much the last order is losing
      RefreshRates();
      total=OrdersTotal();
      if (total < MaxRecoveryOrders)
      {
         double lastOrderGain = GetLastOrderGain();

         if (lastOrderGain < 0 && MathAbs(lastOrderGain) >= GetDistanceByLevel(total)) {
            
            int lastOrderPos = GetLastOrderPosition();
            int firstOrderPos = GetFirstOrderPosition();
            
            if ((lastOrderPos == OP_BUY && BuysThisBar==0) || (Hedging && SellsThisBar==0 && firstOrderPos == OP_SELL && total >= MaxRecoveryOrders/2)) {
               if(!( (closedOrdersCurrentBar & BUY_ORDERS) > 0 && (closedOrdersPreviousBar & BUY_ORDERS) > 0))
               {
                  ticket=OrderSend(Symbol(),OP_BUY,GetLotsByLevel(InitialOrderOpenLots,total),Ask,3,0,CalculateTP(OP_BUY),"macd sample",Magic,0,Blue);
                  if(ticket>0)
                    {
                     if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
                     {
                        Print("BUY recovery order opened : ",OrderOpenPrice());
                        TradesThisBar++;
                        BuysThisBar++;
                        IsNewDay=false;
                        IsNewHour=false;

                        for(cnt=0;cnt<total;cnt++)
                        {
                           if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
                              continue;
                           if(OrderType()<=OP_SELL &&   // check for opened position 
                              OrderMagicNumber()==Magic && // check for magic number 
                              OrderSymbol()==Symbol())  // check for symbol
                           {
                              bool modified = false;
                              if (OrderType() == OP_BUY)
                              {
                                 RefreshRates();
                                 modified = OrderModify(OrderTicket(),OrderOpenPrice(),GetFiboStopLoss(OP_BUY,total),CheckTakeProfit(Ask, Ask+GetFiboTakeProfit(total)),0,Green);
                              }
                              if (OrderType() == OP_SELL)
                              {
                                 RefreshRates();
                                 modified = OrderModify(OrderTicket(),OrderOpenPrice(),GetFiboStopLoss(OP_SELL,total),CheckTakeProfit(Bid, Bid-GetFiboTakeProfit(total)),0,Red);
                              }
                           }
                         }
                     }
                    }
                  else
                     Print("Error opening BUY recovery order : ",GetLastError());
               }
            }
            else if ((lastOrderPos == OP_SELL && SellsThisBar==0) || (Hedging && BuysThisBar==0 && firstOrderPos == OP_BUY && total >= MaxRecoveryOrders/2)) {
               if(!( (closedOrdersCurrentBar & SELL_ORDERS) > 0 && (closedOrdersPreviousBar & SELL_ORDERS) > 0))
               {
                  ticket=OrderSend(Symbol(),OP_SELL,GetLotsByLevel(InitialOrderOpenLots,total),Bid,3,0,CalculateTP(OP_SELL),"macd sample",Magic,0,Red);
                  if(ticket>0)
                    {
                     if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
                     {
                        TradesThisBar++;
                        SellsThisBar++;
                        IsNewDay=false;
                        IsNewHour=false;

                        Print("SELL recovery order opened : ",OrderOpenPrice());
                        for(cnt=0;cnt<total;cnt++)
                        {
                           if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
                              continue;
                           if(OrderType()<=OP_SELL &&   // check for opened position 
                              OrderMagicNumber()==Magic && // check for magic number
                              OrderSymbol()==Symbol())  // check for symbol
                           {
                              if (OrderType() == OP_SELL)
                              {
                                 RefreshRates();
                                 modified = OrderModify(OrderTicket(),OrderOpenPrice(),GetFiboStopLoss(OP_SELL,total),CheckTakeProfit(Bid, Bid-GetFiboTakeProfit(total)),0,Red);
                              }
                              if (OrderType() == OP_BUY)
                              {
                                 RefreshRates();
                                 modified = OrderModify(OrderTicket(),OrderOpenPrice(),GetFiboStopLoss(OP_BUY,total),CheckTakeProfit(Ask, Ask+GetFiboTakeProfit(total)),0,Green);
                              }
                           }
                         }
                     }
                    }
                  else
                     Print("Error opening SELL recovery order : ",GetLastError());
               }
            }
         }
      }
  }

  //-- Break Even------------------------------------------------------------------------------------------------------------------------
	if (UseBE)
	{
   	RefreshRates();
   	total = OrdersTotal();
   	
      lastOrderGain = GetLastOrderGain();
      lastOrderPos = GetLastOrderPosition();
   
      int dgts = Digits;

      if (lastOrderGain >= 0 && 
           (
            (lastOrderPos==OP_SELL && NormalizeDouble((Ask + (BeActivationPips*Point*DigiMultiplier)), dgts) < GetLastOrderOpenPrice())
            ||
            (lastOrderPos==OP_BUY && NormalizeDouble((Bid - (BeActivationPips*Point*DigiMultiplier)), dgts) > GetLastOrderOpenPrice())
           )
         ) {
   	   for (cnt = 0; cnt < total; cnt++)
   		{
   			if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES))
   			{
   				Print("Cannot select order");
   			}
            else
      			if ((OrderMagicNumber() == Magic) && (OrderSymbol() == Symbol()))
      			{   
      				if (OrderType() == OP_SELL)
      				{
                  	if (UseBE && (NormalizeDouble((Ask + (BeActivationPips*Point*DigiMultiplier)), dgts) < NormalizeDouble(OrderOpenPrice(), dgts))
      						&& (OrderStopLoss() == 0 || (NormalizeDouble((OrderOpenPrice() - (BePlusPips*Point*DigiMultiplier)), dgts) < OrderStopLoss())))
                  	{
                  		if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(OP_SELL,Ask, NormalizeDouble((OrderOpenPrice() - (BePlusPips*Point*DigiMultiplier)), dgts)), OrderTakeProfit(), 0, Red))
                  		{
                  			Print("OrderModify failed");
                  		}
                  	}
                  }
                  
                  if (OrderType() == OP_BUY)
                  {
                     if (UseBE && (NormalizeDouble((Bid - (BeActivationPips*Point*DigiMultiplier)), dgts) > NormalizeDouble(OrderOpenPrice(), dgts))
         						&& (OrderStopLoss() == 0 || (NormalizeDouble((OrderOpenPrice() + (BePlusPips*Point*DigiMultiplier)), dgts) > OrderStopLoss())))
         				{
         					if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(OP_BUY,Bid, NormalizeDouble((OrderOpenPrice() + (BePlusPips*Point*DigiMultiplier)), dgts)), OrderTakeProfit(), 0, Green))
         					{
         						Print("OrderModify failed");
         					}
         				}
         	      }
               }
         }
      }
	}
	
  //-- Trailing StopLoss Management-------------------------------------------------------------------------------------------------------
	   double lowFrac = iFractals(NULL, 0, MODE_LOWER, Shift);
	   double upFrac  = iFractals(NULL, 0, MODE_UPPER, Shift);
   	if ((lowFrac > 0) && (HighestDownFrac != lowFrac))
   	{
   		HighestDownFrac = lowFrac;
   		DownFracTime = TimeCurrent();
   	}
   	if ((upFrac > 0) && (LowestUpFrac != upFrac))
   	{
   		LowestUpFrac = upFrac;
   		UpFracTime = TimeCurrent();
   	}

  //-- Trailing Stop----------------------------------------------------------------------------------------------------------------------
   	if (UseTrailStop)
   	{
         TrailStop();
   	}

  //-- Awesome Trailing-------------------------------------------------------------------------------------------------------------------
   	if (UseAwesomeTrail)
   	{
         AwesomeTrail(LowestUpFrac, HighestDownFrac, DownFracTime, UpFracTime, Shift);
   	}

   //--
     IsNewBar=False;
//---
  }
//+------------------------------------------------------------------+
double GetLastOrderGain()
{
   RefreshRates();
	//Sleep(100);
   int lastOrderTicket = SearchLastOpenedMarketTicket(Magic);
   
   if (lastOrderTicket > 0)
   {
      if (OrderSelect(lastOrderTicket, SELECT_BY_TICKET))
      {
         if(OrderType()==OP_BUY)
         {
            return(Bid-OrderOpenPrice());
         } else if(OrderType()==OP_SELL)
         {
            return(OrderOpenPrice()-Ask);
         }
      }
   }
   
   return (0);
}
//+------------------------------------------------------------------+
int GetLastOrderPosition()
{
   RefreshRates();
	//Sleep(100);
   int lastOrderTicket = SearchLastOpenedMarketTicket(Magic);
   
   if (lastOrderTicket > 0)
   {
      if (OrderSelect(lastOrderTicket, SELECT_BY_TICKET)) {
         return (OrderType());
      }
   }
   
   return (-1);
}
//+------------------------------------------------------------------+
int GetLastOrderOpenPrice()
{
   RefreshRates();
	//Sleep(100);
   int lastOrderTicket = SearchLastOpenedMarketTicket(Magic);
   
   if (lastOrderTicket > 0)
   {
      if (OrderSelect(lastOrderTicket, SELECT_BY_TICKET)) {
         return (NormalizeDouble(OrderOpenPrice(), Digits));
      }
   }
   
   return (0);
}
//+------------------------------------------------------------------+
int GetFirstOrderPosition()
{
   RefreshRates();
	//Sleep(100);
   int lastOrderTicket = SearchFirstOpenedMarketTicket(Magic);
   
   if (lastOrderTicket > 0)
   {
      if (OrderSelect(lastOrderTicket, SELECT_BY_TICKET)) {
         return (OrderType());
      }
   }
   
   return (-1);
}
//+------------------------------------------------------------------+
int SearchLastOpenedMarketTicket(int magic) {
   RefreshRates();
	//Sleep(100);
   int i, ordersCount = OrdersTotal();
   datetime lastTime;

   // Search timestamp of last opened orders.
   for (i = ordersCount - 1; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS)) {
         if (OrderMagicNumber() != magic || OrderSymbol() != Symbol()) {
            continue;
         }

         if (OrderOpenTime() > lastTime) {
            lastTime = OrderOpenTime();
         }
      }
   }   

   for (i = ordersCount - 1; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS)) {
         if (OrderMagicNumber() != magic  || OrderSymbol() != Symbol() ||
             OrderOpenTime() < lastTime) {
            continue;
         }

         return (OrderTicket());
      }
   }

   return (0);
}
//+------------------------------------------------------------------+
int SearchFirstOpenedMarketTicket(int magic) {
   RefreshRates();
	//Sleep(100);
   int ordersCount = OrdersTotal();

   if(ordersCount>0) {
      if (OrderSelect(0, SELECT_BY_POS)) {
         return (OrderTicket());
      }
   }

   return (0);
}
//+------------------------------------------------------------------+
void CalculateInitialBalance()
  {
   RefreshRates();
	//Sleep(100);
   double total=0.0;
   double opentotal=0.0;

   int i,hstTotal=OrdersHistoryTotal();
   for(i=0;i<hstTotal;i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         Print("Could not select order");
        }
      if(OrderMagicNumber()!=Magic)
        {
         continue;
        }

      total+=OrderProfit()+OrderCommission()+OrderSwap();
     }

   int tot=OrdersTotal();
   for(i=0;i<tot;i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS))
        {
         Print("Could not select order");
        }
      if(OrderMagicNumber()!=Magic)
        {
         continue;
        }

      opentotal+=OrderProfit()+OrderCommission()+OrderSwap();
     }

   CalculatedBalance= SpecificBalance+total;
   CalculatedEquity = CalculatedBalance+opentotal;
  }
//+------------------------------------------------------------------+
double CalculateLots()
  {

// Order value
   RefreshRates();
	//Sleep(100);                              // Refresh rates
   double Min_Lot=MarketInfo(Symbol(),MODE_MINLOT);        // Minimal number of lots 
   double Max_Lot=MarketInfo(Symbol(),MODE_MAXLOT);
   double Free=AccountFreeMargin();                 // Free margin
   double One_Lot=MarketInfo(Symbol(),MODE_MARGINREQUIRED);// Price of 1 lot
   double Step   =MarketInfo(Symbol(),MODE_LOTSTEP);       // Step is changed
   if(MoneyManagement==Static)
     {
      double lotSize = LotSize;
      if(lotSize < Min_Lot){lotSize = Min_Lot;}
      if(lotSize > Max_Lot){lotSize = Max_Lot;}
      if(lotSize > MaxLotSize){lotSize = MaxLotSize;}
      return (NormalizeDouble(lotSize,2));
     }
   if(MoneyManagement==StepLots)
     {
      lotSize = LotSize;
      double balanceDiff = AccountEquity()-StartingBalance;
      int mux = balanceDiff/StepBalance;
      if (balanceDiff < 0 || mux == 0)
      {
          if(NoDropLotSize)
          {
            lotSize = SteppingLatestLotSize();
          }
          if(lotSize < Min_Lot){lotSize = Min_Lot;}
          if(lotSize > Max_Lot){lotSize = Max_Lot;}
          if(lotSize > MaxLotSize){lotSize = MaxLotSize;}
          return (NormalizeDouble(lotSize,2));
      } else {
          lotSize = LotSize+mux*LotStep;
          if(lotSize < Min_Lot){lotSize = Min_Lot;}
          if(lotSize > Max_Lot){lotSize = Max_Lot;}
          if(lotSize > MaxLotSize){lotSize = MaxLotSize;}
          return (NormalizeDouble(lotSize,2));
      }
     }
   if(InitialBalance==SpecificBal)
     {
      Free=CalculatedBalance;
     }

// 500 here because that's what the default is based off of
   double LeverageRatio=500.0/AccountLeverage();
// % of free margin
   double Lts=MathFloor(Free*RiskSetting/10.0/One_Lot/Step*LeverageRatio)*Step;  // For opening

   if(Lts<=Min_Lot) Lts=Min_Lot;               // Not less than minimal
   if(Lts>=Max_Lot) Lts=Max_Lot;
   if(Lts > MaxLotSize){Lts = MaxLotSize;}
   if(Lts*One_Lot>=Free) // Lot larger than free margin
     {
      Alert(" Not enough money for ",Lts," lots");
      return(0);                                   // Exit start()
     }
   return(NormalizeDouble(Lts,2));
  }
//+------------------------------------------------------------------+
double SteppingLatestLotSize()
{
   RefreshRates();
	//Sleep(100);                              // Refresh rates
   double total=0.0;
   double opentotal=0.0;

   int i,hstTotal=OrdersHistoryTotal();
   for(i=0;i<hstTotal;i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         Print("Could not select order");
        }
      if(OrderMagicNumber()!=Magic)
        {
         continue;
        }
      if(OrderProfit()>0)
         total+=OrderProfit()+OrderCommission()+OrderSwap();
     }

   double Min_Lot=MarketInfo(Symbol(),MODE_MINLOT);        // Minimal number of lots 
   double Max_Lot=MarketInfo(Symbol(),MODE_MAXLOT);
   double steppingCalculatedBalance= StartingBalance+total;
   
   double lotSize = LotSize;
   double balanceDiff = steppingCalculatedBalance-StartingBalance;
   int mux = balanceDiff/StepBalance;
   if (balanceDiff < 0 || mux == 0) {
       if(lotSize < Min_Lot){lotSize = Min_Lot;}
       if(lotSize > Max_Lot){lotSize = Max_Lot;}
       if(lotSize > MaxLotSize){lotSize = MaxLotSize;}
       return (NormalizeDouble(lotSize,2));
   } else {
       lotSize = LotSize+mux*LotStep;
       if(lotSize < Min_Lot){lotSize = Min_Lot;}
       if(lotSize > Max_Lot){lotSize = Max_Lot;}
       if(lotSize > MaxLotSize){lotSize = MaxLotSize;}
       return (NormalizeDouble(lotSize,2));
   }
}
//+------------------------------------------------------------------+
double GetLotsByLevel(double lots,int level)
{
   RefreshRates();
	//Sleep(100);
	
	if (MoneyManagement == Static || MoneyManagement == StepBalance) {
	   return (lots);
	}
	
   //--- Calculate the Fibonacci series
   int counterFibonacci=level+1;
   int i=0,first=0,second=1;
   int currentFibonacciNumber;
   do
     {
      currentFibonacciNumber=first+second;
      first=second;
      second=currentFibonacciNumber;
      i++; // without this operator an infinite loop will appear!
     }
   while(i<counterFibonacci && !IsStopped());
   
   double fiboLot = lots + (lots*currentFibonacciNumber)/10.0;
   if (fiboLot < lots) fiboLot = lots;
   
   /*if(MoneyManagement==Dynamic)
   {*/
      return(NormalizeDouble(fiboLot,Digits));
   /*}
   else
   {
      return(NormalizeDouble(lots,Digits));
   }*/
}
//+------------------------------------------------------------------+
void CheckForBrokenTrades()
  {
   RefreshRates();
	//Sleep(100);
   for(int cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
        {
         Print("Order could not be selected");
         continue;
        }
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=Magic)
         continue;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic)
        {

         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
           {
            if(OrderStopLoss()==0)
              {

               double stoploss_bn=TS1*Point*DigiMultiplier;
               
               if(OrderType()==OP_BUY)
                  stoploss_bn=stoploss_bn-MarketInfo(NULL,MODE_SPREAD)*Point;
               if(OrderType()==OP_SELL)
                  stoploss_bn=stoploss_bn+MarketInfo(NULL,MODE_SPREAD)*Point;
                  
               int errorcode_ts=0;
               int digits_bn;
               double points_bn,price_bn;
               digits_bn=int(MarketInfo(OrderSymbol(),MODE_DIGITS));
               points_bn=MarketInfo(OrderSymbol(),MODE_POINT);

               color ordercolor_bn;

               stoploss_bn=stoploss_bn*PipMultiplier;

               if(OrderType()==OP_BUY)
                 {
                  price_bn=NormalizeDouble(MarketInfo(OrderSymbol(),MODE_ASK),digits_bn);
                  ordercolor_bn=Green;
                  if(stoploss_bn>0)
                    {
                     stoploss_bn = NormalizeDouble(price_bn-stoploss_bn*points_bn, digits_bn);
                     stoploss_bn = CheckStopLoss(OP_BUY,price_bn, stoploss_bn);
                    }
                 } else {  // go short set up
                  price_bn=NormalizeDouble(MarketInfo(OrderSymbol(),MODE_BID),digits_bn);
                  ordercolor_bn=Red;
                  if(stoploss_bn>0)
                    {
                     stoploss_bn = NormalizeDouble(price_bn+stoploss_bn*points_bn, digits_bn);
                     stoploss_bn = CheckStopLoss(OP_SELL,price_bn, stoploss_bn);
                    }
                 }

               //modify order, adds TP/SL
               if(OrderModify(OrderTicket(),OrderOpenPrice(),stoploss_bn,OrderTakeProfit(),0,ordercolor_bn))
                 {
                  Print("Fixing broken trades: SL=",stoploss_bn," TP=",OrderTakeProfit());
                    }else {
                  errorcode_ts=GetLastError();
                  Print("Could not add SL/TP to order. Error:",errorcode_ts," ",ErrorDescription(errorcode_ts));
                 }

              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
double GetFiboTakeProfit(int level)
{
   //--- Calculate the Fibonacci series
   int counterFibonacci=level+1;
   int i=0,first=0,second=1;
   int currentFibonacciNumber;
   do
     {
      currentFibonacciNumber=first+second;
      first=second;
      second=currentFibonacciNumber;
      i++; // without this operator an infinite loop will appear!
     }
   while(i<counterFibonacci && !IsStopped());

   double fiboTp = TakeProfit + (TakeProfit*currentFibonacciNumber)/10.0;
   if (fiboTp<TakeProfit) fiboTp=TakeProfit;
   
   return(NormalizeDouble(fiboTp*Point*DigiMultiplier, Digits));
}
//+------------------------------------------------------------------+
double CalculateTP(int dir)
{
   RefreshRates();
	//Sleep(100);
   double TP = 0;
   if (TakeProfit == 0)
      return(0);
   
   if (dir == OP_BUY)
   {
      TP = CheckTakeProfit(Ask, Ask+TakeProfit*Point*DigiMultiplier);
   } else if (dir == OP_SELL) {
      TP = CheckTakeProfit(Bid, Bid-TakeProfit*Point*DigiMultiplier);
   }
   
   return(TP);
}
//+------------------------------------------------------------------+
double CheckTakeProfit(double price_tp,double tp)
{
   double minimumstop;
   if(tp==0)
   { //no take profit
      return(tp);
   }
   
   RefreshRates();
	//Sleep(100);
   minimumstop=2*MarketInfo(Symbol(),MODE_STOPLEVEL)*MarketInfo(Symbol(),MODE_POINT);
   // Print("Minimum take profit allowed=",minimumstop);
   if(MathAbs(price_tp-tp)<=minimumstop)
   {
      //move to a higher stop that assure execution
      //for longs
      if(price_tp<tp)
      {
         tp=price_tp+minimumstop;
         //for shorts
      } else if(price_tp>tp) {
         tp=price_tp-minimumstop;
      } else {
         Print("ERROR: Could not adjust take profit, TP=",tp);
         return(tp);
      }
      
      //normalize TP
      tp=NormalizeDouble(tp, Digits);
      Print("Target Profit was too small. It was changed. New TP=",tp);
   }
   
   return(tp);
}
//+------------------------------------------------------------------+
double GetFiboStopLoss(int type,int level)
{
   if (StopLoss == 0)
      return(0);
   
   double SL_B = 0;
   double SL_S = 0;
   
   if (level <= 1)
   {
      if (type == OP_BUY)
      {
         SL_B = CheckStopLoss(OP_BUY, Bid, NormalizeDouble(Bid-TS1*Point*DigiMultiplier,Digits));
         return(SL_B);
      }
      else if (type == OP_SELL)
      {
         SL_S = CheckStopLoss(OP_SELL, Ask, NormalizeDouble(Ask+TS1*Point*DigiMultiplier,Digits));
         return(SL_S);
      }
   }
   
   //--- Calculate the Fibonacci series
   int counterFibonacci=level+1;
   int i=0,first=0,second=1;
   int currentFibonacciNumber;
   do
     {
      currentFibonacciNumber=first+second;
      first=second;
      second=currentFibonacciNumber;
      i++; // without this operator an infinite loop will appear!
     }
   while(i<counterFibonacci && !IsStopped());

   double fiboSl = TS1 + (TS1*currentFibonacciNumber)/10.0;
   if (fiboSl<TS1) fiboSl=TS1;
   
   
   if (type == OP_BUY)
   {
      SL_B = CheckStopLoss(OP_BUY, Bid, NormalizeDouble(Bid-fiboSl*Point*DigiMultiplier,Digits));
      return(SL_B);
   }
   else if (type == OP_SELL)
   {
      SL_S = CheckStopLoss(OP_SELL, Ask, NormalizeDouble(Ask+fiboSl*Point*DigiMultiplier,Digits));
      return(SL_S);
   }
   
   return(0);
}
//+------------------------------------------------------------------+
double CheckStopLoss(int dir,double price_sl,double sl)
{
   RefreshRates();
	//Sleep(100);
   double minimumstop;
   if(sl==0)
   { // no stop loss
      return(sl);
   }
   
   minimumstop=MarketInfo(Symbol(),MODE_STOPLEVEL)*Point;
   // Print("Minimum stop loss allowed (Points) = ",minimumstop/Point);
   if(MathAbs(price_sl-sl)<=minimumstop)
   {
      //move to a higher stop that assure execution
      //for longs
      if(dir==OP_BUY)
      {
         //sl=price_sl-minimumstop+TrailingStop*Point*DigiMultiplier;
         sl=price_sl-TS1*Point*DigiMultiplier-minimumstop;
      } else if(dir==OP_SELL) {
         //for shorts
         //sl=price_sl+minimumstop+TrailingStop*Point*DigiMultiplier;
         sl=price_sl+TS1*Point*DigiMultiplier+minimumstop;
      } else {
         Print("ERROR: Could not adjust stop loss, SL=",sl);
         return(sl);
      }
      
      //normalize SL
      //sl=NormalizeDouble(sl, Digits);
      Print("Stop Loss was too small. It was changed. New SL=",sl);
   }
   
   return(sl);
}
//+------------------------------------------------------------------+
double GetDistanceByLevel(int level)
{
   RefreshRates();
	//Sleep(100);
   //--- Calculate the Fibonacci series
   int counterFibonacci=level+1;
   int i=0,first=0,second=1;
   int currentFibonacciNumber;
   do
     {
      currentFibonacciNumber=first+second;
      first=second;
      second=currentFibonacciNumber;
      i++; // without this operator an infinite loop will appear!
     }
   while(i<counterFibonacci && !IsStopped());
   
   double fiboDistance = (BaseDistance*currentFibonacciNumber)/10.0;
   if (fiboDistance<BaseDistance) fiboDistance=BaseDistance;
   
   return(NormalizeDouble(Point*DigiMultiplier*fiboDistance,Digits));
}
//+------------------------------------------------------------------+
void CloseAllOpenPositions()
{
  RefreshRates();
  //Sleep(100);
  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    if(!OrderSelect(i, SELECT_BY_POS))
     {
      continue;
     }
    
    if(OrderMagicNumber()!=Magic)
     {
      continue;
     }
     
    int type   = OrderType();

    bool result = false;
    
    switch(type)
    {
      //Close opened long positions
      case OP_BUY       : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
                          break;
      
      //Close opened short positions
      case OP_SELL      : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );
                          
    }
    
    if(result == false)
    {
      Alert("Order " , OrderTicket() , " failed to close. Error:" , GetLastError() );
      Sleep(3000);
    }  
  }
}
//+------------------------------------------------------------------+
int ClosedOrdersPerBar(int bar) 
{
   if (bar == 0 && !ClosedOnCurrentBarCheck) return(0);
   if (bar > 0 && !ClosedOnPreviousBarCheck) return(0);
   
   RefreshRates();
	//Sleep(100);
   int orders=0;
   if(OrdersHistoryTotal()>0) 
      { 
      for(int i = OrdersHistoryTotal()-1; i>=0; i--) 
      {
         if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
         {
            continue;
         }
         if(OrderMagicNumber()!=Magic)
         {
            continue;
         }
         if(OrderCloseTime() >= iTime(NULL,0,bar))
         {
            orders += ORDER_INCREMENT; 
            if(OrderType() == OP_BUY)  orders |= BUY_ORDERS;
            if(OrderType() == OP_SELL) orders |= SELL_ORDERS;
         }
      } 
   }
   
   return(orders); 
}
//+------------------------------------------------------------------+
int CheckOpen(double closep, double bube, double bumbe, double blbe, double blmbe, double minma, double maxma, double price, int h)
{
   if ((price < blbe) && (price > blmbe) && (price > minma))
   {
       return (0);
   }
   if ((price < blbe) && (price > blmbe) && ((h==NoTrendHour1) || (h==NoTrendHour2) || (h==NoTrendHour3) || (h==NoTrendHour4)))
   {
       return (0);
   }    
   if ((price > bube) && (price < bumbe) && (price < maxma)) 
   {
      return (1);
   }
   if ((price > bube) && (price < bumbe) && ((h==NoTrendHour1) || (h==NoTrendHour2) || (h==NoTrendHour3) || (h==NoTrendHour4)))
   {
      return (1);   
   }
   return (-1);
}
//+------------------------------------------------------------------+
int TradeTime() {
   int h = Hour();
   h -= BrokerTimeOffset;
   if (h > 23) h -= 24;
   if (h < 0) h += 24;
   return (h);
}
//+------------------------------------------------------------------+
void TrailStop() {
	RefreshRates();
	//Sleep(1000);
	int total = OrdersTotal();	
   int dgts = Digits;

   if (!UseTrailStop)
      return;

	for (int cnt = 0; cnt < total; cnt++)
	{
		if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES))
		{
			Print("Cannot select order");
			continue;
		}
		
		if ((OrderMagicNumber() == Magic) && (OrderSymbol() == Symbol()))
		{
			if (OrderType() == OP_SELL)
			{
				if (TrailingStop > 0)
				{
				   if (UseHybridStop)
				      if (Ask <= NormalizeDouble(OrderOpenPrice() - StopTrailAtPips*Point*DigiMultiplier, dgts))
				         continue;
			
			      if (OrderStopLoss() != 0 && Ask < OrderStopLoss() && Ask <= NormalizeDouble(OrderOpenPrice() - TSActivationPips*Point*DigiMultiplier, dgts))		
						if (OrderStopLoss() != 0 && OrderStopLoss() > NormalizeDouble(Ask + (TrailingStep + TrailingStop)*Point*DigiMultiplier, dgts))
						{
							if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(OP_SELL, Ask, NormalizeDouble(Ask + ((TrailingStep + TrailingStop)*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Red))
							{
								Print("OrderModify failed");
							}
						}
				}
			}

			if (OrderType() == OP_BUY)
			{
			   if (!UseHybridStop || (UseHybridStop && NormalizeDouble((Bid - (StopTrailAtPips*Point*DigiMultiplier)), dgts) < NormalizeDouble(OrderOpenPrice(), dgts)) )
			   {
					if (TrailingStop > 0)
					{
					   if (UseHybridStop)
					      if (Bid >= NormalizeDouble(OrderOpenPrice() + StopTrailAtPips*Point*DigiMultiplier, dgts))
					         continue;

                  if (OrderStopLoss() != 0 && Bid > OrderStopLoss() && Bid >= NormalizeDouble(OrderOpenPrice() + (TSActivationPips*Point*DigiMultiplier), dgts))
   						if (OrderStopLoss() != 0 && OrderStopLoss() < NormalizeDouble(Bid - (TrailingStep + TrailingStop)*Point*DigiMultiplier, dgts))
   						{
   							if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(OP_BUY, Bid, NormalizeDouble(Bid - ((TrailingStep + TrailingStop)*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Green))
   							{
   								Print("OrderModify failed");
   							}
   						}
					}
			   }
			}
		}
	}
}
//+------------------------------------------------------------------+
void AwesomeTrail(double lowestUpFrac, double highestDownFrac, datetime downFracTime, datetime upFracTime, int shift)
{
	RefreshRates();
	//Sleep(1000);
	int total = OrdersTotal();
	int dgts = Digits;
	
	if (!UseAwesomeTrail)
	   return;

	for (int cnt = 0; cnt < total; cnt++)
	{
		if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES))
		{
			Print("Cannot select order");
			continue;
		}
		if ((OrderMagicNumber() == Magic) && (OrderSymbol() == Symbol()))
		{
			if (OrderType() == OP_SELL)
			{
			   if (UseHybridStop)
			      if (Ask > NormalizeDouble(OrderOpenPrice() - ActivationPips*Point*DigiMultiplier, dgts))
			         continue;			
			
			   if (Ask <= OrderOpenPrice() && Ask <= NormalizeDouble(lowestUpFrac + (TrailingStop*Point*DigiMultiplier), dgts))
			      if(upFracTime > OrderOpenTime() + shift * 60)
      				if (OrderStopLoss() !=0 && OrderStopLoss() > NormalizeDouble(lowestUpFrac + (TrailingStop*Point*DigiMultiplier), dgts))
      				{
      					Print("Lowest Up Frac  ", lowestUpFrac);
      					if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(OP_SELL, Ask, NormalizeDouble(lowestUpFrac + (TrailingStop*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Red))
      					{
      						Print("OrderModify failed");
      					}
      				}
			}

			if (OrderType() == OP_BUY)
			{
			   if (UseHybridStop)
			      if (Bid < NormalizeDouble(OrderOpenPrice() + ActivationPips*Point*DigiMultiplier, dgts))
			         continue;
			
			   if (Bid >= OrderOpenPrice() && Bid >= NormalizeDouble(highestDownFrac - (TrailingStop*Point*DigiMultiplier), dgts))
			      if(downFracTime > OrderOpenTime() + shift * 60)
      				if (OrderStopLoss() !=0 && OrderStopLoss() < NormalizeDouble(highestDownFrac - (TrailingStop*Point*DigiMultiplier), dgts))
      				{
      					Print("Highest Down Frac  ", highestDownFrac);
      					if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(OP_BUY, Bid, NormalizeDouble(highestDownFrac - (TrailingStop*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Red))
      					{
      						Print("OrderModify failed");
      					}
      				}
			}
		}
	}
}