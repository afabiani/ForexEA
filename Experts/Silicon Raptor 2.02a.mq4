//+------------------------------------------------------------------+
//| 
//+------------------------------------------------------------------+

#property     copyright                     "Copyright © 2016 Cutting Edge Forex LLC"
#property     link                          "CuttingEdgeForex.com"
#property     version                       "1.14"
string        Version =                     "1.14";

#define       SleepTime                     250               
#property     strict    
extern bool   UseLocalTime      = false;
extern int    BrokerTimeOffset  = 0;
extern int    MaxFillTime       = 60;

extern bool   SkipFriday        = true;
extern int    ClosingHour       = 20;     
extern int    ClosingMinute     = 10; 

extern string Algo_Name="Silicon Raptor";          // Cutting Edge Forex
enum Enum1       // Entry Strategy
  {
   BreakOut,    // Break Out
   Fade,        // Fade
   Impulsive,   // Impulsive
  };
enum Enum2       // Lot Size
  {
   Dynamic,     // Dynamic lots
   StepLots,    // Step lots
   Static,      // Fixed lots
  };
enum Enum3       // Time Filtering
  {
   NoFilter,    // No Filter
   SkipQuarters,// Skip Quarters
   QuartersOnly,// Quarters Only
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
enum Enum6       // Alerts
  {
   ShowAlerts,  // Show Alerts
   HideAlerts,  // Hide Alerts
  };
enum Enum7       // Display Background
  {
   Solid,       // Solid
   Transparent, // Transparent
  };
//extern bool   UseOco                       = true;
extern int    ExpHours                      = 2;                          // Expiration Hours
extern Enum2  MoneyManagement               = Dynamic;                    // Money Management
extern double RiskSetting                   = 1.0;                        // Risk Setting   (Dynamic)
extern double LotSize                       = 0.01;                       // Fixed Lot Size
extern double LotStep                       = 0.01;                       // Stepping Lot Size
extern bool   NoDropLotSize                 = true;
extern double MaxCurSpread                  = 1.5;                        // Max Spread Live  (Pips)
extern double MaxAvgSpread                  = 1.5;                        // Max Spread Avg   (Pips)
extern double Offset                        = 25;                         // Offset Pending Orders
extern double DriftAllowed                  = 2.0;                        // Dift Allowed (Pips)
extern double InitialStopLoss               = 10;                          // Initial Stop (Pips)
extern bool   UseAwesomeTrail               = true;
extern bool   UseBE                         = false;
extern double BeActivationPips              = 5.0;
extern double BePlusPips                    = 2.0;

extern bool   UseTrailStop                  = false;
extern double TrailingStop                  = 2.0;                        // Trailing Stop      (Pips)
extern double TSActivationPips              = 2.0;                        // TS Activation    (Pips)
extern double TrailingStep                  = 0.5;                        // Trailing Step     (Pips)

extern bool   UseHybridStop     = true;
extern double ActivationPips    = 10.0;
extern double StopTrailAtPips   = 2.0;

int    Shift                         = 3;  
 bool   ProfitLock                         = false;
 double TrigPer                            = 0.5;
 double ProLockPer                         = 20;

int           TAS                          = 100;                        // TAS tick array 
//extern int    Window                     = 20;                         // Window  (Seconds)

int    Per1                                = 3;                          // Indi 1 Period 
int    Per2                                = 3;                          // Indi 2 Period 

double        ExitSeconds                  = 0;                          // Exit         (Seconds)
double        PauseSeconds                 = 0;                          // Pause     (Seconds)
extern int    MaxPositions                 = 1;
int    TradesPerBar                        = 1;                                             // Trades Per Bar
extern double TargetProfit                 = 0;                          // Target Profit  (Pips)

bool          CheckTSEveryTick              = true;
string        Trading_Hours                 = " Use trading hours below";
bool          UseTradingTime                = false;
int           TradingTimeStart              = 9;
int           TradingTimeEnd                = 16;
bool          ClosePositionsNonTradingHours = false;
int           Max_Order_Retry               = 5;
int           Slippage                      = 2;
Enum3  TimeFilter                    = NoFilter;                   // Time Filtering
extern Enum4  InitialBalance                = AccountBal;                 // Initial Balance
extern double SpecificBalance               = 250.0;                      // Specified Balance
extern double StepIntialBalance             = 1000;
extern double StepBalance                   = 100.0;                      // Stepping Balance
bool          Micro_Account                 = true;
extern Enum5  BrokerDigits                  = Digit5;                     // Broker Digits 
extern bool   AutoAdjustTPSL                = true;                       // Auto Adjust TP/SL
       
bool          DigiFix                       = false;                      // Digit Fix 
extern Enum6  Alerts                        = ShowAlerts;                 // Show Alerts        
extern Enum7  Display                       = Solid;                      // Display Background
int           Display_Colors                = 12;                         // Display Colors
extern string TradeTag                     = "Silicon Raptor";            // User Defined Tag

extern int    MagicNumber                   = 2821;                      // Magic Number
int           PipMultiplier                 = 1;
string        MySound                       = "alert.wav";
bool          ECN_Friendly                  = true;
bool          Send_Emails                   = false;
double        CalculatedBalance             = 0.0;
double        CalculatedEquity              = 0.0;
double        CalculatedBalance2            = 0.0;
double        CalculatedEquity2             = 0.0;
static color  BuyColor                      = Green;
static color  SellColor                     = Red;
bool          UseMaximumPercentageatRisk    = false;
double        MaximumPercentageatRisk       = 1;
bool          UseRiskRatio                  = false;
int           RiskRatio                     = 3;
bool          UseLotManagement              = false;
int           LotManagementType             = 2;
double        ReductionFactor               = 5;
bool          UseMartingale                 = false;
double        MartingaleMultiplier          = 2.0;
double        MaxMartingaleSize             = 1.8;
bool          afterLoss                     = false;
bool          afterWin                      = false;
datetime      MartingaleTime                = 0;
string        CurrencyPrefix                = "";
double        TempBuffer[];
int           Open_Total;
int           Open_Sells;
int           Open_Buys;
datetime      StartTime;
datetime      expiration;
int           NumTradesToShow               = 1;
string        mailstring                    = "";
string        subject                       = "Algo: ";
bool          Hedge                         = false;
bool          EnableAudibleAlerts           = false;
int           MinBars                       = 10;

double        Spread;
bool          Add_Positions=false;
//int           MaxPositions                 = 1;
bool          TradeOrAlert                  = true;
bool          UseTimedExit                  = true;
int           MBars;
color         clr1;
color         clr2;
color         clr3;
color         clr4;
bool          BuyCond1;
bool          SellCond1;
bool          BuyCond2;
bool          SellCond2;
bool          Strategy1TradedThisBar;
bool          GoTime;
bool          AlgoPaused;
bool          MinSpikeAchieved;
bool          CancelledByTime;
bool          Ready;
bool          Armed;
bool          Fired;
bool          flag1;
bool          flag2;
bool          flag3;
bool          flag4;
bool          SleepFlag;
//datetime      CurrentTime;
datetime      SleepStartTime;
datetime      SleepEndTime;
datetime      AlgoTime;
double          DigiMultiplier;
datetime        Timer;
string          Timer2;
double          BuyBackTick;
double          SellBackTick;
int             TickArraySize;
double          BidArray[];
double          AskArray[];
datetime        TimeArray[];
double          Array_spread[30];
int             UpTo30Counter=0;
bool            DelayTS;
bool            printlimiter1;
int             TradesThisBar;
int             BuysThisBar;
int             SellsThisBar;
double          Trailing_Stop2;
bool            UpSpike;
static datetime TimeStamp;
static datetime PauseStamp;
static datetime LatestTradeTime;
bool             ClearToTrade;
bool            BuyS1;
bool            BuyS2;
bool            BuyS3;
bool            SellS1;
bool            SellS2;
bool            SellS3;
double          avgspread;
bool            Transparent2;
double          SpreadAvg;
bool            messageflag1;
double          TS1;
double          HighPro;
double          LowPro;
int           Pending_Total;
int           Pending_Buys;
int           Pending_Sells;
bool IsNewBar;
bool OutOfRange;
double BidStamp;
double SL2;
double TempClose;
double TempClose2;
int    ExpSeconds;
int  HBars;
int  DBars;
bool IsNewDay;
double HighestDownFrac;
double LowestUpFrac;
datetime UpFracTime;
datetime DownFracTime;
bool SpeedCode;

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

int init()
  { 
  
   if(IsTesting() && (!IsVisualMode()))
   {
   SpeedCode = true;
   }
   if(IsTesting() && (IsVisualMode()))
   {
   SpeedCode = false;
   }
   if(!IsTesting())
   {
   SpeedCode = false;
   }    
   HighestDownFrac = 0;
   LowestUpFrac = 0;
   UpFracTime = 0;
   DownFracTime = 0;
   IsNewDay = false;
   DBars = 0;
   HBars = 0;
   MBars = 0;
   ExpSeconds = (ExpHours*PERIOD_H1*60);
   TempClose = 0;
   TempClose = 0;
   BidStamp = 0;
   OutOfRange      = true;
   CancelledByTime = false;
   AlgoPaused      = false;
   flag4           = false;
   SleepFlag       = false;
   DelayTS         = false;
   printlimiter1   = false;
   messageflag1    = false;
   PauseStamp      = TimeCurrent();
   TradesThisBar = 0;
   BuysThisBar   = 0;
   SellsThisBar  = 0;
   avgspread=0.2;
   SpreadAvg=0.2;
   if(Display==Transparent)
     {
      Transparent2=true;
        }else{
      Transparent2=false;
     }
   
   
//----init start
   HideTestIndicators(true);
   TickArraySize=TAS;
   ArrayResize(BidArray,TickArraySize);
   ArrayResize(AskArray,TickArraySize);
   ArrayResize(TimeArray,TickArraySize);

   StartTime=TimeCurrent();
   TimeStamp= TimeCurrent();
   if(InitialBalance==SpecificBal)
     {
      CalculateInitialBalance();
     }

   if(AccountCurrency()=="USD")
     {
      //	CurrencyPrefix = "$";
     }

   CreateLabels();

   checkForBrokenTrades();

//Adjust calculations for 5 digit brokers 

   double COMmultiplier=MathPow(10,Digits);
   DigiMultiplier=1;
//  double COMmultiplier=10;
   if(Digits==5 && !DigiFix)
     {
      COMmultiplier/=10;
     }
   if(Digits==3 && !DigiFix)
     {
      COMmultiplier/=100;
     }

   if(DigiFix || BrokerDigits == Digit4)
     {
      COMmultiplier/=10;
      DigiMultiplier=1;
     }
   else
     {
      DigiMultiplier=10;
     }

   if(BrokerDigits==Digit5 && !DigiFix)
     {
      PipMultiplier=10;
        }else{
      PipMultiplier=1;
     }
   Slippage=Slippage*PipMultiplier;  
   
   if(InitialStopLoss==0)
     {
     TS1 = TrailingStop;
     }else{
     TS1 = InitialStopLoss;
     }
    
   if((!UseHybridStop) && (UseTrailStop) && (UseAwesomeTrail))
     {
      Print("You must choose either Trailing Stop -OR- Awesome Stops");
      MessageBox("You must choose either Trailing Stop -OR- Awesome Stops");
      return(-1);
     }  
   if((UseHybridStop) && !(UseTrailStop) && !(UseAwesomeTrail))
   {
      Print("You must choose both Trailing Stop -AND- Awesome Stops -WHEN- Hybrid mode is enabled.");
      MessageBox("You must choose both Trailing Stop -AND- Awesome Stops -WHEN- Hybrid mode is enabled.");
      return(-1);
   }
   
   if((Digits==5 || Digits==3) && (BrokerDigits==Digit4))
     {
      Print(Symbol()," You selected 4 Digit Broker but your graph seems to have 5 digits (or 3 for JPY pairs). Please review your digits definition.");
      MessageBox(Symbol()+" You selected 4 Digit Broker but your graph seems to have 5 digits (or 3 for JPY pairs). Please review your digits definitions.","Digits setup may be wrong");
     }


//Hedging message
   if(Hedge)
     {
      Print("You are hedging.");
      if(Alerts==ShowAlerts) MessageBox("You are hedging. You need to use the Close icons in your trading diagram to close postitions."," Warning: Close existing orders");
     }

   Print("Account Equity=",AccountEquity(),". Account Balance=",AccountBalance(),". Account Free Margin = ",AccountFreeMargin(),". Account Leverage=",AccountLeverage());
// Verify if there are open positions and alert    
   
// Check for enough ticks and trade permission
   if(Bars<MinBars)
     {
      Print(" CANNOT TRADE. Not enough historical information!");
      MessageBox(" CANNOT TRADE . Not enough historical information!"," Warning");
     }

// Check for enough ticks and trade permission
  

   if(IsTradeAllowed()==false)
     {
      Print(" CANNOT TRADE  Trading is not allowed! Please confirm that the checkbox -Allow Live Trading option- is checked and that you are able to connect to the server.");
      if(Alerts==ShowAlerts) MessageBox(" CANNOT TRADE  Trading is not allowed! Please confirm that the checkbox -Allow Live Trading option- is checked and that you are able to connect to the server."," Warning");
     }

// Using current symbol to check for account type
   Print("Lot Information: Symbol=",Symbol(),". MIN LOT ALLOWED=",MarketInfo(Symbol(),MODE_MINLOT),". MAX LOT ALLOWED=",MarketInfo(Symbol(),MODE_MAXLOT),". LOT SIZE IN BASE CURRENCY=",MarketInfo(Symbol(),MODE_LOTSIZE));
   Print("Lot Information: Buying 1 lot in your Account is equivalent to buying ",MarketInfo(Symbol(),MODE_LOTSIZE)," of currency.");
   Print("Lot Information: Buying the minimum lot size of ",MarketInfo(Symbol(),MODE_MINLOT)," is equivalent to buying ",MarketInfo(Symbol(),MODE_LOTSIZE)*MarketInfo(Symbol(),MODE_MINLOT)," of currency.");

   Print("Min Stops/Limit Level = ",MarketInfo(Symbol(),MODE_STOPLEVEL)," Points.");

   RefreshRates();

   UpdateLabels();

//----init end
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
   RemoveLabels();
//----deinitialization start
   DELETEP(Symbol(),"All");
   DELETEP(Symbol(),"All");
   
   Print(" Expert Advisor has been removed ");
   Comment("");
//----deinitialization end
   return(0);
  }
//---- Start -------------------------------------------------------------------------------------------------------------
int start()
  {
   // Print("Orders Total", OrdersTotal());
   int activeSell,activeBuy;
   int OrdersCondition=CheckOrdersCondition();
   SL2 = 0;
   Open_Total =0;
   Open_Sells =0;
   Open_Buys  =0;
   Pending_Total = 0;
   Pending_Sells = 0;
   Pending_Buys  = 0;
   if(Open_Total==0)
   {
   HighPro=0;
   LowPro=0;
   } 
      if((TS1)*DigiMultiplier < MarketInfo(NULL,MODE_STOPLEVEL)|| (TS1==0 && (InitialStopLoss)*DigiMultiplier < MarketInfo(NULL,MODE_STOPLEVEL)))
           {
           if(!messageflag1)
            {
            MessageBox(" Stop Loss is too small for broker's minimum stop levels. Please increase your Stop Loss  ");
            messageflag1 = true;
            }
           Print(" Your Stop Loss is too small for broker's minimum stop levels (Points):  ",  DoubleToStr( MarketInfo(NULL,MODE_STOPLEVEL)));
           
           }
       if((Offset)*DigiMultiplier < MarketInfo(NULL,MODE_STOPLEVEL))
           {
           
           
           MessageBox(" Offset is too small for broker's minimum stop levels. Please increase your pending order offset distance  ");
           
            
           Print(" Offset is too small for broker's minimum stop levels. Please increase your pending order offset distance to minimum stop levels (Points):  ",  DoubleToStr( MarketInfo(NULL,MODE_STOPLEVEL)));
           return(0);
           }    
        
 
   if(Bars<MinBars)
     {
      UpdateLabels();
      return(0);
     }
   
   if(InitialBalance==SpecificBal)
     {
      CalculateInitialBalance();
        }else{
      CalculatedBalance= AccountBalance();
      CalculatedEquity = AccountEquity();
     }
//Prepare coments
   string mycomment;
   mycomment="Designed by CuttingEdgeForex.com";
   if(TradeOrAlert)
     {
      mycomment=StringConcatenate(mycomment," Trading Mode -");
        } else {
      mycomment=StringConcatenate(mycomment," Alarm Mode -");
     }
   mycomment=StringConcatenate(mycomment,"\nServer Time=",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS));
//Comment(mycomment);

// Check trading time
   if(UseTradingTime)
     {
      if(!(Hour()>=TradingTimeStart && Hour()<=TradingTimeEnd))
        {
         mycomment=StringConcatenate(mycomment," General Settings: Server Time=",Hour(),"h:",Minute(),"m. | Current server time is NOT between trading time hours. | Trading Time is from ",TradingTimeStart," to ",TradingTimeEnd," hours");
         Comment(mycomment);
         if(ClosePositionsNonTradingHours && TradeOrAlert)
           {
            CloseAll(OP_BUY,MagicNumber);
            CloseAll(OP_SELL,MagicNumber);
            CloseAll(OP_BUY,MagicNumber);
            CloseAll(OP_SELL,MagicNumber);
           }
         return(0);
           } else {
         mycomment=StringConcatenate(mycomment," General Settings: Server Time=",Hour(),"h:",Minute(),"m. | Current server time is between trading time hours. | Trading Time is from ",TradingTimeStart," to ",TradingTimeEnd," hours");
         Comment(mycomment);
        }
     }

   // 0=Sunday,1=Monday,2=Tuesday,3=Wednesday,4=Thursday,5=Friday,6=Saturday) of the last known server time; 
   int   CloseAlltradesDay     = 5;
   
   // ClosingHour 0 to 23 & Closing Minute 0 to 59 , BOTH based on Brokers Time;    
   if(SkipFriday && (DayOfWeek()==CloseAlltradesDay && Hour()==ClosingHour+BrokerTimeOffset && Minute()>=ClosingMinute+BrokerTimeOffset))
   {
       DELETEP(Symbol(),"All"); 
       return(0);
   }

// Check if trading is possible
   if(!IsConnected())
     {
      Print("URGENT ACTION REQUIRED : There is no connection to the server!");
      if(Alerts==ShowAlerts) Alert("URGENT ACTION REQUIRED : There is no connection to the server!");

      return(0);
     }
   if(IsStopped())
     {
      Print("ERROR :Expert Advisor has been stopped");
      if(Alerts==ShowAlerts) Alert("ERROR :Expert Advisor has been stopped");

      return(0);
     }

//-- Trailing Stop----------------------------------------------------------------------------------------------------------------------
 if(UseTrailStop)
 {
 if(Open_Total < 1)
   {
     DelayTS=false;
   }
     
 	for (int cnt = 0; cnt < OrdersTotal(); cnt++)
	{
		if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES))
		{
			Print("Cannot select order");
			continue;
		}
		
		if ((OrderMagicNumber() == MagicNumber) && (OrderSymbol() == Symbol()))
		{

         if(OrderOpenTime()> LatestTradeTime)
           {
            LatestTradeTime=OrderOpenTime();
           }

         int dgts=int(MarketInfo(Symbol(),MODE_DIGITS));

			if (OrderType() == OP_SELL)
			{
            activeSell = 1;
            Open_Total++;
            Open_Sells++;

				if (TrailingStop > 0)
				{
				   if (UseHybridStop)
				      if (Ask <= NormalizeDouble(OrderOpenPrice() - StopTrailAtPips*Point*DigiMultiplier, dgts))
				         continue;
			
			      if (OrderStopLoss() != 0 && Ask < OrderStopLoss() && Ask <= NormalizeDouble(OrderOpenPrice() - TSActivationPips*Point*DigiMultiplier, dgts))		
						if (OrderStopLoss() != 0 && OrderStopLoss() > NormalizeDouble(Ask + (TrailingStep + TrailingStop)*Point*DigiMultiplier, dgts))
						{
							if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(Symbol(), Ask, NormalizeDouble(Ask + ((TrailingStep + TrailingStop)*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Red))
							{
								Print("OrderModify failed");
							}
						}
				}
			}

			if (OrderType() == OP_BUY)
			{
            activeBuy=1;
            Open_Total++;
            Open_Buys++;

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
   							if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(Symbol(), Bid, NormalizeDouble(Bid - ((TrailingStep + TrailingStop)*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Green))
   							{
   								Print("OrderModify failed");
   							}
   						}
					}
			   }
			}
			
         if (OrderType() == OP_BUYSTOP) {
            Pending_Total++;
            Pending_Buys++;
         }
         
         if (OrderType() == OP_SELLSTOP) {
            Pending_Total++;
            Pending_Sells++;
         }
		}
	}
	
 }
