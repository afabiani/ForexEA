//+------------------------------------------------------------------+
//|                                             OrdersManagement.mq4 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property library

#include <stderror.mqh>
#include <stdlib.mqh>
#include <hash.mqh>

#define CLOSE_MODE 0
#define OPENCLOSE_MODE 1
#define CLOSE_RELATIVE_MODE 2

#define DIR_LONG 1
#define DIR_SHORT -1

int lastOrderErrorCloseTime;

//---------------------------------------------------------------------------         
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
int            timeGMTOffset=0;
//---
MqlRates       DailyBar[];
MqlDateTime currentBarTimeStruct, lastBarTimeStruct, timeGMTStruct;

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

//---
int hours_from_session_start(int session_start)
{
   TimeGMT(timeGMTStruct);
   
   if(timeGMTStruct.hour<session_start)
   {
      return(24+timeGMTStruct.hour-session_start);
   }
   
   return(timeGMTStruct.hour-session_start);   
}
//---
bool is_market_session_open(int session_start, int session_end)
{
   return(hours_from_session_start(session_start)<MathAbs(session_end-session_start));
}
//---  

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

//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
// int MyCalculator(int value,int value2) export
//   {
//    return(value+value2);
//   }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| H4 and Daily Support/Resistance and Pivot                        |
//+------------------------------------------------------------------+
void get_pivots(string symbol, int timeframe)
{
//----------------------------------------------------------------------------- Get new TimeFrame ---------------
   ArrayCopyRates(Fhr_rates_d1, symbol, timeframe);

   Fhr_yesterday_close = Fhr_rates_d1[1][4];
   Fhr_yesterday_open = Fhr_rates_d1[1][1];
   Fhr_today_open = Fhr_rates_d1[0][1];
   Fhr_yesterday_high = Fhr_rates_d1[1][3];
   Fhr_yesterday_low = Fhr_rates_d1[1][2];
   Fhr_day_high = Fhr_rates_d1[0][3];
   Fhr_day_low = Fhr_rates_d1[0][2];


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

   D_yesterday_close = D_rates_d1[1][4];
   D_yesterday_open = D_rates_d1[1][1];
   D_today_open = D_rates_d1[0][1];
   D_yesterday_high = D_rates_d1[1][3];
   D_yesterday_low = D_rates_d1[1][2];
   D_day_high = D_rates_d1[0][3];
   D_day_low = D_rates_d1[0][2];


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
}

double getPrice(string Pair, int TimeFrame, int Mode, int shift)
{
   switch(Mode)
   {
      case CLOSE_MODE: 
         return(iClose(Pair, TimeFrame, shift));
      case OPENCLOSE_MODE: 
         return(iClose(Pair, TimeFrame, shift) - iOpen(Pair, TimeFrame, shift));
      case CLOSE_RELATIVE_MODE: 
         return(iClose(Pair, TimeFrame, shift)/iHigh(Pair, TimeFrame, shift));
      default:
         return(0);
   }
}

datetime getTimeToGMT(datetime time1)
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

void getNearestAndFarestSR(string symbol, int timeframe, double price, double& pivots[])
{
   //-- Pivots, Support/Resistance and Price Alerts
   get_pivots(symbol, timeframe);
   //---
   ArrayResize(pivots,8);
   ArrayInitialize(pivots,EMPTY_VALUE);
   
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
      //-D
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
   
   pivots[0] = nearest_support;
   pivots[1] = nearest_resistance;
   pivots[2] = nearest_daily_support;
   pivots[3] = nearest_daily_resistance;
   
   pivots[4] = farest_support;
   pivots[5] = farest_resistance;
   pivots[6] = farest_daily_support;
   pivots[7] = farest_daily_resistance;
   
}

//-------------------------------
double sqGetPipValue(string symbol) {
   return(MathPow(10.0, MathFloor(MathLog(MarketInfo(symbol,MODE_BID) / 2.0) / MathLog(10.0)) - 3));
}

//-------------------------------
double sqGetPipDigits(string symbol) {
   return(MathRound(MathLog(sqGetPipValue(symbol) / MarketInfo(symbol,MODE_POINT)) / MathLog(10.0)));
}

//-------------------------------
double sqGetStopLevelInPips(string symbol) {
   return(NormalizeDouble(MarketInfo(symbol, MODE_STOPLEVEL) * MarketInfo(symbol,MODE_POINT) / sqGetPipValue(symbol), sqGetPipDigits(symbol)));
}

//-------------------------------
double sqGetEqualityTolerance(string symbol) {
   return(MarketInfo(symbol,MODE_POINT) / 2.0);
}

//+------------------------------------------------------------------+
bool sqCheckTradeLevelsToSetBe(string symbol, int orderMagicNumber, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips, bool force=false)
{
   for(int i = 0; i < OrdersTotal(); i++)
      if (OrderSelect(i, SELECT_BY_POS))
         if (OrderSymbol() == symbol && OrderMagicNumber() == orderMagicNumber)
            if ((OrderType() == OP_BUY) || (OrderType() == OP_SELL))
               if (force || !sqOrderIsInBeOrFurther(OrderTicket(),Break_Even_in_Pips,Break_Even_Trigger_in_Pips))
                  if (force || sqOrderIsTriggeredByBe(OrderTicket(),Break_Even_in_Pips,Break_Even_Trigger_in_Pips))
                     if(!sqSetBreakEven(OrderTicket(),Break_Even_in_Pips,Break_Even_Trigger_in_Pips))
                        return(false);

   return(true);
}

