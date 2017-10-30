//+-----------------------------------------------------------------------------------+
//|                                                         Leviathan_v3.0_SqLite.mq4 |
//|                                              Copyright 2017, Al.Fa.Software Corp. |
//|                                                               http://www.mql5.com |
//+-----------------------------------------------------------------------------------+
#property copyright "Copyright 2017, Al.Fa.Software Corp."
#property link      "http://www.mql5.com"
#property version   "3.0"
#property strict

//--- Assert 2: Plus include files
#include <PlusTurtle.mqh>
#include <PlusGhost.mqh>
#include <orders.mqh>
#include <stdlib.mqh>

#import "stdlib.ex4"
   string ErrorDescription(int a0);
//#import "Kernel32.dll"
//   void GetSystemTime(int& TimeArray[]);
#import "kernel32.dll"
   int  GetTimeZoneInformation(int& TZInfoArray[]);
#import

#define TIME_ZONE_ID_UNKNOWN   0
#define TIME_ZONE_ID_STANDARD  1
#define TIME_ZONE_ID_DAYLIGHT  2

int   MaxAccountTrades = 30;

int gi_76;
string gs_dummy_80;
string gsa_92[4] = {"0000000000", "1111111111", "2222222222", "33333333333"};
string Register_Number = "";
string User = "";
string KEY = "";
extern string EA_Name = "Leviathan";
extern string _________ = "Input a unique magic number for each chart";
extern int MagicNumber = 0;
extern double BaseLotSize = 0.01;
extern bool LotStepEnable    = FALSE;
extern double LotStepValue   = 0.01;
extern double LotStepFrom    = 1000;
extern double LotStepEvery   = 1000;
extern int ExecutionPoint = 8;
extern double BasketTakeProfit = 13.0;
extern int BasketStopLoss = 180;
extern double StandardDeviation = 0.2;
extern bool BalanceChecks = FALSE;
extern bool EquityShield = FALSE;
extern double EquityDrawDownMoney = 50;
extern double ProgressiveStopLossPerc = 0;
/*extern*/ bool TriggerProtectionOn = FALSE;
/*extern*/ double MinDuration = 2;
/*extern*/ double MaxDuration = 12;
//extern double Tolerance = 0.5;
//extern double Pendence = 0.25;
extern double Multiplier = 0.5;
extern int MaximumBuyLevels = 12;
extern int MaximumSellLevels = 12;
/*extern*/ bool GreedyModeOn = TRUE;
/*extern*/ bool EnvyAugmenterOn = TRUE;
/*extern*/ bool Negative_Basket_Protection = TRUE;
/*extern*/ int NBP = 5;
extern double Slippage = 0.5;
string gs_168 = "1234567890123456";

/*extern*/ double BailOutPct = 100.0;
/*extern*/ bool Chicken_Out = FALSE;
/*extern*/ int Close_Order_Attempts = 3;
/*extern*/ bool FreezeAfterTP = FALSE;
/*extern*/ bool FreezeAfterTPScheduler = FALSE;
/*extern*/ bool SupportECN = TRUE;
/*extern*/ string __________ = "Freeze After TP Scheduler";
/*extern*/ int SUN_StartHour = 0;
/*extern*/ int SUN_StartMinute = 0;
/*extern*/ int SUN_EndHour = 0;
/*extern*/ int SUN_EndMinute = 0;
/*extern*/ int MON_StartHour = 0;
/*extern*/ int MON_StartMinute = 0;
/*extern*/ int MON_EndHour = 0;
/*extern*/ int MON_EndMinute = 0;
/*extern*/ int TUE_StartHour = 0;
/*extern*/ int TUE_StartMinute = 0;
/*extern*/ int TUE_EndHour = 0;
/*extern*/ int TUE_EndMinute = 0;
/*extern*/ int WED_StartHour = 0;
/*extern*/ int WED_StartMinute = 0;
/*extern*/ int WED_EndHour = 0;
/*extern*/ int WED_EndMinute = 0;
/*extern*/ int THU_StartHour = 0;
/*extern*/ int THU_StartMinute = 0;
/*extern*/ int THU_EndHour = 0;
/*extern*/ int THU_EndMinute = 0;
/*extern*/ int FRI_StartHour = 0;
/*extern*/ int FRI_StartMinute = 0;
/*extern*/ int FRI_EndHour = 0;
/*extern*/ int FRI_EndMinute = 0;
/*extern*/ int SAT_StartHour = 0;
/*extern*/ int SAT_StartMinute = 0;
/*extern*/ int SAT_EndHour = 0;
/*extern*/ int SAT_EndMinute = 0;
extern string ____________ = "";
/*extern*/ string EnvyAugmenter = "";
extern string Level_1 = "";
extern double Multiplier_1 = 1.1;
extern double BasketTakeProfit_1 = 0.0;
extern string Level_2 = "";
extern double Multiplier_2 = 1.1;
extern double BasketTakeProfit_2 = 0.0;
extern string Level_3 = "";
extern double Multiplier_3 = 1.51;
extern double BasketTakeProfit_3 = 0.0;
extern string Level_4 = "";
extern double Multiplier_4 = 1.52;
extern double BasketTakeProfit_4 = 0.0;
extern string Level_5 = "";
extern double Multiplier_5 = 1.53;
extern double BasketTakeProfit_5 = 0.0;
extern string Level_6 = "";
extern double Multiplier_6 = 1.54;
extern double BasketTakeProfit_6 = 0.0;
extern string Level_7 = "";
extern double Multiplier_7 = 1.55;
extern double BasketTakeProfit_7 = 0.0;
extern string Level_8 = "";
extern double Multiplier_8 = 1.65;
extern double BasketTakeProfit_8 = 0.0;
extern string Level_9 = "";
extern double Multiplier_9 = 1.66;
extern double BasketTakeProfit_9 = 0.0;
extern string Level_10 = "";
extern double Multiplier_10 = 1.67;
extern double BasketTakeProfit_10 = 0.0;
extern string Level_11 = "";
extern double Multiplier_11 = 1.68;
extern double BasketTakeProfit_11 = 0.0;
extern string Level_12 = "";
extern double Multiplier_12 = 1.69;
extern double BasketTakeProfit_12 = 0.0;
extern string Level_13 = "";
extern double Multiplier_13 = 1.68;
extern double BasketTakeProfit_13 = 0.0;
extern string Level_14 = "";
extern double Multiplier_14 = 1.67;
extern double BasketTakeProfit_14 = 0.0;
extern string Level_15 = "";
extern double Multiplier_15 = 1.66;
extern double BasketTakeProfit_15 = 0.0;
extern string Level_16 = "";
extern double Multiplier_16 = 1.65;
extern double BasketTakeProfit_16 = 0.0;
extern string Level_17 = "";
extern double Multiplier_17 = 1.55;
extern double BasketTakeProfit_17 = 0.0;
extern string Level_18 = "";
extern double Multiplier_18 = 1.54;
extern double BasketTakeProfit_18 = 0.0;
extern string Level_19 = "";
extern double Multiplier_19 = 1.53;
extern double BasketTakeProfit_19 = 0.0;
extern string Level_20 = "";
extern double Multiplier_20 = 1.52;
extern double BasketTakeProfit_20 = 0.0;
extern string Level_21 = "";
extern double Multiplier_21 = 1.51;
extern double BasketTakeProfit_21 = 0.0;
extern string Level_22 = "";
extern double Multiplier_22 = 1.5;
extern double BasketTakeProfit_22 = 0.0;
extern string Level_23 = "";
extern double Multiplier_23 = 1.5;
extern double BasketTakeProfit_23 = 0.0;
extern string Level_24 = "";
extern double Multiplier_24 = 1.5;
extern double BasketTakeProfit_24 = 0.0;
extern string Level_25 = "";
extern double Multiplier_25 = 1.5;
extern double BasketTakeProfit_25 = 0.0;
extern bool   DrawLines = TRUE;
extern string S5="-------News Filter-------";
extern bool   Use_NewsFilter      = false;
extern int    GMT_Offset          = 1;
extern bool   IncludeHigh         = true;
// mins before an event to stay out of trading
extern int    MinsBeforeHigh      = 180;
// mins after  an event to stay out of trading
extern int    MinsAfterHigh       = 120;
extern bool   IncludeMedium       = false;
extern int    MinsBeforeMedium    = 60;
extern int    MinsAfterMedium     = 60;
extern bool   IncludeLow          = false;
extern int    MinsBeforeLow       = 30;
extern int    MinsAfterLow        = 30;
// news items with "Speaks" in them have different characteristics
extern bool   IncludeSpeaks       = false;
extern int    MinsBeforeSpeaks    = 180;
extern int    MinsAfterSpeaks     = 120;
extern bool	  ReportAllForUSD	    = true;
extern bool   ReportAllForEUR     = false;
extern bool   ReportAllForGBP     = false;
extern bool   ReportAllForNZD     = false;
extern bool   ReportAllForJPY     = false;
extern bool   ReportAllForAUD     = false;
extern bool   ReportAllForCHF     = false;
extern bool   ReportAllForCAD     = false;
extern bool   ReportAllForCNY     = false;
//----------------------------------------------------------------------- +
bool            IsNewBar;
MqlDateTime     currentBarTimeStruct, lastBarTimeStruct, timeGMTStruct;
datetime        currentBarTimeGMT;
datetime        lastBarTimeGMT;
int             timeGMTOffset=0;


double totalProfit;
bool gi_956 = FALSE;
bool gi_960 = FALSE;
double gd_964;
double g_pips_972 = 0.0;
double gi_execution_point = 0;
double gi_stop_loss = 0;
double gi_take_profit = 0;
int gi_unused_988 = 300;
int gi_992 = 5000;
int gi_996 = 0;
int gi_1000 = 0;
double gd_1004 = 100.0;
int gi_1012 = 600;
double gd_1016;
bool gi_1024;
int g_period_1028 = 7;
int gi_1032 = 0;
int g_ma_method_1036 = MODE_LWMA;
int g_applied_price_1040 = PRICE_WEIGHTED;
double gd_1044 = 0.25;
double gd_1052 = 0.2;
double gd_1060 = 1.01;
int gi_1068 = 5;
int g_datetime_1072;
double gd_1076;
int gi_1084;
bool gi_unused_1088 = FALSE;
string gs_dummy_1092;
int gi_unused_1108 = 0;
int gi_unused_1112 = 1;
int gi_unused_1116 = 3;
int gi_unused_1120 = 250;
string gs_1124;
bool gi_1132;
bool gi_1136;
bool gi_1140;
bool gi_1144;
int g_ticket_1148;
int g_cmd_1152;
string gs__hedged_1156 = " hedged";
int gi_1164;
bool gi_1168 = FALSE;
string gs_1172 = "12345678901234567890123456789012345678901234567890ABCDEFGHIJKLMNOP";
double gda_1180[27];
double gda_1184[27];
double gda_1196[4];
int gi_1200;
bool gi_1212 = FALSE;
int gia_1216[25];
int gia_1220[25];
double gda_1224[25];
double gda_1228[25];
double gda_1232[25];
double gda_1236[25];
int g_error_1248;
int gLevel[2]; //SE for chart_comment
int SignalPeriod = Period();
double Last_TP[2]; // Fix 0.5 to store TP if TCB
double base_lot;

double StartingBalance;

//--------------------------------- SPIKES ----
/*extern*/ double ATR_Slow_Period = 60;
/*extern*/ double ATR_Fast_Period = 1;
/*extern*/ int MinutesToSleep = 4*PERIOD_H1;
/*extern*/ double LittleSpikeMultiplier = 1;
/*extern*/ double BigSpikeMultiplier = 3.6;
bool spikeAlert=false;
datetime lastSpikeAlertTime;
//--------------------------------- PIVOTS ----
double Fhr_day_high=0;
double Fhr_day_low=0;
double Fhr_yesterday_high=0;
double Fhr_yesterday_open=0;
double Fhr_yesterday_low=0;
double Fhr_yesterday_close=0;
double Fhr_today_open=0;
double Fhr_today_high=0;
double Fhr_today_low=0;
double Fhr_P=0;
double Fhr_Q=0;
double Fhr_R1,Fhr_R2,Fhr_R3;
double Fhr_M0,Fhr_M1,Fhr_M2,Fhr_M3,Fhr_M4,Fhr_M5;
double Fhr_S1,Fhr_S2,Fhr_S3;
double Fhr_nQ=0;
double Fhr_nD=0;
double Fhr_D=0;
double Fhr_rates_d1[2][6];
double Fhr_ExtMapBuffer[];
//---------------------------------
double D_day_high=0;
double D_day_low=0;
double D_yesterday_high=0;
double D_yesterday_open=0;
double D_yesterday_low=0;
double D_yesterday_close=0;
double D_today_open=0;
double D_today_high=0;
double D_today_low=0;
double D_P=0;
double D_Q=0;
double D_R1,D_R2,D_R3;
double D_M0,D_M1,D_M2,D_M3,D_M4,D_M5;
double D_S1,D_S2,D_S3;
double D_nQ=0;
double D_nD=0;
double D_D=0;
double D_rates_d1[2][6];
double D_ExtMapBuffer[];
//---------------------------------
double nearest_support = 0;
double nearest_resistance = 0;
double nearest_daily_support = 0;
double nearest_daily_resistance = 0;

double farest_support = 0;
double farest_resistance = 0;
double farest_daily_support = 0;
double farest_daily_resistance = 0;
//---------------------------------

//---- indicator parameters

/*extern*/ string _____ = "SWB indicator settings";
/*extern*/ bool Use_SWB_indicator = false;
/*extern*/ bool      swb_is_reversed = FALSE;

/*extern*/ bool      use_bb=true;
/*extern*/ int       bb_period=20;
/*extern*/ int       bb_deviation=2;
/*extern*/ int       bb_shift=0;
/*extern*/ bool      use_stoch=true;
/*extern*/ int       k=5;
/*extern*/ int       d=3;
/*extern*/ int       slowing=3;
/*extern*/ int       price_field=0;
/*extern*/ int       stoch_shift=0;
/*extern*/ int       lo_level=30;
/*extern*/ int       up_level=70;
/*extern*/ bool      use_rsi=true;
/*extern*/ int       rsi_period=12;
/*extern*/ int       rsi_shift=0;
/*extern*/ int       lower=30;
/*extern*/ int       upper=70;
int CorrelationRadius                 = 25;
int MA_Period                         = 20;
int ResultingBars                     = 0;
double HeatMapDailyPercRateTholdMin   = 0.23;
double HeatMapDailyPercRateTholdMax   = 0.33;
string II1   = "== BBands Signals";
string II1_2 = "== Doda-BBands2";
int        Length                     = 20;
int        Deviation                  = 2;
double     MoneyRisk                  = 2.0;
int        Signal                     = 1;
int        Line                       = 1;
int        Nbars                      = 100;
string II1_3 = "== bbsqueeze_dark";
int        bolPrd                     = 20;
double     bolDev                     = 2.0;
int        keltPrd                    = 20;
double     keltFactor                 = 1.5;
int        momPrd                     = 12;
int Viscosity         = 7;      //[Viscosity] - Volatility Viscosity
int Sedimentation     = 50;     //[Sedimentation] - Volatility Sedimentation
double Threshold_level= 1.1;   //[Threshold_level] - Volatility Threshold
bool lag_supressor    = true;   //[lag_supressor] - Volatility Lag Suppressor
//---------------------------------
double    lag_s_K=0.5;
//---- buffers
double thresholdBuffer[];
double vol_m[];
double vol_t[];
double ind_c[];
double soglie[];
double regression_line[];           // array dei valori della retta di regressione

//---------------------------------------------------------------------------
bool TriggerLongHit;
bool TriggerShortHit;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);

//Adjust Time GMT Offset
   TimeToStruct(iTime(Symbol(),PERIOD_M1,0),currentBarTimeStruct);
   TimeGMT(timeGMTStruct);
   timeGMTOffset = (currentBarTimeStruct.hour-timeGMTStruct.hour);
   currentBarTimeGMT = GetTimeToGMT(iTime(Symbol(),PERIOD_M1,0));
   lastBarTimeGMT = currentBarTimeGMT;

  //---
  if((!IsTesting())&&(!IsOptimization())) 
  {
      datetime pc_time = TimeLocal();
	   datetime my_time_GMT = myTimeGMT();
	
      GMT_Offset=(TimeHour(pc_time) - TimeHour(my_time_GMT));//GMT_Offset=GMTOffset();
  }
  //---

//--- Assert 0: Init Plus   
   TurtleInit();
   GhostInit();
//--- 
   // gi_1212 = FALSE;
   if (Chicken_Out == TRUE) gi_960 = TRUE;
   else gi_960 = FALSE;
//   if (Period() != PERIOD_H1) {
//      Print("ERROR -- ",EA_Name," should be attached to ",Symbol()," H1 chart window");
//      Alert("ERROR -- ",EA_Name," should be attached to ",Symbol()," H1 chart window");
//      
//      return(INIT_PARAMETERS_INCORRECT);
//   }
   //updateMagicNumber();
   MathSrand(ExecutionPoint+BasketTakeProfit*Multiplier); // Fix 0.5 for Un-synk
   gsa_92[0] = GhostAccountNumber();
   gsa_92[1] = KEY;
   gsa_92[2] = User;
   gsa_92[3] = gs_168;
   gi_76 = fun1(gsa_92, ArraySize(gsa_92), 0.1, gs_1172, IsDemo());
   gd_964 = Multiplier;
//------
   gi_execution_point = ExecutionPoint;
   gi_stop_loss = BasketStopLoss;
   gi_take_profit = BasketTakeProfit;
  /*
   if (Digits == 3) {
      gi_execution_point = 10.0 * ExecutionPoint;
      gi_stop_loss = 10.0 * BasketStopLoss;
      gi_take_profit = 10.0 * BasketTakeProfit;
   } else {
      if (Digits == 5) {
         gi_execution_point = 10.0 * ExecutionPoint;
         gi_stop_loss = 10.0 * BasketStopLoss;
         gi_take_profit = 10.0 * BasketTakeProfit;
      } else {
         gi_execution_point = ExecutionPoint;
         gi_stop_loss = BasketStopLoss;
         gi_take_profit = BasketTakeProfit;
      }
   }
  */
//------
   gda_1180[0] = BasketTakeProfit_1;
   gda_1180[1] = BasketTakeProfit_2;
   gda_1180[2] = BasketTakeProfit_3;
   gda_1180[3] = BasketTakeProfit_4;
   gda_1180[4] = BasketTakeProfit_5;
   gda_1180[5] = BasketTakeProfit_6;
   gda_1180[6] = BasketTakeProfit_7;
   gda_1180[7] = BasketTakeProfit_8;
   gda_1180[8] = BasketTakeProfit_9;
   gda_1180[9] = BasketTakeProfit_10;
   gda_1180[10] = BasketTakeProfit_11;
   gda_1180[11] = BasketTakeProfit_12;
   gda_1180[12] = BasketTakeProfit_13;
   gda_1180[13] = BasketTakeProfit_14;
   gda_1180[14] = BasketTakeProfit_15;
   gda_1180[15] = BasketTakeProfit_16;
   gda_1180[16] = BasketTakeProfit_17;
   gda_1180[17] = BasketTakeProfit_18;
   gda_1180[18] = BasketTakeProfit_19;
   gda_1180[19] = BasketTakeProfit_20;
   gda_1180[20] = BasketTakeProfit_21;
   gda_1180[21] = BasketTakeProfit_22;
   gda_1180[22] = BasketTakeProfit_23;
   gda_1180[23] = BasketTakeProfit_24;
   gda_1180[24] = BasketTakeProfit_25;
   gda_1180[25] = BasketTakeProfit;
   gda_1180[26] = BasketTakeProfit_1;
   gda_1184[0] = Multiplier_1;
   gda_1184[1] = Multiplier_2;
   gda_1184[2] = Multiplier_3;
   gda_1184[3] = Multiplier_4;
   gda_1184[4] = Multiplier_5;
   gda_1184[5] = Multiplier_6;
   gda_1184[6] = Multiplier_7;
   gda_1184[7] = Multiplier_8;
   gda_1184[8] = Multiplier_9;
   gda_1184[9] = Multiplier_10;
   gda_1184[10] = Multiplier_11;
   gda_1184[11] = Multiplier_12;
   gda_1184[12] = Multiplier_13;
   gda_1184[13] = Multiplier_14;
   gda_1184[14] = Multiplier_15;
   gda_1184[15] = Multiplier_16;
   gda_1184[16] = Multiplier_17;
   gda_1184[17] = Multiplier_18;
   gda_1184[18] = Multiplier_19;
   gda_1184[19] = Multiplier_20;
   gda_1184[20] = Multiplier_21;
   gda_1184[21] = Multiplier_22;
   gda_1184[22] = Multiplier_23;
   gda_1184[23] = Multiplier_24;
   gda_1184[24] = Multiplier_25;
   gda_1184[25] = Multiplier;
   gda_1184[26] = Multiplier_1;
   int li_0 = fun0(gda_1180, gda_1184, Digits, 0, Point, gda_1196, 0, IsDemo());
   if (li_0 >= 0) {
      g_pips_972 = gda_1196[0];
      gd_1076 = gda_1196[1];
      gd_964 = gda_1196[2];
   }
   gi_1084 = MathRound((-MathLog(MarketInfo(Symbol(), MODE_LOTSTEP))) / 2.302585093);
   gi_1132 = FALSE;
   gi_1136 = FALSE;
   gi_1140 = FALSE;
   gi_1144 = FALSE;
   g_ticket_1148 = -1;
   gi_1024 = FALSE;
   g_cmd_1152 = -1;
   gs_1124 = "approved";
   if (gi_76 == 0) {
      Print("Please input valid KEY.");
      Alert("Please input valid KEY.");
   }
   StartingBalance = AccountBalance();
   //NBP=gi_take_profit;
   GhostFreeSelect(false);
//---
   ArrayCopyRates(Fhr_rates_d1, Symbol(), PERIOD_H1);
   ArrayCopyRates(D_rates_d1, Symbol(), 1440);
//---
   TriggerLongHit = FALSE;
   TriggerShortHit = FALSE;
//---
   
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
//--- Assert 2: DeInit Plus
   GhostDeInit();
   Comment("");
   ObjectDelete("Buy_Target");
   ObjectDelete("Buy_StopLoss");
   ObjectDelete("Sell_Target");
   ObjectDelete("Sell_StopLoss");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
//-------------------------------------------------------------------------
   IsNewBar = CheckIsNewBar();
   
   if (IsNewBar)
   {
   //Adjust Time GMT Offset
      TimeToStruct(iTime(GhostOrderSymbol(),PERIOD_M1,0),currentBarTimeStruct);
      TimeGMT(timeGMTStruct);
      timeGMTOffset = (currentBarTimeStruct.hour-timeGMTStruct.hour);
   }
//-- Pivots, Support/Resistance and Price Alerts
   //get_pivots(Symbol(), PERIOD_H4);
   get_NearestAndFarestSR(GhostOrderSymbol(), PERIOD_H1, (iLow(GhostOrderSymbol(), PERIOD_H1, 2)+iHigh(GhostOrderSymbol(), PERIOD_H1, 2))/2.0 );
   
   int lowestIndex = iLowest(NULL, 0, MODE_LOW, i_extremumRank, 3);
   int highestIndex = iHighest(NULL, 0, MODE_HIGH, i_extremumRank, 3);
   
   double lowest  = Low[lowestIndex];
   double highest = High[highestIndex];
//---