//--------------------------------------------------------------------------------------------------------------
//-- Awesome Stops. Fractals Trailing Stops
//--------------------------------------------------------------------------------------------------------------
 if((iFractals(Symbol(),0,MODE_LOWER,Shift) > 0) && (HighestDownFrac != iFractals(Symbol(),0,MODE_LOWER,Shift)))
  {
  HighestDownFrac = iFractals(Symbol(),0,MODE_LOWER,Shift);
  DownFracTime = TimeCurrent();
  }
 if((iFractals(Symbol(),0,MODE_UPPER,Shift) > 0) && (LowestUpFrac != iFractals(Symbol(),0,MODE_UPPER,Shift)))
  {
  LowestUpFrac = iFractals(Symbol(),0,MODE_UPPER,Shift);
  UpFracTime = TimeCurrent();
  }  
//Print(" Fracin Test ", HighestDownFrac); 
 if(UseAwesomeTrail)
  {
    if(Open_Total < 1)
    {
      DelayTS=false;
    }
      
   	for (int cnt = 0; cnt < OrdersTotal(); cnt++)
   	{
   		if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES))
   		{
   			Print("Cannot select order");
   			continue;
   		}
   		if ((OrderMagicNumber() == MagicNumber) && (OrderSymbol() == Symbol()))
   		{

            if(OrderOpenTime()> LatestTradeTime)
              {
               LatestTradeTime=OrderOpenTime();
              }
   
            int dgts=int(MarketInfo(Symbol(),MODE_DIGITS));
               		
   			if (OrderType() == OP_SELL)
   			{
               activeSell = 1;
               Open_Total++;
               Open_Sells++;

               if(UseBE &&(NormalizeDouble((Ask+(BeActivationPips*Point*DigiMultiplier)),dgts)<NormalizeDouble(OrderOpenPrice(),dgts))
                 && (NormalizeDouble((OrderOpenPrice()-(BePlusPips*Point*DigiMultiplier)),Digits )< OrderStopLoss()))
                
                 {
                  if(!OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble((OrderOpenPrice()-(BePlusPips*Point*DigiMultiplier)),dgts),0,0,Red))
                    {
                     Print("OrderModify failed");
                    }
                 }

   			   if (UseHybridStop)
   			      if (Ask > NormalizeDouble(OrderOpenPrice() - ActivationPips*Point*DigiMultiplier, dgts))
   			         continue;			
   			
   			   if (Ask <= OrderOpenPrice() && Ask <= NormalizeDouble(LowestUpFrac + (TrailingStop*Point*DigiMultiplier), dgts))
   			      if(UpFracTime > OrderOpenTime() + Shift * 60)
         				if (OrderStopLoss() !=0 && OrderStopLoss() > NormalizeDouble(LowestUpFrac + (TrailingStop*Point*DigiMultiplier), dgts))
         				{
         					Print("Lowest Up Frac  ", LowestUpFrac);
         					if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(Symbol(), Ask, NormalizeDouble(LowestUpFrac + (TrailingStop*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Red))
         					{
         						Print("OrderModify failed");
         					}
         				}
   			}
   
   			if (OrderType() == OP_BUY)
   			{
               activeBuy=1;
               Open_Total++;
               Open_Buys++;
               
               if(UseBE &&(NormalizeDouble((Bid-(BeActivationPips*Point*DigiMultiplier)),dgts)>NormalizeDouble(OrderOpenPrice(),dgts))
                 && (NormalizeDouble((OrderOpenPrice()+(BePlusPips*Point*DigiMultiplier)),Digits)> OrderStopLoss()))
                  {
                  if(!OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble((OrderOpenPrice()+(BePlusPips*Point*DigiMultiplier)),dgts),0,0,Green))
                    {
                     Print("OrderModify failed");
                    }
                  }
               
   			   if (UseHybridStop)
   			      if (Bid < NormalizeDouble(OrderOpenPrice() + ActivationPips*Point*DigiMultiplier, dgts))
   			         continue;
   			
   			   if (Bid >= OrderOpenPrice() && Bid >= NormalizeDouble(HighestDownFrac - (TrailingStop*Point*DigiMultiplier), dgts))
   			      if(DownFracTime > OrderOpenTime() + Shift * 60)
         				if (OrderStopLoss() !=0 && OrderStopLoss() < NormalizeDouble(HighestDownFrac - (TrailingStop*Point*DigiMultiplier), dgts))
         				{
         					Print("Highest Down Frac  ", HighestDownFrac);
         					if (!OrderModify(OrderTicket(), OrderOpenPrice(), CheckStopLoss(Symbol(), Bid, NormalizeDouble(HighestDownFrac - (TrailingStop*Point*DigiMultiplier), dgts)), OrderTakeProfit(), 0, Red))
         					{
         						Print("OrderModify failed");
         					}
         				}
   			}
   			
            if (OrderType() == OP_BUYSTOP) {
               Pending_Total++;
               Pending_Buys++;
            }
            
            if (OrderType() == OP_SELLSTOP) {
               Pending_Total++;
               Pending_Sells++;
            } 

   		}
   	}
	
  }