//+------------------------------------------------------------------+
bool sqOrderIsInBeOrFurther(int orderTicket, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips)
{
   if(OrderSelect(orderTicket,SELECT_BY_TICKET)) {

      double STOPLEVEL = MarketInfo(OrderSymbol(),MODE_STOPLEVEL)*MarketInfo(OrderSymbol(),MODE_POINT);
      double Spread    = MarketInfo(OrderSymbol(),MODE_SPREAD)*MarketInfo(OrderSymbol(),MODE_POINT);  
      
      if (OrderType() == OP_BUY) {
         double tmpValue = OrderStopLoss() - OrderOpenPrice();
         return((OrderStopLoss() != 0.0) && (tmpValue > Break_Even_in_Pips * getPointCoef(OrderSymbol(), OrderMagicNumber())/*sqGetPipValue(OrderSymbol()) - sqGetEqualityTolerance(OrderSymbol())*/ ));
      }
      else if (OrderType() == OP_SELL) {
         tmpValue = OrderOpenPrice() - OrderStopLoss();
         return((OrderStopLoss() != 0.0) && (tmpValue > Break_Even_in_Pips * getPointCoef(OrderSymbol(), OrderMagicNumber())/*sqGetPipValue(OrderSymbol()) - sqGetEqualityTolerance(OrderSymbol())*/ ));
      }
      return(true);
   }
   return(false);
}
//+------------------------------------------------------------------+
bool sqOrderIsTriggeredByBe(int orderTicket, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips)
{
   if(OrderSelect(orderTicket,SELECT_BY_TICKET)) {

      double STOPLEVEL = MarketInfo(OrderSymbol(),MODE_STOPLEVEL)*MarketInfo(OrderSymbol(),MODE_POINT);
      double Spread    = MarketInfo(OrderSymbol(),MODE_SPREAD)*MarketInfo(OrderSymbol(),MODE_POINT);  

      if (OrderType() == OP_BUY) {
         double plValue = MarketInfo(Symbol(), MODE_BID) - OrderOpenPrice();
         return(plValue >= Break_Even_Trigger_in_Pips * getPointCoef(OrderSymbol(), OrderMagicNumber()) /*sqGetPipValue(OrderSymbol()) - sqGetEqualityTolerance(OrderSymbol())*/  );
      }
      else if (OrderType() == OP_SELL) {
         plValue = OrderOpenPrice() - MarketInfo(Symbol(), MODE_ASK);
         return(plValue >= Break_Even_Trigger_in_Pips * getPointCoef(OrderSymbol(), OrderMagicNumber()) /*sqGetPipValue(OrderSymbol()) - sqGetEqualityTolerance(OrderSymbol())*/  );
      }
      return(false);
   }
   return(false);
}
//+------------------------------------------------------------------+
bool sqSetBreakEven(int orderTicket, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips)
{
  if(OrderSelect(orderTicket,SELECT_BY_TICKET)) {

      double STOPLEVEL = MarketInfo(OrderSymbol(),MODE_STOPLEVEL)*MarketInfo(OrderSymbol(),MODE_POINT);
      double Spread    = MarketInfo(OrderSymbol(),MODE_SPREAD)*MarketInfo(OrderSymbol(),MODE_POINT);  

      double new_stop_level = ( Break_Even_in_Pips * getPointCoef(OrderSymbol(), OrderMagicNumber()) + Spread + STOPLEVEL );
      if(new_stop_level > 0) {
         if (OrderType() == OP_BUY) {
            //new_stop_level = NormalizeDouble(OrderClosePrice() + Spread /*+ STOPLEVEL*/ + Break_Even_in_Pips * sqGetPipValue(OrderSymbol()), MarketInfo(OrderSymbol(),MODE_DIGITS));
            //new_stop_level = MarketInfo(OrderSymbol(), MODE_BID) - new_stop_level;
            new_stop_level = OrderOpenPrice() + new_stop_level;
         }
         else if (OrderType() == OP_SELL) {
            //new_stop_level = NormalizeDouble(OrderClosePrice() - Spread /*- STOPLEVEL*/ - Break_Even_in_Pips * sqGetPipValue(OrderSymbol()), MarketInfo(OrderSymbol(),MODE_DIGITS));
            //new_stop_level = MarketInfo(OrderSymbol(), MODE_ASK) + new_stop_level;
            new_stop_level = OrderOpenPrice() - new_stop_level;
         }
         else {
            new_stop_level = 0.0;
         }

         if (new_stop_level > 0.0 && !sqDoublesAreEqual(OrderSymbol(),OrderStopLoss(),new_stop_level))
            if ( (OrderType() == OP_BUY && new_stop_level > OrderStopLoss()) || (OrderType() == OP_SELL && OrderStopLoss() != 0 && new_stop_level < OrderStopLoss())  )
               if(OrderModify(OrderTicket(), OrderOpenPrice(), new_stop_level, OrderTakeProfit(), 0)) {
                  VerboseLog("Order updates, StopLoss: ", new_stop_level,", Profit Target: ", OrderTakeProfit());
                  return(true);
               } else {
                  int error = GetLastError();
                  VerboseLog("Error modifying order with ticket("+orderTicket+") - error #",error, " : ", ErrorDescription(error));
                  VerboseLog("Order Details - Type: "+sqGetOrderTypeAsString(OrderType())+", OpenPrice: "+OrderOpenPrice()+", SL: "+OrderStopLoss()+", TP: "+OrderTakeProfit());
                  VerboseLog("Order Modify Bid: "+MarketInfo(OrderSymbol(), MODE_BID)+", Ask: "+MarketInfo(OrderSymbol(), MODE_ASK)+", NewSL: "+new_stop_level+", NewTP: "+OrderTakeProfit());
                  return(false);
               }
               //if ( ! OrderModify(OrderTicket(), 0.0, new_stop_level, OrderTakeProfit(), 0))
               //   write_error_message(error__title_order_modify, TimeToStr(TimeCurrent(), TIME_MINUTES|TIME_SECONDS) + get_error_message(GetLastError()));
      }
  }
  return(false);
}

//-------------------------------
int getHigherTimeFrame(int sig_timeFrame)
{
   //--
   int time_frame = sig_timeFrame;
   //--
   switch (sig_timeFrame) {
      case 1:
         time_frame = 5;  

         break;
      case 5:
         time_frame = 15;

         break;
      case 15:
         time_frame = 30;

         break;
      case 30:
         time_frame = 60;

         break;      
      case 60:
         time_frame = 240;

         break;
      case 240:
         time_frame = 1440;

         break;
      case 1440:
         time_frame = 10080;

         break;
      case 10080:
         time_frame = 43200;

         break;
      case 43200:
         time_frame = 43200;

         break;
   }
   //--
   return(time_frame);
}

//----------------------------------------------------------------------------