//------------------------------------------------------------------------------------------
if (IsNewBar && DrawLines)
{
//--- Draw Pivot lines on chart
   if(ObjectFind("Nearest_Support label") == 0) ObjectDelete("Nearest_Support label");
    ObjectCreate("Nearest_Support label", OBJ_TEXT, 0, Time[0], nearest_support);
    ObjectSetText("Nearest_Support label", "Nearest Support @ " +DoubleToStr((iLow(Symbol(), 0, 1)+iHigh(Symbol(), 0, 1))/2.0,4)+ " -> " +DoubleToStr(nearest_support,4), 8, "Arial", EMPTY);
   if(ObjectFind("Nearest_Support line") != 0)
   {
      ObjectCreate("Nearest_Support line", OBJ_HLINE, 0, Time[0], nearest_support);
      ObjectSet("Nearest_Support line", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet("Nearest_Support line", OBJPROP_WIDTH,2);
      ObjectSet("Nearest_Support line", OBJPROP_COLOR, Blue);
   }
   else
   {
      ObjectMove("Nearest_Support line", 0, Time[40], nearest_support);
   }
//-----
   if(ObjectFind("Nearest_Resistance label") == 0) ObjectDelete("Nearest_Resistance label");
    ObjectCreate("Nearest_Resistance label", OBJ_TEXT, 0, Time[0], nearest_resistance);
    ObjectSetText("Nearest_Resistance label", "Nearest Resistance @ " +DoubleToStr((iLow(Symbol(), 0, 1)+iHigh(Symbol(), 0, 1))/2.0,4)+ " -> " +DoubleToStr(nearest_resistance,4), 8, "Arial", EMPTY);
   if(ObjectFind("Nearest_Resistance line") != 0)
   {
      ObjectCreate("Nearest_Resistance line", OBJ_HLINE, 0, Time[0], nearest_resistance);
      ObjectSet("Nearest_Resistance line", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet("Nearest_Resistance line", OBJPROP_WIDTH,2);
      ObjectSet("Nearest_Resistance line", OBJPROP_COLOR, Red);
   }
   else
   {
      ObjectMove("Nearest_Resistance line", 0, Time[40], nearest_resistance);
   }
//-----
//-----
   if(ObjectFind("Nearest_Daily_Support label") == 0) ObjectDelete("Nearest_Daily_Support label");
    ObjectCreate("Nearest_Daily_Support label", OBJ_TEXT, 0, Time[0], nearest_daily_support);
    ObjectSetText("Nearest_Daily_Support label", "Nearest Daily Support @ " +DoubleToStr((iLow(Symbol(), 0, 1)+iHigh(Symbol(), 0, 1))/2.0,4)+ " -> " +DoubleToStr(nearest_daily_support,4), 8, "Arial", EMPTY);
   if(ObjectFind("Nearest_Daily_Support line") != 0)
   {
      ObjectCreate("Nearest_Daily_Support line", OBJ_HLINE, 0, Time[0], nearest_daily_support);
      ObjectSet("Nearest_Daily_Support line", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet("Nearest_Daily_Support line", OBJPROP_WIDTH,2);
      ObjectSet("Nearest_Daily_Support line", OBJPROP_COLOR, LightBlue);
   }
   else
   {
      ObjectMove("Nearest_Daily_Support line", 0, Time[40], nearest_daily_support);
   }
//-----
   if(ObjectFind("Nearest_Daily_Resistance label") == 0) ObjectDelete("Nearest_Daily_Resistance label");
    ObjectCreate("Nearest_Daily_Resistance label", OBJ_TEXT, 0, Time[0], nearest_daily_resistance);
    ObjectSetText("Nearest_Daily_Resistance label", "Nearest Daily Resistance @ " +DoubleToStr((iLow(Symbol(), 0, 1)+iHigh(Symbol(), 0, 1))/2.0,4)+ " -> " +DoubleToStr(nearest_daily_resistance,4), 8, "Arial", EMPTY);
   if(ObjectFind("Nearest_Daily_Resistance line") != 0)
   {
      ObjectCreate("Nearest_Daily_Resistance line", OBJ_HLINE, 0, Time[0], nearest_daily_resistance);
      ObjectSet("Nearest_Daily_Resistance line", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet("Nearest_Daily_Resistance line", OBJPROP_WIDTH,2);
      ObjectSet("Nearest_Daily_Resistance line", OBJPROP_COLOR, LightPink);
   }
   else
   {
      ObjectMove("Nearest_Daily_Resistance line", 0, Time[40], nearest_daily_resistance);
   }
//-----
//-----
   if(ObjectFind("Lowest_Supoprt label") == 0) ObjectDelete("Lowest_Supoprt label");
    ObjectCreate("Lowest_Supoprt label", OBJ_TEXT, 0, Time[0], lowest);
    ObjectSetText("Lowest_Supoprt label", "Lowest Support @ " +DoubleToStr(lowest,4), 8, "Arial", EMPTY);
   if(ObjectFind("Lowest_Supoprt line") != 0)
   {
      ObjectCreate("Lowest_Supoprt line", OBJ_HLINE, 0, Time[0], lowest);
      ObjectSet("Lowest_Supoprt line", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet("Lowest_Supoprt line", OBJPROP_WIDTH,2);
      ObjectSet("Lowest_Supoprt line", OBJPROP_COLOR, Magenta);
   }
   else
   {
      ObjectMove("Lowest_Supoprt line", 0, Time[40], lowest);
   }
//-----
   if(ObjectFind("Highest_Resistance label") == 0) ObjectDelete("Highest_Resistance label");
    ObjectCreate("Highest_Resistance label", OBJ_TEXT, 0, Time[0], lowest);
    ObjectSetText("Highest_Resistance label", "Highest Resistance @ " +DoubleToStr(highest,4), 8, "Arial", EMPTY);
   if(ObjectFind("Highest_Resistance line") != 0)
   {
      ObjectCreate("Highest_Resistance line", OBJ_HLINE, 0, Time[0], highest);
      ObjectSet("Highest_Resistance line", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet("Highest_Resistance line", OBJPROP_WIDTH,2);
      ObjectSet("Highest_Resistance line", OBJPROP_COLOR, Magenta);
   }
   else
   {
      ObjectMove("Highest_Resistance line", 0, Time[40], highest);
   }
//-----
   WindowRedraw();
//-----
}
//------------------------------------------------------------------------------------------
   if (base_lot == 0 || GhostOrdersTotal() == 0) {
      base_lot = LOT();
   }
//---
   double order_takeprofit_0;
   double ld_8;
   double ld_16;
   double order_takeprofit_44;
   int li_52;
   bool bool_56;
   f0_8();
   //if (IsTesting()) {
   //   if (Period() != PERIOD_M30) {
   //      Print("ERROR -- Leviathan should be attached to " + Symbol() + " 30 minute chart window");
   //      Alert("ERROR -- Leviathan should be attached to " + Symbol() + " 30 minute chart window");
   //      return;
   //   }
   //} else {
   //   if (Period() != PERIOD_M30) {
   //      Print("ERROR -- Leviathan should be attached to " + Symbol() + " 30 minute chart window");
   //      Alert("ERROR -- Leviathan should be attached to " + Symbol() + " 30 minute chart window");
   //      return;
   //   }
   //}

//-----------------------------------
//--- SPIKE ALERT
/*
   bool spikeDetected = false;

   //---
   double ATRfast = iATR(Symbol(), 0, ATR_Fast_Period, 0);
   double ATRslow = iATR(Symbol(), 0, ATR_Slow_Period, 0);
   
   //Print("ATRfast / ATRslow - ",ATRfast," / ",ATRslow);
   
   if ( !spikeDetected && ATRfast >= (BigSpikeMultiplier *  ATRslow) ) spikeDetected = true;
   //---
   
   if( !spikeAlert && spikeDetected && (TimeCurrent() - lastSpikeAlertTime) >= MinutesToSleep*60)
   {
      Alert("Spike on " + Symbol() + "!");
      Log("[SPIKE ALERT] - (Fast = " + ATRfast + ", Slow = " + ATRslow + ") - Sleep for "+MinutesToSleep+" minutes ...");
      CloseAllOrders();
      spikeAlert = true;
      lastSpikeAlertTime = TimeCurrent();
   }

   if( spikeAlert )
   {
      if( (TimeCurrent() - lastSpikeAlertTime) >= MinutesToSleep*60 ) 
      {
         Log("[SPIKE ALERT] - Wake up after ",IntegerToString(MinutesToSleep)," minutes...");
         spikeAlert = false;
      }
      else
      {
         return;
      }
   }
*/
//-----------------------------------  
/*
   if (trigger(OP_BUY, 0) == 1)
   {
      TriggerLongHit = TRUE;
   }

   if (trigger(OP_SELL, 0) == -1)
   {
      TriggerShortHit = TRUE;
   }
*/
   /*if(IsNewBar)
   {*/

   // Broker digits
      double point=Point;
      if((Digits==3) || (Digits==5))
        {
         point*=10;
        }

      double PipValue=(((MarketInfo(GhostOrderSymbol(),MODE_TICKVALUE)*point)/MarketInfo(GhostOrderSymbol(),MODE_TICKSIZE))*BaseLotSize);
      double PointValue=PipValue/10;

  if (BalanceChecks) {
   if(GetOrdersCount(OP_SELL)>=2 && GetOrdersProfit(OP_SELL) > 0) {
      double nn_sup = NormalizeDouble(IsLocalMinimum(3, i_extremumRank),Digits);
      double diff   = NormalizeDouble(MathAbs(Ask - nn_sup),Digits);
      double target = NormalizeDouble(5*getPointCoef(),Digits);
      Print("--nearest support:",nn_sup,"--diff:",diff,"--target:",target);
      if(nn_sup != EMPTY_VALUE && nn_sup > 0 && diff<=target) {
         Print(" ----------------SELL:",GetOrdersProfit(OP_SELL));
         TriggerShortHit = FALSE;
         CloseSellOrders(TRUE);
      } 
   }
   if(GetOrdersCount(OP_BUY)>=2 && GetOrdersProfit(OP_BUY) > 0) {
      double nn_res = NormalizeDouble(IsLocalMaximum(3, i_extremumRank),Digits);
      double diff   = NormalizeDouble(MathAbs(Bid - nn_res),Digits);
      double target = NormalizeDouble(5*getPointCoef(),Digits);
      Print("--nearest resistance:",nn_res,"--diff:",diff,"--target:",target);
      if(nn_res != EMPTY_VALUE && nn_res > 0 && diff<=target) {
         Print(" ----------------BUY:",GetOrdersProfit(OP_BUY));
         TriggerLongHit = FALSE;
         CloseBuyOrders(TRUE);
      } 
   }
   /*
      if (TriggerLongHit)
      {
         if(GetOrdersProfit(OP_BUY)>20*PipValue)
         {
            Print(" ----------------BUY:",GetOrdersProfit(OP_BUY));
            TriggerLongHit = FALSE;
            CloseBuyOrders(TRUE);
            //ChickenOutClose(GhostOrderSymbol(), OP_BUY);
         }
      }
      else
      if (TriggerShortHit)
      {
         if(GetOrdersProfit(OP_SELL)>20*PipValue)
         {
            Print(" ----------------SELL:",GetOrdersProfit(OP_SELL));
            TriggerShortHit = FALSE;
            CloseSellOrders(TRUE);
            //ChickenOutClose(GhostOrderSymbol(), OP_SELL);
         }
      }
      else
      if (GhostOrdersTotal()>=5 && GetOrdersProfit(OP_BUY)+GetOrdersProfit(OP_SELL) > 0) {
            Print(" ----------------SELL:",GetOrdersProfit(OP_SELL));
            Print(" ----------------BUY:",GetOrdersProfit(OP_BUY));
            TriggerLongHit = FALSE;
            TriggerShortHit = FALSE;
            CloseBuyOrders(TRUE);
            CloseSellOrders(TRUE);
            //ChickenOutClose(GhostOrderSymbol(), OP_BUY);
            //ChickenOutClose(GhostOrderSymbol(), OP_SELL);
      }
      else
      if (GhostOrdersTotal()>=6 && GhostAccountEquity()>GhostAccountBalance()) {
            Print(" ----------------AccountBalance:",GhostAccountBalance());
            Print(" ----------------AccountEquity:",GhostAccountEquity());
            Print(" ----------------SELL:",GetOrdersProfit(OP_SELL));
            Print(" ----------------BUY:",GetOrdersProfit(OP_BUY));
            TriggerLongHit = FALSE;
            TriggerShortHit = FALSE;
            CloseBuyOrders(TRUE);
            CloseSellOrders(TRUE);
            //ChickenOutClose(GhostOrderSymbol(), OP_BUY);
            //ChickenOutClose(GhostOrderSymbol(), OP_SELL);
      }
      else
      if (GhostOrdersTotal()>=7 && GhostAccountBalance()-GhostAccountEquity()<=50*PipValue) {
            Print(" ----------------AccountBalance:",GhostAccountBalance());
            Print(" ----------------AccountEquity:",GhostAccountEquity());
            Print(" ----------------SELL:",GetOrdersProfit(OP_SELL));
            Print(" ----------------BUY:",GetOrdersProfit(OP_BUY));
            TriggerLongHit = FALSE;
            TriggerShortHit = FALSE;
            CloseBuyOrders(TRUE);
            CloseSellOrders(TRUE);
            //ChickenOutClose(GhostOrderSymbol(), OP_BUY);
            //ChickenOutClose(GhostOrderSymbol(), OP_SELL);
      }
    */
  }
   RefreshRates();
   /*
   if (gi_960 == TRUE) {
      CloseBuyOrders(TRUE);
      CloseSellOrders(TRUE);
      //ChickenOutClose(GhostOrderSymbol(), OP_BUY);
      //ChickenOutClose(GhostOrderSymbol(), OP_SELL);
      return;
   }
   */
   if (FreezeAfterTPScheduler == TRUE) gi_956 = f0_4();
   gsa_92[0] = GhostAccountNumber();
   gsa_92[1] = KEY;
   gsa_92[2] = User;
   gsa_92[3] = gs_168;
   gi_76 = fun1(gsa_92, ArraySize(gsa_92), 0.2, gs_1172, IsDemo());
   if (gs_1124 != "approved" || gi_76 == 0) {
      Comment("Access denied!", 
      "\nPlease input valid KEY and User into the EA parameters.");
      return;
   }
   int count_24 = 0;
   int count_28 = 0;
//--- Assert 0: close most losing orders
   ProgressiveStopLoss();
//--- Assert 1: equity protection
   EquityStopLoss();
//--- Assert 2: Init OrderSelect #15
   int total = GhostOrdersTotal();
   
   if (total == 0 && AccountBalance() > StartingBalance) StartingBalance = AccountBalance();
   
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32, SELECT_BY_POS, MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber) {
            if (StringFind(GhostOrderComment(), gs__hedged_1156) == -1) {
               if (GhostOrderType() == OP_BUY) {
                  count_24++;
                  continue;
               }
               if (GhostOrderType() == OP_SELL) count_28++;
            }
         }
      }
   }
//--- Assert 1: Free OrderSelect #15
   GhostFreeSelect(false);
   if (count_24 >= gi_1068) {
      if (!gi_1144) {
         f0_16("Allow long hedge! trades=" + count_24 + ",TradesDeep=" + gi_1068);
         gi_1144 = TRUE;
      }
   }
   if (count_28 >= gi_1068) {
      if (!gi_1140) {
         f0_16("Allow short hedge! trades=" + count_28 + ",TradesDeep=" + gi_1068);
         gi_1140 = TRUE;
      }
   }
   bool li_36 = FALSE;
   if ((100 - BailOutPct) * GhostAccountBalance() / 100.0 >= GhostAccountEquity()) {
      f0_16("AccountBalance=" + GhostAccountBalance() + ",AccountEquity=" + GhostAccountEquity());
      gi_1024 = TRUE;
      li_36 = TRUE;
   }
   if ((gd_1004 + 100.0) * GhostAccountBalance() / 100.0 <= GhostAccountEquity()) gi_1024 = TRUE;
   if (gi_1024) {
   //--- Assert 6: Declare variables
      int      aCommand[];    // 1-OrderModify BUY; 2-OrderClose BUY; 3-OrderModify SELL; 4-OrderClose SELL;
      int      aTicket[];
      double   aLots[];
      double   aClosePrice[];
      bool     aOk[];
      int      aCount;
   //--- Assert 5: Dynamically resize arrays
      ArrayResize(aCommand,MaxAccountTrades);
      ArrayResize(aTicket,MaxAccountTrades);
      ArrayResize(aLots,MaxAccountTrades);
      ArrayResize(aClosePrice,MaxAccountTrades);
      ArrayResize(aOk,MaxAccountTrades);
   //--- Assert 2: Init OrderSelect #16
      int      aTotal = GhostOrdersTotal();
      GhostInitSelect(false,0,SELECT_BY_POS,MODE_TRADES);
      for (int pos_40 = aTotal - 1; pos_40 >= 0; pos_40--) {
         if (GhostOrderSelect(pos_40, SELECT_BY_POS)) {
         //--- Assert 5: Populate arrays
            aCommand[aCount]     =  2;
            aTicket[aCount]      =  GhostOrderTicket();
            aLots[aCount]        =  GhostOrderLots();
            aClosePrice[aCount]  =  GhostOrderClosePrice();
            if (GhostOrderMagicNumber() == MagicNumber) {
               f0_16("close #" + GhostOrderTicket());
            //--- 6: Assert replace OrderClose a buy trade with arrays
               aCommand[aCount]     = 2; 
               aClosePrice[aCount]  = NormalizeDouble(Bid, Digits);
               aCount ++;
               if( aCount >= MaxAccountTrades ) break;
               /*if (!OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White)) {
                  f0_16("error");
                  return (0);
               }*/
            }
         }
      }
   //--- Assert 1: Free OrderSelect #16
      GhostFreeSelect(false);
   //--- Assert for: process array of commands
      for(int i=0; i<aCount; i++)
      {
         switch( aCommand[i] )
         {
            case 1:  // OrderModify Buy
            case 2:  // OrderClose Buy
               GhostOrderClose( aTicket[i], aLots[i], aClosePrice[i], MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
               break;
            case 3:  // OrderModify Sell
            case 4:  // OrderClose Sell
               break;
         }
      }
      gi_1024 = FALSE;
      if (li_36) {
         Sleep(1000 * gi_1012);
         li_36 = FALSE;
      }
      gi_1144 = FALSE;
      gi_1140 = FALSE;
   }
   if (SupportECN) {
      order_takeprofit_0 = 0;
   //--- Assert 1: Init OrderSelect #17
      GhostInitSelect(true,g_ticket_1148,SELECT_BY_TICKET,MODE_TRADES);
      if (GhostOrderSelect(g_ticket_1148, SELECT_BY_TICKET)) order_takeprofit_0 = GhostOrderTakeProfit();
   //--- Assert 1: Free OrderSelect #17
      GhostFreeSelect(false);
   //--- Assert 7: Declare variables
      int      bCommand[];    // 1-OrderModify BUY; 2-OrderClose BUY; 3-OrderModify SELL; 4-OrderClose SELL;
      int      bTicket[];
      double   bOpenPrice[];
      double   bStopLoss[];
      double   bTakeProfit[];
      bool     bOk[];
      int      bCount;
   //--- Assert 6: Dynamically resize arrays
      ArrayResize(bCommand,MaxAccountTrades);
      ArrayResize(bTicket,MaxAccountTrades);
      ArrayResize(bOpenPrice,MaxAccountTrades);
      ArrayResize(bStopLoss,MaxAccountTrades);
      ArrayResize(bTakeProfit,MaxAccountTrades);
      ArrayResize(bOk,MaxAccountTrades);
   //--- Assert 2: Init OrderSelect #18
      int   bTotal = GhostOrdersTotal();
      GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
      for (int pos_40 = 0; pos_40 < bTotal; pos_40++) {
         if (GhostOrderSelect(pos_40, SELECT_BY_POS)) {
         //--- Assert 5: Populate arrays
            bCommand[bCount]     =  0;
            bTicket[bCount]      =  GhostOrderTicket();
            bOpenPrice[bCount]   =  GhostOrderOpenPrice();
            bStopLoss[bCount]    =  GhostOrderStopLoss();
            bTakeProfit[bCount]  =  GhostOrderTakeProfit();
            if (GhostOrderMagicNumber() == MagicNumber) {
               order_takeprofit_44 = GhostOrderTakeProfit();
               if (order_takeprofit_44 == 0.0 && StringFind(GhostOrderComment(), gs__hedged_1156) == -1) {
                  if (GhostOrderType() == OP_BUY) {
                     if (count_24 > 0) {
                        gi_1200 = fun0(gda_1180, gda_1184, Digits, count_24 - 1, Point, gda_1196, count_24 - 1, IsDemo());
                        if (gi_1200 >= 0) {
                           g_pips_972 = gda_1196[0];
                           gd_1076 = gda_1196[1];
                           gd_964 = gda_1196[2];
                           if (gi_1200 == 0) gi_1168 = FALSE;
                           else gi_1168 = TRUE;
                        }
                     } else {
                        gi_1200 = fun0(gda_1180, gda_1184, Digits, count_24, Point, gda_1196, count_24, IsDemo());
                        if (gi_1200 >= 0) {
                           g_pips_972 = gda_1196[0];
                           gd_1076 = gda_1196[1];
                           gd_964 = gda_1196[2];
                           if (gi_1200 == 0) gi_1168 = FALSE;
                           else gi_1168 = TRUE;
                        }
                     }
                     li_52 = Close_Order_Attempts;
                     bool_56 = FALSE;
                     while (bool_56 == FALSE && li_52 >= 0) {
                        li_52--;
                        RefreshRates();
                     //--- 6: Assert replace OrderModify a buy trade with arrays
                        bCommand[bCount]     = 1; 
                        bOpenPrice[bCount]   = 0;
                        bStopLoss[bCount]    = NormalizeDouble(GhostOrderStopLoss(), Digits);
                        bTakeProfit[bCount]  = NormalizeDouble(
                                    GhostOrderOpenPrice() + BasketTakeProfit * getPointCoef() + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef(), Digits);
                        bCount ++;
                        if( bCount >= MaxAccountTrades ) break;
                        /*bool_56 = OrderModify(OrderTicket(), 0, NormalizeDouble(OrderStopLoss(), Digits), NormalizeDouble(OrderOpenPrice() + g_pips_972 * getPointCoef(), Digits), 0, White);*/
                        if (!TRUE) {
                           g_error_1248 = GetLastError();
                           if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                              Sleep(50);
                              continue;
                           }
                        }
                        bool_56 = TRUE;
                     }
                  } else {
                     if (GhostOrderType() != OP_SELL) continue;
                     if (count_28 > 0) {
                        gi_1200 = fun0(gda_1180, gda_1184, Digits, count_28 - 1, Point, gda_1196, count_28 - 1, IsDemo());
                        if (gi_1200 >= 0) {
                           g_pips_972 = gda_1196[0];
                           gd_1076 = gda_1196[1];
                           gd_964 = gda_1196[2];
                           if (gi_1200 == 0) gi_1168 = FALSE;
                           else gi_1168 = TRUE;
                        }
                     } else {
                        gi_1200 = fun0(gda_1180, gda_1184, Digits, count_28, Point, gda_1196, count_28, IsDemo());
                        if (gi_1200 >= 0) {
                           g_pips_972 = gda_1196[0];
                           gd_1076 = gda_1196[1];
                           gd_964 = gda_1196[2];
                           if (gi_1200 == 0) gi_1168 = FALSE;
                           else gi_1168 = TRUE;
                        }
                     }
                     li_52 = Close_Order_Attempts;
                     bool_56 = FALSE;
                     while (bool_56 == FALSE && li_52 >= 0) {
                        li_52--;
                        RefreshRates();
                     //--- 6: Assert replace OrderModify a sell trade with arrays
                        bCommand[bCount]     = 3; 
                        bOpenPrice[bCount]   = 0;
                        bStopLoss[bCount]    = NormalizeDouble(GhostOrderStopLoss(), Digits);
                        bTakeProfit[bCount]  = NormalizeDouble(
                                 GhostOrderOpenPrice() - BasketTakeProfit * getPointCoef() - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef(), Digits);
                        bCount ++;
                        if( bCount >= MaxAccountTrades ) break;
                        /*bool_56 = OrderModify(OrderTicket(), 0, NormalizeDouble(OrderStopLoss(), Digits), NormalizeDouble(OrderOpenPrice() - g_pips_972 * getPointCoef(), Digits), 0, White);*/
                        if (!TRUE) {
                           g_error_1248 = GetLastError();
                           if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                              Sleep(50);
                              continue;
                           }
                        }
                        bool_56 = TRUE;
                     }
                     continue;
                  }
               }
               if (StringFind(GhostOrderComment(), gs__hedged_1156) != -1 && g_cmd_1152 == GhostOrderType()) {
                  ld_8 = order_takeprofit_0 - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
                  ld_16 = order_takeprofit_0 + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
                  if (GhostOrderStopLoss() == 0.0 || (GhostOrderType() == OP_BUY && GhostOrderStopLoss() != ld_8) || (GhostOrderType() == OP_SELL && GhostOrderStopLoss() != ld_16)) {
                     if (GhostOrderType() == OP_BUY) {
                        li_52 = Close_Order_Attempts;
                        bool_56 = FALSE;
                        while (bool_56 == FALSE && li_52 >= 0) {
                           li_52--;
                           RefreshRates();
                        //--- 6: Assert replace OrderModify a buy trade with arrays
                           bCommand[bCount]     = 1; 
                           bOpenPrice[bCount]   = 0;
                           bStopLoss[bCount]    = NormalizeDouble(ld_8, Digits);
                           bTakeProfit[bCount]  = NormalizeDouble(
                              GhostOrderOpenPrice() + BasketTakeProfit * getPointCoef() + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef(), Digits);
                           bCount ++;
                           if( bCount >= MaxAccountTrades ) break;
                           /*bool_56 = OrderModify(OrderTicket(), 0, NormalizeDouble(ld_8, Digits), NormalizeDouble(OrderTakeProfit(), Digits), 0, White);*/
                           if (!TRUE) {
                              g_error_1248 = GetLastError();
                              if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                                 Sleep(50);
                                 continue;
                              }
                           }
                           bool_56 = TRUE;
                        }
                        continue;
                     }
                     if (GhostOrderType() == OP_SELL) {
                        li_52 = Close_Order_Attempts;
                        bool_56 = FALSE;
                        while (bool_56 == FALSE && li_52 >= 0) {
                           li_52--;
                           RefreshRates();
                        //--- 6: Assert replace OrderModify a sell trade with arrays
                           bCommand[bCount]     = 3; 
                           bOpenPrice[bCount]   = 0;
                           bStopLoss[bCount]    = NormalizeDouble(ld_16, Digits);
                           bTakeProfit[bCount]  = NormalizeDouble(
                              GhostOrderOpenPrice() - BasketTakeProfit * getPointCoef() - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef(), Digits);
                           bCount ++;
                           if( bCount >= MaxAccountTrades ) break;
                           /*bool_56 = OrderModify(OrderTicket(), 0, NormalizeDouble(ld_16, Digits), NormalizeDouble(OrderTakeProfit(), Digits), 0, White);*/
                           if (!TRUE) {
                              g_error_1248 = GetLastError();
                              if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                                 Sleep(50);
                                 continue;
                              }
                           }
                           bool_56 = TRUE;
                        }
                     }
                  }
               }
            }
         }
      }
   //--- Assert 1: Free OrderSelect #18
      GhostFreeSelect(true);
   //--- Assert for: process array of commands
      for(int i=0; i<bCount; i++)
      {
         switch( bCommand[i] )
         {
            case 1:  // OrderModify Buy
               GhostOrderModify( bTicket[i], bOpenPrice[i], bStopLoss[i], bTakeProfit[i], 0, White ); 
               break;
            case 2:  // OrderClose Buy
            case 3:  // OrderModify Sell
               GhostOrderModify( bTicket[i], bOpenPrice[i], bStopLoss[i], bTakeProfit[i], 0, White ); 
               break;
            case 4:  // OrderClose Sell
               break;
         }
      }
   }