//-- Reset Conditions ----------------------------------------------------------------------------------------------------------

   if((iBars(Symbol(),PERIOD_CURRENT)>MBars) )
      {
      
         IsNewBar = true;
         BuyCond1=false;
         SellCond1= false;
         BuyCond2 = false;
         SellCond2= false;
         flag1  = false;
         flag2  = false;
         flag3  = false;
         CancelledByTime=false;
         Strategy1TradedThisBar=false;
         MinSpikeAchieved=false;
         MBars = iBars(Symbol(),PERIOD_CURRENT);
         DelayTS = false;
         TradesThisBar=0;
         BuysThisBar=0;
         SellsThisBar=0;
         TimeStamp = TimeCurrent();  
     }
  if((iBars(Symbol(),PERIOD_H1)>HBars) )
     {
      HBars = iBars(Symbol(),PERIOD_H1);
      Print("Orders Total  ", OrdersTotal());
      Print("Open_Total  ",Open_Total); 
      Print("Open_Buys  ",Open_Buys);   
      Print("Open_Sells  ",Open_Sells);
      Print("Pending_Total  ", Pending_Total);
      Print("Pending_Sells  ", Pending_Sells);
      Print("Pending_Buys  ", Pending_Buys); 
      //DELETEP(Symbol(),"All");  
     }
  if((iBars(Symbol(),PERIOD_D1)>DBars) )
     {
      DBars = iBars(Symbol(),PERIOD_D1);
      IsNewDay = true;
     }

Spread=NormalizeDouble(((Ask-Bid)/Point/DigiMultiplier),1);

//-- Average Spread for the last 30 ticks-----------------------------------------------------------------------------------------------------
if(!SpeedCode)
  {
   double sumofspreads;
   int loopcount1;
   int loopcount2;
   ArrayCopy(Array_spread,Array_spread,0,1,29);
   Array_spread[29]=Spread;
   if(UpTo30Counter<30)
      UpTo30Counter++;
   sumofspreads=0;
   loopcount2=29;
   for(loopcount1=0; loopcount1<UpTo30Counter; loopcount1++)
     {
      sumofspreads+=Array_spread[loopcount2];
      loopcount2 --;
     }
   avgspread=sumofspreads/UpTo30Counter;
   
   SpreadAvg = NormalizeDouble(avgspread,1);
   }else{
   SpreadAvg = Spread;
   }
//--- Spread Filters For Pending Orders-------------------------------------------------------------------------------------------------------
 if((SpreadAvg > MaxAvgSpread) && (Pending_Total > 0))
 {
    DELETEP(Symbol(),"All");
    DELETEP(Symbol(),"All");
    Print("Pending Orders Deleted Due to HIGH SPREAD. Average Spread :   ", DoubleToStr(SpreadAvg,1));
 }
 if((Spread > MaxCurSpread) && (Pending_Total > 0))
 {
    DELETEP(Symbol(),"All");
    DELETEP(Symbol(),"All");
    Print("Pending Orders Cancelled Due to HIGH SPREAD. Current Spread :   ", DoubleToStr(Spread,1));
 }
 /*
 if(TimeCurrent() > iTime(Symbol(),PERIOD_CURRENT,0)+30)
 {
    DELETEP(Symbol(),"All");
    DELETEP(Symbol(),"All");
    Print("Time Delete Test :   ", DoubleToStr(Spread,1));
 }
*/
//--------------------------------------------------------------------------------------------------------------------------------------  
   
   //--
   datetime CurrentTime;//    = TimeCurrent();
   datetime OpenTime = Time[0];
   
   if (UseLocalTime)
   {
       CurrentTime = TimeLocal();
   }else{
       CurrentTime = TimeCurrent();
   }
   if((Open_Total==0) && (TimeCurrent()>(PauseStamp+PauseSeconds)))
     {
      PauseStamp=0;
      ClearToTrade=true;
     }
  OutOfRange = true;  
//----------------------------------------------------------------------------------------------------------------------------------------
//-- Modify Pending 
//----------------------------------------------------------------------------------------------------------------------------------------

   if((Bid < NormalizeDouble(BidStamp + ((DriftAllowed/2)*Point*DigiMultiplier),Digits))&&(Bid > NormalizeDouble(BidStamp - ((DriftAllowed/2)*Point*DigiMultiplier),Digits)))
       {
       OutOfRange = false;
       }
       else
       {
       OutOfRange = true;
       BidStamp = Close[1];
       }
if(  OutOfRange) {

   for(int cnt=0; cnt<OrdersTotal(); cnt++) 
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
        {
         Print("Cannot select order");
         return(0);
        }
      if((OrderMagicNumber() == MagicNumber)&&(OrderSymbol()==Symbol()) )
        {
         
         

         int dgts=int(MarketInfo(Symbol(),MODE_DIGITS));

         if(OrderType()==OP_SELLSTOP) 
           {
          // Print("Expiration  ",OrderExpiration());
           double PriceSell = NormalizeDouble(Close[1],Digits);
           double PriceSellOffset = NormalizeDouble(PriceSell-(Offset*Point*DigiMultiplier),Digits);
           expiration = 0;
         if(InitialStopLoss>0 ) 
           {
            //To do: Verify stop loss is valid
            SL2=NormalizeDouble((PriceSellOffset+(InitialStopLoss*Point*DigiMultiplier)),Digits);

           }
         if((InitialStopLoss==0) && (TrailingStop>0))
           {
            //To do: Verify stop loss is valid
            SL2=NormalizeDouble((PriceSellOffset+(TrailingStop*Point*DigiMultiplier)),Digits);

           } 

         if(TargetProfit>0) 
           {
            //To do :Verify take profit are valid
            TargetProfit=NormalizeDouble((PriceSellOffset-(TargetProfit*Point*DigiMultiplier)),Digits);

           }
               if(TempClose != Close[1])
                 {
                  if(!OrderModify(OrderTicket(),PriceSellOffset,SL2,TargetProfit,expiration,CLR_NONE))
                    {
                     Print("OrderModify failed3");
                    }
                 TempClose = Close[1];
                 }
              
           }

         if(OrderType()==OP_BUYSTOP) 
           {
         //  Print("Expiration  ",OrderExpiration());
           double PriceBuy = NormalizeDouble((Close[1]+(Ask-Bid)),Digits);//++5 digits
           double PriceBuyOffset=NormalizeDouble(PriceBuy+(Offset*Point*DigiMultiplier),Digits);//++5 digits
           expiration = 0;
         if(InitialStopLoss>0) 
           {
            //To do : Verify stop loss if valid
            SL2=NormalizeDouble((PriceBuyOffset-(InitialStopLoss*Point*DigiMultiplier)),Digits);

           }
         if(((InitialStopLoss==0) && (TrailingStop>0)) ) 
           {
            //To do: Verify stop loss is valid
            SL2=NormalizeDouble((PriceBuyOffset-(TrailingStop*Point*DigiMultiplier)),Digits);

           } 

         if(TargetProfit>0) 
           {
            //Todo : Verify take profit is valid
            TargetProfit=NormalizeDouble((PriceBuyOffset+(TargetProfit*Point*DigiMultiplier)),Digits);

           }
               if(TempClose2 != Close[1])
                 {
                  if(!OrderModify(OrderTicket(),PriceBuyOffset,SL2,TargetProfit,expiration,CLR_NONE))
                    {
                     Print("OrderModify failed4");
                    }
                  TempClose2 = Close[1];
                  }
              
           }
           
          
        }
     }
    
 }

//-- Initial entry logic ---------------------------------------------------------------------------------------------------------------
   BuyS1 = false;
   BuyS2 = false;
   BuyS3 = false;
   SellS1 = false;
   SellS2 = false;
   SellS3 = false;

   RefreshRates();
   double high  = iHigh(NULL,PERIOD_CURRENT,1);
   double low   = iLow(NULL,PERIOD_CURRENT,1);
   double open  = iOpen(NULL,PERIOD_CURRENT,0);
   double close = iClose(NULL,PERIOD_CURRENT,1);

   double PriceBuy = NormalizeDouble((close+(Ask-Bid)),Digits);//++5 digits
   double PriceBuyOffset=NormalizeDouble(PriceBuy+(Offset*Point*DigiMultiplier),Digits);//++5 digits
   double PriceBuyOffset2=NormalizeDouble(PriceBuy+(Offset*Point*DigiMultiplier)-(DriftAllowed*Point*DigiMultiplier),Digits);//++5 digits
   
   double PriceSell = NormalizeDouble(close,Digits);
   double PriceSellOffset = NormalizeDouble(PriceSell-(Offset*Point*DigiMultiplier),Digits);
   double PriceSellOffset2 = NormalizeDouble(PriceSell-(Offset*Point*DigiMultiplier)+(DriftAllowed*Point*DigiMultiplier),Digits);

   //---------------------------------------------- 
         if((Pending_Buys < 1)
          &&(BuysThisBar < 1)
          &&(Open_Total < MaxPositions)
          )
           {
            if( (Spread <= MaxCurSpread)
             && (SpreadAvg <= MaxAvgSpread)
             
              )
               {
                if(InitialStopLoss == 0 && UseTrailStop)
                  {
                     SL2 = TrailingStop;
                  }else{
                     SL2 = InitialStopLoss;
                  }
                  Print("Expiration  ",OrderExpiration());
                  double lots=CalculateLots();
                  BuyCond1=true;
                  TradesThisBar++;
                  BuysThisBar++;
                  IsNewDay = false;
                  BidStamp = Close[1];
                  //if(Ask >= PriceSellOffset)
                  //   BUY(Symbol(),CalculateLots(),TargetProfit,SL2,0,TradeTag,BuyColor);
                //--  BUYP(Symbol(),Offset,CalculateLots(),TargetProfit,InitialStopLoss,100,TradeTag);
                  BUYP(Symbol(),Offset,CalculateLots(),TargetProfit,SL2,ExpSeconds,TradeTag);
                  Print("Current Spread: ",DoubleToStr(Spread,1),"  Average Spread: ",DoubleToStr(SpreadAvg,1));
               }else{
                  Print(" Spread is too high. BUY Trade filtered. ");
                  Print("Current Spread: ",DoubleToStr(Spread,1),"  Average Spread: ",DoubleToStr(SpreadAvg,1),"  Current BID:  ",DoubleToStr(Bid,Digits),"  Current ASK:  ",DoubleToStr(Ask,Digits));
               }
            }
   //-------------------------------------------------    
        if((Pending_Sells < 1)
         &&(SellsThisBar < 1)
         &&(Open_Total < MaxPositions)
         )
          {
           if( (Spread <= MaxCurSpread) 
            && (SpreadAvg <= MaxAvgSpread) 
            
             )
               { 
                if(InitialStopLoss == 0 && UseTrailStop)
                  {
                     SL2 = TrailingStop;
                  }else{
                     SL2 = InitialStopLoss;
                  }
                  Print("Expiration  ",OrderExpiration());
                  double lots=CalculateLots();
                  SellCond1=true;
                  TradesThisBar++;
                  SellsThisBar++;
                  IsNewDay = false;
                  BidStamp = Close[1];
                  //if(Bid <= PriceSellOffset)
                  //   SELL(Symbol(),CalculateLots(),TargetProfit,SL2,0,TradeTag,SellColor);
                  SELLP(Symbol(),Offset,CalculateLots(),TargetProfit,SL2,ExpSeconds,TradeTag);
                //--  SELLP(Symbol(),Offset,CalculateLots(),TargetProfit,InitialStopLoss,100,TradeTag);
                  Print("Current Spread: ",DoubleToStr(Spread,1),"  Average Spread: ",DoubleToStr(SpreadAvg,1)); 
               }else{
                  Print(" Spread is too high. SELL Trade filtered. ");
                  Print("Current Spread: ",DoubleToStr(Spread,1),"  Average Spread: ",DoubleToStr(SpreadAvg,1),"  Current BID:  ",DoubleToStr(Bid,Digits),"  Current ASK:  ",DoubleToStr(Ask,Digits));
               } 
            }
         //  }
        
      //-- Initiate Trades ---------------------------------------------------------------------------------------------------------------
      
        
         
        
        
         