double getOrderPrice(string symbol, int orderType) {
   double price = 0;

   if(orderType == OP_BUY) {
      price = MarketInfo(symbol, MODE_ASK);
   }
   if(orderType == OP_SELL) { 
      price = MarketInfo(symbol, MODE_BID);
   }

   return(NormalizeDouble(price, MarketInfo(symbol,MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getOrderSize(string symbol, int orderMagicNumber, int orderType) {
   double size = 0;
   size = sqMMFixedRisk(symbol, orderMagicNumber, orderType);

   return(size);
}

//----------------------------------------------------------------------------

double getOrderTrailingStop(string symbol, int timeFrame, int orderMagicNumber, int orderType, int trailingStopPips) {
   double value = 0;

   //--
   double price = (orderType == OP_BUY ? MarketInfo(symbol,MODE_ASK) : MarketInfo(symbol,MODE_BID));
   double pivots[];
   getNearestAndFarestSR(symbol, timeFrame, price, pivots);
   //--
   
   if(orderType == OP_BUY  ) {
      double trailingStop_value = ( trailingStopPips * getPointCoef(symbol, orderMagicNumber));
      if(trailingStop_value > 0) {
         if(orderType == OP_BUY || orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT) {
            trailingStop_value = MarketInfo(symbol, MODE_BID) - trailingStop_value;
         } else {
            trailingStop_value = MarketInfo(symbol, MODE_ASK) + trailingStop_value;
         }
      }
      
      double nearestSR_value = MathMin(nearest_support, nearest_daily_support) - (MarketInfo(symbol,MODE_STOPLEVEL)*MarketInfo(symbol,MODE_POINT));
      
      //value = MathMin(trailingStop_value, nearestSR_value);
      value = trailingStop_value;
   }

   if(orderType == OP_SELL ) {
      trailingStop_value = ( trailingStopPips * getPointCoef(symbol, orderMagicNumber));
      if(trailingStop_value > 0) {
         if(orderType == OP_BUY || orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT) {
            trailingStop_value = MarketInfo(symbol, MODE_BID) - trailingStop_value;
         } else {
            trailingStop_value = MarketInfo(symbol, MODE_ASK) + trailingStop_value;
         }
      }
      
      nearestSR_value = MathMax(nearest_resistance, nearest_daily_resistance) + (MarketInfo(symbol,MODE_STOPLEVEL)*MarketInfo(symbol,MODE_POINT));
      
      //value = MathMax(trailingStop_value, nearestSR_value);
      value = trailingStop_value;
   }

   return(NormalizeDouble(value, MarketInfo(symbol, MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getOrderTrailingStopActivation(string symbol, int orderMagicNumber, int orderType, int addPips) {
   double value = 0;

   if(orderType == OP_BUY ) {
      value = ( addPips * getPointCoef(symbol, orderMagicNumber));
   }

   if(orderType == OP_SELL ) {
      value = ( addPips * getPointCoef(symbol, orderMagicNumber));
   }

   return(NormalizeDouble(value, MarketInfo(symbol, MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getOrderBreakEven(string symbol, int orderMagicNumber, int orderType, double price, int addPips) {
   double value = 0;

   value = ( addPips * getPointCoef(symbol, orderMagicNumber));
   if(value > 0) {
      if(orderType == OP_BUY || orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT) {
         value = MarketInfo(symbol, MODE_BID) - value;
      } else {
         value = MarketInfo(symbol, MODE_ASK) + value;
      }
   }

   return(NormalizeDouble(value, MarketInfo(symbol, MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getOrderBreakEvenAddPips(string symbol, int orderMagicNumber, int addPips) {
   double value = 0;

   value = ( addPips * getPointCoef(symbol, orderMagicNumber));

   return(NormalizeDouble(value, MarketInfo(symbol, MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getOrderExpiration(string symbol, int orderMagicNumber) {
   double price = 0;

   if(orderMagicNumber == 1000) {
      price = 0;
   }

   if(orderMagicNumber == 2000) {
      price = 0;
   }


   return(NormalizeDouble(price, MarketInfo(symbol, MODE_DIGITS)));
}

//+------------------------------------------------------------------+

double getOrderExitAfterXBars(string symbol, int orderMagicNumber) {
   double price = 0;

   if(orderMagicNumber == 1000) {
      price = 0;
   }

   if(orderMagicNumber == 2000) {
      price = 0;
   }


   return(NormalizeDouble(price, MarketInfo(symbol, MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getStopDifferencePrice(string symbol, int orderMagicNumber) {
   double price = 0;

   if(orderMagicNumber == 1000) {
      price = 0;
   }

   if(orderMagicNumber == 2000) {
      price = 0;
   }


   return(NormalizeDouble(price, MarketInfo(symbol,MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getOrderStopLoss(string symbol, int orderMagicNumber, int orderType, double price) {
   double value = 0;

   if(orderMagicNumber == 1000) {
      value = 1.5 * iATR(NULL, 0, 14 ,1)+ sqConvertToRealPips(symbol, 15);
      if(value > 0) {
         if(orderType == OP_BUY || orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT) {
            value = price - value;
         } else {
            value = price + value;
         }
      }
   }

   if(orderMagicNumber == 2000) {
      value = 1.5 * iATR(NULL, 0, 14 ,1)+ sqConvertToRealPips(symbol, 15);
      if(value > 0) {
         if(orderType == OP_BUY || orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT) {
            value = price - value;
         } else {
            value = price + value;
         }
      }
   }

   return(NormalizeDouble(value, MarketInfo(symbol,MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getOrderProfitTarget(string symbol, int orderMagicNumber, int orderType, double price) {
   double value = 0;

   value = 3 * iATR(symbol, 0, 14 ,1);
   if(value > 0) {
      if(orderType == OP_BUY || orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT) {
         value = price + value;
      } else {
         value = price - value;
      }
   }

   return(NormalizeDouble(value, MarketInfo(symbol,MODE_DIGITS)));
}

//----------------------------------------------------------------------------

double getPointCoef(string symbol, int orderMagicNumber) {
   double coef = 0;
   double rDigits, pointPow;
   
   rDigits = MarketInfo(symbol, MODE_DIGITS);
   if(rDigits > 0 && rDigits != 2 && rDigits != 4) {
      rDigits -= 1;
   }

   pointPow = MathPow(10, rDigits);
   coef = 1/pointPow;      

   return(coef);
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

//----------------------------------------------------------------------------

double sqSafeDivide(double var1, double var2) {
   if(var2 == 0) return(10000000);
   return(var1/var2);
}

//----------------------------------------------------------------------------

datetime sqGetTime(int hour, int minute, int second) {
   // StrToTime works only on a current date, for previous dates it should be used like this:
   string str = TimeToStr(TimeCurrent(), TIME_DATE)+ " " +hour+ ":" + minute;
   datetime time2 =  StrToTime(str)+second;
   return(time2);
}

//+------------------------------------------------------------------+

int sqGetBarsSinceExit(string symbol, int orderMagicNumber) {

   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true) {

         if(OrderMagicNumber() == orderMagicNumber && OrderSymbol() == symbol) {
            return (sqGetBarsFromOrderClose(symbol, orderMagicNumber));
         }
      }
   }

   return(-1);
}

//+------------------------------------------------------------------+

int sqGetOpenBarsForOrder(string symbol, int expBarsPeriod) {
   datetime opTime = OrderOpenTime();

   int numberOfBars = 0;
   for(int i=0; i<expBarsPeriod+10; i++) {
      if(opTime < iTime(symbol,Period(),i)) {
         numberOfBars++;
      }
   }

   return(numberOfBars);
}

//+------------------------------------------------------------------+

int sqGetOrdersOpenedToday(string symbol, int direction, string includePending) {
   string todayTime = TimeToStr( TimeCurrent(), TIME_DATE);
   int tradesOpenedToday = 0;

   for(int i=0;i<OrdersHistoryTotal();i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {

         if(direction == 1) {
            if(OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
               // skip short orders
               continue;
            }
         } else if(direction == -1) {
            if(OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP) {
               // skip long orders
               continue;
            }
         }

         if(includePending == "false") {
            if(OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
               // skip pending orders
               continue;
            }
         }

         if(TimeToStr( OrderOpenTime(), TIME_DATE) == todayTime) {
            tradesOpenedToday++;
         }
      }
   }

   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (OrderSelect(cc, SELECT_BY_POS) && OrderSymbol() == symbol) {

         if(direction == 1) {
            if(OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
               // skip short orders
               continue;
            }
         } else if(direction == -1) {
            if(OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP) {
               // skip long orders
               continue;
            }
         }

         if(includePending == "false") {
            if(OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
               // skip pending orders
               continue;
            }
         }

         if(TimeToStr( OrderOpenTime(), TIME_DATE) == todayTime) {
            tradesOpenedToday++;
         }
      }
   }

   return(tradesOpenedToday);
}

//+------------------------------------------------------------------+

double sqGetProfitToday(string symbol, int orderMagicNumber) {
   double profit = 0;
   string todayTime = TimeToStr( TimeCurrent(), TIME_DATE);
   int tradesOpenedToday = 0;

   for(int i=0;i<OrdersHistoryTotal();i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol && OrderMagicNumber() == orderMagicNumber) {
         if(TimeToStr( OrderOpenTime(), TIME_DATE) == todayTime) {
            if(OrderType() == OP_SELL || OrderType() == OP_BUY) {
               profit += OrderProfit()+OrderSwap()+OrderCommission();
            }
         }
      }
   }

   return(profit);
}

//+------------------------------------------------------------------+

int sqGetProfitablePositionToday(string symbol, int orderMagicNumber) {
   int position = -1;
   int buys = 0, sells = 0;
   string todayTime = TimeToStr( TimeCurrent(), TIME_DATE);
   int tradesOpenedToday = 0;

   for(int i=0;i<OrdersHistoryTotal();i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol && OrderMagicNumber() == orderMagicNumber) {
         if(TimeToStr( OrderOpenTime(), TIME_DATE) == todayTime) {
            if(OrderType() == OP_SELL) {
               if(OrderProfit()+OrderSwap()+OrderCommission() > 0)
                  sells++;
            }
            if(OrderType() == OP_BUY) {
               if(OrderProfit()+OrderSwap()+OrderCommission() > 0)
                  buys++;
            }
         }
      }
   }

   if(sells>buys) {
      position = OP_SELL;
   } else if(sells<buys) {
      position = OP_BUY;
   }

   return(position);
}

//+------------------------------------------------------------------+

int sqGetOpenedPositionOlderThanToday(string symbol, int orderMagicNumber) {
   
   if (OrdersTotal() <= 0) return(-1);
   
   string todayTime = TimeToStr( TimeCurrent(), TIME_DATE);
   int tradesOpenedToday = 0;

   for(int i=0;i<OrdersTotal();i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true && OrderSymbol() == symbol && OrderMagicNumber() == orderMagicNumber) {
         if(TimeToStr( OrderOpenTime(), TIME_DATE) == todayTime) {
            if(OrderType() == OP_SELL || OrderType() == OP_BUY) {
               tradesOpenedToday++;
            }
         }
      }
   }

   return(tradesOpenedToday);
}

//+------------------------------------------------------------------+

int sqGetLastOrderType(string symbol, int orderMagicNumber) {
   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol && OrderMagicNumber() == orderMagicNumber) {
         if(OrderType() == OP_BUY) {
            return(1);
         }
         if(OrderType() == OP_SELL) {
            return(-1);
         }
      }
   }

   return(0);
}

//+------------------------------------------------------------------+

int sqGetLastOrderTodayType(string symbol, int orderMagicNumber) {
   string todayTime = TimeToStr( TimeCurrent(), TIME_DATE);

   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol && OrderMagicNumber() == orderMagicNumber) {
         if(TimeToStr( OrderOpenTime(), TIME_DATE) != todayTime) {
            continue;
         }

         if(OrderType() == OP_BUY) {
            return(1);
         }
         if(OrderType() == OP_SELL) {
            return(-1);
         }
      }
   }

   return(0);
}

//+------------------------------------------------------------------+

bool sqOrderOpenedThisBar(string symbol, int orderMagicNumber) {
   double pl = 0;

   for(int i=0; i<OrdersTotal(); i++) {
      if (OrderSelect(i,SELECT_BY_POS)==true && OrderSymbol() == symbol) {
         if(orderMagicNumber == 0 || OrderMagicNumber() == orderMagicNumber) {
            if(OrderOpenTime() > Time[1]) {
               return(true);
            }
         }
      }
   }

   for(i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(orderMagicNumber == 0 || OrderMagicNumber() == orderMagicNumber) {
            if(OrderOpenTime() > Time[1]) {
               return(true);
            }
         }
      }
   }


   return(false);
}

//+------------------------------------------------------------------+

bool sqOrderClosedThisBar(string symbol, int orderMagicNumber) {
   double pl = 0;

   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(orderMagicNumber == 0 || OrderMagicNumber() == orderMagicNumber) {
            if(OrderCloseTime() > Time[1]) {
               return(true);
            }
         }
      }
   }

   return(false);
}

//+------------------------------------------------------------------+

double sqOrderClosedThisBarProfit(string symbol, int orderMagicNumber) {
   double pl = 0;

   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(OrderMagicNumber() == orderMagicNumber) {
            if(OrderCloseTime() > Time[1]) {
               pl += OrderProfit()+OrderCommission()+OrderSwap();
            }
         }
      }
   }

   return(pl);
}

//+------------------------------------------------------------------+

double sqOrderClosedProfit(string symbol, int orderTicket, int orderMagicNumber) {
   double pl = 0;

   if (orderTicket < 0) return(pl);
   
   //if(OrderSelect(orderTicket,SELECT_BY_TICKET,MODE_HISTORY)==false) return(pl);
      
   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(OrderMagicNumber() == orderMagicNumber) {
            //if(OrderTicket() >= orderTicket && (OrderType() == OP_BUY || OrderType() == OP_SELL)) {
               pl = pl + OrderProfit()+OrderCommission()+OrderSwap();
            //}
            if(OrderTicket() == orderTicket) {
               break;
            }
         }
      }
   }

   //if (orderTicket >= 0) Alert(orderTicket + " - " + pl);

   return(pl);
}

//+------------------------------------------------------------------+

int sqOrderClosedThisSeries(string symbol, int orderTicket, int orderMagicNumber) {
   int pl = 0;

   if (orderTicket < 0) return(pl);
   
   //if(OrderSelect(orderTicket,SELECT_BY_TICKET,MODE_HISTORY)==false) return(pl);
      
   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(OrderMagicNumber() == orderMagicNumber) {
            if(OrderTicket() >= orderTicket) {
               pl++;
               //Alert(OrderProfit()+OrderCommission()+OrderSwap());
            }
            if(OrderTicket() == orderTicket) {
               break;
            }
         }
      }
   }

   //if (orderTicket >= 0) Alert(orderTicket + " - " + pl);

   return(pl);
}

//+------------------------------------------------------------------+

bool sqOrderOpenedThisMinute(string symbol, int orderMagicNumber) {
   datetime timeCandle = TimeCurrent() - 60; //iTime(NULL, PERIOD_M1, 1);

   for(int i=0; i<OrdersTotal(); i++) {
      if (OrderSelect(i,SELECT_BY_POS)==true && OrderSymbol() == symbol) {
         if(orderMagicNumber == 0 || OrderMagicNumber() == orderMagicNumber) {
            if(OrderOpenTime() >= timeCandle) {
               return(true);
            }
         }
      }
   }

   for(i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(orderMagicNumber == 0 || OrderMagicNumber() == orderMagicNumber) {
            if(OrderOpenTime() >= timeCandle) {
               return(true);
            }
         }
      }
   }

   return(false);
}

//+------------------------------------------------------------------+

bool sqOrderClosedThisMinute(string symbol, int orderMagicNumber) {
   datetime timeCandle = TimeCurrent() - 60; //iTime(NULL, PERIOD_M1, 1);

   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(orderMagicNumber == 0 || OrderMagicNumber() == orderMagicNumber) {
            if(OrderCloseTime() >= timeCandle) {
               return(true);
            }
         }
      }
   }

   return(false);
}

//+------------------------------------------------------------------+

double sqGetAngle(double value1, double value2, int period, double coef) {
   double diff = value1 - value2;

   double fAngleRad = MathArctan(diff / (coef*period));
   double PI =  3.141592654;

   double fAngleDegrees = (fAngleRad * 180) / PI;

   return((fAngleDegrees));
}

//+------------------------------------------------------------------+

string sqGetOrderSymbol(string symbol, int orderMagicNumber) {
   datetime timeCandle = TimeCurrent() - 60; //iTime(NULL, PERIOD_M1, 1);

   for(int i=OrdersHistoryTotal(); i>=0; i--) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderSymbol() == symbol) {
         if(orderMagicNumber == 0 || OrderMagicNumber() == orderMagicNumber) {
            if(OrderCloseTime() >= timeCandle) {
               return(OrderSymbol());
            }
         }
      }
   }

   return("");
}

//+------------------------------------------------------------------+

string sqGetPeriodAsStr() {
   string str = TimeToStr(Time[0], TIME_DATE);
   int period = Period();

   if(period == PERIOD_H4 || period == PERIOD_H1) {
      str = str + TimeHour(Time[0]);
   }
   if(period == PERIOD_M30 || period == PERIOD_M15 || period == PERIOD_M5 || period == PERIOD_M1) {
      str = str + " " + TimeToStr(Time[0], TIME_MINUTES);
   }

   return(str);
}

//+------------------------------------------------------------------+

string sqGetTimeFrameAsStr(int time_frame) {
   string str = "";
   
   switch( time_frame )
   {
      case PERIOD_M1:
         str = "M1";
         break;
      case PERIOD_M5:
         str = "M5";
         break;
      case PERIOD_M15:
         str = "M15";
         break;
      case PERIOD_M30:
         str = "M30";
         break;
      case PERIOD_H1:
         str = "H1";
         break;
      case PERIOD_H4:
         str = "H4";
         break;
      case PERIOD_D1:
         str = "D1";
         break;
      case PERIOD_W1:
         str = "W1";
         break;
      case PERIOD_MN1:
         str = "MN1";
         break;
   }

   return(str);
}

//+------------------------------------------------------------------+

string sqGetOrderTypeAsString(int type) {
   switch(type) {
      case OP_BUY: return("Buy");
      case OP_SELL: return("Sell");
      case OP_BUYLIMIT: return("Buy Limit");
      case OP_BUYSTOP: return("Buy Stop");
      case OP_SELLLIMIT: return("Sell Limit");
      case OP_SELLSTOP: return("Sell Stop");
   }

   return("Unknown");
}

//+------------------------------------------------------------------+

int sqGetBarsFromOrderOpen(string symbol, int expBarsPeriod) {
   datetime opTime = OrderOpenTime();

   int numberOfBars = 0;
   for(int i=0; i<expBarsPeriod+10; i++) {
      if(opTime < Time[i]) {
         numberOfBars++;
      }
   }

   return(numberOfBars);
}

//+------------------------------------------------------------------+

int sqGetBarsFromOrderClose(string symbol, int expBarsPeriod) {
   datetime clTime = OrderCloseTime();

   int numberOfBars = 0;
   for(int i=0; i<expBarsPeriod+10; i++) {
      if(clTime < Time[i]) {
         numberOfBars++;
      }
   }

   return(numberOfBars);
}

//+------------------------------------------------------------------+

int sqGetMarketPosition(string symbol, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (OrderSelect(cc, SELECT_BY_POS) && OrderSymbol() == symbol) {

         if(OrderType() == OP_BUY && OrderMagicNumber() == orderMagicNumber) {
            return(1);
         }
         if(OrderType() == OP_SELL && OrderMagicNumber() == orderMagicNumber) {
            return(-1);
         }
      }
   }

   return(0);
}

//+------------------------------------------------------------------+

double sqGetMarketLot(string symbol, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (OrderSelect(cc, SELECT_BY_POS) && OrderSymbol() == symbol) {

         if(OrderType() == OP_BUY && OrderMagicNumber() == orderMagicNumber) {
            return(OrderLots());
         }
         if(OrderType() == OP_SELL && OrderMagicNumber() == orderMagicNumber) {
            return(OrderLots());
         }
      }
   }

   return(-1);
}

//+------------------------------------------------------------------+

double sqGetMarketPipDistance(string symbol, int orderMagicNumber) {
   int    digits   = MarketInfo(symbol,MODE_DIGITS);
   int    power    = MathPow(10,digits-1);

   double pipDistance = 0;
   
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (OrderSelect(cc, SELECT_BY_POS) && OrderSymbol() == symbol) {
         if(OrderType() == OP_BUY && OrderMagicNumber() == orderMagicNumber) {
            pipDistance = (OrderClosePrice() - OrderOpenPrice()) * power;
            return(pipDistance);
         }
         if(OrderType() == OP_SELL && OrderMagicNumber() == orderMagicNumber) {
            pipDistance = (OrderOpenPrice() - OrderClosePrice()) * power;
            return(pipDistance);
         }
      }
   }

   return(pipDistance);
}

//+------------------------------------------------------------------+

double sqGetMaxMarketPipDistance(string symbol, int orderMagicNumber) {
   int    digits   = MarketInfo(symbol,MODE_DIGITS);
   int    power    = MathPow(10,digits-1);

   int ticket = -1;
   double pipDistance = EMPTY_VALUE;
   
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (OrderSelect(cc, SELECT_BY_POS) && OrderSymbol() == symbol) {
         if(OrderType() == OP_BUY && OrderMagicNumber() == orderMagicNumber) {
            double distance = (OrderClosePrice() - OrderOpenPrice()) * power;
            
            if(pipDistance == EMPTY_VALUE || MathAbs(pipDistance)<MathAbs(distance))
            {
               pipDistance = distance;
               ticket = OrderTicket();
            }
         }
         if(OrderType() == OP_SELL && OrderMagicNumber() == orderMagicNumber) {
            distance = (OrderOpenPrice() - OrderClosePrice()) * power;
            
            if(pipDistance == EMPTY_VALUE || MathAbs(pipDistance)<MathAbs(distance))
            {
               pipDistance = distance;
               ticket = OrderTicket();
            }
         }
      }
   }
   
   if(pipDistance != EMPTY_VALUE) OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES);
   
   return(pipDistance);
}

//+------------------------------------------------------------------+

int sqGetMarketWinPosition(string symbol, int orderMagicNumber) {
   int pos = -1;
   int buys = 0;
   int sells = 0;
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (OrderSelect(cc, SELECT_BY_POS) && OrderSymbol() == symbol) {
         if(OrderType() == OP_BUY && OrderMagicNumber() == orderMagicNumber) {
            if(OrderProfit()+OrderCommission()+OrderSwap()>0)
            {
               buys++;
            }
         }
         if(OrderType() == OP_SELL && OrderMagicNumber() == orderMagicNumber) {
            if(OrderProfit()+OrderCommission()+OrderSwap()>0)
            {
               sells++;
            }
         }
      }
   }
   
   if(buys > sells) {
      pos = OP_BUY;
   } else if(buys < sells) {
      pos = OP_SELL;
   }
   
   return(pos);
}

//+------------------------------------------------------------------+
double sqGetOrderPipDistance(string symbol, int orderTicket) {
   int    digits   = MarketInfo(symbol,MODE_DIGITS);
   int    power    = MathPow(10,digits-1);

   double pipDistance = 0;
   
   if (OrderSelect(orderTicket, SELECT_BY_TICKET) && OrderSymbol() == symbol) {
      if(OrderType() == OP_BUY) {
         pipDistance = (OrderClosePrice() - OrderOpenPrice()) * power;
         return(pipDistance);
      }
      if(OrderType() == OP_SELL) {
         pipDistance = (OrderOpenPrice() - OrderClosePrice()) * power;
         return(pipDistance);
      }
   }

   return(pipDistance);
}

//+------------------------------------------------------------------+

double sqGetOrderPosition(string symbol, int orderType, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (!OrderSelect(cc, SELECT_BY_POS) ) continue;
      if(OrderSymbol() == symbol && OrderMagicNumber() == orderMagicNumber) {
         if((orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT || orderType == OP_BUY) && OrderType() == OP_BUY) {
            return(1);
         }
         if((orderType == OP_SELLSTOP || orderType == OP_SELLLIMIT || orderType == OP_SELL) && OrderType() == OP_SELL) {
            return(-1);
         }
      }
   }

   return(0);
}

//+------------------------------------------------------------------+

double sqGetOpenPrice(string symbol, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (!OrderSelect(cc, SELECT_BY_POS) ) continue;
      if((orderMagicNumber == 0 && OrderSymbol() == symbol) || OrderMagicNumber() == orderMagicNumber) {
         return(OrderOpenPrice());
      }
   }

   return(0);
}

//+------------------------------------------------------------------+

double sqGetOrderStopLoss(string symbol, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (!OrderSelect(cc, SELECT_BY_POS) ) continue;
      if(OrderMagicNumber() == orderMagicNumber && OrderSymbol() == symbol) {
         return(OrderStopLoss());
      }
   }

   return(0);
}