//--- Assert 2: Refresh Plus   
   GhostRefresh();
   double tp_buy = GetOpenOrdersHighestTP(OP_BUY);
   double sl_buy = GetOpenOrdersLowestSL(OP_BUY);
   // Print("--------- TP_BUY:", tp_buy);
   if (tp_buy != 0.0 /*&& GetOrdersCount(OP_BUY)>1*/) {
      FixOpenOrdersTP(tp_buy, OP_BUY);
   }
   /*if (sl_buy != 0.0 && GetOrdersCount(OP_BUY)>1) {
      FixOpenOrdersSL(sl_buy, OP_BUY);
   }*/

   double tp_sell = GetOpenOrdersHighestTP(OP_SELL);
   double sl_sell = GetOpenOrdersLowestSL(OP_SELL);
   // Print("--------- TP_SELL:", tp_sell);
   if (tp_sell != 0.0 /*&& GetOrdersCount(OP_SELL)>1*/) {
      FixOpenOrdersTP(tp_sell, OP_SELL);
   }
   /*if (sl_sell != 0.0 && GetOrdersCount(OP_SELL)>1) {
      FixOpenOrdersSL(sl_sell, OP_SELL);
   }*/

//--- Assert 2: Refresh Plus   
   GhostRefresh();
   if (f0_0() != 0) {
      gi_1200 = fun0(gda_1180, gda_1184, Digits, count_24, Point, gda_1196, count_24, IsDemo());
      if (gi_1200 >= 0) {
         g_pips_972 = gda_1196[0];
         gd_1076 = gda_1196[1];
         gd_964 = gda_1196[2];
         if (gi_1200 == 0) gi_1168 = FALSE;
         else gi_1168 = TRUE;
      }
      f0_15(count_24, count_28);
      gi_1200 = fun0(gda_1180, gda_1184, Digits, count_28, Point, gda_1196, count_28, IsDemo());
      if (gi_1200 >= 0) {
         g_pips_972 = gda_1196[0];
         gd_1076 = gda_1196[1];
         gd_964 = gda_1196[2];
         if (gi_1200 == 0) gi_1168 = FALSE;
         else gi_1168 = TRUE;
      }
      f0_14(count_24, count_28);
      gi_1200 = fun0(gda_1180, gda_1184, Digits, 0, Point, gda_1196, 0, IsDemo());
      if (gi_1200 >= 0) {
         g_pips_972 = gda_1196[0];
         gd_1076 = gda_1196[1];
         gd_964 = gda_1196[2];
         if (gi_1200 == 0) gi_1168 = FALSE;
         else gi_1168 = TRUE;
      }
      if ((!FreezeAfterTP) && !gi_956) {
         if (gi_1136) {
            gi_1200 = fun0(gda_1180, gda_1184, Digits, count_24, Point, gda_1196, count_24, IsDemo());
            if (gi_1200 >= 0) {
               g_pips_972 = gda_1196[0];
               gd_1076 = gda_1196[1];
               gd_964 = gda_1196[2];
               if (gi_1200 == 0) gi_1168 = FALSE;
               else gi_1168 = TRUE;
            }
            if (f0_12(1)) gi_1136 = FALSE;
         }
         if (gi_1132) {
            gi_1200 = fun0(gda_1180, gda_1184, Digits, count_28, Point, gda_1196, count_28, IsDemo());
            if (gi_1200 >= 0) {
               g_pips_972 = gda_1196[0];
               gd_1076 = gda_1196[1];
               gd_964 = gda_1196[2];
               if (gi_1200 == 0) gi_1168 = FALSE;
               else gi_1168 = TRUE;
            }
            if (f0_13(1)) gi_1132 = FALSE;
         }
      }
      DisplayLeviathanInfo();
      return;
   }
   return;
}

//+------------------------------------------------------------------+   
bool CheckIsNewBar()
{
   TimeToStruct(iTime(Symbol(),Period(),0),currentBarTimeStruct);
   currentBarTimeGMT = StrToTime(currentBarTimeStruct.year+"."+currentBarTimeStruct.mon+"."+currentBarTimeStruct.day+" "+(currentBarTimeStruct.hour-timeGMTOffset)+":"+currentBarTimeStruct.min+":"+currentBarTimeStruct.sec);

   if( currentBarTimeGMT != lastBarTimeGMT)
   {
      lastBarTimeGMT = currentBarTimeGMT;
      return(true);
   }
   
   return(false);
}
//+------------------------------------------------------------------+   
datetime GetTimeToGMT(datetime time1)
{
   MqlDateTime time1Struct, time1GMTStruct;
   TimeToStruct(iTime(Symbol(),PERIOD_M1,0),time1Struct);
   TimeGMT(time1GMTStruct);
   int timeOffset = (time1Struct.hour-time1GMTStruct.hour);

   TimeToStruct(time1,time1Struct);
   //datetime time1GMT = StrToTime(time1Struct.year+"."+time1Struct.mon+"."+time1Struct.day+" "+(time1Struct.hour-timeGMTOffset)+":"+time1Struct.min+":"+time1Struct.sec);
   time1GMTStruct.year = time1Struct.year;
   time1GMTStruct.mon  = time1Struct.mon;
   time1GMTStruct.day  = time1Struct.day;
   time1GMTStruct.hour = (time1Struct.hour-timeOffset);
   time1GMTStruct.min  = time1Struct.min;
   time1GMTStruct.sec  = time1Struct.sec;
   datetime time1GMT = StructToTime(time1GMTStruct);

   return(time1GMT);
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
void f0_16(string as_unused_0) {
   if (gi_1164 >= 0) {
   }
}

void AccountTotalLossProfit() {
   totalProfit = 0;
//--- Assert 2: Init OrderSelect #1
   int hist_total_0 = GhostOrdersHistoryTotal();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_HISTORY);
   for (int pos_4 = 0; pos_4 < hist_total_0; pos_4++) {
      GhostOrderSelect(pos_4, SELECT_BY_POS, MODE_HISTORY);
      if (GhostOrderMagicNumber() == MagicNumber) totalProfit += GhostOrderProfit() + GhostOrderSwap();
   }
//--- Assert 1: Free OrderSelect #1
   GhostFreeSelect(false);
}

int f0_5() {
   double ld_0 = MarketInfo(Symbol(), MODE_MINLOT);
   int count_8 = 0;
   for (count_8 = 0; ld_0 < 1.0; count_8++) ld_0 = 10.0 * ld_0;
   return (count_8);
}

double f0_2(double a_minlot_0) {
   double minlot_8;
   double ld_16 = GhostAccountEquity() - gi_992;
   double ld_24 = gi_996;
   double ld_32 = gi_1000;
   if (gi_996 == 0 || gi_1000 == 0) minlot_8 = a_minlot_0;
   else {
      ld_24 = gi_992 * ld_24 / 100.0;
      Print("tmp=" + ld_16 + ",AccountEquity()=" + GhostAccountEquity() + ",InitEquity=" + gi_992);
      ld_32 /= 100.0;
      if (ld_16 > 0.0) ld_16 = MathPow(ld_32 + 1.0, ld_16 / ld_24);
      else {
         if (ld_16 < 0.0) ld_16 = MathPow(1 - ld_32, MathAbs(ld_16 / ld_24));
         else ld_16 = 1;
      }
      minlot_8 = NormalizeDouble(a_minlot_0 * ld_16, f0_5());
      if (minlot_8 < MarketInfo(Symbol(), MODE_MINLOT)) minlot_8 = MarketInfo(Symbol(), MODE_MINLOT);
   }
   if (minlot_8 < 0.0) Print("ERROR tmp=" + ld_16 + ",a=" + ld_24 + ",b=" + ld_32 + ",AccountEquity()=" + GhostAccountEquity());
   return (minlot_8);
}
//---------------------------------------------------------------------------------------------------------------------------+
int f0_8() {
   bool bool_4;
   double ld_12;
   int li_20;
   bool li_ret_0 = FALSE;
//--- Assert 7: Declare variables
   int      aCommand[];    // 1-OrderModify BUY; 2-OrderClose BUY; 3-OrderModify SELL; 4-OrderClose SELL;
   int      aTicket[];
   double   aOpenPrice[];
   double   aStopLoss[];
   double   aTakeProfit[];
   bool     aOk[];
   int      aCount;
//--- Assert 6: Dynamically resize arrays
   ArrayResize(aCommand,MaxAccountTrades);
   ArrayResize(aTicket,MaxAccountTrades);
   ArrayResize(aOpenPrice,MaxAccountTrades);
   ArrayResize(aStopLoss,MaxAccountTrades);
   ArrayResize(aTakeProfit,MaxAccountTrades);
   ArrayResize(aOk,MaxAccountTrades);
//--- Assert 2: Init OrderSelect #2
   int   total = GhostOrdersTotal();
   GhostInitSelect(false,0,SELECT_BY_POS,MODE_TRADES);
   for (int pos_8 = total - 1; pos_8 >= 0; pos_8--) {
      if (GhostOrderSelect(pos_8, SELECT_BY_POS, MODE_TRADES)) {
      //--- Assert 5: Populate arrays
         aCommand[aCount]     =  0;
         aTicket[aCount]      =  GhostOrderTicket();
         aOpenPrice[aCount]   =  GhostOrderOpenPrice();
         aStopLoss[aCount]    =  GhostOrderStopLoss();
         aTakeProfit[aCount]  =  GhostOrderTakeProfit();
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderSymbol() == Symbol()) {
            RefreshRates();
            if (GhostOrderType() == OP_BUY) {
               if (GhostOrderStopLoss() == 0.0) {
                  ld_12 = GhostOrderOpenPrice() - gi_stop_loss * getPointCoef();
                  li_20 = Close_Order_Attempts;
                  bool_4 = FALSE;
                  while (bool_4 == FALSE && li_20 >= 0) {
                     li_20--;
                     RefreshRates();
                  //--- 5: Assert replace OrderModify a buy trade with arrays
                     aCommand[aCount]     = 1; 
                     aStopLoss[aCount]    = ld_12;
                     aCount ++;
                     if( aCount >= MaxAccountTrades ) break;
                     /*bool_4 = OrderModify(OrderTicket(), NormalizeDouble(OrderOpenPrice(), Digits), NormalizeDouble(ld_12, Digits), OrderTakeProfit(), 0, Black);*/
                     if (!TRUE) {
                        g_error_1248 = GetLastError();
                        if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                           Sleep(50);
                           continue;
                        }
                     }
                     bool_4 = TRUE;
                  }
               }
            }
            if (GhostOrderType() == OP_SELL) {
               if (GhostOrderStopLoss() == 0.0) {
                  ld_12 = GhostOrderOpenPrice() + gi_stop_loss * getPointCoef();
                  li_20 = Close_Order_Attempts;
                  bool_4 = FALSE;
                  while (bool_4 == FALSE && li_20 >= 0) {
                     li_20--;
                     RefreshRates();
                  //--- 5: Assert replace OrderModify a sell trade with arrays
                     aCommand[aCount]     = 3; 
                     aStopLoss[aCount]    = ld_12;
                     aCount ++;
                     if( aCount >= MaxAccountTrades ) break;
                     /*bool_4 = OrderModify(OrderTicket(), NormalizeDouble(OrderOpenPrice(), Digits), NormalizeDouble(ld_12, Digits), OrderTakeProfit(), 0, Black);*/
                     if (!TRUE) {
                        g_error_1248 = GetLastError();
                        if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                           Sleep(50);
                           continue;
                        }
                     }
                     bool_4 = TRUE;
                  }
               }
            }
         }
      }
   }
//--- Assert 1: Free OrderSelect #2
   GhostFreeSelect(false);
//--- Assert for: process array of commands
   for(int i=0; i<aCount; i++)
   {
      switch( aCommand[i] )
      {
         case 1:  // OrderModify Buy
            GhostOrderModify( aTicket[i], NormalizeDouble(aOpenPrice[i],Digits), NormalizeDouble(aStopLoss[i],Digits), aTakeProfit[i], 0, Black );
            break;
         case 2:  // OrderClose Buy
         case 3:  // OrderModify Sell
            GhostOrderModify( aTicket[i], NormalizeDouble(aOpenPrice[i],Digits), NormalizeDouble(aStopLoss[i],Digits), aTakeProfit[i], 0, Black );
            break;
         case 4:  // OrderClose Sell
            break;
      }
   }
   return (li_ret_0);
}

double f0_11(int ai_0) {
//--- Assert 4: Init OrderSelect #3
   bool     found;
   double   lots;
   int      total = GhostOrdersTotal();
   GhostInitSelect(false,0,SELECT_BY_POS,MODE_TRADES);
   for (int pos_4 = total - 1; pos_4 >= 0; pos_4--) {
      if (GhostOrderSelect(pos_4, SELECT_BY_POS)) {
         if (GhostOrderMagicNumber() == MagicNumber) {
            if (StringFind(GhostOrderComment(), gs__hedged_1156) == -1) {
               f0_16("GetLastLotSize " + ai_0 + ",OrderLots()=" + GhostOrderLots());
            //--- Assert 3: return value
               found = true;
               lots  = GhostOrderLots();
               break;
               /*return (OrderLots());*/
            }
         }
      }
   }
//--- Assert 2: Free OrderSelect #3
   GhostFreeSelect(false);
   if( found ) return( lots );
   f0_16("GetLastLotSize " + ai_0 + " wasnt found");
   return (0);
}

double f0_3(int ai_0) {
//--- Assert 4: Init OrderSelect #4
   bool     found;
   double   lots;
   int      total = GhostOrdersTotal();
   GhostInitSelect(false,0,SELECT_BY_POS,MODE_TRADES);
   for (int pos_4 = total - 1; pos_4 >= 0; pos_4--) {
      if (GhostOrderSelect(pos_4, SELECT_BY_POS)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == OP_BUY) {
            if (StringFind(GhostOrderComment(), gs__hedged_1156) == -1) {
               f0_16("GetLastLotSize " + ai_0 + ",OrderLots()=" + GhostOrderLots());
            //--- Assert 3: return value
               found = true;
               lots  = GhostOrderLots();
               break;
               /*return (OrderLots());*/
            }
         }
      }
   }
//--- Assert 2: Free OrderSelect #4
   GhostFreeSelect(false);
   if( found ) return( lots );
   f0_16("GetLastLotSize " + ai_0 + " wasnt found");
   return (0);
}

double f0_6(int ai_0) {
//--- Assert 4: Init OrderSelect #5
   bool     found;
   double   lots;
   int      total = GhostOrdersTotal();
   GhostInitSelect(false,0,SELECT_BY_POS,MODE_TRADES);
   for (int pos_4 = total - 1; pos_4 >= 0; pos_4--) {
      if (GhostOrderSelect(pos_4, SELECT_BY_POS)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == OP_SELL) {
            if (StringFind(GhostOrderComment(), gs__hedged_1156) == -1) {
               f0_16("GetLastLotSize " + ai_0 + ",OrderLots()=" + GhostOrderLots());
            //--- Assert 3: return value
               found = true;
               lots  = GhostOrderLots();
               break;
               /*return (OrderLots());*/
            }
         }
      }
   }
//--- Assert 2: Free OrderSelect #5
   GhostFreeSelect(false);
   if( found ) return( lots );
   f0_16("GetLastLotSize " + ai_0 + " wasnt found");
   return (0);
}

int f0_12(bool ai_0 = FALSE, double nbp = 0.0, double lots = 0, int type = OP_SELL) {
   int ticket_4;
   int li_48;
   bool bool_52;
   double lots_8 = 0;
   double ld_16 = 0;
   double ld_24 = 0;
   string ls_32 = "";
   bool li_ret_40 = TRUE;
   if (TimeCurrent() - g_datetime_1072 < 60) return (0);
   if (ai_0 && (!gi_1140)) return (0);
   if (!GlobalVariableCheck("PERMISSION")) {
      GlobalVariableSet("PERMISSION", TimeCurrent());
      if (!SupportECN) {
         if (ai_0) {
         //--- Assert 4: Init OrderSelect #6
            GhostInitSelect(true,g_ticket_1148,SELECT_BY_TICKET,MODE_TRADES);
            if (GhostOrderSelect(g_ticket_1148, SELECT_BY_TICKET)) 
            {
               ld_24 = GhostOrderTakeProfit() - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
            }
         //--- Assert 2: Free OrderSelect #6
            GhostFreeSelect(false);
         } else ld_16 = Ask + g_pips_972 * getPointCoef();
      }
      if (lots <= 0) {
         if (gi_1168 == FALSE) {
            if (ai_0) lots_8 = NormalizeDouble(f0_11(1) * gd_1060, 2);
            else lots_8 = f0_2(gd_1016);
         } else {
            if (type == OP_SELL && f0_3(0) > 0.0) lots_8 = NormalizeDouble(f0_3(0) * gd_964, 2);
            else if (type == OP_BUY && f0_6(0) > 0.0) lots_8 = NormalizeDouble(f0_6(0) * gd_964, 2);
            else lots_8 = NormalizeDouble(base_lot, 2);
         }
      } else {
         lots_8 = NormalizeDouble(lots, 2);
      }
      
      // No money check
      if (!MarginEnoughCheck(lots_8)) {Sleep(10000); GlobalVariableDel("PERMISSION"); return(false);}// Fix 0.06a No money check      
      
      if (BasketStopLoss > 0) ld_24 = Ask - gi_stop_loss * getPointCoef();
      if (!SupportECN) {
         if (ld_16 == 0.0) ld_16 = Ask + gi_take_profit * getPointCoef();
         if (ld_24 == 0.0) ld_24 = Ask - gi_stop_loss * getPointCoef();
         if (nbp > 0.0) ld_16 = nbp; // NBP
         if (gi_1212 == TRUE) {
            int index_44 = 0;
            for (index_44 = 0; index_44 < 25; index_44++)
               if (gia_1216[index_44] <= 0) break;
            if (index_44 < 25) {
               ticket_4 = GhostOrderSend(Symbol(), OP_BUY, lots_8, NormalizeDouble(Ask, Digits), Slippage, NormalizeDouble(ld_24, Digits), NormalizeDouble(ld_16, Digits), EA_Name + ls_32, MagicNumber, 0, Green);
               if (ticket_4 > 0) {
                  gia_1216[index_44] = ticket_4;
                  gia_1220[index_44] = 0;
                  gda_1224[index_44] = lots_8;
                  gda_1228[index_44] = NormalizeDouble(Ask, Digits);
                  gda_1232[index_44] = 0;
                  gda_1236[index_44] = 0;
                  GlobalVariableSet(Symbol() + "ticketS4" + index_44, gia_1216[index_44]);
                  GlobalVariableSet(Symbol() + "typeS4" + index_44, gia_1220[index_44]);
                  GlobalVariableSet(Symbol() + "lotsS4" + index_44, gda_1224[index_44]);
                  GlobalVariableSet(Symbol() + "priceS4" + index_44, gda_1228[index_44]);
                  GlobalVariableSet(Symbol() + "stoplossS4" + index_44, gda_1232[index_44]);
                  GlobalVariableSet(Symbol() + "takeprofitS4" + index_44, gda_1236[index_44]);
               }
            }
         } else {
            ticket_4 = GhostOrderSend(Symbol(), OP_BUY, lots_8, NormalizeDouble(Ask, Digits), Slippage, NormalizeDouble(ld_24, Digits), NormalizeDouble(ld_16, Digits), EA_Name + ls_32, MagicNumber, 0, Green);
         }
      } else {
         if (gi_1212 == TRUE) {
            int index_44 = 0;
            for (index_44 = 0; index_44 < 25; index_44++)
               if (gia_1216[index_44] <= 0) break;
            if (index_44 < 25) {
               ticket_4 = GhostOrderSend(Symbol(), OP_BUY, lots_8, NormalizeDouble(Ask, Digits), Slippage, 0, 0, EA_Name + ls_32, MagicNumber, 0, Green);
               if (ticket_4 > 0) {
                  gia_1216[index_44] = ticket_4;
                  gia_1220[index_44] = 0;
                  gda_1224[index_44] = lots_8;
                  gda_1228[index_44] = NormalizeDouble(Ask, Digits);
                  gda_1232[index_44] = 0;
                  gda_1236[index_44] = 0;
                  GlobalVariableSet(Symbol() + "ticketS4" + index_44, gia_1216[index_44]);
                  GlobalVariableSet(Symbol() + "typeS4" + index_44, gia_1220[index_44]);
                  GlobalVariableSet(Symbol() + "lotsS4" + index_44, gda_1224[index_44]);
                  GlobalVariableSet(Symbol() + "priceS4" + index_44, gda_1228[index_44]);
                  GlobalVariableSet(Symbol() + "stoplossS4" + index_44, gda_1232[index_44]);
                  GlobalVariableSet(Symbol() + "takeprofitS4" + index_44, gda_1236[index_44]);
               }
               Sleep(1000);
            }
         } else {
            ticket_4 = GhostOrderSend(Symbol(), OP_BUY, lots_8, NormalizeDouble(Ask, Digits), Slippage, 0, 0, EA_Name + ls_32, MagicNumber, 0, Green);
            Sleep(1000);
         }
         
         if (ticket_4 >= 0) {
         //--- Assert 1: Declare variables
            double   aOpenPrice;
         //--- Assert 2: Init OrderSelect #7
            GhostInitSelect(true,ticket_4,SELECT_BY_TICKET,MODE_TRADES);
            if( GhostOrderSelect(ticket_4, SELECT_BY_TICKET) ) aOpenPrice = GhostOrderOpenPrice();
         //--- Assert 1: Free OrderSelect #7
            GhostFreeSelect(false);
            if (ld_16 == 0.0) ld_16 = Ask + gi_take_profit * getPointCoef();
            if (ld_24 == 0.0) ld_24 = Ask - gi_stop_loss * getPointCoef();
            li_48 = Close_Order_Attempts;
            bool_52 = FALSE;
            while (bool_52 == FALSE && li_48 >= 0) {
               li_48--;
               RefreshRates();
               bool_52 = GhostOrderModify(ticket_4, NormalizeDouble(aOpenPrice, Digits), NormalizeDouble(ld_24, Digits), NormalizeDouble(ld_16, Digits), 0, Black);
               if (!bool_52) {
                  g_error_1248 = GetLastError();
                  if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                     Sleep(50);
                     continue;
                  }
               }
               bool_52 = TRUE;
            }
         }
      }
      //---
      //Alert("B:",lots_8);
      /*
      if(TriggerProtectionOn == FALSE && iMA(Symbol(),SignalPeriod,600,0,MODE_EMA,PRICE_CLOSE,0) > MarketInfo(Symbol(), MODE_ASK)) {
         if (Negative_Basket_Protection == TRUE) {
            double std_TP, nbp_TP, tmp_TP;
            std_TP = Bid - gi_take_profit * getPointCoef();
            nbp_TP = Ask - NBP * getPointCoef();
            if (std_TP > nbp_TP) {
               tmp_TP = SellMinTP();
               if (tmp_TP == 0.0) {
                  f0_13(0, std_TP, lots_8);
               } else {
                  tmp_TP = nbp_TP;
                  f0_13(0, tmp_TP, lots_8);
               }
            } else {
               f0_13(0, std_TP, lots_8);
            }
         } // IF NBP TRUE  
      }
      */
      //---
      g_datetime_1072 = TimeCurrent();
      if (ticket_4 != -1) {
         if (!ai_0) {
            g_ticket_1148 = ticket_4;
            f0_16("BUY hedgedTicket=" + g_ticket_1148);
         } else {
            f0_16("BUY Leviathan_ticket=" + ticket_4);
            g_cmd_1152 = 0;
         }
      } else {
         f0_16("failed sell");
         li_ret_40 = FALSE;
      }
   }
   GlobalVariableDel("PERMISSION");
   return (li_ret_40);
}