// Handle Pending Orders ---------------------------------------------------------------------------------------------------------------
/*
   if ((!TradingAllowed)&& Pending_Total > 0)
   {
	DELETEP(Symbol(),"All");
	}
*/
/*
	if (UseOco) 
	{ // if after news and within wait time and we are using one cancels other
		if (OrdersCondition==1001) { // if we have a buy and a sell stop
			Print("BUY Filled. SELL Cancelled");
			//DeleteSellStop();
			DELETEP(Symbol(),"SELLP");
		}
		if (OrdersCondition==110) { // if we have a sell and a buy stop
			Print("SELL Filled. BUY Cancelled");
			//DeleteBuyStop();
			DELETEP(Symbol(),"BUYP");
		}
	}
*/
/*
	if (CurrentTime > OpenTime && CurrentTime > (OpenTime+MaxFillTime)) 
	{ // if after news and after wait time 
		if (OrdersCondition==11) { // if we have a buy stop and a sell stop
			Print("Orders Cancelled. Max Fill Time expired");
			
			DELETEP(Symbol(),"All");
		}
		if (OrdersCondition==1 || OrdersCondition==1001) { // if we have a sell stop or a buy and a sell stop
			Print("SELL Order Cancelled. Max Fill Time expired");
			DELETEP(Symbol(),"SELLP");
		}
		if (OrdersCondition==10 || OrdersCondition==110) { // if we have a buy stop or a sell and a buy stop
			Print("BUY Order Cancelled. Max Fill Time expired");
			DELETEP(Symbol(),"BUYP");
		}
	}
   */   
     
//-- End Trading Code            
   if(!SpeedCode)
    {    
      UpdateLabels();
    }
   IsNewBar = false;
   return(0);
  }