//+------------------------------------------------------------------+

double sqGetOrderProfitTarget(string symbol, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (!OrderSelect(cc, SELECT_BY_POS) ) continue;
      if(OrderMagicNumber() == orderMagicNumber && OrderSymbol() == symbol) {
         return(OrderTakeProfit());
      }
   }

   return(0);
}

//+------------------------------------------------------------------+

void sqDeletePendingOrder(string symbol, int orderType, int orderMagicNumber) {
   for(int i=0; i<OrdersTotal(); i++) {
      if (OrderSelect(i,SELECT_BY_POS)==true) {
         if(OrderMagicNumber() == orderMagicNumber && OrderSymbol() == symbol && OrderType() == orderType) {
            OrderDelete(OrderTicket());
            return;
         }
      }
   }
}

//+------------------------------------------------------------------+

bool sqLiveOrderExists(string symbol, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (!OrderSelect(cc, SELECT_BY_POS) ) continue;
      if(OrderMagicNumber() == orderMagicNumber && OrderSymbol() == symbol) return(true);
   }

   return(false);
}

//+------------------------------------------------------------------+

bool sqPendingOrderExists(string symbol, int orderType, int orderMagicNumber) {
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (!OrderSelect(cc, SELECT_BY_POS) ) continue;
      if(OrderMagicNumber() != orderMagicNumber && OrderSymbol() != symbol) continue;
      if(OrderType() == OP_BUY || OrderType() == OP_SELL) continue;
      if(OrderType() != orderType) continue;

      return(true);
   }

   return(false);
}