int f0_13(bool ai_0 = FALSE, double nbp = 0.0, double lots = 0, int type = OP_BUY) {
   int ticket_4;
   int li_48;
   bool bool_52;
   double lots_8 = 0;
   double ld_16 = 0;
   double ld_24 = 0;
   string ls_32 = "";
   bool li_ret_40 = TRUE;
   if (TimeCurrent() - g_datetime_1072 < 60) return (0);
   if (ai_0 && (!gi_1144)) return (0);
   if (!GlobalVariableCheck("PERMISSION")) {
      GlobalVariableSet("PERMISSION", TimeCurrent());
      if (!SupportECN) {
         if (ai_0) {
         //--- Assert 4: Init OrderSelect #8
            GhostInitSelect(true,g_ticket_1148,SELECT_BY_TICKET,MODE_TRADES);
            if (GhostOrderSelect(g_ticket_1148, SELECT_BY_TICKET)) 
            {
               ld_24 = GhostOrderTakeProfit() + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
            }
         //--- Assert 2: Free OrderSelect #8
            GhostFreeSelect(false);
         } else ld_16 = Bid - g_pips_972 * getPointCoef();
      }
      if (lots <= 0) {
         if (gi_1168 == FALSE) {
            if (ai_0) lots_8 = NormalizeDouble(f0_11(0) * gd_1060, 2);
            else lots_8 = f0_2(gd_1016);
         } else {
            if (type == OP_BUY && f0_6(0) > 0.0) lots_8 = NormalizeDouble(f0_6(0) * gd_964, 2);
            else if (type == OP_SELL && f0_3(0) > 0.0) lots_8 = NormalizeDouble(f0_3(0) * gd_964, 2);
            else lots_8 = NormalizeDouble(base_lot, 2);
         }
      } else {
         lots_8 = NormalizeDouble(lots, 2);
      }
      // No money check
      if (!MarginEnoughCheck(lots_8)) {Sleep(10000); GlobalVariableDel("PERMISSION"); return(false);}// Fix 0.06a No money check      
      
      if (BasketStopLoss > 0) ld_24 = Bid + gi_stop_loss * getPointCoef();
      if (!SupportECN) {
         if (ld_16 == 0.0) ld_16 = Bid - gi_take_profit * getPointCoef();
         if (ld_24 == 0.0) ld_24 = Bid + gi_stop_loss * getPointCoef();
         if (nbp > 0.0) ld_16 = nbp; // NBP
         if (gi_1212 == TRUE) {
            int index_44 = 0;
            for (index_44 = 0; index_44 < 25; index_44++)
               if (gia_1216[index_44] <= 0) break;
            if (index_44 < 25) {
               ticket_4 = GhostOrderSend(Symbol(), OP_SELL, lots_8, NormalizeDouble(Bid, Digits), Slippage, NormalizeDouble(ld_24, Digits), NormalizeDouble(ld_16, Digits), EA_Name + ls_32, MagicNumber, 0, Pink);
               if (ticket_4 > 0) {
                  gia_1216[index_44] = ticket_4;
                  gia_1220[index_44] = 1;
                  gda_1224[index_44] = lots_8;
                  gda_1228[index_44] = NormalizeDouble(Bid, Digits);
                  gda_1232[index_44] = 0;
                  gda_1236[index_44] = 0;
                  GlobalVariableSet(Symbol() + "ticketS4" + index_44, gia_1216[index_44]);
                  GlobalVariableSet(Symbol() + "typeS4" + index_44, gia_1220[index_44]);
                  GlobalVariableSet(Symbol() + "lotsS4" + index_44, gda_1224[index_44]);
                  GlobalVariableSet(Symbol() + "priceS4" + index_44, gda_1228[index_44]);
                  GlobalVariableSet(Symbol() + "stoplossS4" + index_44, gda_1232[index_44]);
                  GlobalVariableSet(Symbol() + "takeprofitS4" + index_44, gda_1236[index_44]);
               }
            }
         } else {
            ticket_4 = GhostOrderSend(Symbol(), OP_SELL, lots_8, NormalizeDouble(Bid, Digits), Slippage, NormalizeDouble(ld_24, Digits), NormalizeDouble(ld_16, Digits), EA_Name + ls_32, MagicNumber, 0, Pink);
         }
      } else {
         if (gi_1212 == TRUE) {
            int index_44 = 0;
            for (index_44 = 0; index_44 < 25; index_44++)
               if (gia_1216[index_44] <= 0) break;
            if (index_44 < 25) {
               ticket_4 = GhostOrderSend(Symbol(), OP_SELL, lots_8, NormalizeDouble(Bid, Digits), Slippage, 0, 0, EA_Name + ls_32, MagicNumber, 0, Pink);
               if (ticket_4 > 0) {
                  gia_1216[index_44] = ticket_4;
                  gia_1220[index_44] = 1;
                  gda_1224[index_44] = lots_8;
                  gda_1228[index_44] = NormalizeDouble(Bid, Digits);
                  gda_1232[index_44] = 0;
                  gda_1236[index_44] = 0;
                  GlobalVariableSet(Symbol() + "ticketS4" + index_44, gia_1216[index_44]);
                  GlobalVariableSet(Symbol() + "typeS4" + index_44, gia_1220[index_44]);
                  GlobalVariableSet(Symbol() + "lotsS4" + index_44, gda_1224[index_44]);
                  GlobalVariableSet(Symbol() + "priceS4" + index_44, gda_1228[index_44]);
                  GlobalVariableSet(Symbol() + "stoplossS4" + index_44, gda_1232[index_44]);
                  GlobalVariableSet(Symbol() + "takeprofitS4" + index_44, gda_1236[index_44]);
               }
               Sleep(1000);
            }
         } else {
            ticket_4 = GhostOrderSend(Symbol(), OP_SELL, lots_8, NormalizeDouble(Bid, Digits), Slippage, 0, 0, EA_Name + ls_32, MagicNumber, 0, Pink);
            Sleep(1000);
         }
         if (ticket_4 >= 0) {
         //--- Assert 1: Declare variables
            double   aOpenPrice;
         //--- Assert 2: Init OrderSelect #9
            GhostInitSelect(true,ticket_4,SELECT_BY_TICKET,MODE_TRADES);
            if( GhostOrderSelect(ticket_4, SELECT_BY_TICKET) ) aOpenPrice = GhostOrderOpenPrice();
         //--- Assert 1: Free OrderSelect #9
            GhostFreeSelect(false);
            if (ld_16 == 0.0) ld_16 = Bid - gi_take_profit * getPointCoef();
            if (ld_24 == 0.0) ld_24 = Bid + gi_stop_loss * getPointCoef();
            li_48 = Close_Order_Attempts;
            bool_52 = FALSE;
            while (bool_52 == FALSE && li_48 >= 0) {
               li_48--;
               RefreshRates();
               bool_52 = GhostOrderModify(ticket_4, NormalizeDouble(aOpenPrice, Digits), NormalizeDouble(ld_24, Digits), NormalizeDouble(ld_16, Digits), 0, Black);
               if (!bool_52) {
                  g_error_1248 = GetLastError();
                  if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                     Sleep(50);
                     continue;
                  }
               }
               bool_52 = TRUE;
            }
         }
      }
      //---
      //Alert("S:",lots_8);
      /*
      if(TriggerProtectionOn == FALSE && iMA(Symbol(),SignalPeriod,600,0,MODE_EMA,PRICE_CLOSE,0) < MarketInfo(Symbol(), MODE_BID)) {
         if (Negative_Basket_Protection == TRUE) {
            double std_TP, nbp_TP, tmp_TP;
            std_TP = Ask + gi_take_profit * getPointCoef();
            nbp_TP = Bid + NBP * getPointCoef();
            if (std_TP < nbp_TP) {
               tmp_TP = BuyMaxTP();
               if (tmp_TP == 0.0) {
                  f0_12(0, std_TP, lots_8); //Openbuy
               } else {
                  tmp_TP = nbp_TP;
                  f0_12(0, tmp_TP, lots_8);
               }
            } else {
               f0_12(0, std_TP, lots_8);
            }
         } // IF NBP TRUE 
      }
      */
      //---
      g_datetime_1072 = TimeCurrent();
      if (ticket_4 != -1) {
         if (!ai_0) {
            g_ticket_1148 = ticket_4;
            f0_16("SELL hedgedTicket=" + g_ticket_1148);
         } else {
            f0_16("SELL Leviathan_ticket=" + ticket_4);
            g_cmd_1152 = 1;
         }
      } else {
         f0_16("failed sell");
         li_ret_40 = FALSE;
      }
   }
   GlobalVariableDel("PERMISSION");
   return (li_ret_40);
}

void f0_15(int ai_0, int ai_unused_4) {
   int li_64;
   bool bool_68;
   int datetime_8 = 0;
   double order_open_price_12 = 0;
   double order_lots_20 = 0;
   double order_takeprofit_28 = 0;
   double order_stoploss_36 = 0;
   int cmd_44 = -1;
   int ticket_48 = 0;
   int pos_52 = 0;
   int count_AA = 0;
   int count_BB = 0;
//--- Assert 2: Init OrderSelect #10
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   int   total = GhostOrdersTotal();
   for (pos_52 = total; pos_52 > 0; pos_52--) {
      if (GhostOrderSelect(pos_52, SELECT_BY_POS, MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber) {
            count_AA+=1;
            if (GhostOrderType() == OP_BUY) {
               count_BB+=1;
               // Print("*");
               if (GhostOrderOpenTime() > datetime_8) {
                  datetime_8 = GhostOrderOpenTime();
                  order_open_price_12 = GhostOrderOpenPrice();
                  cmd_44 = GhostOrderType();
                  ticket_48 = GhostOrderTicket();
                  if (order_takeprofit_28 == 0 || order_takeprofit_28 < GhostOrderTakeProfit()) {
                     order_takeprofit_28 = GhostOrderTakeProfit();
                  }
                  order_stoploss_36 = GhostOrderStopLoss();
               }
               if (GhostOrderLots() > order_lots_20) order_lots_20 = GhostOrderLots();
            }
         }
      }
   }
//--- Assert 1: Free OrderSelect #10
   GhostFreeSelect(false);
   int li_60 = MathRound(MathLog(order_lots_20 / base_lot) / MathLog(gd_964)) + 1.0;
   if (li_60 < 0) li_60 = 0;
   gd_1016 = NormalizeDouble(base_lot * MathPow(gd_964, li_60), gi_1084);
   // Print("count_BB:",count_BB);
   if (li_60 == 0 && signal(OP_BUY, count_BB, count_AA) == 1) {
      if (FreezeAfterTP == FALSE && gi_956 == FALSE) f0_12();
      else
         if (ai_0 > 0) f0_12();
   } else {
/*
      if (signal(OP_SELL, 0, 0) == -1 || signal(OP_BUY, 0, 0) == EMPTY_VALUE ) {
         if ( count_BB > 5 )
            CloseBuyOrders(TRUE);
      }
*/
      if (/*trigger(OP_BUY, count_AA) != 1 &&*/ order_open_price_12 - Ask > gi_execution_point * gd_1076 && order_open_price_12 > 0.0 && count_BB < MaximumBuyLevels) {
          /* if (Negative_Basket_Protection == TRUE) {
            double std_TP, nbp_TP, tmp_TP;
            tmp_TP = BuyMaxTP();
            if (tmp_TP > 0.0 && tmp_TP > Ask + gi_take_profit * getPointCoef()) {
               f0_12(0, tmp_TP);
               return;
            } else {
               std_TP = Ask + gi_take_profit * getPointCoef();
               f0_12(0, std_TP);
               return;
            }
            //std_TP = Ask + gi_take_profit * getPointCoef();
            //nbp_TP = order_open_price_12 + NBP * getPointCoef();
            //if (std_TP < nbp_TP) {
            //   tmp_TP = BuyMaxTP();
            //   if (tmp_TP == 0.0) {
            //      f0_12(0, std_TP); //Openbuy
            //      return;
            //   }
            //   tmp_TP = nbp_TP;
            //   f0_12(0, tmp_TP);
            //   return;
            //}
            //f0_12(0, std_TP);
            //return;
            
         } // IF NBP TRUE */
         
         /* else*/ if (!(f0_12())) return;
         
         return;} // if (ord_op_price - Ask > Execut...
      //}
   }

//--- Assert 7: Declare variables
   int      aCommand[];    // 1-OrderModify BUY; 2-OrderClose BUY; 3-OrderModify SELL; 4-OrderClose SELL;
   int      aTicket[];
   double   aOpenPrice[];
   double   aStopLoss[];
   double   aTakeProfit[];
   bool     aOk[];
   int      aCount;
//--- Assert 6: Dynamically resize arrays
   ArrayResize(aCommand,MaxAccountTrades);
   ArrayResize(aTicket,MaxAccountTrades);
   ArrayResize(aOpenPrice,MaxAccountTrades);
   ArrayResize(aStopLoss,MaxAccountTrades);
   ArrayResize(aTakeProfit,MaxAccountTrades);
   ArrayResize(aOk,MaxAccountTrades);
//--- Assert 2: Init OrderSelect #11
   total = GhostOrdersTotal();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
   for (pos_52 = 0; pos_52 < total; pos_52++) {
      if( GhostOrderSelect(pos_52, SELECT_BY_POS, MODE_TRADES) )
      {
      //--- Assert 5: Populate arrays
         aCommand[aCount]     =  0;
         aTicket[aCount]      =  GhostOrderTicket();
         aOpenPrice[aCount]   =  GhostOrderOpenPrice();
         aStopLoss[aCount]    =  GhostOrderStopLoss();
         aTakeProfit[aCount]  =  GhostOrderTakeProfit();
         if (GhostOrderMagicNumber() != MagicNumber || GhostOrderType() != cmd_44 || GhostOrderStopLoss() == order_stoploss_36 || order_stoploss_36 == 0.0 || GhostOrderTakeProfit() == order_takeprofit_28 ||
            order_takeprofit_28 == 0.0) continue;
         li_64 = Close_Order_Attempts;
         bool_68 = FALSE;
         while (bool_68 == FALSE && li_64 >= 0) {
            li_64--;
            RefreshRates();
         //--- 6: Assert replace OrderModify a buy trade with arrays
            aCommand[aCount]     = 1; 
            aOpenPrice[aCount]   = NormalizeDouble(GhostOrderOpenPrice(), Digits);
            aStopLoss[aCount]    = NormalizeDouble(order_stoploss_36, Digits);
            aTakeProfit[aCount]  = NormalizeDouble(
                  order_takeprofit_28 + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef(), Digits);
            aCount ++;
            if( aCount >= MaxAccountTrades ) break;
            /*bool_68 = OrderModify(OrderTicket(), NormalizeDouble(OrderOpenPrice(), Digits), NormalizeDouble(order_stoploss_36, Digits), NormalizeDouble(order_takeprofit_28, Digits),
               0, Pink);*/
            if (!TRUE) {
               g_error_1248 = GetLastError();
               if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                  Sleep(50);
                  continue;
               }
            }
            bool_68 = TRUE;
         }
         Sleep(1000);
      }
   }
//--- Assert 1: Free OrderSelect #11
   GhostFreeSelect(false);
//--- Assert for: process array of commands
   for(int i=0; i<aCount; i++)
   {
      switch( aCommand[i] )
      {
         case 1:  // OrderModify Buy
            GhostOrderModify( aTicket[i], aOpenPrice[i], aStopLoss[i], aTakeProfit[i], 0, Pink ); 
            break;
         case 2:  // OrderClose Buy
         case 3:  // OrderModify Sell
         case 4:  // OrderClose Sell
            break;
      }
   }

   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   count_AA = 0;
   count_BB = 0;
   total = GhostOrdersTotal();
   for (pos_52 = total; pos_52 > 0; pos_52--) {
      if (GhostOrderSelect(pos_52, SELECT_BY_POS, MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber) {
            count_AA+=1;
            if (GhostOrderType() == OP_BUY) {
               count_BB+=1;
               if (GhostOrderOpenTime() > datetime_8) {
                  datetime_8 = GhostOrderOpenTime();
                  order_open_price_12 = GhostOrderOpenPrice();
                  cmd_44 = GhostOrderType();
                  ticket_48 = GhostOrderTicket();
                  if (order_takeprofit_28 == 0 || order_takeprofit_28 < GhostOrderTakeProfit()) {
                     order_takeprofit_28 = GhostOrderTakeProfit();
                  }
                  order_stoploss_36 = GhostOrderStopLoss();
               }
               if (GhostOrderLots() > order_lots_20) order_lots_20 = GhostOrderLots();
            }
         }
      }
   }
   if (TriggerLongHit == FALSE && count_BB>3)
   {
      TriggerLongHit=TRUE;
   }

}
// ------------------------- ENTRY SIGNAL ---------------------

   //+------------------------------------------------------------------+
   //| Variable Begin                                                   |
   //+------------------------------------------------------------------+
   uint                 i_periodK               = 100;                                          // %K period
   uint                 i_periodD               = 100;                                          // %D period
   uint                 i_slowing               = 3;                                            // Slowing
   double               i_highLevel             = 80.0;                                         // Bottom of overbought zone
   double               i_lowLevel              = 20.0;                                         // Top of overselling zone
   double               i_highCloseLevel        = 90.0;                                         // Level for Buy close
   double               i_lowCloseLevel         = 10.0;                                         // Level for Sell close
   uint                 i_extremumRank          = 300;                                          // Rank of extremum
   //+------------------------------------------------------------------+
   //| Variable End                                                     |
   //+------------------------------------------------------------------+

int signal(
   int _ordType,
   int _ordCount,
   int _ordTotal) {

   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   //----
   int buy = 1, sell = -1;
   //----
/*
   if (count > 0) {
      return(EMPTY_VALUE);
   }
*/
   // Print("count:",count," - total:",total);
   if(_ordType == OP_BUY && _ordCount > 0)
   {
       return(buy);
   }
   
   if(_ordType == OP_SELL && _ordCount > 0)
   {
      return(sell);
   }

//----
   /*if(IsNewBar)
   {*/
   //----
   if (_ordCount == 0) {
      //if(IsNewsTime()) return(0);
      //if (Month() == 12 && Day() >= 15) return(0);
      //if((DayOfWeek()==5 && Hour()>=7) || DayOfWeek()==6 || DayOfWeek()==0 || (DayOfWeek()==1 && Hour()<=3)) return(0);
      MqlDateTime str1;
      datetime time_gmt = myTimeGMT();
      TimeToStruct(time_gmt,str1);
      // if(str1.hour <= 9 || str1.hour >= 17) return(0);
   }
   //----
      HideTestIndicators(TRUE);
   //----   
      /*MqlRates RatesBar[];
      ArraySetAsSeries(RatesBar,true);
      CopyRates(NULL,PERIOD_W1,0,500,RatesBar);
      
      Print(RatesBar[0].open);*/
/*
   double MACDOpenLevel =3;
   double MACDCloseLevel=2;
   int    MATrendPeriod =26;
   MacdCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,0);
   MacdPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
   SignalCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,0);
   SignalPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,1);
   MaCurrent=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,0);
   MaPrevious=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,1);
   
   if(MacdCurrent<0 && MacdCurrent>SignalCurrent && MacdPrevious<SignalPrevious && 
         MathAbs(MacdCurrent)>(MACDOpenLevel*Point) && MaCurrent>MaPrevious)
        {
        return(buy);
   }
   
   if(MacdCurrent>0 && MacdCurrent<SignalCurrent && MacdPrevious>SignalPrevious && 
         MacdCurrent>(MACDOpenLevel*Point) && MaCurrent<MaPrevious)
        {
        return(sell);
   }
*/
      double sma0_60  = iMA(NULL, PERIOD_CURRENT,60,0,MODE_SMMA,PRICE_MEDIAN,0);
      double sma1_60  = iMA(NULL, PERIOD_CURRENT,60,0,MODE_SMMA,PRICE_MEDIAN,1);
      double sma2_60  = iMA(NULL, PERIOD_CURRENT,60,0,MODE_SMMA,PRICE_MEDIAN,2);
      double sma3_60  = iMA(NULL, PERIOD_CURRENT,60,0,MODE_SMMA,PRICE_MEDIAN,3);

      double val_low_index1 = Low[iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_LOW,1,1)];
      double val_low_index2 = Low[iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_LOW,3,1)];
      double val_low_index3 = Low[iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_LOW,14,1)];
      double val_low_index4 = Low[iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_LOW,20,1)];

      double val_high_index1 = High[iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,1,1)];
      double val_high_index2 = High[iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,3,1)];
      double val_high_index3 = High[iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,14,1)];
      double val_high_index4 = High[iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,20,1)];
      
      double stdDev=iStdDev(GhostOrderSymbol(),PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,0);
      double stdDev1=iStdDev(GhostOrderSymbol(),PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE,1);
      double stdDevCoeff = (((stdDev / stdDev1) - 1) * 100);
      double ask = Ask + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
      double bid = Bid - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
      
      //Print(" --bid:",bid," -- local_max:",IsLocalMaximum(1, i_extremumRank) - 10*getPointCoef());
      double local_minimum = IsLocalMinimum(3, i_extremumRank);
      double local_maximum = IsLocalMaximum(3, i_extremumRank);
      
      if (IsNewBar) {
         if (_ordType == OP_BUY) {
            Print("[Check] LONG   -- Local Maximum @Bid[",Bid,"] > ",NormalizeDouble(local_maximum,Digits),
               " - StdDev -- Thold[",DoubleToString(StandardDeviation),"] - iStdDev[", DoubleToString(stdDev), "/", DoubleToString(stdDev1), " -->",stdDevCoeff,"]");
         }
         if (_ordType == OP_SELL) {
            Print("[Check] SHORT  -- Local Minimum @Ask[",Ask,"] > ",NormalizeDouble(local_minimum,Digits),
               " - StdDev -- Thold[",DoubleToString(StandardDeviation),"] - iStdDev[", DoubleToString(stdDev), "/", DoubleToString(stdDev1), " -->",stdDevCoeff,"]");
         }
      }

      if (_ordCount == 0 && stdDevCoeff > 0 && stdDevCoeff >= StandardDeviation) {
         // //&& (iSAR(NULL,0,0.02,0.2,1)<Close[1] || iSAR(NULL,0,0.02,0.2,2)<Close[2])
         //) {
         if (Ask < sma0_60 && sma0_60 < sma1_60 && sma1_60 < sma2_60 && sma2_60 < sma3_60) {
            //Print(" --ask:",Ask," -- local_min:",IsLocalMinimum(0, i_extremumRank) - 2*getPointCoef());
            //Print(IsLocalMinimum(0, i_extremumRank) - 2*getPointCoef());
            if (local_minimum != EMPTY_VALUE && Ask < local_minimum - 2*getPointCoef()) {
               //if (ask < val_low_index2 && ask < val_low_index3 && ask < val_low_index4)
               //ChickenOutClose(GhostOrderSymbol(), OP_BUY);
               if(iSAR(GhostOrderSymbol(),PERIOD_CURRENT,0.02,0.2,0)>Ask) {
                  // Print("Order Count:", _ordCount, "/", _ordTotal);
                  Print("SELL -- Local Minimum @Ask[",Ask,"] > ",NormalizeDouble(local_minimum,Digits));
                  Print("SELL -- Thold[",DoubleToString(StandardDeviation),"] - iStdDev[", DoubleToString(stdDev), "/", DoubleToString(stdDev1), " -->",stdDevCoeff,"]" );
                  return(sell);
               }
            }
            /*else if (IsLocalMaximum(0, i_extremumRank) != EMPTY_VALUE && bid > IsLocalMaximum(0, i_extremumRank)) */
            /*else if (sma0_60 - Bid > 0 && sma0_60 - Bid <= 5*getPointCoef()) {
               return (buy);
            }*/
         }
      }

      if (_ordCount == 0 && stdDevCoeff > 0 && stdDevCoeff >= StandardDeviation) {
        //(iSAR(GhostOrderSymbol(),PERIOD_CURRENT,0.02,0.2,0)<bid) //&& (iSAR(NULL,0,0.02,0.2,1)>Close[1] || iSAR(NULL,0,0.02,0.2,2)>Close[2])
        // ) {
         //Print("Bid[",DoubleToString(Bid),"] - Hx[", DoubleToString(val_high_index4), "]" );
         if (Bid > sma0_60 && sma0_60 > sma1_60 && sma1_60 > sma2_60 && sma2_60 > sma3_60) {
            if (local_maximum != EMPTY_VALUE && Bid > local_maximum + 2*getPointCoef()) {
               //if(bid > val_high_index2 && bid > val_high_index3 && bid > val_high_index4)
               //ChickenOutClose(GhostOrderSymbol(), OP_SELL);
               if(iSAR(GhostOrderSymbol(),PERIOD_CURRENT,0.02,0.2,0)<Bid) {
                  // Print("Order Count:", _ordCount, "/", _ordTotal);
                  Print("BUY -- Local Maximum @Bid[",Bid,"] > ",NormalizeDouble(local_maximum,Digits));
                  Print("BUY -- Thold[",DoubleToString(StandardDeviation),"] - iStdDev[", DoubleToString(stdDev), "/", DoubleToString(stdDev1), " -->",stdDevCoeff,"]" );
                  return(buy);
               }
            }
            /*else if (IsLocalMinimum(1, i_extremumRank) != EMPTY_VALUE && ask < IsLocalMinimum(1, i_extremumRank)) */
            /*else if (Ask - sma0_60 > 0 && Ask - sma0_60 <= 5*getPointCoef()) {
               return (sell);
            }*/
        }
      }