//+-- End Start. Functions below ----------------------------------------------------------------+
int EdgeAlert(string condition,string sygnaltype,string mypair)
  {

   Print("Alert:",sygnaltype);
   Alert("Alert:",sygnaltype);
   if(EnableAudibleAlerts) PlaySound(MySound);
   return(0);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int BUY(string symbol_b,double lotsize_b,double takeprofit_b,double stoploss_b,double trailings_b,string condition_b,color TradeColor)
  {
   if(!Hedge) CloseAllPositions(symbol_b,OP_SELL,MagicNumber);
   if(ECN_Friendly)
     {
      (ExecuteOrderinTwo(OP_BUY,symbol_b,lotsize_b,
       stoploss_b,takeprofit_b,condition_b,MagicNumber,TradeColor,condition_b));
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int SELL(string symbol_s,double lotsize_s,double takeprofit_s,double stoploss_s,double trailings_s,string condition_s,color TradeColor)
  {
   if(!Hedge) CloseAllPositions(symbol_s,OP_BUY,MagicNumber);
   if(ECN_Friendly)
     {
      (ExecuteOrderinTwo(OP_SELL,symbol_s,lotsize_s,
       stoploss_s,takeprofit_s,condition_s,MagicNumber,TradeColor,condition_s));
     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CLOSELONG(string symbol_c)
  {
   CloseAllPositions(symbol_c,OP_BUY,MagicNumber);
   CloseAllPositions(symbol_c,OP_BUY,MagicNumber);
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CLOSESHORT(string symbol_c)
  {
   CloseAllPositions(symbol_c,OP_SELL,MagicNumber);
   CloseAllPositions(symbol_c,OP_SELL,MagicNumber);
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EnoughMoney(string symbol_em,double lotsize_em)
  {
   if(( AccountFreeMarginCheck(symbol_em,OP_BUY,lotsize_em)<10) || 
      (AccountFreeMarginCheck(symbol_em,OP_SELL,lotsize_em)<10) || 
      (GetLastError()==134))
     {
      Print("NOT ENOUGH MONEY TO TRADE. Free margin is insufficient to trade a lot size of ",lotsize_em,". Current Free Margin=",AccountFreeMargin());
      Alert("NOT ENOUGH MONEY TO TRADE. Free margin is insufficient to trade a lot size of ",lotsize_em,". Current Free Margin=",AccountFreeMargin());
      return(false);
        } else {
      return(true);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ExecuteOrderinTwo(int ordertype_bn,string symbol_bn,double lotsize_bn,double stoploss_bn,double takeprofit_bn,string comment_bn,int magic_bn,color ordercolor_bn,string condition_bn) //1 is ok, -1 is not ok
{

   int errorcode_ts=0;
   int my_ticket=ExecuteOrder(ordertype_bn,symbol_bn,lotsize_bn,0,0,
                              comment_bn,magic_bn,ordercolor_bn,condition_bn);
   if(my_ticket>0 && (stoploss_bn!=0 || takeprofit_bn!=0))
   {
      if(OrderSelect(my_ticket,SELECT_BY_TICKET))
      {
         //adjusting TP/SL if needed
         RefreshRates();
         int digits_bn;
         double points_bn,price_bn;
         bool golong_bn;
         digits_bn=int(MarketInfo(symbol_bn,MODE_DIGITS));
         points_bn=MarketInfo(symbol_bn,MODE_POINT);
         //stoploss_bn=stoploss_bn*10;
         //takeprofit_bn=takeprofit_bn*10;
         stoploss_bn=stoploss_bn*PipMultiplier;
         takeprofit_bn=takeprofit_bn*PipMultiplier;

         switch(ordertype_bn)
           {
            case OP_BUY:
               golong_bn=true;
               break;
            case OP_SELL:
               golong_bn=false;
               break;
            default:
               Print("ERROR : Wrong order type. Cannot add SL/TP ",ordertype_bn);
               return(-1);
               break;
           }

         if(golong_bn)
         {
            price_bn=NormalizeDouble(MarketInfo(symbol_bn,MODE_ASK),digits_bn);
            if(stoploss_bn>0)
              {
               stoploss_bn = NormalizeDouble(price_bn-stoploss_bn*points_bn, digits_bn);
               stoploss_bn = CheckStopLoss(symbol_bn, price_bn, stoploss_bn);
              }
            if(takeprofit_bn>0)
              {
               takeprofit_bn= NormalizeDouble(price_bn+takeprofit_bn*points_bn,digits_bn);
               takeprofit_bn= CheckTakeProfit(symbol_bn,price_bn,takeprofit_bn);
              }
          } else {  // go short set up
            price_bn=NormalizeDouble(MarketInfo(symbol_bn,MODE_BID),digits_bn);
            if(stoploss_bn>0)
              {
               stoploss_bn = NormalizeDouble(price_bn+stoploss_bn*points_bn, digits_bn);
               stoploss_bn = CheckStopLoss(symbol_bn, price_bn, stoploss_bn);
              }
            if(takeprofit_bn>0)
              {
               takeprofit_bn= NormalizeDouble(price_bn-takeprofit_bn*points_bn,digits_bn);
               takeprofit_bn= CheckTakeProfit(symbol_bn,price_bn,takeprofit_bn);
              }
           }//closes if go long  	   
         //modify order, adds TP/SL
         if(OrderModify(my_ticket,OrderOpenPrice(),stoploss_bn,takeprofit_bn,0,ordercolor_bn))
         {
            Print("Step 2 - TP/SL added. SL=",stoploss_bn," TP=",takeprofit_bn);
         }else {
            errorcode_ts=GetLastError();
            Print("Could not add SL/TP to order. Error:",errorcode_ts," ",ErrorDescription(errorcode_ts));
         }
       } else {//closes if order select 
         errorcode_ts=GetLastError();
         Print("Could not select order. Error:",errorcode_ts," ",ErrorDescription(errorcode_ts));
       }
   }//closes if my_ticket >0
   return(1);
}
//ExecuteOrder opens a new position

int ExecuteOrder(int ordertype_bn,string symbol_bn,double lotsize_bn,double stoploss_bn,double takeprofit_bn,string comment_bn,int magic_bn,color ordercolor_bn,string condition_bn) //Returns ticket, -1 is not ok
  {
   int digits_bn;
   double points_bn;
   double price_bn;
   int ticket_bn;
   bool golong_bn;
   int errorcode_bn;
   int retrynumber_bn=1;

   stoploss_bn=stoploss_bn*PipMultiplier;
   takeprofit_bn=takeprofit_bn*PipMultiplier;

//Set ordertype boolean
   switch(ordertype_bn)
     {
      case OP_BUY:
         golong_bn=true;
         break;
      case OP_SELL:
         golong_bn=false;
         break;
      default:
         Print("ERROR : Wrong order type ",ordertype_bn);
         return(-1);
         break;
     }

//check open positions
   if(CalculateOpenPositions(symbol_bn,ordertype_bn,magic_bn)>=MaxPositions)
     {
      Print("Warning : Cannot execute new ",OrderTypetoString(ordertype_bn)," order for Symbol ",symbol_bn,". Maximum number of ",MaxPositions," open positions reached.");
      return(0);
     }

// Check if there is enough money to close the position
   if(!EnoughMoney(symbol_bn,lotsize_bn))
     {
      Print("ERROR : Not enough money to open position!");  
      //Alert("ERROR : Not enough money to open position!");
      return(-1);
     }

//Gets pair info to prepare price 

   digits_bn = int(MarketInfo(symbol_bn, MODE_DIGITS));
   points_bn = MarketInfo(symbol_bn, MODE_POINT);
   if(UseRiskRatio)
     {
      //adjust sl to tp/riskratio
      stoploss_bn=NormalizeDouble(takeprofit_bn/RiskRatio,digits_bn);
      //Print("Stop loss adjusted according to risk ratio, equation TargetProfit/InitialStopLoss=",RiskRatio,". SL=Price +/- ", stoploss_bn*points_bn,".");
     }

//adjust lot 
   int tmpdecimal=1;
   if(Micro_Account)
     {
      tmpdecimal=2;
     }
   double old_lot=lotsize_bn;
   if((NormalizeDouble(AccountFreeMargin()*(MaximumPercentageatRisk/100)/1000.0,tmpdecimal)<lotsize_bn) && UseMaximumPercentageatRisk)
     {
      lotsize_bn=NormalizeDouble(AccountFreeMargin()*(MaximumPercentageatRisk/100)/1000.0,tmpdecimal);
      if(lotsize_bn<MarketInfo(symbol_bn,MODE_MINLOT))
        {
         lotsize_bn=MarketInfo(symbol_bn,MODE_MINLOT);
         Print("Lot adjusted from ",old_lot," to minimum size allowed by the server of ",lotsize_bn," but it DOES NOT comply with Maximum Risk condition. User interaction is required!");
           } else {
         Print("Lot adjusted from ",old_lot," to ",lotsize_bn," to comply with Maximum Risk condition. Each trade can risk only ",MaximumPercentageatRisk,"% of free margin.");
        }
     }

   while(retrynumber_bn>0)
     {
      RefreshRates();

      // go long set up

      if(golong_bn)
        {
         price_bn=NormalizeDouble(MarketInfo(symbol_bn,MODE_ASK),digits_bn);

         if(stoploss_bn>0)
           {
            //Verify stop loss if valid

            stoploss_bn = NormalizeDouble(price_bn-stoploss_bn*points_bn, digits_bn);
            stoploss_bn = CheckStopLoss(symbol_bn, price_bn, stoploss_bn);

           }

         if(takeprofit_bn>0)
           {
            //Verify take profit is valid
            takeprofit_bn= NormalizeDouble(price_bn+takeprofit_bn*points_bn,digits_bn);
            takeprofit_bn= CheckTakeProfit(symbol_bn,price_bn,takeprofit_bn);

           }

           } else {  // go short set up
         price_bn=NormalizeDouble(MarketInfo(symbol_bn,MODE_BID),digits_bn);

         if(stoploss_bn>0)
           {
            //Verify stop loss is valid
            stoploss_bn = NormalizeDouble(price_bn+stoploss_bn*points_bn, digits_bn);
            stoploss_bn = CheckStopLoss(symbol_bn, price_bn, stoploss_bn);

           }

         if(takeprofit_bn>0)
           {
            //Verify take profit are valid
            takeprofit_bn= NormalizeDouble(price_bn-takeprofit_bn*points_bn,digits_bn);
            takeprofit_bn= CheckTakeProfit(symbol_bn,price_bn,takeprofit_bn);

           }

        }
      // Verify order execution
      if(!isTradingPossible())
        {
         Print("Warning: Trading may not be possible. Trying to open a new position.");
        }
      ticket_bn=OrderSend(symbol_bn,ordertype_bn,lotsize_bn,price_bn,Slippage,stoploss_bn,takeprofit_bn,comment_bn,magic_bn,0,ordercolor_bn);
      if(ticket_bn>=0)
        {
         Sleep(SleepTime);
         if(OrderSelect(ticket_bn,SELECT_BY_TICKET))
           {


            if(EnableAudibleAlerts) PlaySound(MySound);
            return(ticket_bn);
           }
           } else {
         errorcode_bn=GetLastError();
         // Retry if server is busy
         if(errorcode_bn==ERR_SERVER_BUSY || errorcode_bn==ERR_TRADE_CONTEXT_BUSY || errorcode_bn==ERR_BROKER_BUSY || errorcode_bn==ERR_NO_CONNECTION
            || errorcode_bn==ERR_TRADE_TIMEOUT || errorcode_bn==ERR_INVALID_PRICE || errorcode_bn==ERR_OFF_QUOTES || errorcode_bn==ERR_PRICE_CHANGED || errorcode_bn==ERR_REQUOTE)
           {
            Print("ERROR: Server error. Sending order to server again. Retry intent number = ",retrynumber_bn);
            retrynumber_bn++;
            if(retrynumber_bn>Max_Order_Retry+1)
              {
               Print("ERROR: Could not open new position. Error=",errorcode_bn," ",ErrorDescription(errorcode_bn),". Order Info : Order Type=",OrderTypetoString(ordertype_bn),". Symbol=",symbol_bn,". Lot Size=",lotsize_bn,
                     ". Price=",price_bn,". SL=",stoploss_bn,". TP=",takeprofit_bn);
               Alert("ERROR: Could not open new position. Error=",errorcode_bn," ",ErrorDescription(errorcode_bn),". Order Info : Order Type=",OrderTypetoString(ordertype_bn),". Symbol=",symbol_bn,". Lot Size=",lotsize_bn,
                     ". Price=",price_bn,". SL=",stoploss_bn,". TP=",takeprofit_bn);
               return (-1);
              }
            Sleep(SleepTime);
              } else {
            Print("ERROR: Could not open new position. Error=",errorcode_bn," ",ErrorDescription(errorcode_bn),". Order Info : Order Type=",OrderTypetoString(ordertype_bn),". Symbol=",symbol_bn,". Lot Size=",lotsize_bn,
                  ". Price=",price_bn,". SL=",stoploss_bn,". TP=",takeprofit_bn);
            Alert("ERROR: Could not open new position. Error=",errorcode_bn," ",ErrorDescription(errorcode_bn),". Order Info : Order Type=",OrderTypetoString(ordertype_bn),". Symbol=",symbol_bn,". Lot Size=",lotsize_bn,
                  ". Price=",price_bn,". SL=",stoploss_bn,". TP=",takeprofit_bn);

            if(errorcode_bn==ERR_INVALID_STOPS)
              {
              Print("ERROR: Invalid Stops  ");
              }

            return (-1);
           }
        }
     } //close while          
   return(1);
  }
//Lot Management changes lot size. Part of money management


//CalculateOpenPositions returs the number of positions

int CalculateOpenPositions(string symbol,int ordertype,int magicn)
  {
   int sells=0;
   int buys=0;

   int sellstop=0;
   int buystop=0;

   bool magiccond=true;
//verify type is ok
   if(ordertype==OP_BUY || ordertype==OP_SELL || ordertype==OP_SELLSTOP || ordertype==OP_BUYSTOP)
     {
      //ok 
        } else {
      // Print("Cannot calculate open positions. Order type is wrong.");
      // Alert("Cannot calculate open positions. Order type is wrong.");
      return(-1);
     }
//----
   int orderstotal=OrdersTotal();
   for(int i=0;i<orderstotal;i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) continue;
      if(magicn==0)
        {
         magiccond=true;
           } else {
         if(OrderMagicNumber()==magicn)
           {
            magiccond=true;
              } else {
            magiccond=false;
           }

        }

      if((OrderSymbol()==symbol) && (magiccond))
        {

         if(OrderType()==OP_SELL) sells++;
         if(OrderType()==OP_BUY) buys++;

         if(OrderType()==OP_SELLSTOP) sellstop++;
         if(OrderType()==OP_BUYSTOP) buystop++;

        }
     }
//---- return number of orders
   if(ordertype==OP_SELL) return(sells);
   if(ordertype==OP_BUY) return(buys);

   if(ordertype==OP_SELLSTOP) return(sellstop);
   if(ordertype==OP_BUYSTOP) return(buystop);

   return(-1);
  }
//This function Returs the string value of the order type

string OrderTypetoString(int ordertypecode)
  {
   if(ordertypecode==OP_BUY)
      return("OP_BUY");

   if(ordertypecode==OP_SELL)
      return("OP_SELL");

   if(ordertypecode==OP_BUYSTOP)
      return("OP_BUYSTOP");

   if(ordertypecode==OP_SELLSTOP)
      return("OP_SELLSTOP");

   if(ordertypecode==OP_BUYLIMIT)
      return("OP_BUYLIMIT");

   if(ordertypecode==OP_SELLLIMIT)
      return("OP_SELLLIMIT");

   return("Unknow order type");
  }
//This function closes all market positions for all pairs.

int CloseAll(int ordertypeclose,int magicclose)
  {
   int cnt;
   int err;
   int retrynumberclose=0;
   double priceclose;
   bool magiccond=true;
//verify type is ok
   if(ordertypeclose==OP_BUY || ordertypeclose==OP_SELL)
     {
      //ok 
        } else {
      Print("Closing all positions failed. Order type is wrong.");
      Alert("Closing all positions failed. Order type is wrong.");
      return(-1);
     }

   int orderstotal=OrdersTotal();
   bool loopcl=true;
   while(loopcl)
     {
      loopcl=false;
      orderstotal=OrdersTotal();
      for(cnt=0;cnt<orderstotal;cnt++)
        {
         if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)) //executes if gets valid order
           {

            if(magicclose==0)
              {
               magiccond=true;
                 } else {
               if(OrderMagicNumber()==magicclose)
                 {
                  magiccond=true;
                    } else {
                  magiccond=false;
                 }

              }
            if(OrderType()==ordertypeclose && magiccond)
              {
               //get closing price
               RefreshRates();
               if(OrderType()==OP_BUY) priceclose=MarketInfo(OrderSymbol(),MODE_BID);
               else priceclose=MarketInfo(OrderSymbol(),MODE_ASK);
               if(!isTradingPossible())
                 {
                  Print("Warning: Trading may not be possible. Trying to close orders.");
                 }
               if(OrderClose(OrderTicket(),OrderLots(),priceclose,Slippage,Violet)) // close position
                 {
                  Print("Order Closed. Symbol:",OrderSymbol(),". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Closed at price:",OrderClosePrice(),". Position was opened at price:",OrderOpenPrice()," Profit:",OrderProfit());

                  loopcl=true;
                  retrynumberclose=1;
                  break; //break loop and restart again
                    }else {
                  err=GetLastError();
                  Print("Closing Order failed. Symbol:",OrderSymbol(),". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Error:",err," ",ErrorDescription(err));
                  Alert("Closing Order failed. Symbol:",OrderSymbol(),". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Error:",err," ",ErrorDescription(err));

                  loopcl=true;
                  retrynumberclose++;
                  break; //break loop and restart again
                 }

              }

           }
        }//for
      if(retrynumberclose>Max_Order_Retry+10)
        {
         Print("Halting. Too many errors when closing positions. Symbol:",OrderSymbol());
         Print("URGENT:Please verify your Internet Connection and Server response.");
         Alert("Halting. Too many errors when closing positions. Symbol:",OrderSymbol());
         Alert("URGENT:Please verify your Internet Connection and Server response.");
         return(-1);
        }
     }//while

   return(0);
  }
//This function closes all market positions.

int CloseAllPositions(string symbolclose,int ordertypeclose,int magicclose)
  {
//Print("Closing all positions started...");
   int cnt;
   int err;
   int retrynumberclose=0;
   double priceclose;
   bool magiccond=true;
//verify type is ok
   if(ordertypeclose==OP_BUY || ordertypeclose==OP_SELL)
     {
      //ok 
        } else {
      Print("Closing all positions failed. Order type is wrong.");
      Alert("Closing all positions failed. Order type is wrong.");
      return(-1);
     }

//Print("Closing all positions (",symbolclose,",",OrderTypetoString(ordertypeclose),",",magicclose,")");
   int orderstotal=OrdersTotal();
   bool loopcl=true;
   while(loopcl)
     {
      loopcl=false;
      orderstotal=OrdersTotal();
      for(cnt=0;cnt<orderstotal;cnt++)
        {
         if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)) //executes if gets valid order
           {

            if(magicclose==0)
              {
               magiccond=true;
                 } else {
               if(OrderMagicNumber()==magicclose)
                 {
                  magiccond=true;
                    } else {
                  magiccond=false;
                 }

              }
            if((OrderType()==ordertypeclose) && (OrderSymbol()==symbolclose) && (magiccond))
              {
               //get closing price
               RefreshRates();
               if(ordertypeclose==OP_BUY) priceclose=MarketInfo(symbolclose,MODE_BID);
               else priceclose=MarketInfo(symbolclose,MODE_ASK);
               if(!isTradingPossible())
                 {
                  Print("Warning: Trading may not be possible. Trying to close orders.");
                 }
               if(OrderClose(OrderTicket(),OrderLots(),priceclose,Slippage,Violet)) // close position
                 {
                  Print("Order Closed. Symbol:",symbolclose,". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Closed at price:",OrderClosePrice(),". Position was opened at price:",OrderOpenPrice()," Profit:",OrderProfit());

                  loopcl=true;
                  retrynumberclose=1;
                  break; //break loop and restart again
                    }else {
                  err=GetLastError();
                  Print("Closing Order failed. Symbol:",symbolclose,". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Error:",err," ",ErrorDescription(err));
                  Alert("Closing Order failed. Symbol:",symbolclose,". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Error:",err," ",ErrorDescription(err));

                  loopcl=true;
                  retrynumberclose++;
                  break; //break loop and restart again
                 }

              }

           }
        }//for
      if(retrynumberclose>Max_Order_Retry+10)
        {
         Print("Halting. Too many errors when closing positions. Symbol:",symbolclose);
         Print("URGENT:Please verify your Internet Connection and Server response.");
         Alert("Halting. Too many errors when closing positions. Symbol:",symbolclose);
         Alert("URGENT:Please verify your Internet Connection and Server response.");
         return(-1);
        }
     }//while
//Print("Closing all positions finished. (",symbolclose,",",OrderTypetoString(ordertypeclose),",",magicclose,")");
   return(0);
  }
//This function check if trading is possible.

bool isTradingPossible()
  {
//Check if trading is possible
   bool tmpresponse=true;
   if(!IsConnected())
     {
      Print("URGENT ACTION REQUIRED : There is no connection to the server!");
      if(Alerts==ShowAlerts) Alert("URGENT ACTION REQUIRED : There is no connection to the server!");
      tmpresponse=false;
     }
   if(IsStopped())
     {
      Print("ERROR :Expert Advisor has been stopped");
      if(Alerts==ShowAlerts) Alert("ERROR :Expert Advisor has been stopped");
      tmpresponse=false;
     }

   return(tmpresponse);
  } //end function
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CheckStopLoss(string symbol_sl,double price_sl,double sl)
 
  {
  if(TrailingStop >0)
   {
   Trailing_Stop2 = TrailingStop*DigiMultiplier;
   }
   if(AutoAdjustTPSL)
     { //executes when AutoAdjustTPSL is set to true
      double minimumstop;
      if(sl==0)
        { // no stop loss
         return(sl);
        }
      minimumstop=MarketInfo(symbol_sl,MODE_STOPLEVEL)*Point;
     // Print("Minimum stop loss allowed (Points) = ",minimumstop/Point);
      if(MathAbs(price_sl-sl)<=minimumstop)
        {
         //move to a higher stop that assure execution
         //for longs
         if(price_sl>sl)
           {
            sl=price_sl-minimumstop+Trailing_Stop2;
              } else if(price_sl<sl) {
            //for shorts
            sl=price_sl+minimumstop+Trailing_Stop2;
              } else {
            Print("ERROR: Could not adjust stop loss, SL=",sl);
            return(sl);
           }
         //normalize SL
         sl=NormalizeDouble(sl,int(MarketInfo(symbol_sl,MODE_DIGITS)));
         Print("Stop Loss was too small. It was changed. New SL=",sl);
         
        }
      return(sl);
        }else{
      return(sl);
     }
  }
//To adjust TP to server accepted levels

double CheckTakeProfit(string symbol_tp,double price_tp,double tp)
  {
   if(AutoAdjustTPSL)
     {
      double minimumstop;
      if(tp==0)
        { //no take profit
         return(tp);
        }
      minimumstop=2*MarketInfo(symbol_tp,MODE_STOPLEVEL)*MarketInfo(symbol_tp,MODE_POINT);
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
         tp=NormalizeDouble(tp,int(MarketInfo(symbol_tp,MODE_DIGITS)));
         Print("Target Profit was too small. It was changed. New TP=",tp);
        }
      return(tp);
        }else{
      return(tp);
     }
  }

  
//PENDINGORDER opens a pending order ===================================================================================================================================================================================

int PENDINGORDER(int ordertype_p,string symbol_p,double lotsize_p,double price_offp,double stoploss_p,double takeprofit_p,string comment_p,int magic_p,color ordercolor_p,string condition_p,int expiration_p) 
  {
   bool golong_p=false;
   
   datetime myexpiration=iTime(Symbol(),PERIOD_CURRENT,0)+ExpSeconds;
   int digits_p;
   double points_p;
   double price_p=0;
   double price_p2=0;

   int ticket_p;
   int retrynumber_p=3;
   int errorcode_p;

//Adjust 5 digits
  // stoploss_p=stoploss_p*PipMultiplier;
 //  takeprofit_p=takeprofit_p*PipMultiplier;
 //  price_offp=price_offp*PipMultiplier;
//Set ordertype boolean
   switch(ordertype_p) 
     {
      case OP_BUYSTOP:
         golong_p=true;
         break;
      case OP_SELLSTOP:
         golong_p=false;
         break;
      default:
         Print("ERROR : Wrong pending order type ",ordertype_p);
         return(-1);
         break;
     }

//check open pending positions
   if(CalculateOpenPositions(symbol_p,ordertype_p,magic_p)>=MaxPositions) 
     {
      // Print("Warning : Cannot execute new pending ",OrderTypetoString(ordertype_p)," order for Symbol ",symbol_p,". Maximum number of ",Max_Number_of_Positions," pending open positions reached."); 
      return(0);
     }

//Verify capital
   if(!EnoughMoney(symbol_p,lotsize_p)) 
     {
      //Print("WARNING : You may not have enough money to cover the execution of the pending order ", OrderTypetoString(ordertype_p));
     }
// To do: Add % at risk

//Gets pair info to prepare price 

   digits_p = int(MarketInfo(symbol_p, MODE_DIGITS));
   points_p = MarketInfo(symbol_p, MODE_POINT);


   while(retrynumber_p>0)
     {
      RefreshRates();

      // go long set up

      if(golong_p) 
        {
        // price_p=NormalizeDouble(MarketInfo(symbol_p,MODE_ASK)+price_offp*points_p,digits_p);//++5 digits
         price_p2=NormalizeDouble(Close[1]+price_offp*Point*DigiMultiplier,Digits);//++5 digits
         price_p= price_p2 - (TS1*Point*DigiMultiplier);
         if(stoploss_p>0) 
           {
            //To do : Verify stop loss if valid
            stoploss_p=NormalizeDouble(price_p,Digits);

           }

         if(takeprofit_p>0) 
           {
            //Todo : Verify take profit is valid
            takeprofit_p=NormalizeDouble(price_p2+takeprofit_p*Point*DigiMultiplier,Digits);

           }

         // Print("Preparing Buy pending order ",symbol_p, " triggered by ",condition_p);

           } else {  // go short set up
        // price_p=NormalizeDouble(MarketInfo(symbol_p,MODE_BID)-price_offp*points_p,digits_p);
         price_p2=NormalizeDouble(Close[1]-price_offp*Point*DigiMultiplier,Digits);//++5 digits
         price_p= price_p2 + (TS1*Point*DigiMultiplier);
         if(stoploss_p>0) 
           {
            //To do: Verify stop loss is valid
            stoploss_p=NormalizeDouble(price_p,Digits);

           }

         if(takeprofit_p>0) 
           {
            //To do :Verify take profit are valid
            takeprofit_p=NormalizeDouble(price_p2-takeprofit_p*Point*DigiMultiplier,Digits);

           }

         // Print("Preparing Sell pending order ",symbol_p, " triggered by ",condition_p);
         // Print("SL  ",stoploss_p);
        }

      //Sending Pending Order
      ticket_p=OrderSend(symbol_p,ordertype_p,lotsize_p,price_p2,Slippage,stoploss_p,takeprofit_p,comment_p,magic_p,myexpiration,CLR_NONE);
      //-
      if(ticket_p>=0)
        {
         Sleep(SleepTime);
         if(OrderSelect(ticket_p,SELECT_BY_TICKET))
           {
            // Print("Pending Order Executed Successfully! Order Type=", OrderTypetoString(ordertype_p), ". Symbol=", symbol_p, ". Lot Size=",lotsize_p,
            //". Price=",price_p, ". SL=",OrderStopLoss(),". TP=",OrderTakeProfit(), ". Expiration time=",TimeToStr(myexpiration)," Ticket:",ticket_p,
            // ". ","BID=",MarketInfo(symbol_p,MODE_BID)," ASK=",MarketInfo(symbol_p,MODE_ASK);

            // if (Send_Emails) {
            //Prepare email
            // subject = "Cutting Edge Forex Algo ALERT: ";
            // subject = StringConcatenate(subject,Algo_Name,". ",symbol_p," ",OrderTypetoString(ordertype_p)," pending order executed. Ticket:",ticket_p);
            // mailstring = "email generated by Cutting Edge Forex Algo";
            // mailstring = StringConcatenate(mailstring, "Server Time=",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS),". Terminal Time=",TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS),"\n"); 
            // mailstring = StringConcatenate(mailstring, "Pending Order Executed Successfully!\nOrder Info : \n Order Type=", OrderTypetoString(ordertype_p), ".\n Symbol=", symbol_p, ".\n Lot Size=",lotsize_p,
            // ".\n Price=",price_p, ".\n SL=",OrderStopLoss(),".\n TP=",OrderTakeProfit(), ".\n Expiration time=",TimeToStr(myexpiration),"\n Ticket:",ticket_p,
            // "."); 

            SendMail(subject,mailstring);
            // }

            if(EnableAudibleAlerts) PlaySound(MySound);
            return(ticket_p);
           }
           } else {
         errorcode_p=GetLastError();
         // Retry if server is busy
         if(errorcode_p==ERR_SERVER_BUSY || errorcode_p==ERR_TRADE_CONTEXT_BUSY || errorcode_p==ERR_BROKER_BUSY || errorcode_p==ERR_NO_CONNECTION
            || errorcode_p==ERR_TRADE_TIMEOUT || errorcode_p==ERR_INVALID_PRICE || errorcode_p==ERR_OFF_QUOTES || errorcode_p==ERR_PRICE_CHANGED || errorcode_p==ERR_REQUOTE) 
           {
             Print("ERROR: Server error. Sending pending order to server again. Retry intent number = ",retrynumber_p);
            retrynumber_p++;
            if(retrynumber_p>Max_Order_Retry+1) 
              {
                Print("ERROR: Could not open new pending order. Error=",errorcode_p, " ",ErrorDescription(errorcode_p),". Order Info : Order Type=", OrderTypetoString(ordertype_p), ". Symbol=", symbol_p, ". Lot Size=",lotsize_p,
                ". Price=",price_p, ". SL=",stoploss_p,". TP=",takeprofit_p, ". Expiration time=",TimeToStr(myexpiration)); 
                Alert("ERROR: Could not open new pending position. Error=",errorcode_p, " ",ErrorDescription(errorcode_p),". Order Info : Order Type=", OrderTypetoString(ordertype_p), ". Symbol=", symbol_p, ". Lot Size=",lotsize_p,
               ". Price=",price_p, ". SL=",stoploss_p,". TP=",takeprofit_p, ". Expiration time=",TimeToStr(myexpiration)); 

               // if (Send_Emails) {
               //	subject = "Algo ALERT: ";
               // subject = StringConcatenate(subject,Algo_Name," ",symbol_p," ",OrderTypetoString(ordertype_p)," pending order FAILED");
               //  mailstring = "email generated by Cutting Edge Forex Algo";
               // mailstring = StringConcatenate(mailstring, "Server Time=",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS),". Terminal Time=",TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS),"\n");
               // mailstring = StringConcatenate(mailstring, "WARNING: Could not open new pending order.\n Error=",errorcode_p, "\n",ErrorDescription(errorcode_p),".\n Order Info :\nOrder Type=", OrderTypetoString(ordertype_p), ".\n Symbol=", symbol_p, ".\n Lot Size=",lotsize_p,
               // ".\n Price=",price_p, ".\n SL=",stoploss_p,".\n TP=",takeprofit_p, ".\n Expiration time=",TimeToStr(myexpiration));
               //SendMail(subject, mailstring); 
               // } 
               return (-1);
              }
            Sleep(SleepTime);
              } else {

             Print("ERROR: Could not open new pending position. Error=",errorcode_p, " ",ErrorDescription(errorcode_p),". Order Info : Order Type=", OrderTypetoString(ordertype_p) , ". Symbol=", symbol_p, ". Lot Size=",lotsize_p,
              ". Price=",price_p, ". SL=",stoploss_p,". TP=",takeprofit_p, ". Expiration time=",TimeToStr(myexpiration)); 
              Alert("ERROR: Could not open new position. Error=",errorcode_p, " ",ErrorDescription(errorcode_p),". Order Info : Order Type=", OrderTypetoString(ordertype_p) , ". Symbol=", symbol_p, ". Lot Size=",lotsize_p,
             ". Price=",price_p, ". SL=",stoploss_p,". TP=",takeprofit_p, ". Expiration time=",TimeToStr(myexpiration)); 

            if(errorcode_p==ERR_INVALID_STOPS) 
              {
               Print("Possible Problem : Market moved. SL or TP too close to current price.");  
               Alert("Possible Problem : Market moved. SL or TP too close to current price.");  

              }

            // if (Send_Emails) {
            // 	subject = "Algo: ";
            //   subject = StringConcatenate(subject,Algo_Name," ",symbol_p," ",OrderTypetoString(ordertype_p)," pending order FAILED");
            //   mailstring = "email generated by Cutting Edge Forex Algo";
            //   mailstring = StringConcatenate(mailstring, "Server Time=",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS),". Terminal Time=",TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS),"\n");
            //   mailstring = StringConcatenate(mailstring, "WARNING: Could not open new pending order.\n Error=",errorcode_p, "\n",ErrorDescription(errorcode_p),".\n Order Info :\nOrder Type=", OrderTypetoString(ordertype_p), ".\n Symbol=", symbol_p, ".\n Lot Size=",lotsize_p,
            //   ".\n Price=",price_p, ".\n SL=",stoploss_p,".\n TP=",takeprofit_p, ".\n Expiration time=",TimeToStr(myexpiration));
            //	SendMail(subject, mailstring); 
            // } 
            return (-1);
           }
        }

      //-     
     }//while
   return(0);
  }
//DeletePending deletes a pending order

int DeletePending(string symbolclose,int ordertypeclose,int magicclose)
  {
   int cnt;
   int err;
   int retrynumberclose=0;
   bool magiccond=true;
//verify type is ok
   if(ordertypeclose==OP_BUYLIMIT || ordertypeclose==OP_SELLLIMIT || ordertypeclose==OP_BUYSTOP || ordertypeclose==OP_SELLSTOP) 
     {
      //ok 
        } else {
       Print("Deleting pending positions failed. Order type is wrong.");
       Alert("Deleting pending positions failed. Order type is wrong.");
      return(-1);
     }

   int orderstotal=OrdersTotal();
   bool loopcl=true;
   while(loopcl) 
     {
      loopcl=false;
      orderstotal=OrdersTotal();
      for(cnt=0;cnt<orderstotal;cnt++)
        {
         if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)) //executes if gets valid order
           {

            if(magicclose==0) 
              {
               magiccond=true;
                 } else {
               if(OrderMagicNumber()==magicclose) 
                 {
                  magiccond=true;
                    } else {
                  magiccond=false;
                 }

              }
            if((OrderType()==ordertypeclose) && (OrderSymbol()==symbolclose) && (magiccond))
              {
               //get closing price
               RefreshRates();
               if(!isTradingPossible()) 
                 {
                  Print("Warning: Trading may not be possible. Trying to delete pending orders.");
                 }
               if(OrderDelete(OrderTicket(),Violet)) // close position
                 {
                  Print("Pending Order Deleted. Symbol:",symbolclose,". Lots:",OrderLots(),". Ticket number:",OrderTicket());
                  if(Send_Emails) 
                    {
                     //Prepare email
                     subject= "Cutting Edge Forex Algo: ";
                     subject = StringConcatenate(subject,Algo_Name,". ",symbolclose," ",OrderTypetoString(ordertypeclose)," pending order was deleted. ","Ticket:",OrderTicket());
                     mailstring = "email generated by Cutting Edge Forex Algo";
                     mailstring = StringConcatenate(mailstring, "Server Time=",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS),". Terminal Time=",TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS),"\n");
                     mailstring = StringConcatenate(mailstring, "Pending Order Deleted\nOrder Info : \n Pending Order Type=", OrderTypetoString(ordertypeclose), ".\n Symbol=", symbolclose, ".\n Lot Size=",OrderLots(),
                                                    ".\n Ticket:",OrderTicket());
                     SendMail(subject,mailstring);
                    }

                  loopcl=true;
                  retrynumberclose=1;
                  break; //break loop and restart again

                    }else {
                  err=GetLastError();
                  Print("Deleting Pending Order failed. Symbol:",symbolclose,". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Error:",err," ",ErrorDescription(err));
                  Alert("Deleting Pending Order failed. Symbol:",symbolclose,". Lots:",OrderLots(),". Ticket number:",OrderTicket(),". Error:",err," ",ErrorDescription(err));
                  if(Send_Emails) 
                    {
                     //Prepare email
                     subject= "Cutting Edge Forex Algo: ";
                     subject = StringConcatenate(subject,Algo_Name," WARNING:",symbolclose," ",OrderTypetoString(ordertypeclose)," pending order could NOT be deleted");
                     mailstring="email generated by Cutting Edge Forex Algo";
                     mailstring= StringConcatenate(mailstring,"Server Time=",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS),". Terminal Time=",TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS),"\n");
                     mailstring = StringConcatenate(mailstring,"Deleting Pending Order failed.\nSymbol:",symbolclose,".\n Lots:",OrderLots(),".\n Ticket number:",OrderTicket(),".\n Error:",err,"\n",ErrorDescription(err));
                     SendMail(subject,mailstring);
                    }

                  loopcl=true;
                  retrynumberclose++;
                  break; //break loop and restart again
                 }

              }

           }
        }//for
      if(retrynumberclose>Max_Order_Retry+10) 
        {
         Print("Halting. Too many errors when deleting orders. Symbol:",symbolclose);
         Print("URGENT:Please verify your Internet Connection and Server response.");
         Alert("Halting. Too many errors when deleting orders. Symbol:",symbolclose);
         Alert("URGENT:Please verify your Internet Connection and Server response.");
         return(-1);
        }
     }//while

   return(0); // exit
  }// end function