//----------------------------------------------------------------------------

bool getReplaceStopLimitOrder(int orderMagicNumber) {
   bool value = true;

   if(orderMagicNumber == orderMagicNumber) {
      value = false;
   }

   return(value);
}

//+------------------------------------------------------------------+

double sqGetOrdersAveragePrice(string symbol, int orderMagicNumber) {
   double sum = 0.0;
   double cnt = 0.0;
   for (int cc = OrdersTotal() - 1; cc >= 0; cc--) {
      if (!OrderSelect(cc, SELECT_BY_POS) ) continue;
      if(OrderMagicNumber() == orderMagicNumber && OrderSymbol() == symbol) {
         if(OrderType() == OP_BUY && OrderCloseTime() == 0) {
            sum += OrderLots() * OrderOpenPrice ();
            cnt += OrderLots();
         }
         if(OrderType() == OP_SELL && OrderCloseTime() == 0) {
            sum += OrderLots() * OrderOpenPrice ();
			   cnt += OrderLots();
         }
      }
   }

   if (NormalizeDouble (cnt, MarketInfo(symbol,MODE_DIGITS)) == 0) return (0);

   return(sum / cnt);
}

//+------------------------------------------------------------------+

double sqGetIf (string symbol, double condition, double val1, double val2) {
	if (NormalizeDouble(condition, MarketInfo(symbol,MODE_DIGITS)) > 0) return (val1);
	return (val2);
}