/*
      if (
          //sma0_60 >= sma1_60 && 
          sma0_60 >= sma2_60 // && 
          // sma2_60 >= sma3_60
         ) {
         if(
            (sma2_60-Ask>=2*ExecutionPoint*getPointCoef())
           ) {
            return(buy);
         } else {
            return(sell);
         }
      }
      
      if (
          //sma0_60 <= sma1_60 && 
          sma0_60 <= sma2_60 // && 
          //sma2_60 <= sma3_60
         ) {
         if(
            (Bid-sma2_60>=2*ExecutionPoint*getPointCoef())
           ) {
            return(sell);
         } else {
            return(buy);
         }
      }
*/
   /*
      double sma0_20  = iMA(NULL, PERIOD_CURRENT,20,0,MODE_SMMA,PRICE_MEDIAN,0);
      double sma1_20  = iMA(NULL, PERIOD_CURRENT,20,0,MODE_SMMA,PRICE_MEDIAN,1);
      double sma2_20  = iMA(NULL, PERIOD_CURRENT,20,0,MODE_SMMA,PRICE_MEDIAN,2);
      double stoch1   = iStochastic(NULL, PERIOD_CURRENT, i_periodK, i_periodD, i_slowing, MODE_EMA, 0, MODE_MAIN, 1);
      double stoch2   = iStochastic(NULL, PERIOD_CURRENT, i_periodK, i_periodD, i_slowing, MODE_EMA, 0, MODE_MAIN, 2);

      if(val_index1 != -1 && val_index2 != -1 && val_index3 != -1)
      {
         val1 = Low[val_index1];
         val2 = Low[val_index2];
         val3 = Low[val_index3];
         
         if(
            (Ask-val1>5*getPointCoef()) ||
            (Ask-val2>10*getPointCoef()) || 
            (Ask-val3>15*getPointCoef())
         )
         {
            if(type == OP_SELL)
            {
               if((stoch1<i_highLevel && stoch2>i_highLevel) || (sma2_20 > sma1_20 && sma1_20 > sma0_20 && Ask < sma0_20)) {
                  val_index1 = iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,2,1);
                  val_index2 = iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,20,1);
                  val_index3 = iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,200,1);

                  if(val_index1 != -1 && val_index2 != -1 && val_index3 != -1)
                  {
                     val1 = Low[val_index1];
                     val2 = Low[val_index2];
                     val3 = Low[val_index3];
                     
                     if(!(val1 <= val2 && val1 < val3 && val2 <= val3 && MathAbs(Bid-val1)<=5*getPointCoef()))
                     {
                        return(sell);
                     }
                  }
               }
            } 
         }
      }

      val_index1 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,4,1);
      val_index2 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,8,1);
      val_index3 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,12,1);
      if(val_index1 != -1 && val_index2 != -1 && val_index3 != -1)
      {
         val1 = High[val_index1];
         val2 = High[val_index2];
         val3 = High[val_index3];
         
         if(
            (val1-Bid>5*getPointCoef()) ||
            (val2-Bid>10*getPointCoef()) || 
            (val3-Bid>15*getPointCoef())
         )
         {
            if(type == OP_BUY)
            {
               if((stoch1>i_lowLevel && stoch2<i_lowLevel) || (sma2_20 < sma1_20 && sma1_20 < sma0_20 && Bid > sma0_20)) {

                  val_index1 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,2,1);
                  val_index2 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,20,1);
                  val_index3 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,200,1);

                  if(val_index1 != -1 && val_index2 != -1 && val_index3 != -1)
                  {
                     val1 = High[val_index1];
                     val2 = High[val_index2];
                     val3 = High[val_index3];
                     
                     if(!(val1 >= val2 && val1 > val3 && val2 >= val3 && MathAbs(Bid-val1)<=5*getPointCoef()))
                     {
                        return(buy);
                     }
                  }
               }
            }
         }
      }
   */
   /*
      if(stoch1>m_lowLevel && stoch2<m_lowLevel)
         return SIGNAL_BUY_OPEN;
   
      if(stoch1<m_highLevel && stoch2>m_highLevel)
         return SIGNAL_SELL_OPEN;
   
      if(stoch1>m_highCloseLevel)
         return SIGNAL_BUY_CLOSE;
   
      if(stoch1<m_lowCloseLevel)
         return SIGNAL_SELL_CLOSE;
   
      return SIGNAL_NONE;
   */
   //----
      //int total=Bars-int(i_periodK);
      //for(int m_lastExtBarIndex=0; m_lastExtBarIndex<total; m_lastExtBarIndex++)
      //{
      /*
         if ((stoch1>i_lowLevel && stoch2<i_lowLevel) && ((sma2_20 < sma1_20 && sma1_20 < sma0_20 && Bid > sma0_20) && (IsLocalMinimum(3, i_extremumRank)))) 
         {
            if(!(val1 < Ask && val1 < val2 && val2 < val3)) {
               return(buy);
            }
         } 
         else 
         
         if ((stoch1<i_highLevel && stoch2>i_highLevel) && ((sma2_20 > sma1_20 && sma1_20 > sma0_20 && Ask < sma0_20) && (IsLocalMaximum(3, i_extremumRank)))) 
         {
            if(!(val1 > Bid && val1 > val2 && val2 > val3))
            {
               return(sell);
            }
         }
      */
      //}
   //----
      HideTestIndicators(TRUE);
   //----      
   //}
//----   
  return(EMPTY_VALUE);
}      
         
// ------------------------- EXIT SIGNAL ---------------------
int trigger(int pos, int count, int count_AA) {
//----
   //----
      HideTestIndicators(TRUE);
   //----
      int buy = 1, sell = -1;
   //----
      if(count_AA>1 && TriggerProtectionOn == FALSE)
      {
         return(0);
      }
     
      if(count_AA>1 && TriggerProtectionOn == TRUE)
      {
         int minDuration = MinDuration * 60 * 60; // 2 hours
         int maxDuration = MaxDuration * 60 * 60; // 8 hours
         for(int pos = GhostOrdersTotal()-1; pos >= 0 ; pos--) if (
             GhostOrderSelect(pos, SELECT_BY_POS)            // Only my orders w/
         &&  GhostOrderMagicNumber() == MagicNumber         // my magic number
         &&  GhostOrderSymbol()      == Symbol()
         &&  GhostOrderType()        == pos ){               // and period and symbol
             int duration = TimeCurrent() - GhostOrderOpenTime();
             if (duration >= minDuration && duration <= maxDuration) {
               if (pos == OP_BUY) {
                  return(buy);
               }
               
               if (pos == OP_SELL) {
                  return(sell);
               }
             }
         }         
      }

   //----
      if (signal(pos, count, count_AA) == buy) {
         return(buy);
      }
      
      if (signal(pos, count, count_AA) == sell) {
         return(sell);
      }

      if(IsNewsTime())
      {
         if (pos == OP_BUY) {
            return(buy);
         }
         
         if (pos == OP_SELL) {
            return(sell);
         }
      }
      
      double stoch1   = iStochastic(NULL, PERIOD_CURRENT, i_periodK, i_periodD, i_slowing, MODE_EMA, 0, MODE_MAIN, 1);
      double stoch2   = iStochastic(NULL, PERIOD_CURRENT, i_periodK, i_periodD, i_slowing, MODE_EMA, 0, MODE_MAIN, 2);
      
      if(stoch1>i_highCloseLevel) {
         return(buy);
      }
   
      if(stoch1<i_lowCloseLevel) {
         return(sell);
      } 
   //----
      HideTestIndicators(TRUE);
//----   
  return(0);
}

double IsLocalMinimum(int barIndex, uint m_extremumRank)
{
   int lowestIndex = iLowest(GhostOrderSymbol(), PERIOD_CURRENT, MODE_CLOSE, m_extremumRank, barIndex);
   int highestIndex = iHighest(GhostOrderSymbol(), PERIOD_CURRENT, MODE_CLOSE, m_extremumRank, barIndex);

   double lowest  = Low[lowestIndex];
   double highest = High[highestIndex];
   
   double local_minimum = lowest;
   double diff = MathAbs(Ask-local_minimum);

   if(nearest_support > 0 && nearest_support < Ask &&
      /*MathAbs(Ask-nearest_support) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Ask-nearest_support) < diff) {
      local_minimum = nearest_support;
      diff = MathAbs(Ask-local_minimum);
   }

   if(nearest_daily_support > 0 && nearest_daily_support < Ask &&
      /*MathAbs(Ask-nearest_daily_support) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Ask-nearest_daily_support) < diff) {
      local_minimum = nearest_daily_support;
      diff = MathAbs(Ask-local_minimum);
   }

   if(nearest_resistance > 0 && nearest_resistance < Ask &&
      /*MathAbs(Ask-nearest_resistance) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Ask-nearest_resistance) < diff) {
      local_minimum = nearest_resistance;
      diff = MathAbs(Ask-local_minimum);
   }

   if(nearest_daily_resistance > 0 && nearest_daily_resistance < Ask &&
      /*MathAbs(Ask-nearest_daily_resistance) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Ask-nearest_daily_resistance) < diff) {
      local_minimum = nearest_daily_resistance;
      diff = MathAbs(Ask-local_minimum);
   }

   return(NormalizeDouble(local_minimum,Digits));
}

double IsLocalMaximum(int barIndex, uint m_extremumRank)
{
   int lowestIndex = iLowest(GhostOrderSymbol(), PERIOD_CURRENT, MODE_CLOSE, m_extremumRank, barIndex);
   int highestIndex = iHighest(GhostOrderSymbol(), PERIOD_CURRENT, MODE_CLOSE, m_extremumRank, barIndex);

   double lowest  = Low[lowestIndex];
   double highest = High[highestIndex];
   
   double local_maximum = highest;
   double diff = MathAbs(Bid-local_maximum);

   if(nearest_resistance > 0 && nearest_resistance > Bid &&
      /*MathAbs(Bid-nearest_resistance) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Bid-nearest_resistance) < diff) {
      local_maximum = nearest_resistance;
      diff = MathAbs(Bid-local_maximum);
   }

   if(nearest_daily_resistance > 0 && nearest_daily_resistance > Bid &&
      /*MathAbs(Bid-nearest_daily_resistance) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Bid-nearest_daily_resistance) < diff) {
      local_maximum = nearest_daily_resistance;
      diff = MathAbs(Bid-local_maximum);
   }

   if(nearest_support > 0 && nearest_support > Bid &&
      /*MathAbs(Bid-nearest_support) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Bid-nearest_support) < diff) {
      local_maximum = nearest_support;
      diff = MathAbs(Bid-local_maximum);
   }

   if(nearest_daily_support > 0 && nearest_daily_support > Bid &&
      /*MathAbs(Bid-nearest_daily_support) > ExecutionPoint*getPointCoef() &&*/ MathAbs(Bid-nearest_daily_support) < diff) {
      local_maximum = nearest_daily_support;
      diff = MathAbs(Bid-local_maximum);
   }

   return(NormalizeDouble(local_maximum,Digits));
}

// Added 2 functions for NBP: SellMinTP, BuyMaxTP

double SellMinTP() {
   double ld_ret_0 = 0;
   int ticket = 0;
   for (int l_pos_8 = OrdersTotal() - 1; l_pos_8 >= 0; l_pos_8--) {
      OrderSelect(l_pos_8, SELECT_BY_POS, MODE_TRADES);
      if (OrderMagicNumber() == MagicNumber) {
         if (OrderSymbol() == Symbol()) {
            if (OrderType() == OP_SELL) {
               if (ticket == 0) ticket = OrderTicket();
               if (ld_ret_0 == 0.0) ld_ret_0 = OrderOpenPrice() - NBP * getPointCoef();
               if (OrderTicket() < ticket && MathAbs(OrderOpenPrice()-OrderClosePrice()) >= NBP*getPointCoef() /*OrderLots() != base_lot*/) {
                  ticket = OrderTicket();
                  if (ld_ret_0 > OrderOpenPrice() - NBP * getPointCoef()) ld_ret_0 = OrderOpenPrice() - NBP * getPointCoef();
               }
            }
         }
      }
   }
   return (ld_ret_0);
}

double BuyMaxTP() {
   double ld_ret_0 = 0;
   int ticket = 0;
   for (int l_pos_8 = OrdersTotal() - 1; l_pos_8 >= 0; l_pos_8--) {
      OrderSelect(l_pos_8, SELECT_BY_POS, MODE_TRADES);
      if (OrderMagicNumber() == MagicNumber) {
         if (OrderSymbol() == Symbol()) {
            if (OrderType() == OP_BUY) {
               if (ticket == 0) ticket = OrderTicket();
               if (ld_ret_0 == 0.0) ld_ret_0 = OrderOpenPrice() + NBP * getPointCoef();
               if (OrderTicket() < ticket && MathAbs(OrderOpenPrice()-OrderClosePrice()) >= NBP*getPointCoef() /*OrderLots() != base_lot*/) {
                  ticket = OrderTicket();
                  if (ld_ret_0 < OrderOpenPrice() + NBP * getPointCoef()) ld_ret_0 = OrderOpenPrice() + NBP * getPointCoef();
               }
            }
         }
      }
   }
   return (ld_ret_0);
} 

bool MarginEnoughCheck(double lot) { // No money check ))
         if (AccountFreeMargin() < 1 ) return(false); // Low margin
         if (AccountFreeMargin() < lot * MarketInfo(Symbol(), MODE_MARGINREQUIRED)) return(false); //No margin to op order
   return(true);
}

void updateMagicNumber() {
   int li_0;
   string ls_12;
   int lia_20[256];
   for (int li_4 = 0; li_4 < 256; li_4++) {
      li_0 = li_4;
      for (int l_count_8 = 0; l_count_8 < 8; l_count_8++) {
         if (li_0 & 1 > 0) li_0 = li_0 >> 1 ^ (-306674912);
         else li_0 >>= 1;
      }
      lia_20[li_4] = li_0;
   }
   if (MagicNumber == 0) {
      ls_12 = Symbol() + 0;
      li_0 = -1;
      for (int li_4 = StringLen(ls_12) - 1; li_4 >= 0; li_4--) li_0 = li_0 >> 8 ^ lia_20[li_0 ^ StringGetChar(ls_12, li_4) & 255];
      MagicNumber = li_0 ^ (-1) & EMPTY_VALUE;
   }
   Print("Using magic number: " + MagicNumber);
}

void f0_14(int ai_unused_0, int ai_4) {
   int li_64;
   bool bool_68;
   int datetime_8 = 0;
   double order_open_price_12 = 0;
   double order_lots_20 = 0;
   double order_takeprofit_28 = 0;
   double order_stoploss_36 = 0;
   int cmd_44 = -1;
   int ticket_48 = 0;
   int pos_52 = 0;
   int count_AA = 0;
   int count_BB = 0;
//--- Assert 2: Init OrderSelect #12
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   int   total = GhostOrdersTotal();
   for (pos_52 = total; pos_52 > 0; pos_52--) {
      if (GhostOrderSelect(pos_52, SELECT_BY_POS, MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber) {
            count_AA+=1;
            if (GhostOrderType() == OP_SELL) {
               count_BB+=1;
               // Print("*");
               if (GhostOrderOpenTime() > datetime_8) {
                  datetime_8 = GhostOrderOpenTime();
                  order_open_price_12 = GhostOrderOpenPrice();
                  cmd_44 = GhostOrderType();
                  ticket_48 = GhostOrderTicket();
                  if (order_takeprofit_28 == 0 || order_takeprofit_28 > GhostOrderTakeProfit()) {
                     order_takeprofit_28 = GhostOrderTakeProfit();
                  }
                  order_stoploss_36 = GhostOrderStopLoss();
               }
               if (GhostOrderLots() > order_lots_20) order_lots_20 = GhostOrderLots();
            }
         }
      }
   }
//--- Assert 1: Free OrderSelect #12
   GhostFreeSelect(false);
   int li_60 = MathRound(MathLog(order_lots_20 / base_lot) / MathLog(gd_964)) + 1.0;
   if (li_60 < 0) li_60 = 0;
   gd_1016 = NormalizeDouble(base_lot * MathPow(gd_964, li_60), gi_1084);
   // Print("count_BB:",count_BB);
   if (li_60 == 0 && signal(OP_SELL, count_BB, count_AA) == -1) {
      //if (Month() == 12 && Day() >= 10) return;
      if (FreezeAfterTP == FALSE && gi_956 == FALSE) f0_13();
      else
         if (ai_4 > 0) f0_13();
   } else {
/*
      if (signal(OP_BUY, 0, 0) == 1 || signal(OP_SELL, 0, 0) == EMPTY_VALUE ) {
         if ( count_BB > 5 )
            CloseSellOrders(TRUE);
      }
*/
      if(/*trigger(OP_SELL, count_AA) != -1 &&*/ Bid - order_open_price_12 > gi_execution_point * gd_1076 && order_open_price_12 > 0.0 && count_BB < MaximumSellLevels){ 
         /*if (Negative_Basket_Protection == TRUE) {
            double std_TP, nbp_TP, tmp_TP;
            
            tmp_TP = SellMinTP();
            if (tmp_TP > 0.0 && tmp_TP < Bid - gi_take_profit * getPointCoef()) {
               f0_13(0, tmp_TP);
               return;
            } else {
               std_TP = Bid - gi_take_profit * getPointCoef();
               f0_13(0, std_TP);
               return;
            }
            
            //std_TP = Bid - gi_take_profit * getPointCoef();
            //nbp_TP = order_open_price_12 - NBP * getPointCoef();
            //if (std_TP > nbp_TP) {
            //   tmp_TP = SellMinTP();
            //   if (tmp_TP == 0.0) {
            //      f0_13(0, std_TP);
            //      return;
            //   }
            //   tmp_TP = nbp_TP;
            //   f0_13(0, tmp_TP);
            //   return;
            //}
            //f0_13(0, std_TP);
            //return;
         } // IF NBP TRUE  */

         /* else */ if (!(f0_13())) return;
         
         return;  } // if Bid - ld_12 > ExecutionPoint * g...
      //}
   }
//--- Assert 7: Declare variables
   int      aCommand[];    // 1-OrderModify BUY; 2-OrderClose BUY; 3-OrderModify SELL; 4-OrderClose SELL;
   int      aTicket[];
   double   aOpenPrice[];
   double   aStopLoss[];
   double   aTakeProfit[];
   bool     aOk[];
   int      aCount;
//--- Assert 6: Dynamically resize arrays
   ArrayResize(aCommand,MaxAccountTrades);
   ArrayResize(aTicket,MaxAccountTrades);
   ArrayResize(aOpenPrice,MaxAccountTrades);
   ArrayResize(aStopLoss,MaxAccountTrades);
   ArrayResize(aTakeProfit,MaxAccountTrades);
   ArrayResize(aOk,MaxAccountTrades);
//--- Assert 2: Init OrderSelect #13
   total = GhostOrdersTotal();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
   for (pos_52 = 0; pos_52 < total; pos_52++) {
      if (GhostOrderSelect(pos_52, SELECT_BY_POS, MODE_TRADES)) {
      //--- Assert 5: Populate arrays
         aCommand[aCount]     =  0;
         aTicket[aCount]      =  GhostOrderTicket();
         aOpenPrice[aCount]   =  GhostOrderOpenPrice();
         aStopLoss[aCount]    =  GhostOrderStopLoss();
         aTakeProfit[aCount]  =  GhostOrderTakeProfit();
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == cmd_44) {
            if (GhostOrderTakeProfit() == order_takeprofit_28 || GhostOrderStopLoss() == order_stoploss_36 || order_stoploss_36 == 0.0 || order_takeprofit_28 == 0.0) continue;
            li_64 = Close_Order_Attempts;
            bool_68 = FALSE;
            while (bool_68 == FALSE && li_64 >= 0) {
               li_64--;
               RefreshRates();
            //--- 6: Assert replace OrderModify a sell trade with arrays
               aCommand[aCount]     = 3; 
               aOpenPrice[aCount]   = NormalizeDouble(GhostOrderOpenPrice(), Digits);
               aStopLoss[aCount]    = NormalizeDouble(order_stoploss_36, Digits);
               aTakeProfit[aCount]  = NormalizeDouble(
                     order_takeprofit_28 - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef(), Digits);
               aCount ++;
               if( aCount >= MaxAccountTrades ) break;
               /*bool_68 = OrderModify(OrderTicket(), NormalizeDouble(OrderOpenPrice(), Digits), NormalizeDouble(order_stoploss_36, Digits), NormalizeDouble(order_takeprofit_28, Digits),
                  0, Pink);*/
               if (!TRUE) {
                  g_error_1248 = GetLastError();
                  if (g_error_1248 == 146/* TRADE_CONTEXT_BUSY */) {
                     Sleep(50);
                     continue;
                  }
               }
               bool_68 = TRUE;
            }
         }
      }
   }
//--- Assert 1: Free OrderSelect #13
   GhostFreeSelect(false);
//--- Assert for: process array of commands
   for(int i=0; i<aCount; i++)
   {
      switch( aCommand[i] )
      {
         case 1:  // OrderModify Buy
         case 2:  // OrderClose Buy
         case 3:  // OrderModify Sell
            GhostOrderModify( aTicket[i], aOpenPrice[i], aStopLoss[i], aTakeProfit[i], 0, Pink ); 
            break;
         case 4:  // OrderClose Sell
            break;
      }
   }

   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   count_AA = 0;
   count_BB = 0;
   total = GhostOrdersTotal();
   for (pos_52 = total; pos_52 > 0; pos_52--) {
      if (GhostOrderSelect(pos_52, SELECT_BY_POS, MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber) {
            count_AA+=1;
            if (GhostOrderType() == OP_SELL) {
               count_BB+=1;
               if (GhostOrderOpenTime() > datetime_8) {
                  datetime_8 = GhostOrderOpenTime();
                  order_open_price_12 = GhostOrderOpenPrice();
                  cmd_44 = GhostOrderType();
                  ticket_48 = GhostOrderTicket();
                  if (order_takeprofit_28 == 0 || order_takeprofit_28 > GhostOrderTakeProfit()) {
                     order_takeprofit_28 = GhostOrderTakeProfit();
                  }
                  order_stoploss_36 = GhostOrderStopLoss();
               }
               if (GhostOrderLots() > order_lots_20) order_lots_20 = GhostOrderLots();
            }
         }
      }
   }
   if (TriggerShortHit == FALSE && count_BB>3)
   {
      TriggerShortHit=TRUE;
   }
}