//DELETEP delete pending positions

int DELETEP(string symbol_c, string penType) 
  {
   if(penType=="All") 
     {
      DeletePending(symbol_c,OP_BUYSTOP,MagicNumber);
      DeletePending(symbol_c,OP_SELLSTOP,MagicNumber);
      DeletePending(symbol_c,OP_BUYSTOP,MagicNumber);
      DeletePending(symbol_c,OP_SELLSTOP,MagicNumber);
        } else if(penType=="BUYP") {
      DeletePending(symbol_c,OP_BUYSTOP,MagicNumber);
      DeletePending(symbol_c,OP_BUYSTOP,MagicNumber);
        } else if(penType=="SELLP") {
      DeletePending(symbol_c,OP_SELLSTOP,MagicNumber);
      DeletePending(symbol_c,OP_SELLSTOP,MagicNumber);
        } else {
      Print("Warning: Could not delete pending orders. Order type is wrong!");
     }

   return(0);
  }
//BUYP creates a pending order to Buy (go long)

void BUYP(string symbol_p,double offset_p,double lotsize_p,double takeprofit_p,double stoploss_p,int expiration_p,string condition_p) 
  {
   PENDINGORDER(OP_BUYSTOP,symbol_p,lotsize_p,offset_p,stoploss_p,takeprofit_p,TradeTag,MagicNumber,BuyColor,condition_p,expiration_p);
  }