//+------------------------------------------------------------------+

double sqRound(double value, int digits) {
   double pow = MathPow(10, digits);
   return(MathRound(value * pow) / pow);
}

//+------------------------------------------------------------------+

double sqGetAsk(string symbol) {
   if(symbol == "NULL") {
      return(MarketInfo(symbol,MODE_ASK));
   } else {
      return(MarketInfo(symbol,MODE_ASK));
   }
}

//+------------------------------------------------------------------+

double sqGetBid(string symbol) {
   if(symbol == "NULL") {
      return(MarketInfo(symbol, MODE_BID));
   } else {
      return(MarketInfo(symbol,MODE_BID));
   }
}

//+------------------------------------------------------------------+

bool sqDoublesAreEqual(string symbol, double n1, double n2) {
   string s1 = DoubleToStr(n1, MarketInfo(symbol, MODE_DIGITS));
   string s2 = DoubleToStr(n2, MarketInfo(symbol, MODE_DIGITS));

   return (s1 == s2);
}

//+------------------------------------------------------------------+

int sqIsTradeAllowed(int MaxWaiting_sec = 30) {
    // check whether the trade context is free
    if(!IsTradeAllowed()) {
        int StartWaitingTime = GetTickCount();
        Print("Trade context is busy! Wait until it is free...");
        // infinite loop
        while(true) {
            // if the expert was terminated by the user, stop operation
            if(IsStopped()) {
                Print("The expert was terminated by the user!");
                return(-1);
            }
            // if the waiting time exceeds the time specified in the
            // MaxWaiting_sec variable, stop operation, as well
            int diff = GetTickCount() - StartWaitingTime;
            if(diff > MaxWaiting_sec * 1000) {
                Print("The waiting limit exceeded (" + MaxWaiting_sec + " ???.)!");
                return(-2);
            }
            // if the trade context has become free,
            if(IsTradeAllowed()) {
                Print("Trade context has become free!");
                RefreshRates();
                return(1);
            }
            // if no loop breaking condition has been met, "wait" for 0.1
            // second and then restart checking
            Sleep(100);
          }
    } else {
        //Print("Trade context is free!");
        return(1);
    }
    
    return(1);
}

//+------------------------------------------------------------------+