int ChickenOutClose(string a_symbol_0, int type) {
   int ticket_20;
   int li_12 = 0;
   bool is_closed_16 = FALSE;
   int error_24 = 0;
   int order_total_28 = GhostOrdersTotal();
   if (order_total_28 == 0) return (0);
   double ld_unused_32 = 0;
//--- Assert 6: Declare variables
   int      aCommand[];    // 1-OrderModify BUY; 2-OrderClose BUY; 3-OrderModify SELL; 4-OrderClose SELL;
   int      aTicket[];
   double   aLots[];
   double   aClosePrice[];
   bool     aOk[];
   int      aCount;
//--- Assert 5: Dynamically resize arrays
   ArrayResize(aCommand,MaxAccountTrades);
   ArrayResize(aTicket,MaxAccountTrades);
   ArrayResize(aLots,MaxAccountTrades);
   ArrayResize(aClosePrice,MaxAccountTrades);
   ArrayResize(aOk,MaxAccountTrades);
   RefreshRates();
//--- Assert 2: Init OrderSelect #14
   GhostInitSelect(false,0,SELECT_BY_POS,MODE_TRADES);
   for (int pos_40 = order_total_28 - 1; pos_40 >= 0; pos_40--) {
      if (GhostOrderSelect(pos_40, SELECT_BY_POS, MODE_TRADES)) {
      //--- Assert 5: Populate arrays
         int size  = ArraySize(aCommand);
         if(size <= 0 || aCount > size) break;
         else {
            aCommand[aCount]     =  0;
            aTicket[aCount]      =  GhostOrderTicket();
            aLots[aCount]        =  GhostOrderLots();
            aClosePrice[aCount]  =  GhostOrderClosePrice();
            if (GhostOrderSymbol() == a_symbol_0 && GhostOrderMagicNumber() == MagicNumber) {
               if (type == OP_BUY && GhostOrderType() == OP_BUY) {
                  RefreshRates();
                  li_12 = Close_Order_Attempts;
                  is_closed_16 = FALSE;
                  while (is_closed_16 == 0 && li_12 >= 0) {
                     li_12--;
                     RefreshRates();
                     ticket_20 = GhostOrderTicket();
                  //--- 6: Assert replace OrderClose a buy trade with arrays
                     aCommand[aCount]     = 2; 
                     aClosePrice[aCount]  = NormalizeDouble(Bid, Digits);
                     aCount ++;
                     if( aCount >= MaxAccountTrades ) break;
                     /*is_closed_16 = OrderClose(ticket_20, OrderLots(), NormalizeDouble(Bid, Digits), Slippage, Red);*/
                     if (!TRUE) {
                        error_24 = GetLastError();
                        Print("Leviathan OrderClose FAILED : Ticket [" + ticket_20 + "]. " + "Error " + error_24 + " [" + ErrorDescription(error_24) + ".]");
                        if (error_24 == 146/* TRADE_CONTEXT_BUSY */) Sleep(50);
                     }
                  }
                  continue;
               }
               if (type == OP_SELL && GhostOrderType() == OP_SELL) {
                  RefreshRates();
                  li_12 = Close_Order_Attempts;
                  is_closed_16 = FALSE;
                  while (is_closed_16 == 0 && li_12 >= 0) {
                     li_12--;
                     RefreshRates();
                     ticket_20 = GhostOrderTicket();
                  //--- 6: Assert replace OrderModify a sell trade with arrays
                     aCommand[aCount]     = 4; 
                     aClosePrice[aCount]  = NormalizeDouble(Ask, Digits);
                     aCount ++;
                     if( aCount >= MaxAccountTrades ) break;
                     /*is_closed_16 = OrderClose(ticket_20, OrderLots(), NormalizeDouble(Ask, Digits), Slippage, Green);*/
                     if (!TRUE) {
                        error_24 = GetLastError();
                        Print("Leviathan OrderClose FAILED : Ticket [" + ticket_20 + "]. " + "Error " + error_24 + " [" + ErrorDescription(error_24) + ".]");
                        if (error_24 == 146/* TRADE_CONTEXT_BUSY */) Sleep(50);
                     }
                  }
               }
            }
         }
      }
   }
//--- Assert 1: Free OrderSelect #14
   GhostFreeSelect(false);
//--- Assert for: process array of commands
   for(int i=0; i<aCount; i++)
   {
      switch( aCommand[i] )
      {
         case 1:  // OrderModify Buy
         case 2:  // OrderClose Buy
            GhostOrderClose( aTicket[i], aLots[i], aClosePrice[i], Slippage, Red ); 
            break;
         case 3:  // OrderModify Sell
         case 4:  // OrderClose Sell
            GhostOrderClose( aTicket[i], aLots[i], aClosePrice[i], Slippage, Green ); 
            break;
      }
   }
   return (1);
}

int f0_4() {
   int li_0;
   int li_4;
   int li_8;
   int li_12;
   if (DayOfWeek() == 0) {
      li_0 = SUN_StartHour;
      li_4 = SUN_StartMinute;
      li_8 = SUN_EndHour;
      li_12 = SUN_EndMinute;
   }
   if (DayOfWeek() == 1) {
      li_0 = MON_StartHour;
      li_4 = MON_StartMinute;
      li_8 = MON_EndHour;
      li_12 = MON_EndMinute;
   }
   if (DayOfWeek() == 2) {
      li_0 = TUE_StartHour;
      li_4 = TUE_StartMinute;
      li_8 = TUE_EndHour;
      li_12 = TUE_EndMinute;
   }
   if (DayOfWeek() == 3) {
      li_0 = WED_StartHour;
      li_4 = WED_StartMinute;
      li_8 = WED_EndHour;
      li_12 = WED_EndMinute;
   }
   if (DayOfWeek() == 4) {
      li_0 = THU_StartHour;
      li_4 = THU_StartMinute;
      li_8 = THU_EndHour;
      li_12 = THU_EndMinute;
   }
   if (DayOfWeek() == 5) {
      li_0 = FRI_StartHour;
      li_4 = FRI_StartMinute;
      li_8 = FRI_EndHour;
      li_12 = FRI_EndMinute;
   }
   if (DayOfWeek() == 6) {
      li_0 = SAT_StartHour;
      li_4 = SAT_StartMinute;
      li_8 = SAT_EndHour;
      li_12 = SAT_EndMinute;
   }
   int li_16 = 60 * TimeHour(TimeCurrent()) + TimeMinute(TimeCurrent());
   int li_20 = 60 * li_0 + li_4;
   int li_24 = 60 * li_8 + li_12;
   if (li_20 == li_24) return (0);
   if (li_20 < li_24) {
      if (!(!(li_16 >= li_20 && li_16 < li_24))) return (1);
      return (0);
   }
   if (li_20 > li_24) {
      if (!(!(li_16 >= li_20 || li_16 < li_24))) return (1);
      return (0);
   }
   return (0);
}

void DisplayLeviathanInfo() {
   string accountDD = DoubleToStr(AccountDrawDown(2), 2);
   if (!IsTesting()) AccountTotalLossProfit();

   /*
   MqlDateTime currentBarTimeStruct;
   TimeToStruct(iTime(Symbol(),PERIOD_H1,0),currentBarTimeStruct);
   datetime currentBarTimeGMT = StrToTime(currentBarTimeStruct.year+"."+currentBarTimeStruct.mon+"."+currentBarTimeStruct.day+" "+(currentBarTimeStruct.hour-GMT_Offset)+":"+currentBarTimeStruct.min+":"+currentBarTimeStruct.sec);
   */
   
   string Session = "[REGULAR] Trading ...";
   if (IsNewsTime()) Session = "[PAUSE] News incoming ...";
   
   if (FreezeAfterTPScheduler == TRUE && f0_4() == 1) {
      Comment( 
         GhostComment(
            "\n*=====================*"+
            "\n    "+EA_Name+
            "\n*=====================*"+
            "\n   "+Session+
            "\n   News Filter: "+(Use_NewsFilter ? "ON" : "OFF")+
            "\n   - [High "+MinsBeforeHigh+"/"+MinsAfterHigh+"]: "+(IncludeHigh ? "ON" : "OFF")+
            "\n   - [Medium "+MinsBeforeMedium+"/"+MinsAfterMedium+"]: "+(IncludeMedium ? "ON" : "OFF")+
            "\n   - [Low "+MinsBeforeLow+"/"+MinsAfterLow+"]: "+(IncludeLow ? "ON" : "OFF")+
            "\n   - [Speaks "+MinsBeforeSpeaks+"/"+MinsAfterSpeaks+"]: "+(IncludeSpeaks ? "ON" : "OFF")+
            "\n*=====================*"+
            "\n    GMT  Offset(Local) = "+GMT_Offset+
            "\n    GMT    Time         = "+TimeToStr(/*currentBarTimeGMT*/myTimeGMT(), TIME_DATE|TIME_MINUTES|TIME_SECONDS)+
            "\n    Server Time          = "+TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES|TIME_SECONDS)+
            "\n*=====================*"+
            "\n    Magic Number       = "+MagicNumber+
            "\n*=====================*"+
            "\nBase Lot  :  " + LOT() + 
            "\nAccount Leverage  :  " + "1 : " + AccountLeverage() + 
            "\nAccount Type  :  " + AccountServer() + 
            "\nAccount Balance = " + GhostAccountBalance() +
            "\nAccount Equity  = " + GhostAccountEquity() +
            "\nFree Margin     = " + GhostAccountFreeMargin() +
            "\nDrawdown  :  " + accountDD + "%" +
            "\nTotal Profit/Loss = " + totalProfit +
            "\nFreezeAfterTPScheduler: ON" +
            "\n\n"
         )
      );
      return;
   }
   Comment( 
      GhostComment(
         "\n*=====================*"+
         "\n    "+EA_Name+
         "\n*=====================*"+
         "\n   "+Session+
         "\n   News Filter: "+(Use_NewsFilter ? "ON" : "OFF")+
         "\n   - [High "+MinsBeforeHigh+"/"+MinsAfterHigh+"]: "+(IncludeHigh ? "ON" : "OFF")+
         "\n   - [Medium "+MinsBeforeMedium+"/"+MinsAfterMedium+"]: "+(IncludeMedium ? "ON" : "OFF")+
         "\n   - [Low "+MinsBeforeLow+"/"+MinsAfterLow+"]: "+(IncludeLow ? "ON" : "OFF")+
         "\n   - [Speaks "+MinsBeforeSpeaks+"/"+MinsAfterSpeaks+"]: "+(IncludeSpeaks ? "ON" : "OFF")+
         "\n*=====================*"+
         "\n    GMT  Offset(Local) = "+GMT_Offset+
         "\n    GMT    Time         = "+TimeToStr(/*currentBarTimeGMT*/myTimeGMT(), TIME_DATE|TIME_MINUTES|TIME_SECONDS)+
         "\n    Server Time          = "+TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES|TIME_SECONDS)+
         "\n*=====================*"+
         "\n    Magic Number       = "+MagicNumber+
         "\n*=====================*"+
         "\nBase Lot  :  " + LOT() + 
         "\nAccount Leverage  :  " + "1 : " + AccountLeverage() +
         "\nAccount Type  :  " + AccountServer() +
         "\nAccount Balance = " + GhostAccountBalance() +
         "\nAccount Equity  = " + GhostAccountEquity() +
         "\nFree Margin     = " + GhostAccountFreeMargin() +
         "\nDrawdown  :  " + accountDD + "%" +
         "\nTotal Profit/Loss = " + totalProfit +
         "\nFreezeAfterTPScheduler: OFF" +
         "\n\n"
      )
   );
}

int f0_0() {
   return (1);
}

double AccountDrawDown(int ai_0) {
   double ld_ret_4;
   double balance = GhostAccountBalance();
          balance = (balance == 0 ? -1.0 : balance);
   if (ai_0 == 2) {
      ld_ret_4 = (GhostAccountEquity() / balance - 1.0) / (-0.010000000000000000208);
      if (ld_ret_4 <= 0.0) return (0);
      return (ld_ret_4);
   }
   if (ai_0 == 1) {
      ld_ret_4 = 100.0 * (GhostAccountEquity() / balance - 1.0);
      if (ld_ret_4 <= 0.0) return (0);
      return (ld_ret_4);
   }
   return (0.0);
}

///////////////////////////////////////////////////////////////////////
int fun0(double& a0[], double& a1[], int a2, int a3, double a4, double& a5[], double a6, int a7)
{
{
  int v8; // esi@1
  double v9; // st7@5
//  unsigned int v10; // edx@8
//  unsigned int v11; // eax@8
  double v12; // st7@36
  //double *v13; // eax@36
  double v14; // st7@183
  double v16; // [sp+8h] [bp-8h]@5

  v8 = 0;
  /*
  if ( v4656A0 != 200 || v465690 || a7 != v46569C && a7 + 2 != v46569C )
    return -1;
    */
  v9 = a0[25]; //take profit standart
  v16 = a1[25]; // mult standart
 
    if ( a0[a3] <= 0.0 )
      v9 = a0[25];
    else
      v9 = a0[a3];
    if ( a1[a3] > 0.0 )
    {
      v16 = a1[a3];
      v8 = 1;
    }
    
  // Standard Leviathan 2.0 Logic's
  if (!EnvyAugmenterOn)
      {if (a3 == 0 || a3 > 1) {v16 = a1[25];}}
    
//LABEL_10:
  if ( a1[1] > 0.0
    || a1[2] > 0.0
    || a1[3] > 0.0
    || a1[4] > 0.0
    || a1[5] > 0.0
    || a1[6] > 0.0
    || a1[7] > 0.0
    || a1[8] > 0.0
    || a1[9] > 0.0
    || a1[10] > 0.0
    || a1[11] > 0.0
    || a1[12] > 0.0
    || a1[13] > 0.0
    || a1[14] > 0.0
    || a1[15] > 0.0
    || a1[16] > 0.0
    || a1[17] > 0.0
    || a1[18] > 0.0
    || a1[19] > 0.0
    || a1[20] > 0.0
    || a1[21] > 0.0
    || a1[22] > 0.0
    || a1[23] > 0.0
    || a1[24] > 0.0 )
    v8 = 1;
  if ( a2 == 3 )
  {
    v12 = v9 * 10.0;
    //v13 = a5;
    a5[1] = 0.01;
    a5[0] = v12;
  }
  else
  {
    if ( a2 == 5 )
    {
      v14 = v9 * 10.0;
      //v13 = a5;
      a5[1] = 0.0001;
      a5[0] = v14;
    }
    else
    {
      //v13 = a5;
      a5[0] = v9;
      a5[1] = a4;
    }
  }
  a5[0] = v9; // Fix 3/5 (23 Lines up disabled, is no need with new 3/5 system)
  a5[1] = getPointCoef(); // Fix 3/5
  a5[2] = v16;
  a5[3] = a6;
  //return (v8 == 1);
  return (v8);
}
}

int fun1(string& a0[], int a1, double a2, string a3, int a4)
{
   return (1);
}

//---------------------------------------------------------------------------         
double LOT()
{
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   double MINLOT = MarketInfo(Symbol(),MODE_MINLOT);
   double LOT = MINLOT;
   
   double DDFromStart = (AccountBalance()-StartingBalance)*100/StartingBalance;
   
   LOT = BaseLotSize;
   
   LOT = NormalizeDouble(LOT,MarketInfo(Symbol(),MODE_DIGITS));


   if(LotStepEnable)
   {
      double safeProfit = AccountBalance();

      /*if (DDFromStart <= -2)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/2;
      } else if (DDFromStart <= -3)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/3;
      } else if (DDFromStart <= -5)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/5;
      } else if (DDFromStart <= -8)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/8;
      } else if (DDFromStart <= -10)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/10;
      } else if (DDFromStart <= -13)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/13;
      } else if (DDFromStart <= -15)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/15;
      } else if (DDFromStart <= -20)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/20;
      } else if (DDFromStart <= -50)
      {
         safeProfit = AccountBalance() + (StartingBalance - AccountBalance())/50;
      } else if (DDFromStart <= -60)
      {
         safeProfit = AccountBalance() + (AccountBalance()*5.0)/100;
      }*/
            
      double stepValue = ((safeProfit-LotStepFrom)/LotStepEvery)*LotStepValue ;
      double lotStepValue = NormalizeDouble( ( stepValue - MathMod(stepValue, LotStepValue) ) , MarketInfo(Symbol(),MODE_DIGITS) );;
      
      LOT += lotStepValue;
      //Log(" >>>>>>>>>>>>>>>>>>>>> ",AccountBalance(), " ----------------- ", lotStepValue, " ************** ", LOT );
   }

   /*double OneLotMargin = MarketInfo(Symbol(),MODE_MARGINREQUIRED);
   double MarginAmount = AccountEquity(); //this means we want to use 200$ for trade
   double lotMM = MarginAmount/OneLotMargin;
   double LotStep = MarketInfo(Symbol(),MODE_LOTSTEP);
   double LOT = NormalizeDouble(lotMM/LotStep,0)*LotStep;*/
   
   if (LOT>MarketInfo(Symbol(),MODE_MAXLOT)) LOT = MarketInfo(Symbol(),MODE_MAXLOT);
   if (LOT<MINLOT) LOT = MINLOT;
   if (MINLOT<0.1) LOT = NormalizeDouble(LOT,2); else LOT = NormalizeDouble(LOT,1);
   
   return(NormalizeDouble(LOT,MarketInfo(Symbol(),MODE_DIGITS)));
}


//----------------------------------------------------------------------------
double GetOpenOrdersHighestTP(int position) {
//--- Assert 2: Init OrderSelect #15
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   int total = GhostOrdersTotal();
   double tp = 0.0;
   double lots = 0.0;

   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == position) {
            if(position == OP_BUY) {
               if(tp == 0.0 || lots == 0.0) {
                  tp = GhostOrderTakeProfit();
                  lots = GhostOrderLots();
               } else if (lots > 0 && lots < GhostOrderLots()) {
                  tp = GhostOrderTakeProfit();
                  lots = GhostOrderLots();
               }
            }
            else
            if(position == OP_SELL) {
               if(tp == 0.0 || lots == 0.0) {
                  tp = GhostOrderTakeProfit();
                  lots = GhostOrderLots();
               } else if (lots > 0 && lots < GhostOrderLots()) {
                  tp = GhostOrderTakeProfit();
                  lots = GhostOrderLots();
               }
            }
         }
      }
   }

   return (tp);
}
bool FixOpenOrdersTP(double tp, int position) {
//--- Assert 2: Init OrderSelect #15
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   double ask = Ask + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
   double bid = Bid - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();

   bool updated = FALSE;
   int total = GhostOrdersTotal();
   
   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == position) {
            int aTicket          =  GhostOrderTicket();
            double aOpenPrice    =  GhostOrderOpenPrice();
            double aClosePrice   =  GhostOrderClosePrice();
            double aStopLoss     =  GhostOrderStopLoss();
            double aTakeProfit   =  GhostOrderTakeProfit();
            if (tp != EMPTY_VALUE && tp != 0.0) {
               if(position == OP_BUY) {
                  /*if(Bid<aOpenPrice) {
                     if (aTakeProfit < tp) {
                        // Order Modify Buy
                        updated = GhostOrderModify( aTicket, aOpenPrice, GhostOrderStopLoss(), tp, 0, Black );
                        continue;
                     }
                  }
                  else if (Bid>aOpenPrice && aTakeProfit > tp + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) && GhostOrderProfit() + GhostOrderCommission() + GhostOrderSwap() > 0) {
                     updated = GhostOrderClose( aTicket, GhostOrderLots(), aClosePrice, Slippage, White );
                     //--- Assert 1: Free OrderSelect #15
                     GhostFreeSelect(false);
                     continue;
                  }*/

                  /*else if (MathAbs(aClosePrice - (tp + MarketInfo(GhostOrderSymbol(), MODE_SPREAD))) <= Slippage) {
                     updated = GhostOrderClose( aTicket, GhostOrderLots(), aClosePrice, MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
                     //--- Assert 1: Free OrderSelect #15
                     GhostFreeSelect(false);
                  }*/
                  
                  if(Bid>NormalizeDouble(aOpenPrice+ExecutionPoint*getPointCoef(),Digits)) {
                     if(aStopLoss<NormalizeDouble(Bid-ExecutionPoint*getPointCoef(),Digits)) {
                        updated = GhostOrderModify( aTicket, aOpenPrice, NormalizeDouble(Bid-ExecutionPoint*getPointCoef(),Digits), aTakeProfit, 0, White );
                        if(Bid>NormalizeDouble(aTakeProfit-ExecutionPoint*getPointCoef(),Digits)) {
                           if(aTakeProfit<NormalizeDouble(Bid+ExecutionPoint*getPointCoef(),Digits))
                           updated = GhostOrderModify( aTicket, aOpenPrice, GhostOrderStopLoss(), NormalizeDouble(Bid+ExecutionPoint*getPointCoef(),Digits), 0, Black );
                        }
                     }
                  }
               }
               else
               if(position == OP_SELL) {
                  /*if(aTakeProfit > tp) {
                     // OrderModify Sell
                     updated = GhostOrderModify( aTicket, NormalizeDouble(aOpenPrice,Digits), NormalizeDouble(aStopLoss,Digits), tp, 0, Black );
                     continue;
                  }
                  if (aTakeProfit < tp - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) && GhostOrderProfit() + GhostOrderCommission() + GhostOrderSwap() > 0) {
                     updated = GhostOrderClose( aTicket, GhostOrderLots(), aClosePrice, MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
                     //--- Assert 1: Free OrderSelect #15
                     GhostFreeSelect(false);
                     continue;
                  }*/
                  /*else if (MathAbs(aClosePrice - (tp - MarketInfo(GhostOrderSymbol(), MODE_SPREAD))) <= Slippage) {
                     updated = GhostOrderClose( aTicket, GhostOrderLots(), aClosePrice, MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
                     //--- Assert 1: Free OrderSelect #15
                     GhostFreeSelect(false);
                  }*/
                  /*
                  if(Ask<aOpenPrice-5*getPointCoef() && Ask>aOpenPrice-10*getPointCoef()) {
                     if(aStopLoss>aOpenPrice-5*getPointCoef()) {
                                  GhostOrderModify( aTicket, NormalizeDouble(aOpenPrice,Digits), NormalizeDouble(aOpenPrice-5*getPointCoef(),Digits), aTakeProfit, 0, White );
                        //updated = GhostOrderModify( aTicket, NormalizeDouble(aOpenPrice,Digits), NormalizeDouble(aStopLoss,Digits), NormalizeDouble(aTakeProfit+5*getPointCoef(),Digits), 0, Black );
                        continue;
                     }
                  }*/
                  if(Ask<NormalizeDouble(aOpenPrice-ExecutionPoint*getPointCoef(),Digits)) {
                     if(aStopLoss>NormalizeDouble(Ask+ExecutionPoint*getPointCoef(),Digits)) {
                        updated = GhostOrderModify( aTicket, aOpenPrice, NormalizeDouble(Ask+ExecutionPoint*getPointCoef(),Digits), aTakeProfit, 0, White );
                        if(Ask<NormalizeDouble(aTakeProfit+ExecutionPoint*getPointCoef(),Digits)) {
                           if(aTakeProfit>NormalizeDouble(Ask-ExecutionPoint*getPointCoef(),Digits))
                           updated = GhostOrderModify( aTicket, aOpenPrice, GhostOrderStopLoss(), NormalizeDouble(Ask-ExecutionPoint*getPointCoef(),Digits), 0, Black );
                        }
                     }
                  }
               }
            }
         }
      }
   }

   return (updated);
}
//----------------------------------------------------------------------------
double GetOpenOrdersLowestSL(int position) {
//--- Assert 2: Init OrderSelect #15
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   int total = GhostOrdersTotal();
   double sl = 0.0;
   double lots = 0.0;
   
   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == position) {
            if(position == OP_BUY) {
               if(sl == 0.0 || lots == 0.0) {
                  sl = GhostOrderStopLoss();
                  lots = GhostOrderLots();
               } else if (lots > 0 && lots > GhostOrderLots()) {
                  sl = GhostOrderStopLoss();
                  lots = GhostOrderLots();
               }
            }
            else
            if(position == OP_SELL) {
               if(sl == 0.0 || lots == 0.0) {
                  sl = GhostOrderStopLoss();
                  lots = GhostOrderLots();
               } else if (lots > 0 && lots > GhostOrderLots()) {
                  sl = GhostOrderStopLoss();
                  lots = GhostOrderLots();
               }
            }
         }
      }
   }

   return (sl);
}
bool FixOpenOrdersSL(double sl, int position) {
//--- Assert 2: Init OrderSelect #15
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   double ask = Ask + MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();
   double bid = Bid - MarketInfo(GhostOrderSymbol(), MODE_SPREAD) * getPointCoef();

   bool updated = FALSE;
   int total = GhostOrdersTotal();
   
   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == position) {
            int aTicket          =  GhostOrderTicket();
            double aOpenPrice    =  GhostOrderOpenPrice();
            double aClosePrice   =  GhostOrderClosePrice();
            double aStopLoss     =  GhostOrderStopLoss();
            double aTakeProfit   =  GhostOrderTakeProfit();
            if (sl != EMPTY_VALUE && sl != 0.0) {
               if(position == OP_BUY) {
                  if (aStopLoss > sl) {
                     // Order Modify Buy
                     updated = GhostOrderModify( aTicket, aOpenPrice, sl, aTakeProfit, 0, Black );
                  }
               }
               else
               if(position == OP_SELL) {
                  if(aStopLoss < sl) {
                     // OrderModify Sell
                     updated = GhostOrderModify( aTicket, aOpenPrice, sl, aTakeProfit, 0, Black );
                  }
               }
            }
         }
      }
   }

   return (updated);
}
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
void CloseAllOrders(bool force=false) {
//--- Assert 2: Init OrderSelect #15
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   int total = GhostOrdersTotal();
   
   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber
            && GhostOrderSymbol() == Symbol()) {
            f0_16("close #" + GhostOrderTicket());
            
            double profit = GhostOrderProfit()+GhostOrderCommission()+GhostOrderSwap();
            
            if (profit<0 || force == TRUE)
            {
               GhostOrderClose( GhostOrderTicket(), GhostOrderLots(), GhostOrderClosePrice(), MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
               //--- Assert 1: Free OrderSelect #15
               GhostFreeSelect(false);
            }
         }
      }
   }
}
//----------------------------------------------------------------------------
void CloseBuyOrders(bool force=false) {
//--- Assert 2: Init OrderSelect #15
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   int total = GhostOrdersTotal();
   
   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == OP_BUY) {
            if(force)
            {
               f0_16("close #" + GhostOrderTicket());
               GhostOrderClose( GhostOrderTicket(), GhostOrderLots(), GhostOrderClosePrice(), MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
               //--- Assert 1: Free OrderSelect #15
               GhostFreeSelect(false);
            }
            else
            {
               if(Bid>GhostOrderOpenPrice()+5*getPointCoef()) 
               {
                  if(GhostOrderStopLoss()<GhostOrderOpenPrice()-5*getPointCoef())
                  {
                     GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), GhostOrderOpenPrice()-5*getPointCoef(), GhostOrderTakeProfit(), 0, White );
                  }
                  if(Bid>GhostOrderStopLoss()+10*getPointCoef() && GhostOrderStopLoss()<Bid-5*getPointCoef())
                  {
                     GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), Bid-5*getPointCoef(), GhostOrderTakeProfit(), 0, White );
                  }
               }
               /*else
               {
                  ModifyBuyOrders(GhostOrderTicket(),60,1);
                  ModifyBuyOrders(GhostOrderTicket(),120,1);
                  ModifyBuyOrders(GhostOrderTicket(),180,1);
                  ModifyBuyOrders(GhostOrderTicket(),360,1);
               }*/
            }
         }
      }
   }
}