//SELLP creates a pending order to Sell (go short)

void SELLP(string symbol_p,double offset_p,double lotsize_p,double takeprofit_p,double stoploss_p,int expiration_p,string condition_p) 
  {
   PENDINGORDER(OP_SELLSTOP,symbol_p,lotsize_p,offset_p,stoploss_p,takeprofit_p,TradeTag,MagicNumber,SellColor,condition_p,expiration_p);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CalculateLots()
  {

// Order value
   RefreshRates();                              // Refresh rates
   double Min_Lot=MarketInfo(Symbol(),MODE_MINLOT);        // Minimal number of lots 
   double Max_Lot=MarketInfo(Symbol(),MODE_MAXLOT);
   double Free=AccountFreeMargin();                 // Free margin
   double One_Lot=MarketInfo(Symbol(),MODE_MARGINREQUIRED);// Price of 1 lot
   double Step   =MarketInfo(Symbol(),MODE_LOTSTEP);       // Step is changed
   if(MoneyManagement==Static)
     {
      if(LotSize < Min_Lot){LotSize = Min_Lot;}
      if(LotSize > Max_Lot){LotSize = Max_Lot;}
      return (NormalizeDouble(LotSize,2));
     }
   if(MoneyManagement==StepLots)
     {
      double balanceDiff = AccountEquity()-StepIntialBalance;
      int mux = int(balanceDiff/StepBalance);
      if (balanceDiff < 0 || mux == 0)
      {
          if(NoDropLotSize)
          {
            LotSize = SteppingLatestLotSize();
          }
          if(LotSize < Min_Lot){LotSize = Min_Lot;}
          if(LotSize > Max_Lot){LotSize = Max_Lot;}
          return (NormalizeDouble(LotSize,2));
      } else {
          LotSize = LotSize+mux*LotStep;
          if(LotSize < Min_Lot){LotSize = Min_Lot;}
          if(LotSize > Max_Lot){LotSize = Max_Lot;}
          return (NormalizeDouble(LotSize,2));
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
   if(Lts*One_Lot>=Free) // Lot larger than free margin
     {
      Alert(" Not enough money for ",Lts," lots");
      return(0);                                   // Exit start()
     }
   return (NormalizeDouble(Lts,2));
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void checkForBrokenTrades()
  {
   for(int cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
        {
         Print("Order could not be selected");
        }
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=MagicNumber)
         continue;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {

         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
           {
            if(OrderStopLoss()==0 || OrderTakeProfit()==0)
              {

               double takeprofit_bn=TargetProfit;
               double stoploss_bn=InitialStopLoss;

               int errorcode_ts=0;
               int digits_bn;
               double points_bn,price_bn;
               digits_bn=int(MarketInfo(OrderSymbol(),MODE_DIGITS));
               points_bn=MarketInfo(OrderSymbol(),MODE_POINT);

               color ordercolor_bn;

               stoploss_bn=stoploss_bn*PipMultiplier;
               takeprofit_bn=takeprofit_bn*PipMultiplier;

               if(OrderType()==OP_BUY)
                 {
                  price_bn=NormalizeDouble(MarketInfo(OrderSymbol(),MODE_ASK),digits_bn);
                  ordercolor_bn=BuyColor;
                  if(stoploss_bn>0)
                    {
                     stoploss_bn = NormalizeDouble(price_bn-stoploss_bn*points_bn, digits_bn);
                     stoploss_bn = CheckStopLoss(OrderSymbol(), price_bn, stoploss_bn);
                    }
                  if(takeprofit_bn>0)
                    {
                     takeprofit_bn= NormalizeDouble(price_bn+takeprofit_bn*points_bn,digits_bn);
                     takeprofit_bn= CheckTakeProfit(OrderSymbol(),price_bn,takeprofit_bn);
                    }
                    } else {  // go short set up
                  price_bn=NormalizeDouble(MarketInfo(OrderSymbol(),MODE_BID),digits_bn);
                  ordercolor_bn=SellColor;
                  if(stoploss_bn>0)
                    {
                     stoploss_bn = NormalizeDouble(price_bn+stoploss_bn*points_bn, digits_bn);
                     stoploss_bn = CheckStopLoss(OrderSymbol(), price_bn, stoploss_bn);
                    }
                  if(takeprofit_bn>0)
                    {
                     takeprofit_bn= NormalizeDouble(price_bn-takeprofit_bn*points_bn,digits_bn);
                     takeprofit_bn= CheckTakeProfit(OrderSymbol(),price_bn,takeprofit_bn);
                    }
                 }

               //modify order, adds TP/SL
               if(OrderModify(OrderTicket(),OrderOpenPrice(),stoploss_bn,takeprofit_bn,0,ordercolor_bn))
                 {
                  Print("Fixing broken trades: SL=",stoploss_bn," TP=",takeprofit_bn);
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
//|                                                                  |
//+------------------------------------------------------------------+
int CheckForOpenPositions()
  {
   for(int cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
        {
         Print("Could not select order");
        }
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=MagicNumber)
         continue;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {

         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
           {
            return (OrderType());
           }
        }
     }

   return (-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculateInitialBalance()
  {
   double total=0.0;
   double opentotal=0.0;

   int i,hstTotal=OrdersHistoryTotal();
   for(i=0;i<hstTotal;i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         Print("Could not select order");
        }
      if(OrderMagicNumber()!=MagicNumber)
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
      if(OrderMagicNumber()!=MagicNumber)
        {
         continue;
        }

      opentotal+=OrderProfit()+OrderCommission()+OrderSwap();
     }

   CalculatedBalance= SpecificBalance+total;
   CalculatedEquity = CalculatedBalance+opentotal;
  }
//+------------------------------------------------------------------+
//
//+------------------------------------------------------------------+
double CalculatePL()
  {
   double total2=0.0;

   int i,hstTotal2=OrdersHistoryTotal();
   for(i=0;i<hstTotal2;i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         Print("Could not select order to calculate P&L");
        }
      if(OrderMagicNumber()!=MagicNumber)
        {
         continue;
        }

      total2+=NormalizeDouble((OrderProfit()+OrderCommission()+OrderSwap()),2);
     }
  return(total2);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CalculateProfit(int type)
  {
   double Profit=0;
   for(int cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
        {
         Print("Order could not be selected");
        }
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=MagicNumber)
         continue;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(type>-1 && OrderType()!=type)
            continue;
         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
           {
            Profit=Profit+OrderProfit();
           }
        }
     }
   return(Profit);
  } 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CreateLabels()
  {

   if(Display_Colors==1)
     {
      clr1 = DarkOrange;
      clr2 = SteelBlue;
      clr3 = Lime;
      clr4 = DarkOrange;
     }
   if(Display_Colors==2)
     {
      clr1 = Yellow;
      clr2 = SkyBlue;
      clr3 = Green;
      clr4 = Yellow;
     }
   if(Display_Colors==3)
     {
      clr1 = MediumBlue;
      clr2 = Orchid;
      clr3 = Lime;
      clr4 = MediumBlue;
     }

   if(Display_Colors==4)
     {
      clr1 = Green;
      clr2 = YellowGreen;
      clr3 = Green;
      clr4 = Green;
     }
   if(Display_Colors==5)
     {
      clr1 = Beige;
      clr2 = Olive;
      clr3 = Lime;
      clr4 = Beige;
     }
   if(Display_Colors==6)
     {
      clr1 = Blue;
      clr2 = DarkOrange;
      clr3 = Green;
      clr4 = Blue;
     }
   if(Display_Colors==7)
     {
      clr1 = HotPink;
      clr2 = Gray;
      clr3 = Lime;
      clr4 = HotPink;
     }
   if(Display_Colors==8)
     {
      clr1 = White;
      clr2 = Gray;
      clr3 = Lime;
      clr4 = White;
     }
   if(Display_Colors==9)
     {
      clr1 = Black;
      clr2 = Gray;
      clr3 = Lime;
      clr4 = Black;
     }
   if(Display_Colors==10)
     {
      clr1 = Red;
      clr2 = Black;
      clr3 = Lime;
      clr4 = Red;
     }
   if(Display_Colors==11)
     {
      clr1 = Khaki;
      clr2 = OliveDrab;
      clr3 = Lime;
      clr4 = Khaki;
     }

   if(Display_Colors==12)
     {
      clr1 = Lime;
      clr2 = Gray;
      clr3 = Lime;
      clr4 = White;
     }
   if(Display_Colors>12)
     {
      clr1 = Lime;
      clr2 = Gray;
      clr3 = Lime;
      clr4 = Lime;
     }
   int ypos=22;
   ObjectCreate("RecBackground",OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSet("RecBackground",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSet("RecBackground",OBJPROP_XDISTANCE,5);
   ObjectSet("RecBackground",OBJPROP_YDISTANCE,14);
//--- set label size
   ObjectSet("RecBackground",OBJPROP_XSIZE,165);
   ObjectSet("RecBackground",OBJPROP_YSIZE,205);
//--- set background color
   ObjectSet("RecBackground",OBJPROP_BGCOLOR,clr2);
//--- set border type
   ObjectSet("RecBackground",OBJPROP_BORDER_TYPE,BORDER_FLAT);

   ObjectSet("RecBackground",OBJPROP_COLOR,clr4);
//--- set flat border line style
   ObjectSet("RecBackground",OBJPROP_STYLE,STYLE_SOLID);
//--- set flat border width
   ObjectSet("RecBackground",OBJPROP_WIDTH,2);
//--- display in the foreground (false) or background (true)
   ObjectSet("RecBackground",OBJPROP_BACK,Transparent2);
//--- enable (true) or disable (false) the mode of moving the label by mouse
   ObjectSet("RecBackground",OBJPROP_SELECTABLE,false);
   ObjectSet("RecBackground",OBJPROP_SELECTED,false);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSet("RecBackground",OBJPROP_HIDDEN,true);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSet("RecBackground",OBJPROP_ZORDER,0);
//--- successful execution

   ObjectCreate("lblCopyright",OBJ_LABEL,0,0,0);
   ObjectSetText("lblCopyright","Copyright © 2016 Cutting Edge Forex LLC",8,"Arial Bold",SlateGray);
   ObjectSet("lblCopyright",OBJPROP_CORNER,3);
   ObjectSet("lblCopyright",OBJPROP_XDISTANCE,10);
   ObjectSet("lblCopyright",OBJPROP_YDISTANCE,10);

   ObjectCreate("lblVersion",OBJ_LABEL,0,0,0);
   ObjectSetText("lblVersion","Silicon",18,"Copperplate Gothic Light",DeepSkyBlue);
// ObjectSet("lblVersion",OBJPROP_FONT,FONT_STRIKEOUT);
   ObjectSet("lblVersion",OBJPROP_XDISTANCE,16);
   ObjectSet("lblVersion",OBJPROP_YDISTANCE,ypos);
   

   ObjectCreate("lblVersion3",OBJ_LABEL,0,0,0);
   ObjectSetText("lblVersion3","V "+Version,8,"Arial Bold",Silver);
// ObjectSet("lblVersion3",OBJPROP_FONT,FONT_STRIKEOUT);
   ObjectSet("lblVersion3",OBJPROP_XDISTANCE,130);
   ObjectSet("lblVersion3",OBJPROP_YDISTANCE,ypos+4);
   ypos+=28;


   ObjectCreate("lblVersion2",OBJ_LABEL,0,0,0);
   ObjectSetText("lblVersion2","Raptor",26,"Copperplate Gothic Light",Lime);
// ObjectSet("lblVersion2",OBJPROP_FONT,FONT_STRIKEOUT);
   ObjectSet("lblVersion2",OBJPROP_XDISTANCE,15);
   ObjectSet("lblVersion2",OBJPROP_YDISTANCE,ypos-8);
   ypos+=28;

   ObjectCreate("lblMagic_Number",OBJ_LABEL,0,0,0);
   ObjectSetText("lblMagic_Number","Magic # "+IntegerToString(MagicNumber,2),8,"Arial Bold",White);
   ObjectSet("lblMagic_Number",OBJPROP_XDISTANCE,15);
   ObjectSet("lblMagic_Number",OBJPROP_YDISTANCE,ypos);
   ypos+=15;
   
   ObjectCreate("lblOffset",OBJ_LABEL,0,0,0);
   ObjectSetText("lblOffset","Offset Pips:  "+DoubleToStr(Offset,1),8,"Arial Bold",White);
   ObjectSet("lblOffset",OBJPROP_XDISTANCE,15);
   ObjectSet("lblOffset",OBJPROP_YDISTANCE,ypos);
   ypos+=15;
   
   if(MoneyManagement==Dynamic)
     {
      ObjectCreate("lblRisk",OBJ_LABEL,0,0,0);
      ObjectSetText("lblRisk",StringConcatenate("Risk Setting: ",RiskSetting),8,"Arial Bold",White);
      ObjectSet("lblRisk",OBJPROP_XDISTANCE,15);
      ObjectSet("lblRisk",OBJPROP_YDISTANCE,ypos);
      ypos+=15;
     }
   ObjectCreate("lblLotSize",OBJ_LABEL,0,0,0);
   ObjectSetText("lblLotSize",StringConcatenate("Lot Size: ",DoubleToStr(CalculateLots(),2)),8,"Arial Bold",White);
   ObjectSet("lblLotSize",OBJPROP_XDISTANCE,15);
   ObjectSet("lblLotSize",OBJPROP_YDISTANCE,ypos);
   ypos+=15;

   ObjectCreate("lblLeverage",OBJ_LABEL,0,0,0);
   ObjectSetText("lblLeverage",StringConcatenate("Leverage: ",AccountLeverage()," : 1"),8,"Arial Bold",White);
   ObjectSet("lblLeverage",OBJPROP_XDISTANCE,15);
   ObjectSet("lblLeverage",OBJPROP_YDISTANCE,ypos);
   ypos+=15;

   ObjectCreate("lblAccountBalance",OBJ_LABEL,0,0,0);
   ObjectSetText("lblAccountBalance",StringConcatenate("Account Balance: ",AccountBalance()),8,"Arial Bold",White);
   ObjectSet("lblAccountBalance",OBJPROP_XDISTANCE,15);
   ObjectSet("lblAccountBalance",OBJPROP_YDISTANCE,ypos);
   ypos+=15;


   ObjectCreate("lblProfit",OBJ_LABEL,0,0,0);
   ObjectSetText("lblProfit",StringConcatenate("Profit: ",CalculatePL()),8,"Arial Bold",White);
   ObjectSet("lblProfit",OBJPROP_XDISTANCE,15);
   ObjectSet("lblProfit",OBJPROP_YDISTANCE,ypos);
   ypos+=15;

   ObjectCreate("lblSpread",OBJ_LABEL,0,0,0);
   ObjectSetText("lblSpread",StringConcatenate("Cur Spread: ",MarketInfo(Symbol(),MODE_SPREAD),8,"Arial Bold",White));
   ObjectSet("lblSpread",OBJPROP_XDISTANCE,15);
   ObjectSet("lblSpread",OBJPROP_YDISTANCE,ypos);
   ypos+=15;

   ObjectCreate("lblSpread2",OBJ_LABEL,0,0,0);
   ObjectSetText("lblSpread2",StringConcatenate("Avg Spread: ",MarketInfo(Symbol(),MODE_SPREAD),8,"Arial Bold",White));
   ObjectSet("lblSpread2",OBJPROP_XDISTANCE,15);
   ObjectSet("lblSpread2",OBJPROP_YDISTANCE,ypos);
   ypos+=15;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void UpdateLabels()
  {

   Timer2=TimeToString(Timer,TIME_MINUTES|TIME_SECONDS);

   ObjectSetText("lblAccountBalance",StringConcatenate("Account Balance: $",DoubleToStr(AccountBalance(),2)),8,"Arial Bold",White);
   ObjectSetText("lblTradingInfo",": ",8,"Arial",White);

   if(InitialBalance==SpecificBal)
     {
      ObjectSetText("lblAccountBalance",StringConcatenate("Phoenix Balance: $",DoubleToStr(CalculatedBalance,2)),8,"Arial Bold",White);
     }

   ObjectSetText("lblLotSize",StringConcatenate("Lot Size: ",DoubleToStr(CalculateLots(),2)),8,"Arial Bold",White);
   ObjectSetText("lblProfit",StringConcatenate("Profit: $",DoubleToStr(CalculatePL(),2)),8,"Arial Bold",White);

   if(Spread<=MaxCurSpread)
     {
      ObjectSetText("lblSpread","Current Spread:   "+DoubleToStr(Spread,1),8,"Arial Bold",clr3);
        }else{
      ObjectSetText("lblSpread","Current Spread:   "+DoubleToStr(Spread,1),8,"Arial Bold",Yellow);
     }
   if(SpreadAvg<=MaxAvgSpread)
     {
      ObjectSetText("lblSpread2","Average Spread:  "+DoubleToStr(SpreadAvg,1),8,"Arial Bold",clr3);
        }else{
      ObjectSetText("lblSpread2","Average Spread:  "+DoubleToStr(SpreadAvg,1),8,"Arial Bold",Yellow);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RemoveLabels()
  {
   ObjectDelete("lblCopyright");
   ObjectDelete("lblVersion");
   ObjectDelete("lblVersion2");
   ObjectDelete("lblVersion3");
   ObjectDelete("lblRisk");
   ObjectDelete("lblLeverage");
   ObjectDelete("lblLotSize");
   ObjectDelete("lblAccountBalance");
   ObjectDelete("lblAccountEquity");
   ObjectDelete("lblProfit");
   ObjectDelete("lblForce");
   ObjectDelete("lblTradingInfo");
   ObjectDelete("lblSpread");
   ObjectDelete("lblSpread2");
   ObjectDelete("lblMagic_Number");
   ObjectDelete("RecBackground");
   ObjectDelete("lblTime");
   ObjectDelete("lblTimer");
   ObjectDelete("lblAction");
   ObjectDelete("lblOffset");
   for(int i=0; i<NumTradesToShow; i++)
     {
      string objName=StringConcatenate("lblTradingInfo",i);
      ObjectDelete(objName);
      ObjectDelete(StringConcatenate("bg",objName));
     }
  } 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CheckOrdersCondition()
{
	int result=0;
	for (int i=OrdersTotal()-1; i>=0; i--) {
		if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
			if (OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber) {
				result=result+1000; 
			}
			if (OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber) {
				result=result+100; 
			}
			if (OrderType()==OP_BUYSTOP && OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber) {
				result=result+10;
			}
			if (OrderType()==OP_SELLSTOP && OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber) {
				result=result+1; 
			}
		}
	}
	return(result); // 0 means we have no trades
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
      if(OrderMagicNumber()!=MagicNumber)
        {
         continue;
        }
      if(OrderProfit()>0)
         total+=OrderProfit()+OrderCommission()+OrderSwap();
     }

   double Min_Lot=MarketInfo(Symbol(),MODE_MINLOT);        // Minimal number of lots 
   double Max_Lot=MarketInfo(Symbol(),MODE_MAXLOT);
   double steppingCalculatedBalance= StepIntialBalance+total;
   
   double lotSize = LotSize;
   double balanceDiff = steppingCalculatedBalance-StepIntialBalance;
   int mux = int(balanceDiff/StepBalance);
   if (balanceDiff < 0 || mux == 0) {
       if(lotSize < Min_Lot){lotSize = Min_Lot;}
       if(lotSize > Max_Lot){lotSize = Max_Lot;}
       return (NormalizeDouble(lotSize,2));
   } else {
       lotSize = LotSize+mux*LotStep;
       if(lotSize < Min_Lot){lotSize = Min_Lot;}
       if(lotSize > Max_Lot){lotSize = Max_Lot;}
       return (NormalizeDouble(lotSize,2));
   }
}