int sqOpenOrderWithErrorHandling(string symbol, int orderType, double orderLots, double price, int slippage, double realSL, double realPT, string comment, int orderMagicNumber, datetime expiration = 0, bool SupportECNBrokers = true, bool CloseAtError = false) {
   int ticket, error;

   Verbose("Sending order...");
   double sl = realSL;
   double pt = realPT;
   if(SupportECNBrokers) {
      sl = 0;
      pt = 0;
   } 
   
   ticket = OrderSend(symbol, orderType, orderLots, price, slippage, sl, pt, comment, orderMagicNumber, expiration);

   if(ticket < 0) {
      // order failed, write error to log
      error = GetLastError();
      Verbose("Order failed, error: ", error);
      return(-1*error);
   }

   bool tmpRet = OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES);
         
   Log("Order opened with ticket: ", OrderTicket(), " at price:", OrderOpenPrice());
   VerboseLog("Order with Magic Number: ",orderMagicNumber," opened with ticket: ", OrderTicket(), " at price:", OrderOpenPrice());

   if(SupportECNBrokers) {
      // set up stop loss and profit target
      // it has to be done separately to support ECN brokers

      int retries = 3;
      while(true) {
         retries--;
         if(retries < 0) return(0);
         
         if((realSL == 0 && realPT == 0) || (OrderStopLoss() == realSL && OrderTakeProfit() == realPT)) {
            return(ticket);
         }

         if(sqIsTradeAllowed() == 1) {
            Verbose("Setting SL/PT, try #", 3-retries);
            if(sqSetSLPTForOrder(ticket, realSL, realPT, orderMagicNumber, orderType, price, slippage, symbol, retries, CloseAtError)) {
               return(ticket);
            }
            if(retries == 0) {
               // there was eror setting SL/PT and order was deleted
               return(-11111);
            }
         }

         Sleep(1000);
      }

      Verbose("Retries of setting SL/PT order finished unsuccessfuly", " ----------------");
      return(-1);
   }

   return(ticket);
}

//+------------------------------------------------------------------+

bool sqSetSLPTForOrder(int ticket, double realSL, double realPT, int orderMagicNumber, int orderType, double price, int slippage, string symbol, int retries, bool closeAtError) {
   Verbose("Setting SL: ", realSL, " and PT: ", realPT, " for order with ticket ", ticket);
   
   if( OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES) )
   {
      if(OrderModify(ticket, OrderOpenPrice(), realSL, realPT, 0, 0)) {
         VerboseLog("Order updates, StopLoss: ", realSL,", Profit Target: ", realPT);
         return(true);
      } else {
         int error = GetLastError();
         VerboseLog("Error modifying order with ticket("+ticket+") - error #",error, " : ", ErrorDescription(error));
         VerboseLog("Order Details - Type: "+sqGetOrderTypeAsString(OrderType())+", OpenPrice: "+OrderOpenPrice()+", SL: "+OrderStopLoss()+", TP: "+OrderTakeProfit());
         VerboseLog("Order Modify Bid: "+MarketInfo(symbol, MODE_BID)+", Ask: "+MarketInfo(symbol, MODE_ASK)+", NewSL: "+realSL+", NewTP: "+realPT);
   
         if(retries == 0 && closeAtError) {
            // when it is last unsuccessful retry, it tries to close the order
            RefreshRates();
            sqClosePositionAtMarket(-1, slippage);
            lastOrderErrorCloseTime = TimeCurrent();
         }
         return(false);
      }
      
      return(true);
   }
   
   return(false);
}

//+------------------------------------------------------------------+

bool sqClosePositionAtMarket(double size, int slippage) {
   Verbose("Closing order with Magic Number: ", OrderMagicNumber(), ", ticket: ", OrderTicket(), " at market price");

   int error;

   int retries = 3;
   while(true) {
      retries--;
      if(retries < 0) return(false);

      if(sqIsTradeAllowed() == 1) {
         Verbose("Closing retry #", 3-retries);
         if(sqClosePositionWithHandling(size, slippage)) {
            // trade successfuly closed
            Verbose("Order with Magic Number: ", OrderMagicNumber(), ", ticket: ", OrderTicket(), " successfuly closed");
            return(true);
         } else {
            error = GetLastError();
            Verbose("Closing order failed, error: ", error," - ", ErrorDescription(error));
         }
      }

      Sleep(100);
   }

   return(false);
}

//+------------------------------------------------------------------+

bool sqClosePositionWithHandling(double size, int slippage) {
   RefreshRates();
   double priceCP;

   if(OrderType() != OP_BUY && OrderType() != OP_SELL) {
     return(true);
   }

   if(OrderType() == OP_BUY) {
      priceCP = sqGetBid(OrderSymbol());
   } else {
      priceCP = sqGetAsk(OrderSymbol());
   }

   if(size <= 0) {
      Verbose("Closing Market price: ", priceCP, ", closing size: ", OrderLots());
      return(OrderClose(OrderTicket(), OrderLots(), priceCP, slippage));
   } else {
      Verbose("Closing Market price: ", priceCP, ", closing size: ", size);
      return(OrderClose(OrderTicket(), size, priceCP, slippage));
   }
}

//+------------------------------------------------------------------+

bool sqOpenOrder(string symbol, int orderType, double orderLots, double price, int slippage, double realSL, double realPT, string comment, int orderMagicNumber, string ruleName, datetime expiration = 0) {
   int ticket;

   Verbose("Opening order with MagicNumber: ", orderMagicNumber,", type: ", sqGetOrderTypeAsString(orderType), ", price: ", price,", lots: ", orderLots, ", comment: ", comment, " ----------------");
   Verbose("Current Ask: ", MarketInfo(symbol,MODE_ASK), ", Bid: ", MarketInfo(symbol,MODE_BID));

   if(TimeCurrent() - lastOrderErrorCloseTime < 600) {
      return(false);
      Verbose("There was error placing order less that a minute ago, waiting with another order!");
   }
   
   if( (orderType == OP_BUY || orderType == OP_SELL) && sqLiveOrderExists(symbol, orderMagicNumber)) {
      Verbose("Order with magic number: ", orderMagicNumber, " already exists, cannot open another one!");
      Verbose("----------------------------------");
      return(false);
   }

   if(sqPendingOrderExists(symbol, orderType, orderMagicNumber)) {
      //if(!getReplaceStopLimitOrder(orderMagicNumber)) {
         Verbose("Pending Order with magic number: ", orderMagicNumber, " already exists, and replace is not allowed!", " ----------------");
         return(false);
      //}

      // close pending order
      //Verbose("Deleting previous pending order");
      //sqDeletePendingOrder(symbol, orderType, orderMagicNumber);
   }

   RefreshRates();
   if(orderType == OP_BUYSTOP || orderType == OP_SELLSTOP) {
      double AskOrBid;
      if(orderType == OP_BUYSTOP) { AskOrBid = sqGetAsk(symbol); } else { AskOrBid = sqGetBid(symbol); }

      // check if stop/limit price isn't too close
      if(NormalizeDouble(MathAbs(price - AskOrBid), MarketInfo(symbol,MODE_DIGITS)) <= NormalizeDouble(getStopDifferencePrice(symbol,orderMagicNumber)/sqGetPointPow(symbol), MarketInfo(symbol,MODE_DIGITS))) {
         Verbose("Stop/limit order is too close to actual price", " ----------------");
         return(false);
      }
   }

   if( realSL == 0 ) realSL = getOrderStopLoss(symbol, orderMagicNumber, orderType, price);
   if( realPT == 0 ) realPT = getOrderProfitTarget(symbol, orderMagicNumber, orderType, price);

   int retries = 3;
   while(true) {
      retries--;
      if(retries < 0) return(0);
      if((orderType == OP_BUY || orderType == OP_SELL) && sqGetOrderPosition(symbol, orderType, orderMagicNumber) != 0) {
         Verbose("Order already opened", " ----------------");
         return(0);
      }

      if(sqIsTradeAllowed() == 1) {
         Verbose("Opening, try #", 3-retries);
         ticket = sqOpenOrderWithErrorHandling(symbol, orderType, orderLots, price, slippage, realSL, realPT, comment, orderMagicNumber, expiration);
         if(ticket > 0) {
            // trade successfuly opened
            Verbose("Trade successfuly opened", " ----------------");
            ObjectSetText("lines", "Last Signal: "+ruleName, 8, "Tahoma", White);
            OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES);
            
            return(true);
         }
      }

      if(ticket == -130) {
         Verbose("Invalid stops, cannot open the trade", " ----------------");
         return(false);
      }

      if(ticket == -131) {
         // invalid volume, we cannot open the trade
         Verbose("Invalid volume, cannot open the trade", " ----------------");
         return(false);
      }
      
      if(ticket == -11111) {
         Verbose("Trade opened, but cannot set SL/PT, closing trade", " ----------------");
         return(false);
      }
      
      Sleep(1000);
   }

   Verbose("Retries of opening order finished", " ----------------");
   return(false);   
}