void ModifyBuyOrders(int ticket, int countBars, int startBar)
{
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   if (GhostOrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) {
      int val_index1 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,countBars,startBar);
      int val_index2 = iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_HIGH,countBars,startBar);
      if(val_index1 != -1 && val_index2 != -1)
      {
         double val1 = High[val_index1];
         double val2 = Low[val_index2];
         if (Bid>val2+10*getPointCoef() && GhostOrderStopLoss()<val2-5*getPointCoef())
         {
            if(GhostOrderStopLoss()!=val2-5*getPointCoef())
               GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), val2-5*getPointCoef(), GhostOrderTakeProfit(), 0, White );
         }
         
         if(Bid<val1-10*getPointCoef() && GhostOrderTakeProfit()>val1 && (GhostOrderProfit()+GhostOrderCommission()+GhostOrderSwap())<0)
         {
            if(GhostOrderTakeProfit()!=val1 && (GhostOrderProfit()+GhostOrderCommission()+GhostOrderSwap())<0)
               GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), GhostOrderStopLoss(), val1, 0, White );
         }
      }
   }
}
//----------------------------------------------------------------------------
void CloseSellOrders(bool force=false) {
//--- Assert 2: Init OrderSelect #15
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
   
   int total = GhostOrdersTotal();

   for (int pos_32 = 0; pos_32 < total; pos_32++) {
      if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
         if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == OP_SELL) {
            if(force)
            {
               f0_16("close #" + GhostOrderTicket());
               GhostOrderClose( GhostOrderTicket(), GhostOrderLots(), GhostOrderClosePrice(), MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
               //--- Assert 1: Free OrderSelect #15
               GhostFreeSelect(false);
            }
            else
            {
               if(Ask<GhostOrderOpenPrice()-5*getPointCoef()) 
               {
                  if(GhostOrderStopLoss()>GhostOrderOpenPrice()+5*getPointCoef())
                  {
                     GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), GhostOrderOpenPrice()+5*getPointCoef(), GhostOrderTakeProfit(), 0, White );
                  }
                  if(Ask<GhostOrderStopLoss()-10*getPointCoef() && GhostOrderStopLoss()>Ask+5*getPointCoef())
                  {
                     GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), Ask+5*getPointCoef(), GhostOrderTakeProfit(), 0, White );
                  }
               }
               /*else
               {
                  ModifySellOrders(GhostOrderTicket(),60,1);
                  ModifySellOrders(GhostOrderTicket(),120,1);
                  ModifySellOrders(GhostOrderTicket(),180,1);
                  ModifySellOrders(GhostOrderTicket(),360,1);
               }*/
            }
         }
      }
   }
}

void ModifySellOrders(int ticket, int countBars, int startBar)
{
   RefreshRates();
   GhostRefresh();
   GhostReorderBuffers();
   GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);

   if (GhostOrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) {
      int val_index1 = iLowest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_LOW,countBars,startBar);
      int val_index2 = iHighest(GhostOrderSymbol(),PERIOD_CURRENT,MODE_LOW,countBars,startBar);
      if(val_index1 != -1 && val_index2 != -1)
      {
         double val1 = Low[val_index1];
         double val2 = High[val_index2];
         
         if (Ask<val2-10*getPointCoef() && GhostOrderStopLoss()>val2+5*getPointCoef())
         {
            if(GhostOrderStopLoss()!=val2+5*getPointCoef())
               GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), val2+5*getPointCoef(), GhostOrderTakeProfit(), 0, White );
         }
         
         if(Ask>val1+10*getPointCoef() && GhostOrderTakeProfit()<val1 && (GhostOrderProfit()+GhostOrderCommission()+GhostOrderSwap())<0)
         {
            if(GhostOrderTakeProfit()!=val1 && (GhostOrderProfit()+GhostOrderCommission()+GhostOrderSwap())<0)
               GhostOrderModify( GhostOrderTicket(), GhostOrderOpenPrice(), GhostOrderStopLoss(), val1, 0, White );
         }
      }
   }
}
//----------------------------------------------------------------------------
void ProgressiveStopLoss() {
   //double DDFromStart                = (AccountEquity()-StartingBalance)*100/StartingBalance;
   double MaxMarketPipDistance       = sqGetMaxMarketPipDistance(Symbol(),MagicNumber);
   
   if (ProgressiveStopLossPerc > 0 /*&& DDFromStart <= -ProgressiveStopLossPerc*/)
   {
      //int signal = signal(-1, 1);
      double actualProfit = 0;
   //--- Assert 2: Init OrderSelect #15
      int total = GhostOrdersTotal();
   
      GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
      for (int pos_32 = 0; pos_32 < total; pos_32++) {
         if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
            if (GhostOrderMagicNumber() == MagicNumber) {
               double profit = GhostOrderProfit()+GhostOrderSwap()+GhostOrderCommission();
               double threshold = StartingBalance * ProgressiveStopLossPerc / 100;
               if (profit <= -threshold && 
                   ( (GhostOrderType() == OP_BUY && signal(OP_BUY, 1, -1) == -1) || (GhostOrderType() == OP_SELL && signal(OP_SELL, 1, -1) == 1) ) 
                  )
               {
                  f0_16("close #" + GhostOrderTicket());
                  GhostOrderClose( GhostOrderTicket(), GhostOrderLots(), GhostOrderClosePrice(), MarketInfo(GhostOrderSymbol(), MODE_SPREAD), White );
                  /*
                     Alert("ProgressiveStopLossPerc on " + Symbol() + "!");
                     Log("[ProgressiveStopLossPerc ALERT] - (actualProfit = " + actualProfit + ") - Sleep for "+MinutesToSleep+" minutes ...");
                     spikeAlert = true;
                     lastSpikeAlertTime = TimeCurrent();
                     return;
                  */
               }
            }
         }
      }
   //--- Assert 1: Free OrderSelect #15
      GhostFreeSelect(false);
   }
}
//----------------------------------------------------------------------------
void EquityStopLoss() {
      
   //double DDFromStart = (AccountEquity()-StartingBalance)*100/StartingBalance;
   //double DDFromStart = (AccountEquity()-AccountBalance())*100/AccountBalance();

   if (EquityShield == TRUE && EquityDrawDownMoney > 0)
   {
      double actualProfit = 0;
   //--- Assert 2: Init OrderSelect #15
      int total = GhostOrdersTotal();
   
      GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
      for (int pos_32 = 0; pos_32 < total; pos_32++) {
         if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
            if (GhostOrderMagicNumber() == MagicNumber
             && GhostOrderSymbol() == Symbol()) {
               double profit = GhostOrderProfit()+GhostOrderSwap()+GhostOrderCommission();
               actualProfit += profit;
            }
         }
      }

      //double DDFromStart = (StartingBalance*EquityDrawDownPerc)/100.0;
      
      if (actualProfit <= -EquityDrawDownMoney)
      {
         CloseAllOrders(FALSE);
         Alert("EquityStopLoss on " + Symbol() + "!");
         Log("[EquityStopLoss ALERT] - (actualProfit = " + actualProfit + ") - Sleep for "+MinutesToSleep+" minutes ...");
      }
   }
}
//----------------------------------------------------------------------------
double GetOrdersProfit(int orderType) {
   double actualProfit = 0;
   //--- Assert 2: Init OrderSelect #15
      int total = GhostOrdersTotal();
   
      GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
      for (int pos_32 = 0; pos_32 < total; pos_32++) {
         if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
            if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == orderType) {
               double profit = GhostOrderProfit()+GhostOrderSwap()+GhostOrderCommission();
               actualProfit += profit;
               //if(profit>0) {
                  //actualProfit++;
               //}
            }
         }
      }
      
   return(actualProfit);
}
//----------------------------------------------------------------------------
int GetOrdersCount(int orderType) {
   double actualCount = 0;
   //--- Assert 2: Init OrderSelect #15
      int total = GhostOrdersTotal();
   
      GhostInitSelect(true,0,SELECT_BY_POS,MODE_TRADES);
      for (int pos_32 = 0; pos_32 < total; pos_32++) {
         if (GhostOrderSelect(pos_32,SELECT_BY_POS,MODE_TRADES)) {
            if (GhostOrderMagicNumber() == MagicNumber && GhostOrderType() == orderType) {
               actualCount++;
            }
         }
      }
      
   return(actualCount);
}
//----------------------------------------------------------------------------
double sqGetPointPow(string symbol) {
   double realDigits = MarketInfo(symbol,MODE_DIGITS);
   if(realDigits > 0 && realDigits != 2 && realDigits != 4) {
      realDigits -= 1;
   }

   double gPointPow = MathPow(10, realDigits);
   return(gPointPow);
}
double sqGetPointCoef(string symbol) {
   double gPointCoef = 1/sqGetPointPow(symbol);
   return(gPointCoef);
}
//----------------------------------------------------------------------------
double sqConvertToRealPips(string symbol, int value) {
   return(sqGetPointCoef(symbol) * value);
}

//----------------------------------------------------------------------------

double sqConvertToPips(string symbol, double value) {
   return(sqGetPointPow(symbol) * value);
}

//---------------------------------------------------------------------------
//+------------------------------------------------------------------+
//| H4 and Daily Support/Resistance and Pivot                        |
//+------------------------------------------------------------------+
void get_pivots(string symbol, int timeframe)
{
//----------------------------------------------------------------------------- Get new TimeFrame ---------------
   ArrayCopyRates(Fhr_rates_d1, symbol, timeframe);

   if(ArraySize(Fhr_rates_d1)<=0)
   {
      return;
   }

   Fhr_today_open = Fhr_rates_d1[0][1];
   Fhr_day_high = Fhr_rates_d1[0][3];
   Fhr_day_low = Fhr_rates_d1[0][2];

   if(ArrayRange(Fhr_rates_d1,0)>1)
   {
      Fhr_yesterday_close = Fhr_rates_d1[1][4];
      Fhr_yesterday_open = Fhr_rates_d1[1][1];
      Fhr_yesterday_high = Fhr_rates_d1[1][3];
      Fhr_yesterday_low = Fhr_rates_d1[1][2];
   }
   else
   {
      Fhr_yesterday_close = Fhr_rates_d1[0][4];
      Fhr_yesterday_open = Fhr_rates_d1[0][1];
      Fhr_yesterday_high = Fhr_rates_d1[0][3];
      Fhr_yesterday_low = Fhr_rates_d1[0][2];
   }

//---- Calculate Pivots

   Fhr_D = (Fhr_day_high - Fhr_day_low);
   Fhr_Q = (Fhr_yesterday_high - Fhr_yesterday_low);
   Fhr_P = (Fhr_yesterday_high + Fhr_yesterday_low + Fhr_yesterday_close) / 3;
   Fhr_R1 = (2*Fhr_P)-Fhr_yesterday_low;
   Fhr_S1 = (2*Fhr_P)-Fhr_yesterday_high;
   Fhr_R2 = Fhr_P+(Fhr_yesterday_high - Fhr_yesterday_low);
   Fhr_S2 = Fhr_P-(Fhr_yesterday_high - Fhr_yesterday_low);


   Fhr_R3 = (2*Fhr_P)+(Fhr_yesterday_high-(2*Fhr_yesterday_low));
   Fhr_M5 = (Fhr_R2+Fhr_R3)/2;
   // Fhr_R2 = Fhr_P-Fhr_S1+Fhr_R1;
   Fhr_M4 = (Fhr_R1+Fhr_R2)/2;
   // Fhr_R1 = (2*Fhr_P)-Fhr_yesterday_low;
   Fhr_M3 = (Fhr_P+Fhr_R1)/2;
   // Fhr_P = (Fhr_yesterday_high + Fhr_yesterday_low + Fhr_yesterday_close)/3;
   Fhr_M2 = (Fhr_P+Fhr_S1)/2;
   // Fhr_S1 = (2*Fhr_P)-Fhr_yesterday_high;
   Fhr_M1 = (Fhr_S1+Fhr_S2)/2;
   // Fhr_S2 = Fhr_P-Fhr_R1+Fhr_S1;
   Fhr_S3 = (2*Fhr_P)-((2* Fhr_yesterday_high)-Fhr_yesterday_low);
   Fhr_M0 = (Fhr_S2+Fhr_S3)/2;

   if (Fhr_Q > 5)
   {
      Fhr_nQ = Fhr_Q;
   }
   else
   {
     Fhr_nQ = Fhr_Q*10000;
   }

   if (Fhr_D > 5)
   {
       Fhr_nD = Fhr_D;
   }
   else
   {
      Fhr_nD = Fhr_D*10000;
   }
//----------------------------------------------------------------------------- Get DAY ---------------
   ArrayCopyRates(D_rates_d1, symbol, 1440);

   if(ArraySize(D_rates_d1)<=0)
   {
      return;
   }

   D_today_open = D_rates_d1[0][1];
   D_day_high = D_rates_d1[0][3];
   D_day_low = D_rates_d1[0][2];

   if(ArrayRange(D_rates_d1,0)>1)
   {
      D_yesterday_close = D_rates_d1[1][4];
      D_yesterday_open = D_rates_d1[1][1];
      D_yesterday_high = D_rates_d1[1][3];
      D_yesterday_low = D_rates_d1[1][2];
   }
   else
   {
      D_yesterday_close = D_rates_d1[0][4];
      D_yesterday_open = D_rates_d1[0][1];
      D_yesterday_high = D_rates_d1[0][3];
      D_yesterday_low = D_rates_d1[0][2];
   }

//---- Calculate Pivots

   D_D = (D_day_high - D_day_low);
   D_Q = (D_yesterday_high - D_yesterday_low);
   D_P = (D_yesterday_high + D_yesterday_low + D_yesterday_close) / 3;
   D_R1 = (2*D_P)-D_yesterday_low;
   D_S1 = (2*D_P)-D_yesterday_high;
   D_R2 = D_P+(D_yesterday_high - D_yesterday_low);
   D_S2 = D_P-(D_yesterday_high - D_yesterday_low);


   D_R3 = (2*D_P)+(D_yesterday_high-(2*D_yesterday_low));
   D_M5 = (D_R2+D_R3)/2;
   // D_R2 = D_P-D_S1+D_R1;
   D_M4 = (D_R1+D_R2)/2;
   // D_R1 = (2*D_P)-D_yesterday_low;
   D_M3 = (D_P+D_R1)/2;
   // D_P = (D_yesterday_high + D_yesterday_low + D_yesterday_close)/3;
   D_M2 = (D_P+D_S1)/2;
   // D_S1 = (2*D_P)-D_yesterday_high;
   D_M1 = (D_S1+D_S2)/2;
   // D_S2 = D_P-D_R1+D_S1;
   D_S3 = (2*D_P)-((2* D_yesterday_high)-D_yesterday_low);

   D_M0 = (D_S2+D_S3)/2;

   if (D_Q > 5)
   {
      D_nQ = D_Q;
   }
   else
   {
     D_nQ = D_Q*10000;
   }

   if (D_D > 5)
   {
       D_nD = D_D;
   }
   else
   {
      D_nD = D_D*10000;
   }

   /*Print("Fhr_R1:",Fhr_R1," Fhr_R2:",Fhr_R2," Fhr_R3:",Fhr_R3);
   Print("Fhr_S1:",Fhr_S1," Fhr_S2:",Fhr_S2," Fhr_S3:",Fhr_S3);
   Print("D_R1:",D_R1," D_R2:",D_R2," D_R3:",D_R3);
   Print("D_S1:",D_S1," D_S2:",D_S2," D_S3:",D_S3);*/
}

//--------------------------------------------------------------------- +
void get_NearestAndFarestSR(string symbol, int timeframe, double price)
{
   //-- Pivots, Support/Resistance and Price Alerts
   get_pivots(symbol, timeframe);
   //---

   MqlRates RatesBar[];
   ArraySetAsSeries(RatesBar,true);
   if(CopyRates(symbol,timeframe,0,20,RatesBar)==20)
   {
      double high     = RatesBar[0].high;
      double point    = MarketInfo(symbol,MODE_POINT);
      int    digits   = MarketInfo(symbol,MODE_DIGITS);
      double ask      = MarketInfo(symbol,MODE_ASK);
      double bid      = MarketInfo(symbol,MODE_BID);
      double low      = RatesBar[0].low;
      int    power    = MathPow(10,digits-1);
      double pipRange = (high-low)*power;
      double bidRatio = (pipRange > 0 ? ((bid-low)/pipRange*power)*100 : 0);
             pipRange = (pipRange != 0 ? pipRange : 0.001);
      //-Fhr
      if( Fhr_R1 > 0 && Fhr_R2 > 0 && Fhr_R3 > 0 && Fhr_S1 > 0 && Fhr_S2 > 0 && Fhr_S3 > 0 ) {
         if( price >= Fhr_R3 )
         {
            nearest_resistance = D_R3;
            nearest_support = Fhr_R3;
   
            farest_resistance = D_R3 + sqConvertToRealPips(symbol, pipRange);
            farest_support = Fhr_R1;
         }
         else if( price < Fhr_R3 && price >= Fhr_R2 )
         {
            nearest_resistance = Fhr_R3;
            nearest_support = Fhr_R2;
   
            farest_resistance = D_R3;
            farest_support = Fhr_S1;
         }
         else if( price < Fhr_R2 && price >= Fhr_R1 )
         {
            nearest_resistance = Fhr_R2;
            nearest_support = Fhr_R1;
   
            farest_resistance = Fhr_R3;
            farest_support = Fhr_S1;
         }
         else if( price < Fhr_R1 && price >= Fhr_S1 )
         {
            nearest_resistance = Fhr_R1;
            nearest_support = Fhr_S1;
   
            farest_resistance = Fhr_R3;
            farest_support = Fhr_S3;
         }
         else if( price < Fhr_S1 && price >= Fhr_S2 )
         {
            nearest_resistance = Fhr_S1;
            nearest_support = Fhr_S2;
   
            farest_resistance = Fhr_R3;
            farest_support = Fhr_S3;
         }
         else if( price < Fhr_S2 && price >= Fhr_S3 )
         {
            nearest_resistance = Fhr_S2;
            nearest_support = Fhr_S3;
   
            farest_resistance = Fhr_S1;
            farest_support = D_S3;
         }
         else
         {
            nearest_resistance = Fhr_S3;
            nearest_support = D_S3;
   
            farest_resistance = Fhr_S1;
            farest_support = D_S3 - sqConvertToRealPips(symbol, pipRange);
         }
      }

      //-D
      if( D_R1 > 0 && D_R2 > 0 && D_R3 > 0 && D_S1 > 0 && D_S2 > 0 && D_S3 > 0 ) {
         if( price >= D_R3 )
         {
            nearest_daily_resistance = D_R3 + sqConvertToRealPips(symbol, pipRange);
            nearest_daily_support = D_R3;
   
            farest_daily_resistance = D_R3 + sqConvertToRealPips(symbol, pipRange);
            farest_daily_support = D_R1;
         }
         else if( price < D_R3 && price >= D_R2 )
         {
            nearest_daily_resistance = D_R3;
            nearest_daily_support = D_R2;
   
            farest_daily_resistance = D_R3 + sqConvertToRealPips(symbol, pipRange);
            farest_daily_support = D_S1;
         }
         else if( price < D_R2 && price >= D_R1 )
         {
            nearest_daily_resistance = D_R2;
            nearest_daily_support = D_R1;
   
            farest_daily_resistance = D_R3;
            farest_daily_support = D_S1;
         }
         else if( price < D_R1 && price >= D_S1 )
         {
            nearest_daily_resistance = D_R1;
            nearest_daily_support = D_S1;
   
            farest_daily_resistance = D_R3;
            farest_daily_support = D_S3;
         }
         else if( price < D_S1 && price >= D_S2 )
         {
            nearest_daily_resistance = D_S1;
            nearest_daily_support = D_S2;
   
            farest_daily_resistance = D_R1;
            farest_daily_support = D_S3;
         }
         else if( price < D_S2 && price >= D_S3 )
         {
            nearest_daily_resistance = D_S2;
            nearest_daily_support = D_S3;
   
            farest_daily_resistance = D_R1;
            farest_daily_support = D_S3 - sqConvertToRealPips(symbol, pipRange);
         }
         else
         {
            nearest_daily_resistance = D_S3;
            nearest_daily_support = D_S3 - sqConvertToRealPips(symbol, pipRange);
   
            farest_daily_resistance = D_R1;
            farest_daily_support = D_S3 - sqConvertToRealPips(symbol, 2*pipRange);
         }
      }
   }
}
//+------------------------------------------------------------------+
//+-----  INDICATORS                                           ------+
//+------------------------------------------------------------------+

double i_TSRLine(string sig_currency, int sig_timeFrame, string indexLabel, int period, int method, int price, int indexBuffer, int shiftBuffer) {

   MqlRates RatesBarTSR[];
   ArraySetAsSeries(RatesBarTSR,true);

   //---- buffers
   double Uptrend[];
   double Dntrend[];
   double ExtMapBuffer[];

   ArrayResize(Uptrend, Nbars);
   ArraySetAsSeries(Uptrend, true);
   ArrayResize(Dntrend, Nbars);
   ArraySetAsSeries(Dntrend, true);
   ArrayResize(ExtMapBuffer, Nbars);
   ArraySetAsSeries(ExtMapBuffer, true);

   if( CopyRates(sig_currency,sig_timeFrame,0,Nbars+period,RatesBarTSR)==Nbars+period )
   {
      int x = 0;
      int p = MathSqrt(2*period);
      int e = Nbars;

      double vect[], trend[];

      ArrayResize(vect, e);
      ArraySetAsSeries(vect, true);
      ArrayResize(trend, e);
      ArraySetAsSeries(trend, true);

      for(x = 0; x < e; x++)
      {
         //vect[x] = 2*WMA(Pair, TimeFrame, x, period/2, method, price) - WMA(Pair, TimeFrame, x, period, method, price);
         vect[x] = 2*iMA(sig_currency,sig_timeFrame, period, 0, method, price, x) - iMA(sig_currency,sig_timeFrame, 2*period, 0, method, price, x);
      }

      for(x = 0; x < e; x++) ExtMapBuffer[x] = iMAOnArray(vect, 0, p, 0, method, x);

      for(x = e-2; x >= 0; x--)
      {
         trend[x] = trend[x+1];
         if (ExtMapBuffer[x]> ExtMapBuffer[x+1]) trend[x] =1;
         if (ExtMapBuffer[x]< ExtMapBuffer[x+1]) trend[x] =-1;

         if (trend[x]>0)
         {
            Uptrend[x] = ExtMapBuffer[x];
            if (trend[x+1]<0) Uptrend[x+1]=ExtMapBuffer[x+1];
            Dntrend[x] = EMPTY_VALUE;
         }
         else if (trend[x]<0)
         {
            Dntrend[x] = ExtMapBuffer[x];
            if (trend[x+1]>0) Dntrend[x+1]=ExtMapBuffer[x+1];
            Uptrend[x] = EMPTY_VALUE;
         }

      }
   }

   switch(indexBuffer) {
   case 0:
      return Uptrend[shiftBuffer];
   case 1:
      return Dntrend[shiftBuffer];
   default:
      return EMPTY_VALUE;
   }

}