//+------------------------------------------------------------------+
//+ Money Management functions
//+------------------------------------------------------------------+

double sqMMGetOrderStopLossDistance(string symbol, int orderMagicNumber, int orderType) {
   double openPrice = getOrderPrice(symbol, orderMagicNumber);
   double slSize = getOrderStopLoss(symbol, orderMagicNumber, orderType, openPrice);

   if(slSize == 0) return(0);

   if(orderType == OP_BUY || orderType == OP_BUYSTOP || orderType == OP_BUYLIMIT) {
      return(openPrice - slSize);
   } else {
      return(slSize - openPrice);
   }
}

double sqMMFixedRisk(string symbol, int orderMagicNumber, int orderType, double riskInPercent = 0, double lotsIfNoMM = 0.01, double lotsDecimals = 2, double maximumLots = 10,string pairSuffix = "") {
   Verbose("Computing Money Management for order with Magic Number: ", orderMagicNumber," - fixed risk");

   double slSize = sqMMGetOrderStopLossDistance(symbol, orderMagicNumber, orderType) * sqGetPointPow(symbol);
   if(slSize <= 0) {
      Verbose("Computing Money Management - Stop Loss is zero, using Lots if no MM: ", lotsIfNoMM);
      return(lotsIfNoMM);
   }

   double _riskInPercent = riskInPercent;
   double _lotsDecimals = lotsDecimals;
   double _maximumLots = maximumLots;
   
   if(_riskInPercent <= 0) {
      Verbose("Computing Money Management - Risk In Percent is zero, using Lots if no MM: ", lotsIfNoMM);
      return(lotsIfNoMM);
   }
   
   string _baseCurrency = StringSubstr(symbol,0,3) + "USD" + pairSuffix;
   /*double _exchRate = (MarketInfo(_baseCurrency, MODE_BID) != EMPTY_VALUE && MarketInfo(_baseCurrency, MODE_BID) != 0
                        ? (1/MarketInfo(_baseCurrency, MODE_BID)) : BaseCurrencyExChgUSD);*/
   double _exchRate = (1/MarketInfo(symbol, MODE_BID));

   if(_riskInPercent < 0 ) {
      Verbose("Computing Money Management - Incorrect RiskInPercent size, it must be above 0");
      return(0);
   }

   double riskPerTrade = (_exchRate * AccountBalance() *  (_riskInPercent / 100.0));
   if(slSize <= 0) {
      Verbose("Computing Money Management - Incorrect StopLossPips size, it must be above 0");
      return(0);
   }
   Verbose("Risk per trade: ", riskPerTrade);

   Verbose("Computing Money Management - SL: ", slSize, ", Account Balance: ", AccountBalance(),", Tick value: ", MarketInfo(symbol, MODE_TICKVALUE),", Point: ", MarketInfo(symbol, MODE_POINT), ", Lot size: ", MarketInfo(symbol, MODE_LOTSIZE),", Tick size: ", MarketInfo(symbol, MODE_TICKSIZE));
   double tickValue = MarketInfo(symbol,MODE_TICKVALUE);

   double lossPerTick = riskPerTrade / slSize;
   Verbose("Computed lossPerTick: ",lossPerTick);
   double lossPerTick2 = lossPerTick;
   if(MarketInfo(symbol,MODE_DIGITS) == 1 || MarketInfo(symbol,MODE_DIGITS) == 3 || MarketInfo(symbol,MODE_DIGITS) == 5) {
      lossPerTick2 = 0.1 * lossPerTick;
   }
   Verbose("Computing: LossPerTick: ",lossPerTick, ", LossPerTick2: ",lossPerTick2);

   double lotMM1 = lossPerTick2;
   if(tickValue < 10) {
      lotMM1 /= MarketInfo(symbol,MODE_TICKVALUE);
   }
   Verbose("Computing Money Management - precomputed lots: ", lotMM1);

   double lotMM;
   double lotStep = MarketInfo(symbol, MODE_LOTSTEP);
   if(MathMod(lotMM*100, lotStep*100) > 0) {
      lotMM = lotMM1 - MathMod(lotMM1, lotStep);
   } else {
      lotMM = lotMM1;
   }

   lotMM = NormalizeDouble( lotMM, _lotsDecimals);
   
   if(MarketInfo(symbol, MODE_LOTSIZE)==10000.0) lotMM=lotMM*10;
   lotMM=NormalizeDouble(lotMM,_lotsDecimals);

   double Smallest_Lot = MarketInfo(symbol, MODE_MINLOT);
   double Largest_Lot = MarketInfo(symbol, MODE_MAXLOT);

   if (lotMM < Smallest_Lot) lotMM = Smallest_Lot;
   if (lotMM > Largest_Lot) lotMM = Largest_Lot;

   if(lotMM > _maximumLots) {
      lotMM = _maximumLots;
   }

   Verbose("Computing Money Management - final computed lots: ", lotMM);
   return (lotMM);
}

//+------------------------------------------------------------------+

void Verbose(string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="", int VerboseMode = 0) {
   if(VerboseMode == 1) {
      // log to standard log
      Print("---VERBOSE--- ", TimeToStr(TimeCurrent()), " ", s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);

   } else if(VerboseMode == 2) {
      // log to special file
      int handle = FileOpen("EAW_VerboseLog.txt", FILE_READ | FILE_WRITE);
      if(handle>0) {
         FileSeek(handle,0,SEEK_END);
         FileWrite(handle, TimeToStr(TimeCurrent()), " VERBOSE: ", s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
         FileClose(handle);
      }
   }
}

//+------------------------------------------------------------------+

void VerboseLog(string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="", int VerboseMode = 1) {
   if(VerboseMode != 1) {
      Log(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
   }

   Verbose(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
}

//----------------------------------------------------------------------------

void Log(string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="" ) {
   Print(TimeToStr(TimeCurrent()), " ", s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
}


//+------------------------------------------------------------------+

void LogToFile(string fileName, string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="" ) {
   int handle = FileOpen(fileName, FILE_READ | FILE_WRITE, ";");
   if(handle>0) {
      FileSeek(handle,0,SEEK_END);
      FileWrite(handle, TimeToStr(TimeCurrent()), " ", s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
      FileClose(handle);
   }
}