//+------------------------------------------------------------------+

double i_hama(string sig_currency, int sig_timeFrame, string indexLabel, int indexBuffer, int shiftBuffer) {

   //---- buffers
   int MaMetod  = 1;
   int MaPeriod = 20;
   //---- buffers
   double ExtMapBuffer1[];
   double ExtMapBuffer2[];
   double ExtMapBuffer3[];
   double ExtMapBuffer4[];

   ArrayResize(ExtMapBuffer1, Nbars);
   ArrayResize(ExtMapBuffer2, Nbars);
   ArrayResize(ExtMapBuffer3, Nbars);
   ArrayResize(ExtMapBuffer4, Nbars);

   ArrayInitialize(ExtMapBuffer1, EMPTY_VALUE);
   ArrayInitialize(ExtMapBuffer2, EMPTY_VALUE);
   ArrayInitialize(ExtMapBuffer3, EMPTY_VALUE);
   ArrayInitialize(ExtMapBuffer4, EMPTY_VALUE);
   //----
   double maOpen, maClose, maLow, maHigh;
   double haOpen, haHigh, haLow, haClose;

   int pos=Nbars - Length - 1;
   while(pos>=0)
     {
      maOpen=iMA(sig_currency, sig_timeFrame,MaPeriod,0,MaMetod,0,pos);
      maClose=iMA(sig_currency, sig_timeFrame,MaPeriod,0,MaMetod,3,pos);
      maLow=iMA(sig_currency, sig_timeFrame,MaPeriod,0,MaMetod,1,pos);
      maHigh=iMA(sig_currency, sig_timeFrame,MaPeriod,0,MaMetod,2,pos);

      haOpen=(ExtMapBuffer3[pos+1]+ExtMapBuffer4[pos+1])/2;
      haClose=(maOpen+maHigh+maLow+maClose)/4;
      haHigh=MathMax(maHigh, MathMax(haOpen, haClose));
      haLow=MathMin(maLow, MathMin(haOpen, haClose));
      if (haOpen<haClose)
        {
         ExtMapBuffer1[pos]=haLow;
         ExtMapBuffer2[pos]=haHigh;
        }
      else
        {
         ExtMapBuffer1[pos]=haHigh;
         ExtMapBuffer2[pos]=haLow;
        }
      ExtMapBuffer3[pos]=haOpen;
      ExtMapBuffer4[pos]=haClose;
 	   pos--;
     }

   switch(indexBuffer) {
   case 0:
      return ExtMapBuffer1[shiftBuffer];
   case 1:
      return ExtMapBuffer2[shiftBuffer];
   case 2:
      return ExtMapBuffer3[shiftBuffer];
   case 3:
      return ExtMapBuffer4[shiftBuffer];
   default:
      return EMPTY_VALUE;
   }
}

//+------------------------------------------------------------------+

double doda_bands2(string sig_currency, int sig_timeFrame, string indexLabel, int Length, int Deviation, double MoneyRisk, int Signal, int Line, int Nbars, bool SoundON, int indexBuffer, int shiftBuffer) {

   //---- buffers
   double a_ibuf_124[];
   double a_ibuf_128[];
   double a_ibuf_132[];
   double a_ibuf_136[];
   double a_ibuf_140[];
   double a_ibuf_144[];

   ArrayResize(a_ibuf_124, Nbars);
   ArrayResize(a_ibuf_128, Nbars);
   ArrayResize(a_ibuf_132, Nbars);
   ArrayResize(a_ibuf_136, Nbars);
   ArrayResize(a_ibuf_140, Nbars);
   ArrayResize(a_ibuf_144, Nbars);

   ArrayInitialize(a_ibuf_124, EMPTY_VALUE);
   ArrayInitialize(a_ibuf_128, EMPTY_VALUE);
   ArrayInitialize(a_ibuf_132, EMPTY_VALUE);
   ArrayInitialize(a_ibuf_136, EMPTY_VALUE);
   ArrayInitialize(a_ibuf_140, EMPTY_VALUE);
   ArrayInitialize(a_ibuf_144, EMPTY_VALUE);

   bool ai_152 = FALSE;
   bool ai_156 = FALSE;

   int ali_8;
   double lda_12[25000];
   double lda_16[25000];
   double lda_20[25000];
   double lda_24[25000];
   for (int al_shift_4 = Nbars - 1; al_shift_4 >= 0; al_shift_4--) {
      a_ibuf_124[al_shift_4] = 0;
      a_ibuf_128[al_shift_4] = 0;
      a_ibuf_132[al_shift_4] = 0;
      a_ibuf_136[al_shift_4] = 0;
      a_ibuf_140[al_shift_4] = EMPTY_VALUE;
      a_ibuf_144[al_shift_4] = EMPTY_VALUE;
   }
   for (int al_shift_4 = Nbars - Length - 1; al_shift_4 >= 0; al_shift_4--) {
      lda_12[al_shift_4] = iBands(sig_currency, sig_timeFrame, Length, Deviation, 0, PRICE_CLOSE, MODE_UPPER, al_shift_4);
      lda_16[al_shift_4] = iBands(sig_currency, sig_timeFrame, Length, Deviation, 0, PRICE_CLOSE, MODE_LOWER, al_shift_4);
      if (iClose(sig_currency, sig_timeFrame, al_shift_4) > lda_12[al_shift_4 + 1]) ali_8 = 1;
      if (iClose(sig_currency, sig_timeFrame, al_shift_4) < lda_16[al_shift_4 + 1]) ali_8 = -1;
      if (ali_8 > 0 && lda_16[al_shift_4] < lda_16[al_shift_4 + 1]) lda_16[al_shift_4] = lda_16[al_shift_4 + 1];
      if (ali_8 < 0 && lda_12[al_shift_4] > lda_12[al_shift_4 + 1]) lda_12[al_shift_4] = lda_12[al_shift_4 + 1];
      lda_20[al_shift_4] = lda_12[al_shift_4] + (MoneyRisk - 1.0) / 2.0 * (lda_12[al_shift_4] - lda_16[al_shift_4]);
      lda_24[al_shift_4] = lda_16[al_shift_4] - (MoneyRisk - 1.0) / 2.0 * (lda_12[al_shift_4] - lda_16[al_shift_4]);
      if (ali_8 > 0 && lda_24[al_shift_4] < lda_24[al_shift_4 + 1]) lda_24[al_shift_4] = lda_24[al_shift_4 + 1];
      if (ali_8 < 0 && lda_20[al_shift_4] > lda_20[al_shift_4 + 1]) lda_20[al_shift_4] = lda_20[al_shift_4 + 1];
      if (ali_8 > 0) {
         if (Signal > 0 && a_ibuf_124[al_shift_4 + 1] == -1.0) {
            a_ibuf_132[al_shift_4] = lda_24[al_shift_4];
            a_ibuf_124[al_shift_4] = lda_24[al_shift_4];
            if (Line > 0) a_ibuf_140[al_shift_4] = lda_24[al_shift_4];
            if (SoundON == TRUE && al_shift_4 == 0 && (!ai_152)) {
               Alert("DodaCharts-BBands going Up on ", sig_currency, "-", sig_timeFrame);
               ai_152 = TRUE;
               ai_156 = FALSE;
            }
         } else {
            a_ibuf_124[al_shift_4] = lda_24[al_shift_4];
            if (Line > 0) a_ibuf_140[al_shift_4] = lda_24[al_shift_4];
            a_ibuf_132[al_shift_4] = -1;
         }
         if (Signal == 2) a_ibuf_124[al_shift_4] = 0;
         a_ibuf_136[al_shift_4] = -1;
         a_ibuf_128[al_shift_4] = -1.0;
         a_ibuf_144[al_shift_4] = EMPTY_VALUE;
      }
      if (ali_8 < 0) {
         if (Signal > 0 && a_ibuf_128[al_shift_4 + 1] == -1.0) {
            a_ibuf_136[al_shift_4] = lda_20[al_shift_4];
            a_ibuf_128[al_shift_4] = lda_20[al_shift_4];
            if (Line > 0) a_ibuf_144[al_shift_4] = lda_20[al_shift_4];
            if (SoundON == TRUE && al_shift_4 == 0 && (!ai_156)) {
               Alert("DodaCharts-BBands going Down on ", sig_currency, "-", sig_timeFrame);
               ai_156 = TRUE;
               ai_152 = FALSE;
            }
         } else {
            a_ibuf_128[al_shift_4] = lda_20[al_shift_4];
            if (Line > 0) a_ibuf_144[al_shift_4] = lda_20[al_shift_4];
            a_ibuf_136[al_shift_4] = -1;
         }
         if (Signal == 2) a_ibuf_128[al_shift_4] = 0;
         a_ibuf_132[al_shift_4] = -1;
         a_ibuf_124[al_shift_4] = -1.0;
         a_ibuf_140[al_shift_4] = EMPTY_VALUE;
      }
   }

   switch(indexBuffer) {
   case 0:
      return a_ibuf_124[shiftBuffer];
   case 1:
      return a_ibuf_128[shiftBuffer];
   case 2:
      return a_ibuf_132[shiftBuffer];
   case 3:
      return a_ibuf_136[shiftBuffer];
   case 4:
      return a_ibuf_140[shiftBuffer];
   case 5:
      return a_ibuf_144[shiftBuffer];
   default:
      return EMPTY_VALUE;
   }

}

//+------------------------------------------------------------------+

double bb_squeeze_dark(string sig_currency, int sig_timeFrame, int bolPrd, double bolDev, int keltPrd, double keltFactor, int momPrd, long Length, long Nbars, int indexBuffer, int shiftBuffer) {

   //---- buffers
   double upB[];
   double upB2[];
   double loB[];
   double loB2[];
   double upK[];
   double loK[];

   ArrayResize(upB,  Nbars);
   ArrayResize(upB2, Nbars);
   ArrayResize(loB,  Nbars);
   ArrayResize(loB2, Nbars);
   ArrayResize(upK,  Nbars);
   ArrayResize(loK,  Nbars);

   ArrayInitialize(upB,  EMPTY_VALUE);
   ArrayInitialize(upB2, EMPTY_VALUE);
   ArrayInitialize(loB,  EMPTY_VALUE);
   ArrayInitialize(loB2, EMPTY_VALUE);
   ArrayInitialize(upK,  EMPTY_VALUE);
   ArrayInitialize(loK,  EMPTY_VALUE);

   int i,j,slippage=3;
   double breakpoint=0.0;
   double ema=0.0;
   int peakf=0;
   int peaks=0;
   int valleyf=0;
   int valleys=0;
   double ccis[61],ccif[61];
   double delta=0;
   double ugol=0;

   int shift;
   double diff,d,dPrev, std,bbs;

   for (shift=Nbars - Length - 1;shift>=0;shift--) {
      //d=iMomentum(NULL,0,momPrd,PRICE_CLOSE,shift);
      d=LinearRegressionValue(sig_currency, sig_timeFrame, bolPrd,shift);
      dPrev=LinearRegressionValue(sig_currency, sig_timeFrame, bolPrd,shift+1);
      if(d>0) {
         if ((dPrev>0) && (dPrev > d)){ upB2[shift]=d; upB[shift] = 0; } else { upB[shift]= d; upB2[shift] = 0; }
         //upB[shift]=0;
         loB[shift]=0;
         loB2[shift]=0;
      } else {
         if ((dPrev<0) && (dPrev < d)){ loB2[shift]=d; loB[shift] = 0; } else { loB[shift]= d; loB2[shift] = 0; }
         upB[shift]=0;
         upB2[shift]=0;
         //loB[shift]=d;
      }
		diff = iATR(sig_currency,sig_timeFrame,keltPrd,shift)*keltFactor;
		std = iStdDev(sig_currency,sig_timeFrame,bolPrd,MODE_SMA,0,PRICE_CLOSE,shift);
		bbs = (diff != 0 ? bolDev * std / diff : 1);
      if(bbs<1) {
         upK[shift]=0;
         loK[shift]=EMPTY_VALUE;
      } else {
         loK[shift]=0;
         upK[shift]=EMPTY_VALUE;
      }
   }

   switch(indexBuffer) {
   case 0:
      return upB[shiftBuffer];
   case 1:
      return loB[shiftBuffer];
   case 2:
      return upB2[shiftBuffer];
   case 3:
      return loB2[shiftBuffer];
   case 4:
      return upK[shiftBuffer];
   case 5:
      return loK[shiftBuffer];
   default:
      return EMPTY_VALUE;
   }
}

double LinearRegressionValue(string sig_currency, int sig_timeFrame, int Len,int shift) {
   double SumBars = 0;
   double SumSqrBars = 0;
   double SumY = 0;
   double Sum1 = 0;
   double Sum2 = 0;
   double Slope = 0;

   SumBars = Len * (Len-1) * 0.5;
   SumSqrBars = (Len - 1) * Len * (2 * Len - 1)/6;

  for (int x=0; x<=Len-1;x++) {
   double HH = iLow(sig_currency,sig_timeFrame,x+shift);
   double LL = iHigh(sig_currency,sig_timeFrame,x+shift);
   for (int y=x; y<=(x+Len)-1; y++) {
     HH = MathMax(HH, iHigh(sig_currency,sig_timeFrame,y+shift));
     LL = MathMin(LL, iLow(sig_currency,sig_timeFrame,y+shift));
   }
    Sum1 += x* (iClose(sig_currency,sig_timeFrame,x+shift)-((HH+LL)/2 + iMA(sig_currency,sig_timeFrame,Len,0,MODE_EMA,PRICE_CLOSE,x+shift))/2);
    SumY += (iClose(sig_currency,sig_timeFrame,x+shift)-((HH+LL)/2 + iMA(sig_currency,sig_timeFrame,Len,0,MODE_EMA,PRICE_CLOSE,x+shift))/2);
  }
  Sum2 = SumBars * SumY;
  double Num1 = Len * Sum1 - Sum2;
  double Num2 = SumBars * SumBars-Len * SumSqrBars;

  if (Num2 != 0.0)  {
    Slope = Num1/Num2;
  } else {
    Slope = 0;
  }

  double Intercept = (SumY - Slope*SumBars) /Len;
  double LinearRegValue = Intercept+Slope * (Len - 1);

  return (LinearRegValue);
}

//---------------------------------------------------------------------------
bool sqVolatility(string symbol, int period)
{
   double vol=0;

   int limit=(Sedimentation+5);

   ArrayResize(ind_c,limit*2);
   ArrayResize(vol_m,limit*2);
   ArrayResize(vol_t,limit*2);
   ArrayResize(thresholdBuffer,limit*2);

   ArrayInitialize(ind_c,0);
   ArrayInitialize(vol_m,0);
   ArrayInitialize(vol_t,0);
   ArrayInitialize(thresholdBuffer,0);

   for(int i=limit;i>=0;i--)
   {
      double sa=iATR(symbol,period,Viscosity,i);
      double s1=ind_c[i+1];
      double s3=ind_c[i+3];
      double atr=NormalizeDouble(sa, MarketInfo(symbol, MODE_DIGITS) );
      double atr_s = iATR(symbol,period,Sedimentation,i);

      if(atr_s != 0)
      {
         if(lag_supressor)
            vol= sa/atr_s+lag_s_K*(s1-s3);
         else
            vol= sa/atr_s;
         //vol_m[i]=vol;
      }
      else
      {
         return(false);
      }

      double anti_thres = iStdDev(symbol,period,Viscosity,0,MODE_LWMA,PRICE_TYPICAL,i);

      double std_dev_s = iStdDev(symbol,period,Sedimentation,0,MODE_LWMA,PRICE_TYPICAL,i);
      if(std_dev_s != 0)
      {
         anti_thres= (anti_thres == 0 ? 0 : anti_thres/std_dev_s);
      } else {
         return(false);
      }

      double t=Threshold_level;
      t=t-anti_thres;

      if (vol>t) {
         vol_t[i]=vol;vol_m[i]=vol;

         if(i==0) return(true);
      }
      else {
         vol_t[i]=vol;vol_m[i]=EMPTY_VALUE;

         if(i==0) return(false);
      }

      ind_c[i]=vol;
      thresholdBuffer[i]=t;
   }

   return(false);
}
//----------------------------------------------------------------------------

double getPointCoef() {
   /*
   double coef = 0;
   double rDigits, pointPow;

   rDigits = MarketInfo(Symbol(), MODE_DIGITS);
   if(rDigits > 0 && rDigits != 2 && rDigits != 4) {
      rDigits -= 1;
   }

   pointPow = MathPow(10, rDigits);
   coef = 1/pointPow;

   return(coef);
   */
   //---
   double pp,pd,cf;
   if (Digits < 4) {
      pp = 0.01;
      pd = 2;
      cf = 0.009;
   } else {
      pp = 0.0001;
      pd = 4;
      cf = 0.00009;
   }
   //----
   return(pp);
}


//+-------------------------------------------------------------------------------------------------------------------------------------+

//=================================================================================================
//=================================================================================================
//===================================   Timezone Functions   ======================================
//=================================================================================================
//=================================================================================================

int TZInfoArray[43];	

datetime myTimeGMT() 
{
	int DST = GetTimeZoneInformation(TZInfoArray);
	if (DST == 1)
		DST = 3600;
	else 
		DST = 2;

   datetime pc_time = TimeLocal();
	datetime my_time_GMT = ( pc_time + DST /*+ (OffsetHours * 3600)*/ + (TZInfoArray[0] + TZInfoArray[42]) * 60 );
	
	return(my_time_GMT);
}

//=================================================================================================================================================//
/*
  int GMTOffset()
  {
      int TimeArray[4];
      int TZInfoArray[43];
      int nYear,nMonth,nDay,nHour,nMin,nSec,nMilliSec;
      string sMilliSec;
  
      GetSystemTime(TimeArray);
      nYear=TimeArray[0]&0x0000FFFF;
      nMonth=TimeArray[0]>>16;
      nDay=TimeArray[1]>>16;
      nHour=TimeArray[2]&0x0000FFFF;
      nMin=TimeArray[2]>>16;
      nSec=TimeArray[3]&0x0000FFFF;
      nMilliSec=TimeArray[3]>>16;
  
      string LocalTimeS=FormatDateTime(nYear,nMonth,nDay,nHour,nMin,nSec);
      double GMTdiff=TimeLocal()-StrToTime(LocalTimeS);
      
      return(MathRound(GMTdiff/3600.0));
  }
*/
//=================================================================================================================================================//
  string FormatDateTime(int nYear,int nMonth,int nDay,int nHour,int nMin,int nSec)
  {
      string sMonth,sDay,sHour,sMin,sSec;
  
      sMonth=100+nMonth;
      sMonth=StringSubstr(sMonth,1);
      sDay=100+nDay;
      sDay=StringSubstr(sDay,1);
      sHour=100+nHour;
      sHour=StringSubstr(sHour,1);
      sMin=100+nMin;
      sMin=StringSubstr(sMin,1);
      sSec=100+nSec;
      sSec=StringSubstr(sSec,1);
      
      return(StringConcatenate(nYear,".",sMonth,".",sDay," ",sHour,":",sMin,":",sSec));
  }
//=================================================================================================================================================//

//=================================================================================================================================================//
/**  FFCal **
      extern bool 	IncludeHigh 		= true;
      extern bool 	IncludeMedium 		= true;
      extern bool 	IncludeLow 			= false;   //true;
      extern bool 	IncludeSpeaks 		= true; 		// news items with "Speaks" in them have different characteristics
      extern bool		IsEA_Call			= false;
      extern int		OffsetHours			= 0;      //-1;
      extern bool		AllowWebUpdates	= true;			// Set this to false when using in another EA or Chart, so that the multiple instances of the indicator dont fight with each other
      extern int		Alert1MinsBefore	= 0;			// Set to -1 for no Alert
      extern int		Alert2MinsBefore	= -1;			// Set to -1 for no Alert
      extern bool		ReportAllForUSD	= true;
      extern bool    ReportAllForEUR   = true;
      extern bool    ReportAllForGBP   = true;
                                                   // added and tested by a1ra, seems working OK.
      extern bool    ReportAllForNZD   = true;
      extern bool    ReportAllForJPY   = true;
      extern bool    ReportAllForAUD   = true;
      extern bool    ReportAllForCHF   = true;
      extern bool    ReportAllForCAD   = true;
      extern bool    ReportAllForCNY   = false;
      
      extern bool 	EnableLogging 		= false; 		// Perhaps remove this from externs once its working well
      extern bool		ShowNextTwoEvents	= true;
      extern bool		ShowVertNews		= false;
      extern int 		TxtSize 			   = 10;
      extern color 	TxtColorTitle 		= Gold;       //LightGray;
      extern color 	TxtColorNews 		= DeepSkyBlue;
      extern color 	TxtColorImpact 	= Red;
      extern color 	TxtColorPrevious 	= Peru;
      extern color 	TxtColorForecast 	= Lime;
      extern int		VertTxtShift 		= 21;			// How far away below the ask line we want to place our vertical news text
      extern int		VertLeftLineShift 	= 900;			// How far away to the left of the line we want to place our vertical news text
      extern int		VertRightLineShift 	= 200;			// How far away to the left of the line we want to place our vertical news text
      extern color	VertLineColor 		= SlateBlue;	// Color of our vertical news line
      extern color	VertTxtColor 		= Black;		// Color of our vertical text color 
      extern int		VertTxtSize 		= 8;			// Color of our vertical text
      extern int		NewsCorner 			= 1;			// Choose which corner to place headlines 0=Upper Left, 1=Upper Right, 2=lower left , 3=lower right
      extern bool		SaveXmlFiles		= false;		// If true, this will keep the daily XML files
**/

bool IsNewsTime()
{
  if(Use_NewsFilter==FALSE) return(FALSE);
  
  static bool rval = false;
  static int lm = -1;
  static bool is_news = false;
  
  // uncomment next line if not global variable
  int minutesSincePrevEvent = 10080, minutesUntilNextEvent = 10080; // 1 week
  
  if (lm != Minute()) { // update news status, run every minute
      is_news = false;
      lm = Minute();

     // check high impact
     if(IncludeHigh) {
         minutesSincePrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, false, false, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, true, false, 1, 0);
         minutesUntilNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, false, false, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, true, false, 1, 1);
         //int impactOfPrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, true, false, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, true, false, 2, 0);
         //int impactOfNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, true, false, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, true, false, 2, 1);
         
         if( (minutesUntilNextEvent<=MinsBeforeHigh /*&& impactOfNextEvent==3*/) || (minutesSincePrevEvent<=MinsAfterHigh /*&& impactOfPrevEvent==3*/) )
            is_news = true;
         else
            is_news = false;
     }

     // check medium impact
     if(IncludeMedium && !is_news) {
         minutesSincePrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, false, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 1, 0);
         minutesUntilNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, false, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 1, 1);
         //int impactOfPrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, true, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 2, 0);
         //int impactOfNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, true, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 2, 1);
         
         if( (minutesUntilNextEvent<=MinsBeforeMedium /*&& impactOfNextEvent==2*/) || (minutesSincePrevEvent<=MinsAfterMedium /*&& impactOfPrevEvent==2*/) )
            is_news = true;
         else
            is_news = false;
     }

     // check low impact
     if(IncludeLow && !is_news) {
         minutesSincePrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 1, 0);
         minutesUntilNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, false, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 1, 1);
         //int impactOfPrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, true, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 2, 0);
         //int impactOfNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, true, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 2, 1);
  
         if( (minutesUntilNextEvent<=MinsBeforeLow /*&& impactOfNextEvent==1*/) || (minutesSincePrevEvent<=MinsAfterLow /*&& impactOfPrevEvent==1*/) )
            is_news = true;
         else
            is_news = false;
     }
   
     // check speaks
     if(IncludeSpeaks && !is_news) {
         minutesSincePrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, IncludeSpeaks, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 1, 0);
         minutesUntilNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, IncludeSpeaks, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 1, 1);
         //int impactOfPrevEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, IncludeSpeaks, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 2, 0);
         //int impactOfNextEvent = iCustom(NULL, PERIOD_H1, "FFCal", IncludeHigh, IncludeMedium, IncludeLow, IncludeSpeaks, true, 0, true, -1, -1, ReportAllForUSD, ReportAllForEUR, ReportAllForGBP, ReportAllForNZD, ReportAllForJPY, ReportAllForAUD, ReportAllForCHF, ReportAllForCAD, ReportAllForCNY, false, false, false, 2, 1);
  
         if( (minutesUntilNextEvent<=MinsBeforeSpeaks /*&& impactOfNextEvent==3*/) || (minutesSincePrevEvent<=MinsAfterSpeaks /*&& impactOfPrevEvent==3*/) )
            is_news = true;
         else
            is_news = false;
     }

     if(is_news)
         rval = true;
     else
         rval = false;
  }
  
  return(rval);
}
//=================================================================================================================================================//

